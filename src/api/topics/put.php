<?php
    include_once '../conn/index.php';
    include_once '../utils/redirect.php';

    $listName = $_GET['listName'];
    $topicName = $_GET['topicName'];
    $newTopicName = $_GET['newTopicName'];

    session_start();

    $editTopic = "CALL update_topic(\"". $_SESSION['email'] ."\", \"" . $listName . "\", \"" . $topicName . "\", \"" . $newTopicName . "\")";
    $editTopicQuery = mysqli_query($conn, $editTopic);

    redirect("../../../memberzone/");
?>