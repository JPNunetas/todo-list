const menuFather = document.getElementById("menu-father");
const menuFather2 = document.getElementById("menu-father2");
const menuIcon = document.getElementById("menu-icon");
const listsFather = document.getElementById("lists-father");
const openMenu = document.getElementById("open-menu");

openMenu.addEventListener("click", () => {
    menuFather.classList.remove("none");
    openMenu.classList.add("none");
    listsFather.classList.add("width");
});
menuIcon.addEventListener("click", () => {
    menuFather.classList.add("none");
    openMenu.classList.remove("none");
    listsFather.classList.remove("width");
});




