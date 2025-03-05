const menuFather = document.getElementById("menu-father");
const menuFatherFather = document.getElementById("menu-father-father");
const content = document.querySelectorAll(".menu > *");
const menuIcon = document.getElementById("menu-icon");
const listsFather = document.getElementById("lists-father");
const openMenu = document.getElementById("open-menu");
const edit = document.getElementsByClassName("edit");
const list = document.getElementsByClassName("list");

// POP UP Vars
const editMenuContainer = document.getElementById("edit-menu-container-all-lists");
const closeBtAllLists = document.getElementById("close");
const inputPopUp = document.getElementById("popup-input");
const add = document.getElementById("add");
const allLists = document.getElementById("all-lists");

openMenu.addEventListener("click", () => {
    menuFatherFather.classList.remove("none");
    openMenu.classList.add("none");
    listsFather.classList.add("width");

    menuFather.classList.remove("animation-out");
    content.forEach(contt => 
        contt.classList.remove("animation-out-stuff")
    );
    menuFather.classList.add("animation-in");
    content.forEach(contt => 
        contt.classList.add("animation-in-stuff")
    );
    listsFather.classList.remove("animation-lists2");
    listsFather.classList.add("animation-lists1");
    setTimeout(() => {
        listsFather.classList.remove("animation-lists1");
    }, 500);
});

menuIcon.addEventListener("click", () => {

    menuFather.classList.add("animation-out");
    content.forEach(contt => 
        contt.classList.add("animation-out-stuff")
    );
    menuFather.classList.remove("animation-in");
    content.forEach(contt => 
        contt.classList.remove("animation-in-stuff")
    );
    listsFather.classList.remove("animation-lists1");
    listsFather.classList.add("animation-lists2");
    setTimeout(() => {
        menuFatherFather.classList.add("none");
        openMenu.classList.remove("none");
        listsFather.classList.remove("width");
    }, 1000);
});

if (window.innerWidth > 720) {
    menuFatherFather.classList.remove("none");
    listsFather.classList.add("width");
    openMenu.classList.add("none");
}

// Popup

for (let i = 0; i < edit.length; i++) {
    edit[i].addEventListener("click", () => {
        editMenuContainer.classList.remove("none");

        const editInput = document.querySelector(".edit-top h1");
        editInput.innerText = list[i].querySelector("h1").innerText;

        const listItems = list[i].querySelectorAll("li");
        listItems.forEach(li => {
            const tA = document.createElement("div");
            const point = document.createElement("div");
            const topic = document.createElement("div");
            const p = document.createElement("p");
            const dlt = document.createElement("div");

            tA.classList.add("topic-all");
            point.classList.add("point");
            topic.classList.add("topic");
            dlt.classList.add("delete-topic");

            p.textContent = li.textContent;

            allLists.appendChild(tA);
            tA.appendChild(point);
            tA.appendChild(topic);
            topic.appendChild(p);
            topic.appendChild(dlt);
        });
    });
}

closeBtAllLists.addEventListener("click", () => {
    const topicsToRemove = allLists.querySelectorAll(".topic-all");
    topicsToRemove.forEach(topic => topic.remove());

    editMenuContainer.classList.add("none");
});

add.addEventListener("click", () => {
    const tA = document.createElement("div");
    const point = document.createElement("div");
    const topic = document.createElement("div");
    const p = document.createElement("p");
    const dlt = document.createElement("div");

    tA.classList.add("topic-all");
    point.classList.add("point");
    topic.classList.add("topic");
    dlt.classList.add("delete-topic");

    p.textContent = inputPopUp.value;

    allLists.appendChild(tA);
    tA.appendChild(point);
    tA.appendChild(topic);
    topic.appendChild(p);
    topic.appendChild(dlt);
});

allLists.addEventListener("click", (event) => {
    if (event.target.classList.contains("delete-topic")) {
        event.target.closest(".topic-all").remove();
    }
});



const addListBtn = document.getElementById("add-list");
const editMenuContainerAddList = document.getElementById("edit-menu-container-add-list");
const closeBtAddList = document.getElementById("close-add-list");

addListBtn.addEventListener("click", () => {
    editMenuContainerAddList.classList.remove("none");
});

closeBtAddList.addEventListener("click", () => {
    editMenuContainerAddList.classList.add("none");
});

const editListBtn = document.getElementById("edit-list");
const editMenuContainerEditList = document.getElementById("edit-menu-container-edit-list");
const closeBtEditList = document.getElementById("close-edit-list");

editListBtn.addEventListener("click", () => {
    editMenuContainerEditList.classList.remove("none");
});

closeBtEditList.addEventListener("click", () => {
    editMenuContainerEditList.classList.add("none");
});

const deleteListBtn = document.getElementById("delete-list");
const deleteMenuContainerEditList = document.getElementById("edit-menu-container-delete-list");
const closeBtDeleteList = document.getElementById("close-delete-list");

deleteListBtn.addEventListener("click", () => {
    deleteMenuContainerEditList.classList.remove("none");
});

closeBtDeleteList.addEventListener("click", () => {
    deleteMenuContainerEditList.classList.add("none");
});

const deleteTopicBtn = document.getElementById("delete-topic");
const deleteMenuContainerDeleteTopic = document.getElementById("edit-menu-container-delete-topic");
const closeBtDeleteTopic = document.getElementById("close-delete-topic");

deleteTopicBtn.addEventListener("click", () => {
    deleteMenuContainerDeleteTopic.classList.remove("none");
});

closeBtDeleteTopic.addEventListener("click", () => {
    deleteMenuContainerDeleteTopic.classList.add("none");
});

const deleteAllListsBtn = document.getElementById("delete-all-lists");
const deleteMenuContainerDeleteAllLists = document.getElementById("edit-menu-container-delete-all-lists");
const closeBtDeleteAllLists = document.getElementById("close-delete-all-lists");

deleteAllListsBtn.addEventListener("click", () => {
    deleteMenuContainerDeleteAllLists.classList.remove("none");
});

closeBtDeleteAllLists.addEventListener("click", () => {
    deleteMenuContainerDeleteAllLists.classList.add("none");
});

const editTopicNameBtn = document.getElementById("edit-topic-name");
const editMenuContainerTopicName = document.getElementById("edit-menu-container-edit-topic-name");
const closeBtTopicName = document.getElementById("close-edit-topic-name");

editTopicNameBtn.addEventListener("click", () => {
    editMenuContainerTopicName.classList.remove("none");
});

closeBtTopicName.addEventListener("click", () => {
    editMenuContainerTopicName.classList.add("none");
});