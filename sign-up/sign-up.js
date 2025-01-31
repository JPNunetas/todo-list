const hide = document.querySelectorAll('.hide');
const input = document.querySelectorAll('.password');
const submit = document.getElementById('submit');
const x = document.getElementsByClassName("input");
const y = document.getElementsByClassName("label");
let rewrite = x[0].value;

hide[0].addEventListener("click", () => {
    if (input[0].type == "password") {
        input[0].type = 'text';
        hide[0].classList.add("show");
    } else {
        input[0].type = 'password';
        hide[0].classList.remove("show");
    } 
});
hide[1].addEventListener("click", () => {
    if (input[1].type == "password") {
        input[1].type = 'text';
        hide[1].classList.add("show");
    } else {
        input[1].type = 'password';
        hide[1].classList.remove("show");
    }  
});
submit.addEventListener("click", (index)=> {
    
    if (x[0].value == "") {
        index.preventDefault();
        x[0].placeholder = "Este campo está vazio";
        x[0].classList.add("error2");
    } 

    if (x[1].value == "") {
        index.preventDefault();
        x[1].placeholder = "Este campo está vazio";
        x[1].classList.add("error");
    }
    if (x[1].value == "'@' em falta") {
        index.preventDefault();
    }
    if (!(x[1].value == "") && x[1].value.includes("@") == false) {
        if (x[1].value == "Email inválido") {
            index.preventDefault();
        }
        if (!(x[1].value == "Email inválido")) {
            rewrite = x[1].value;
            index.preventDefault();
            x[1].value = "'@' em falta";
            x[1].classList.add("error");    
        }
    }  
    if (x[1].value.startsWith("@") || x[1].value.endsWith("@")) {
        rewrite = x[1].value;
        index.preventDefault();
        x[1].value = "Email inválido";
        x[1].classList.add("error");
    }

    if (x[2].value == "") {
        index.preventDefault();
        x[2].placeholder = "Este campo está vazio";
        x[2].classList.add("error2");
    } 

    if (x[3].value == "") {
        if (x[3].placeholder == "Password Errada") {
            index.preventDefault();
        }
        if (!(x[3].placeholder == "Password Errada")) {
            index.preventDefault();
            x[3].placeholder = "Este campo está vazio";
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
});
x[1].addEventListener("focus", ()=> {
    x[1].value = rewrite;
    x[1].placeholder = "";
    x[1].classList.remove("error2");    
});
x[2].addEventListener("focus", ()=> {
    x[2].placeholder = "";
    x[2].classList.remove("error2");    
});
x[3].addEventListener("focus", ()=> {
    x[3].placeholder = "";
    x[3].classList.remove("error2");    
}); 

if (x[0].value == "") {
    y[0].innerHTML = "Username <span class='error2'>⁕</span>";
}
x[0].addEventListener("blur", ()=> {
    if (x[0].value == "") {
        y[0].innerHTML = "Username <span class='error2'>⁕</span>";
    }
});
x[0].addEventListener("keydown", ()=> {
    y[0].innerHTML = "Username";
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
x[1].addEventListener("keydown", ()=> {
    y[1].innerHTML = "Email";
});
if (x[2].value == "") {
    y[2].innerHTML = "Password <span class='error2'>⁕</span>";
}
x[2].addEventListener("blur", ()=> {
    if (x[2].value == "") {
        y[2].innerHTML = "Password <span class='error2'>⁕</span>";
    }
});
x[2].addEventListener("keydown", ()=> {
    y[2].innerHTML = "Password";
});
if (x[3].value == "") {
    y[3].innerHTML = "Confirm-Password <span class='error2'>⁕</span>";
}
x[3].addEventListener("blur", ()=> {
    if (x[3].value == "") {
        y[3].innerHTML = "Confirm-Password <span class='error2'>⁕</span>";
    }
});
x[3].addEventListener("keydown", ()=> {
    y[3].innerHTML = "Confirm-Password";
});