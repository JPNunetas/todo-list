const hide = document.querySelector('.hide');
const input = document.querySelector('.password');
const submit = document.getElementById('submit');
const x = document.getElementsByClassName("input");
const y = document.getElementsByClassName("label");
const a = document.getElementById('a');
let rewrite = x[0].value;

a.addEventListener("click", () => {
    if (window.history.length <= 1) {
        a.href = "../index.php";
        return;
    }
    window.history.back();
});

hide.addEventListener("click", () => {
    if (input.type == "password") {
        input.type = 'text';
        hide.classList.add("show");
        return;
    } 
    if (input.type != "password") {
        input.type = 'password';
        hide.classList.remove("show");
    }
});

submit.addEventListener("click", index => {
    if (x[0].value == "") {
        index.preventDefault();
        x[0].placeholder = "Este campo está vazio";
        x[0].classList.add("error");
    }
    if (x[0].value == "'@' em falta") {
        index.preventDefault();
    }
    if (!(x[0].value == "") && x[0].value.includes("@") == false) {
        if (x[0].value == "Email incompleto") {
            index.preventDefault();
        }
        if (!(x[0].value == "Email incompleto")) {
            rewrite = x[0].value;
            index.preventDefault();
            x[0].value = "'@' em falta";
            x[0].classList.add("error");    
        }
    }  
    if (x[0].value.startsWith("@") || x[0].value.endsWith("@")) {
        rewrite = x[0].value;
        index.preventDefault();
        x[0].value = "Email incompleto";
        x[0].classList.add("error");
    } 

    if (x[1].value == "") {
        index.preventDefault();
        x[1].placeholder = "Este campo está vazio";
        x[1].classList.add("error");
    } 
    if (!(x[1].value == "") && x[1].value.length < 8) {
        index.preventDefault();
        x[1].value = "";
        x[1].placeholder = "Mínimo de 8 caracteres";
        x[1].classList.add("error");
    }
});

x[0].addEventListener("focus", ()=> {
    x[0].value = rewrite;
    x[0].placeholder = "";
    x[0].classList.remove("error");    

});
x[1].addEventListener("focus", ()=> {
    x[1].placeholder = "";
    x[1].classList.remove("error");
});

y[0].innerHTML = "Email <span class='error'>⁕</span>";
y[1].innerHTML = "Password <span class='error'>⁕</span>";

x[0].addEventListener("blur", ()=> {
    rewrite = x[0].value;
});

