// EndPoint to Edit Topic Name

const endpointEditTopicBtn = document.getElementById("edit-topic-name-btn");
endpointEditTopicBtn.addEventListener("click", () => {
    const listName = document.getElementById("edit-topic-name-list-name");
    const topicName = document.getElementById("edit-topic-name-topic-name");
    const newTopicName = document.getElementById("edit-topic-name-new-topic-name");

    location.href = "../../src/api/topics/put.php?listName=" + listName.value + "&topicName=" + topicName.value + "&newTopicName=" + newTopicName.value;
});

// EndPoint to Delete a Topic

const endpointDeleteTopic = document.getElementById("delete-topic-btn");
endpointDeleteTopic.addEventListener("click", () => {
    const listNameToDeleteTopic = document.getElementById("input-search-list-delete-topic");
    const deleteTopic = document.getElementById("input-delete-topic");

    location.href = "../../src/api/topics/delete.php?listName=" + listNameToDeleteTopic.value + "&deleteTopic=" + deleteTopic.value;
});