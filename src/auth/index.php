<?php
    include_once "../conn/index.php";

    $getUsersInfo = "CALL get_users_info()";
    $resultUsersInfo = mysqli_query($conn, $getUsersInfo);

    if (mysqli_num_rows($resultUsersInfo) > 0) {
        while ($row = mysqli_fetch_assoc($resultUsersInfo)) {
            echo "<h1>" . $row["first_name"] . " " . $row["last_name"] . "</h1>Username: " . $row["username"] . "<br>Email: " . $row["email"] . "<br>Data de Criação: " . $row["create_at"] . "<br><br>";
        }
    }
?>