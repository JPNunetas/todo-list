const menuFather = document.getElementById("menu-father");
const menuFatherFather = document.getElementById("menu-father-father");
const content = document.querySelectorAll(".menu > *");
const menuIcon = document.getElementById("menu-icon");
const listsFather = document.getElementById("lists-father");
const openMenu = document.getElementById("open-menu");

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
    }, 1000);
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
    }, 2000);
});

if (window.innerWidth > 720) {
    menuFatherFather.classList.remove("none");
    listsFather.classList.add("width");
    openMenu.classList.add("none");
}


