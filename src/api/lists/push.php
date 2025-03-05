<?php
    include_once '../conn/index.php';
    include_once '../utils/redirect.php';

    $listName = $_GET['listName'];

    session_start();

    $addList = "CALL create_list(\"". $_SESSION['email'] ."\", \"" . $listName . "\")";
    $addListQuery = mysqli_query($conn, $addList);

    redirect("../../../memberzone/");
?>