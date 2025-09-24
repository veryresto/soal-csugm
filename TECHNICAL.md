# Technical Architecture

## 1. Objective

This document provides a technical overview of the Soal CSUGM application. The goal is to outline the current static architecture and contrast it with the previous PHP-based implementation.

## 2. Current Application Architecture (Static)

The application is a **static web application**. Its purpose is to provide a fast, browser-based interface for browsing files and folders of exam questions. It uses pre-generated HTML files and does not require a server-side language like PHP.

- **Static Site:** The entire application consists of static HTML, CSS, and JavaScript files.
- **File System as Database:** The directory structure and files on the file system *are* the data. The hierarchy is organized by year (`/2007`, `/2008`, etc.).
- **Client-Side Rendering:** Navigation and display are handled entirely by the browser.

## 3. Execution Flow (Static)

1.  A user navigates to the site (e.g., by opening `soal/index.html`).
2.  The browser renders the static HTML file for the requested directory.
3.  All browsing is done by navigating to other pre-generated `index.html` files within the directory structure.

## 4. Previous Application Architecture (PHP)

The application was previously a **monolithic PHP web application**. Its sole purpose was to dynamically generate a web interface for browsing files and folders within a specific directory on the server.

- **Server-Side Rendering:** The entire HTML interface was rendered on the server by PHP.
- **Single Entry Point:** All requests were funneled through `soal/index.php`, which acted as the controller.

### 4.1. Core Components (PHP)

- **`soal/index.php` (Controller):**
    - The main entry point for the application. It instantiated the `DirectoryLister` class and rendered the view.

- **`soal/resources/DirectoryLister.php` (The Engine):**
    - The core class containing all the application logic for scanning directories and preparing data for the view.

- **`soal/resources/themes/bootstrap/` (The View):**
    - This directory contained the presentation logic (the "View" in an MVC pattern), primarily using a theme `index.php` file to generate HTML.

- **`.htaccess`:**
    - This file was used for configuration on an **Apache web server**.

### 4.2. Execution Flow (PHP)

1.  A user navigated to the site, which would trigger the PHP application.
2.  The web server executed `soal/index.php`.
3.  `DirectoryLister` would scan the file system.
4.  The theme file would iterate over the data and generate the final HTML, which was sent to the user's browser.

## 5. Migration to Static

The previous architecture was tightly coupled to a PHP server environment. The migration to a static site was done to decouple these components for better performance, security, and scalability, and to remove the need for a server-side runtime.

The migration process involved:
1.  **Generating Static HTML:** The output of the `DirectoryLister` PHP script was saved as static `index.html` files for each directory.
2.  **Removing PHP Dependency:** The core PHP logic (`DirectoryLister.php`, `index.php`) is no longer used for serving the site and is pending removal.
3.  **Updating Footer:** The footer was updated to reflect the new architecture and hosting provider.
