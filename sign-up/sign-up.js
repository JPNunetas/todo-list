const hide = document.querySelectorAll('.hide');
const input = document.querySelectorAll('.password');
const submit = document.getElementById('submit');
const x = document.getElementsByClassName("input");
const y = document.getElementsByClassName("label");
let rewrite = x[0].value;

hide[0].addEventListener("click", show0);
hide[1].addEventListener("click", show1);
submit.addEventListener("click", (index)=> {
    
    if (x[0].value == "") {
        index.preventDefault();
        x[0].placeholder = "*Vazio";
        x[0].classList.add("error2");
    } 

    if (x[1].value == "") {
        index.preventDefault();
        x[1].placeholder = "*Vazio";
        x[1].classList.add("error2");
    } else if (x[1].value === "'@' em falta") {
        index.preventDefault();
    } else if (x[1].value === "Email inválido") {
        index.preventDefault();
    } else if (x[1].value.includes("@") == false) {
        rewrite = x[1].value;
        index.preventDefault();
        x[1].value = "'@' em falta";
        x[1].classList.add("error2");
    } else if (x[1].value.startsWith("@") || x[1].value.endsWith("@")) {
        rewrite = x[1].value;
        index.preventDefault();
        x[1].value = "Email inválido";
        x[1].classList.add("error2");
    } else {
        rewrite = x[1].value;
    }

    if (x[2].value == "") {
        index.preventDefault();
        x[2].placeholder = "*Vazio";
        x[2].classList.add("error2");
    } 

    if (x[3].value == "") {
        if (x[3].placeholder == "*Password Errada") {
            index.preventDefault();
        }
        if (!(x[3].placeholder == "*Password Errada")) {
            index.preventDefault();
            x[3].placeholder = "*Vazio";
            x[3].classList.add("error2");
        }
        
    }
    if (x[2].value != x[3].value) {
            index.preventDefault();
            x[3].value = "";
            x[3].classList.add("error2");
            x[3].placeholder = "*Password Errada"
    }
});

x[0].addEventListener("focus", ()=> {
    x[0].placeholder = "";
    x[0].classList.remove("error2");    
    y[0].innerHTML = "Username";
});
x[1].addEventListener("focus", ()=> {
    x[1].value = rewrite;
    x[1].placeholder = "";
    x[1].classList.remove("error2");    
    y[1].innerHTML = "Email";
});
x[2].addEventListener("focus", ()=> {
    x[2].placeholder = "";
    x[2].classList.remove("error2");    
    y[2].innerHTML = "Password";
});
x[3].addEventListener("focus", ()=> {
    x[3].placeholder = "";
    x[3].classList.remove("error2");    
    y[3].innerHTML = "Confirm-Password";
}); 

x[0].addEventListener("blur", ()=> {
    if (x[0].value == "") {
        y[0].innerHTML = "Username <span class='error2'>⁕</span>";
    }
});
if (x[1].value == "") {
    y[1].innerHTML = "Email <span class='error2'>⁕</span>";
}
x[1].addEventListener("blur", ()=> {
    if (x[1].value == "") {
        y[1].innerHTML = "Email <span class='error2'>⁕</span>";
    }
    rewrite = x[1].value;
});
if (x[2].value == "") {
    y[2].innerHTML = "Password <span class='error2'>⁕</span>";
}
x[2].addEventListener("blur", ()=> {
    if (x[2].value == "") {
        y[2].innerHTML = "Password <span class='error2'>⁕</span>";
    }
});
if (x[3].value == "") {
    y[3].innerHTML = "Confirm-Password <span class='error2'>⁕</span>";
}
x[3].addEventListener("blur", ()=> {
    if (x[3].value == "") {
        y[3].innerHTML = "Confirm-Password <span class='error2'>⁕</span>";
    }
});

function show0() {
    if (input[0].type == "password") {
        input[0].type = 'text';
        hide[0].classList.add("show");
    } else {
        input[0].type = 'password';
        hide[0].classList.remove("show");
    }  
}

function show1() {
    if (input[1].type == "password") {
        input[1].type = 'text';
        hide[1].classList.add("show");
    } else {
        input[1].type = 'password';
        hide[1].classList.remove("show");
    }  
}