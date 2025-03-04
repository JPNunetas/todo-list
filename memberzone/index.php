<?php
    include_once '../src/api/lists/get.php';
    include_once '../src/api/topics/get.php';
    include_once '../src/api/conn/index.php';
    include_once '../src/api/utils/redirect.php';

    session_start();

    if (!isset($_SESSION['email'])) {
        redirect('../signin/');
    }

    $userLists = getUserLists($conn);

    mysqli_next_result($conn);
?>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width">

        <link rel="stylesheet" href="./member-zone.css">
        <link rel="stylesheet" href="./animations.css">
        <link rel="stylesheet" href="./classes.css">
        <link rel="shortcut icon" href="../src/img/logo.svg" type="image/x-icon">
        
        <title>Member Zone</title>
    </head>
    <body>
        <div class="all">
            <div id="menu-father-father" class="menu-father-father none">
                <div id="menu-father" class="menu-father">
                    <div class="menu" id="menu">
                        <div class="logo-menu">
                            <div class="logo"></div>
                            <div id="menu-icon" class="menu-icon"></div>
                        </div>
                        <div class="input">
                            <div class="search"></div>
                            <input type="text" placeholder="Pesquisar nome da lista">
                        </div>
                        <div class="gerir">
                            <h1>Gerir Listas</h1>
                        </div>
                        <div class="box">
                            <div class="more"></div>
                            <h1>Listas</h1>
                        </div>
                        <div class="box">
                            <div class="delete"></div>
                            <h1>Apagar Lista</h1>
                        </div>
                        <div class="box">
                            <div class="delete"></div>
                            <h1>Apagar Listas</h1>
                        </div>
                        <div class="gerir">
                            <h1>User Info</h1>
                        </div>
                        <div class="box">
                            <div class="user"></div>
                            <h1>Ver Perfil</h1>
                        </div>
                        <div class="box">
                            <div class="log-out"></div>
                            <h1>Log out</h1>
                        </div>
                    </div>
                </div>
            </div>
            <div id="lists-father" class="lists-father">
                <div class="lists-title">
                    <div id="open-menu" class="open-menu"></div>
                    <h1>Listas</h1>
                </div>
                <div class="lists">
                    <?php
                        if(isset($userLists) && count($userLists) > 0) {
                            foreach ($userLists as $userList) {
                                $listName = $userList['l_name'];

                                $listTopics = getListTopics($conn, $listName);

                                echo '<div class="list">
                                        <h1>' . $listName . '</h1>
                                        <ul>';

                                if(isset($listTopics) && count($listTopics) > 0) {
                                    foreach ($listTopics as $listTopic) {
                                        $topicName = $listTopic['t_text'];

                                        echo '<li>' . $topicName . '</li>';
                                    }

                                    mysqli_next_result($conn);
                                }

                                echo '</ul>
                                        <div class="edit"></div>
                                    </div>';
                            }
                        }
                    ?>
                </div>
            </div>

            <div class="edit-menu-container none" id="edit-menu-container">
                <div class="edit-menu">
                    <div class="edit-top">
                        <input type="text" value="cjdjbvhbvjhvhdndn" maxlength="15">
                        <div class="close" id="close"></div>
                    </div>

                    <div class="edit-topics" id="edit-topics">
                        <div class="edit-topics-top">
                            <input type="text" id="popup-input" placeholder="Insira um tópico" maxlength="30">
                            <div class="add" id="add">
                                <div class="add-container"></div>
                            </div>
                        </div>

                        <div class="all-lists" id="all-lists"></div>

                        <div class="popup-submit-father">
                            <div class="popup-submit">
                                <p>Guardar Alterações</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <script src="index.js"></script>
    </body>
</html>