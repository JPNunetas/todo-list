<?php
    include_once '../conn/index.php';
    include_once '../utils/redirect.php';

    $listName = $_GET['listName'];
    $topicName = $_GET['topicName'];

    session_start();

    $addTopic = "CALL create_topics(\"". $_SESSION['email'] ."\", \"" . $listName . "\", \"" . $topicName . "\")";
    $addTopicQuery = mysqli_query($conn, $addTopic);

    redirect("../../../memberzone/");
?>