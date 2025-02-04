<?php

    $servername = 'localhost';
    $username = 'root';    
    $password = 'root';
    $dbname = 'tododb';

    $conn = mysqli_connect($servername, $username, $password, $dbname);

    if (!$conn) {
        die('Error on making conection to DB' . mysqli_connect_error());
    }
?>