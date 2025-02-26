<?php
include_once '../../conn/index.php';
include_once '../../utils/redirect.php';

session_start();

$email = trim($_POST['email']);
$password = $_POST['password'];

$_SESSION['email'] = $email;

$getPasswordQuery = mysqli_prepare($conn ,'SELECT get_password(?) AS dbpassword');
mysqli_stmt_bind_param($getPasswordQuery, 's', $email);

mysqli_stmt_execute($getPasswordQuery);
$getPasswordResult = mysqli_stmt_get_result($getPasswordQuery);

$row = mysqli_fetch_assoc($getPasswordResult);
$dbPasswordEncrypted = password_hash($row['dbpassword'], PASSWORD_DEFAULT);

if(!password_verify($password, $dbPasswordEncrypted)) {
    $_SESSION['error_password'] = 'Password Incorreta!';
    redirect('../../../../sign-in/');
}

redirect('../../../../member-zone/');
?>