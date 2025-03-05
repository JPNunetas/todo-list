<?php
    include_once '../conn/index.php';
    include_once '../utils/redirect.php';

    $listName = $_GET['listName'];

    session_start();

    $editList = "CALL delete_list(\"". $_SESSION['email'] ."\", \"" . $listName . "\")";
    $editListQuery = mysqli_query($conn, $editList);

    redirect("../../../memberzone/");
?>