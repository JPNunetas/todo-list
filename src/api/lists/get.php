<?php
    function getUserLists($conn) {
        $getUserLists = 'CALL get_user_lists(\'' . $_SESSION['email'] . '\')';
        $getUserListsQuery = mysqli_query($conn, $getUserLists);

        $final_data = array();
        if(mysqli_num_rows($getUserListsQuery) > 0) {
            while($row = mysqli_fetch_assoc($getUserListsQuery)) {
                $final_data[] = $row;
            }
        }

        return $final_data;
    }
?>