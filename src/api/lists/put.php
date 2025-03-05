<?php
    include_once '../conn/index.php';
    include_once '../utils/redirect.php';

    $listName = $_GET['listName'];
    $editListName = $_GET['editListName'];

    session_start();

    $editList = "CALL update_list(\"". $_SESSION['email'] ."\", \"" . $listName . "\", \"" . $editListName . "\")";
    $editListQuery = mysqli_query($conn, $editList);

    redirect("../../../memberzone/");
?>