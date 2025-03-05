<?php
    include_once '../conn/index.php';
    include_once '../utils/redirect.php';

    $listName = $_GET['listName'];
    $deleteTopicName = $_GET['deleteTopic'];

    session_start();

    $deleteTopic = "CALL delete_topic(\"". $_SESSION['email'] ."\", \"" . $listName . "\", \"" . $deleteTopicName . "\")";
    $deleteTopicQuery = mysqli_query($conn, $deleteTopic);

    redirect("../../../memberzone/");
?>