# Technical Architecture Analysis for Re-architecture

## 1. Objective

This document provides a technical overview of the Soal CSUGM application for a Large Language Model (LLM). The goal is to outline the current architecture and identify key details necessary for planning a re-architecture of the application, likely towards a modern, static-first (Jamstack) approach.

## 2. Current Application Architecture

The application is a **monolithic PHP web application**. Its sole purpose is to dynamically generate a web interface for browsing files and folders within a specific directory on the server.

- **Server-Side Rendering:** The entire HTML interface is rendered on the server by PHP.
- **File System as Database:** The application does not use a traditional database. The directory structure and files on the server's file system *are* the data. The hierarchy is organized by year (`/2007`, `/2008`, etc.).
- **Single Entry Point:** All requests are funneled through `soal/index.php`, which acts as the controller.

## 3. Core Components

- **`soal/index.php` (Controller):**
    - This is the main entry point for the application.
    - It includes and instantiates the `DirectoryLister` class.
    - It reads the `?dir=` query parameter from the URL to determine which directory to list.
    - It calls the `DirectoryLister` to get the directory contents and then includes the theme's `index.php` to render the final HTML.

- **`soal/resources/DirectoryLister.php` (The Engine):**
    - This is the core class containing all the application logic.
    - **`_readDirectory()`:** This protected method is the heart of the class. It uses PHP's `scandir()` to read the contents of a given directory path.
    - **`listDirectory()`:** A public method that orchestrates the directory reading process.
    - **Theming:** It determines the theme to use from a config file and provides helper methods (`getThemePath()`, `listBreadcrumbs()`, `getFileSize()`) that are used by the theme files to render data.
    - **Configuration:** It loads its configuration from `soal/resources/config.php`.

- **`soal/resources/themes/bootstrap/` (The View):**
    - This directory contains the presentation logic (the "View" in an MVC pattern).
    - `index.php`: The main theme file that generates the HTML structure. It loops through the data array provided by `DirectoryLister.php` to build the file and folder list.
    - `css/`, `js/`: Contains the static assets for the theme.

- **`index.html` (Root Redirect):**
    - The `index.html` file in the project root simply performs an immediate meta refresh (redirect) to the `/soal` directory, which triggers the PHP application.

- **`.htaccess`:**
    - This file indicates the application is designed to be deployed on an **Apache web server**.
    - `Options -Indexes`: Disables Apache's default directory listing functionality, ensuring that `soal/index.php` is always used instead.
    - `ErrorDocument`: Specifies custom pages for 403 and 404 errors.

- **`soal/soal_map.txt`:**
    - This file appears to be a manually generated, text-based representation of the directory tree.
    - It is **not used by the PHP application**. It is likely an artifact for human reference.

## 4. Execution Flow

1.  A user navigates to the site, is redirected by the root `index.html` to `/soal/`.
2.  The web server (e.g., Apache or the PHP dev server) executes `soal/index.php`.
3.  `soal/index.php` instantiates `DirectoryLister`.
4.  `DirectoryLister` reads the directory specified in the `?dir=` URL parameter (or `.` if not present).
5.  `DirectoryLister` scans the file system, filters out hidden files, and creates a sorted array of file/folder data (name, path, size, mod_time).
6.  `soal/index.php` includes the theme's `index.php`.
7.  The theme file iterates over the data array and generates the final HTML, which is sent to the user's browser.

## 5. Considerations for Re-architecture (Jamstack)

The current architecture is tightly coupled to a PHP server environment and the local file system. A Jamstack approach would decouple these components for better performance, security, and scalability.

**Suggested Re-architecture Plan:**

1.  **Data Source:** The exam paper images (`.jpeg` files) remain the core data. They should be treated as static assets.

2.  **Build Step (Data Ingestion):**
    - Create a script (e.g., using Node.js or Python) that runs at build time.
    - This script will recursively scan the `soal/` directory, mirroring the logic of `DirectoryLister.php`.
    - Instead of rendering HTML, the script will generate a single **`data.json`** file. This JSON file will represent the entire file and folder hierarchy, including paths, names, and any other metadata.

3.  **Frontend Application (The View):**
    - Create a new frontend application using a modern JavaScript framework (like React, Vue, Svelte) or even plain HTML, CSS, and JavaScript.
    - This application will be fully static.
    - On page load, it will fetch the `data.json` file.
    - It will then use client-side JavaScript to dynamically render the directory listing and breadcrumbs based on the JSON data. This eliminates the need for a PHP server to render the page on each request.

4.  **Hosting:**
    - The entire project (static HTML/CSS/JS files, the `data.json` file, and all the image assets) can be deployed to a static hosting provider like **Netlify, Vercel, or GitHub Pages**.
    - The build script from Step 2 would be configured to run automatically whenever the site is deployed.
