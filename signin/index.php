<?php
    include_once '../src/api/conn/index.php';
    include_once '../src/api/utils/redirect.php';

    session_start();
?>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width">

        <link rel="stylesheet" href="sign-in.css">
        <link rel="shortcut icon" href="../src/img/logo.svg" type="image/x-icon">

        <title>Sign In</title>
    </head>
    <body>
        <div class="signIn-hero">
            <div class="signIn-top">
                <a id="a">
                    <div class="back">
                        <div class="back-container"></div>
                    </div>
                </a>
            </div>
            <div class="signIn-center">
                <div class="sign-in-center-container">
                    <a href="">
                        <div class="signIn-icon">
                            <div class="signIn-icon-container"></div>
                        </div>
                    </a>
                    <form id="form" action="../src/api/auth/signin/get.php" method="POST" enctype="application/x-www-form-urlencoded">
                        <div class="box">
                            <div class="icon-email"></div>
                            <label class="label"> Email</label><br>
                        </div>
                        <input class="input" type="email" name='email' maxlength="30">
                        <div class="box">
                            <div class="icon-password"></div>
                            <label class="label"> Password</label><br>
                        </div>
                        <div id="box-password">
                            <?php
                                if(isset($_SESSION['error_password'])) {
                                    echo '<input class="password input error" placeholder="Password Incorreta" type="password" name="password" minlength="8" maxlength="30">';
                                }
                                
                                if (!isset($_SESSION['error_password'])) {
                                    echo '<input class="password input" type="password" name="password" minlength="8" maxlength="30">';
                                }
                            ?>
                            <div class="hide"></div>
                        </div>
                        <input type="submit" id="submit" value="Sign In">
                        <div class="last-label">
                            <label><span>Não tem conta? </span><a href="../signup/">Sign Up</a></label>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <script src="sign-in.js"></script>
    </body>
</html>