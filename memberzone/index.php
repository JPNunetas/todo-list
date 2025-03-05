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

        <link rel="stylesheet" href="./style/member-zone.css">
        <link rel="stylesheet" href="./style/animations.css">
        <link rel="stylesheet" href="./style/classes.css">
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
                        <div class="box" id="add-list">
                            <div class="more"></div>
                            <h1>Adicionar Lista</h1>
                        </div>
                        <div class="box" id="edit-list">
                            <div class="more"></div>
                            <h1>Editar Lista</h1>
                        </div>
                        <div class="box" id="edit-topic-name">
                            <div class="more"></div>
                            <h1>Editar Nome Tópico</h1>
                        </div>
                        <div class="box" id="delete-list">
                            <div class="delete"></div>
                            <h1>Apagar Lista</h1>
                        </div>
                        <div class="box" id="delete-topic">
                            <div class="delete"></div>
                            <h1>Apagar Tópico</h1>
                        </div>
                        <div class="box" id="delete-all-lists">
                            <div class="delete"></div>
                            <h1>Apagar Listas</h1>
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

            <div class="edit-menu-container none" id="edit-menu-container-all-lists">
                <div class="edit-menu">
                    <div class="edit-top">
                        <h1></h1>
                        <div class="close" id="close"></div>
                    </div>

                    <div class="edit-topics">
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

            <div class="edit-menu-container none" id="edit-menu-container-add-list">
                <div class="edit-menu">
                    <div class="edit-top">
                        <h1>Adicionar Lista</h1>
                        <div class="close" id="close-add-list"></div>
                    </div>

                    <div class="edit-topics" id="edit-topics">
                        <div class="edit-topics-top">
                            <input type="text" placeholder="Insira o nome da lista" maxlength="30">
                        </div>

                        <div class="popup-submit-father">
                            <div class="popup-submit">
                                <p>Guardar Alterações</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="edit-menu-container none" id="edit-menu-container-edit-list">
                <div class="edit-menu">
                    <div class="edit-top">
                        <h1>Editar Lista</h1>
                        <div class="close" id="close-edit-list"></div>
                    </div>

                    <div class="edit-topics" id="edit-topics">
                        <div class="edit-topics-top">
                            <input id="edit-list-list-name" type="text" placeholder="Insira o nome da lista a renomear" maxlength="30">
                        </div>

                        <div class="edit-topics-top">
                            <input id="edit-list-list-rename" type="text" placeholder="Insira o novo nome da lista" maxlength="30">
                        </div>

                        <div class="popup-submit-father">
                            <div class="popup-submit" id="list-edit-btn">
                                <p>Guardar Alterações</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="edit-menu-container none" id="edit-menu-container-edit-topic-name">
                <div class="edit-menu">
                    <div class="edit-top">
                        <h1>Editar Topico</h1>
                        <div class="close" id="close-edit-topic-name"></div>
                    </div>

                    <div class="edit-topics" id="edit-topics">
                        <div class="edit-topics-top">
                            <input id="edit-topic-name-list-name" type="text" placeholder="Insira o nome da lista" maxlength="30">
                        </div>

                        <div class="edit-topics-top">
                            <input id="edit-topic-name-topic-name" type="text" placeholder="Insira o nome do topico" maxlength="30">
                        </div>

                        <div class="edit-topics-top">
                            <input id="edit-topic-name-new-topic-name" type="text" placeholder="Insira o novo nome do topico" maxlength="30">
                        </div>

                        <div class="popup-submit-father">
                            <div class="popup-submit" id="edit-topic-name-btn">
                                <p>Guardar Alterações</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="edit-menu-container none" id="edit-menu-container-delete-list">
                <div class="edit-menu">
                    <div class="edit-top">
                        <h1>Apagar Lista</h1>
                        <div class="close" id="close-delete-list"></div>
                    </div>

                    <div class="edit-topics" id="edit-topics">
                        <div class="edit-topics-top">
                            <input type="text" placeholder="Insira o nome da lista a apagar" maxlength="30">
                        </div>

                        <div class="popup-submit-father">
                            <div class="popup-submit">
                                <p>Apagar Lista</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="edit-menu-container none" id="edit-menu-container-delete-topic">
                <div class="edit-menu">
                    <div class="edit-top">
                        <h1>Apagar Tópico</h1>
                        <div class="close" id="close-delete-topic"></div>
                    </div>

                    <div class="edit-topics" id="edit-topics">
                        <div class="edit-topics-top">
                            <input id="input-search-list-delete-topic" type="text" placeholder="Insira o nome do tópico a apagar" maxlength="30">
                        </div>

                        <div class="edit-topics-top">
                            <input id="input-delete-topic" type="text" placeholder="Insira o nome do tópico a apagar" maxlength="30">
                        </div>

                        <div class="popup-submit-father">
                            <div class="popup-submit" id="delete-topic-btn">
                                <p>Apagar Tópico</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="edit-menu-container none" id="edit-menu-container-delete-all-lists">
                <div class="edit-menu">
                    <div class="edit-top">
                        <h1>Tem a certeza?</h1>
                        <div class="close" id="close-delete-all-lists"></div>
                    </div>

                    <div class="edit-topics" id="edit-topics">
                        <div class="popup-submit-father">
                            <div class="popup-submit">
                                <p>Sim</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <script src="./script/index.js"></script>
        <script src="./script/endpoints.js"></script>
    </body>
</html>