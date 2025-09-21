# Soal CSUGM (Computer Science UGM Exam Questions Archive)

This project is a simple PHP-based web application to browse an archive of past exam questions from the Computer Science department at Universitas Gadjah Mada (UGM).

It uses the [DirectoryLister](https://www.directorylister.com/) script to dynamically list the contents of the `soal/` directory and its subdirectories.

## How to Run

1.  **Prerequisites:** You must have [PHP](https://www.php.net/downloads) installed on your machine.
2.  **Start the server:** Navigate to the project's root directory in your terminal and run the following command:

    ```bash
    php -S localhost:8000 -t soal
    ```

3.  **Open in browser:** Open your web browser and go to `http://localhost:8000`.

The application will be running, serving the files from the `soal/` directory.
