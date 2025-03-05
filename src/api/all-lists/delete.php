<?php
    include_once '../conn/index.php';
    include_once '../utils/redirect.php';

    session_start();

    $deleteAllLists = "CALL delete_user_lists(\"". $_SESSION['email'] ."\")";
    $deleteAllListsQuery = mysqli_query($conn, $deleteAllLists);

    redirect("../../../memberzone/");
?>