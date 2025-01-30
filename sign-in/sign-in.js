const hide = document.querySelector('.hide');
const input = document.querySelector('.password');
const submit = document.getElementById('submit');
const x = document.getElementsByClassName("input");
const y = document.getElementsByClassName("label");
let rewrite = x[0].value;

hide.addEventListener("click", () => {
    if (input.type == "password") {
        input.type = 'text';
        hide.classList.add("show");
    } else {
        input.type = 'password';
        hide.classList.remove("show");
    }
});

submit.addEventListener("click", index => {
     if (x[0].value == "") {
        index.preventDefault();
        x[0].placeholder = "*Vazio";
        x[0].classList.add("error");
    } else if (x[0].value === "'@' em falta") {
        index.preventDefault();
    } else if (x[0].value === "Email inválido") {
        index.preventDefault();
    } else if (x[0].value.includes("@") == false) {
        rewrite = x[0].value;
        index.preventDefault();
        x[0].value = "'@' em falta";
        x[0].classList.add("error");
    } else if (x[0].value.startsWith("@") || x[0].value.endsWith("@")) {
        rewrite = x[0].value;
        index.preventDefault();
        x[0].value = "Email inválido";
        x[0].classList.add("error");
    } else {
        rewrite = x[0].value;
    }

    if (x[1].value == "") {
        index.preventDefault();
        x[1].placeholder = "*Vazio";
        x[1].classList.add("error");
    } 
});

x[0].addEventListener("focus", ()=> {
    x[0].value = rewrite;
    x[0].placeholder = "";
    x[0].classList.remove("error");    
    y[0].innerHTML = "Email";
});
x[1].addEventListener("focus", ()=> {
    x[1].placeholder = "";
    x[1].classList.remove("error");
    y[1].innerHTML = "Password";
});

x[0].addEventListener("blur", ()=> {
    if (x[0].value == "") {
        y[0].innerHTML = "Email <span class='error'>⁕</span>";
    }
    rewrite = x[0].value;
});
if (x[1].value == "") {
    y[1].innerHTML = "Password <span class='error'>⁕</span>";
}
x[1].addEventListener("blur", ()=> {
    if (x[1].value == "") {
        y[1].innerHTML = "Password <span class='error'>⁕</span>";
    }
});