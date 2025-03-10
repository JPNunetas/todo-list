<?php
    session_start();
?>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width">

        <link rel="stylesheet" href="sign-up.css">
        <link rel="stylesheet" href="../signin/sign-in.css">
        <link rel="shortcut icon" href="../src/img/logo.svg" type="image/x-icon">

        <title>Sign In</title>
    </head>
    <body>
        <div class="signUp-hero">
            <div class="signIn-top">
                <a id="a">
                    <div class="back">
                        <div class="back-container"></div>
                    </div>
                </a>
            </div>
            <div class="signUp-center">
                <div class="sign-in-center-container">
                    <a href="">
                        <div class="signUp-icon">
                            <div class="signIn-icon-container"></div>
                        </div>
                    </a>
                    <form id="form" action="../src/api/auth/signup/post.php" method="POST" enctype="application/x-www-form-urlencoded">
                        <div class="box">
                            <div class="icon-username"></div>
                            <label class="label"> Username</label><br>
                        </div>
                        <input class="input" type="text" name="username" maxlength="30">
                        <div class="box">
                            <div class="icon-email"></div>
                            <label class="label"> Email</label><br>
                        </div>
                        <input class="input" name="email" type="email">
                        <div class="box">
                            <div class="icon-password"></div>
                            <label class="label"> Password</label><br>
                        </div>
                        <div id="box-password">
                            <input class="password input" type="password" name="password" minlength="8" maxlength="30">
                            <div class="hide"></div>
                        </div>
                        <div class="box">
                            <div class="icon-confirm-password"></div>
                            <label class="label">Confirm-Password</label><br>
                        </div>
                        <div id="box-password">
                            <input class="password input" type="password" maxlength="30">
                            <div class="hide"></div>
                        </div>
                        <input type="submit" id="submit" value="Sign Up">
                    </form>
                </div>
            </div>
        </div>

        <script src="sign-up.js"></script>
    </body>
</html>