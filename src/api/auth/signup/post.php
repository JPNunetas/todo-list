<?php
include_once '../../conn/index.php';
include_once '../../utils/redirect.php';

session_start();

$username = $_POST['username'];
$email = trim($_POST['email']);
$password = $_POST['password'];

$getUser = 'CALL get_user(\'' . $email .'\')';
$getUserQuery = mysqli_query($conn, $getUser);

if (mysqli_num_rows($getUserQuery) > 0) {
    redirect('../../../../sign-up/');
}

mysqli_free_result($getUserQuery);
while (mysqli_next_result($conn)) {;}

$createUser = 'CALL create_user(\'' . $username . '\', \'' . $email . '\', \'' . $password . '\')';
$createUserQuery = mysqli_query($conn, $createUser);

if($createUserQuery) {
    redirect('../../../../sign-in/');
}
?>