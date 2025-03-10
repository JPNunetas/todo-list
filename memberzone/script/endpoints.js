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

// EndPoint to Edit a List

const endpointEditList = document.getElementById("list-edit-btn");
endpointEditList.addEventListener("click", () => {
    const listNameToEdit = document.getElementById("edit-list-list-name");
    const editListName = document.getElementById("edit-list-list-rename");

    location.href = "../../src/api/lists/put.php?listName=" + listNameToEdit.value + "&editListName=" + editListName.value;
});

// EndPoint to Delete a List

const endpointDeleteList = document.getElementById("delete-list-btn");
endpointDeleteList.addEventListener("click", () => {
    const listDeleteName = document.getElementById("delete-list-input");

    location.href = "../../src/api/lists/delete.php?listName=" + listDeleteName.value;
});

// EndPoint to Delete all Lists

const endpointDeleteAllLists = document.getElementById("delete-all-lists-btn");
endpointDeleteAllLists.addEventListener("click", () => {
    location.href = "../../src/api/all-lists/delete.php";
});

// EndPoint to Add List

const endpointAddLists = document.getElementById("add-list-btn");
endpointAddLists.addEventListener("click", () => {
    const listName = document.getElementById("add-list-input");

    location.href = "../../src/api/lists/push.php?listName=" + listName.value;
});

// EndPoint to Add Topics

const endpointAddTopics = document.getElementById("add-topic-btn");
endpointAddTopics.addEventListener("click", () => {
    const listName = document.getElementById("list-name-h1");
    const topicName = document.getElementById("topic-add-input");

    location.href = "../../src/api/topics/push.php?listName=" + listName.innerText + "&topicName=" + topicName.value;
});