const menuFather = document.getElementById("menu-father");
const menuFatherFather = document.getElementById("menu-father-father");
const content = document.querySelectorAll(".menu > *");
const menuIcon = document.getElementById("menu-icon");
const listsFather = document.getElementById("lists-father");
const openMenu = document.getElementById("open-menu");
const edit = document.getElementsByClassName("edit");
const list = document.getElementsByClassName("list");
const editMenuContainer = document.getElementById("edit-menu-container");

// POP UP Vars
const closeBt = document.getElementById("close");
const inputPopUp = document.getElementById("popup-input");
const add = document.getElementById("add");
const editTopics = document.getElementById("all-lists");

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
for (let i = 0; i < edit.length; i++) {
    edit[i].addEventListener("click", () => {
        editMenuContainer.classList.remove("none");

        const editInput = document.querySelector(".edit-top input");
        editInput.value = list[i].querySelector("h1").textContent;

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

            editTopics.appendChild(tA);
            tA.appendChild(point);
            tA.appendChild(topic);
            topic.appendChild(p);
            topic.appendChild(dlt);
        });
    });
}

closeBt.addEventListener("click", () => {
    const topicsToRemove = editTopics.querySelectorAll(".topic-all");
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

    editTopics.appendChild(tA);
    tA.appendChild(point);
    tA.appendChild(topic);
    topic.appendChild(p);
    topic.appendChild(dlt);
});

editTopics.addEventListener("click", (event) => {
    if (event.target.classList.contains("delete-topic")) {
        event.target.closest(".topic-all").remove();
    }
});