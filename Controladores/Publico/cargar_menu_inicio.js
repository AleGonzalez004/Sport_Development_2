document.addEventListener('DOMContentLoaded', function(){
    const ContenedorMenu = document.getElementById("menu_navbar");
    const menuHTML = MenuIndex();

    ContenedorMenu.innerHTML = menuHTML;
})