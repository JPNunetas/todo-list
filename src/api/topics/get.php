<?php
    function getListTopics($conn, $listName) {
        $getUserTopics = 'CALL get_list_topics(\'' . $_SESSION['email'] . '\', \'' . $listName . '\')';
        $getUserTopicsQuery = mysqli_query($conn, $getUserTopics);

        $final_data = array();
        if(mysqli_num_rows($getUserTopicsQuery) > 0) {
            while($row = mysqli_fetch_assoc($getUserTopicsQuery)) {
                $final_data[] = $row;
            }
        }

        return $final_data;
    }
?>