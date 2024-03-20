document.addEventListener('DOMContentLoaded', function(){
    const ContenedorMenu = document.getElementById("menulogin_contenedor");
    const menuloginHTML = MenuLogin();

    ContenedorMenu.innerHTML = menuloginHTML;
})