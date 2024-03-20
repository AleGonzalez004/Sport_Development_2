document.addEventListener('DOMContentLoaded', function(){
    const ContenedorFooter = document.getElementById("footer_contenedor");
    const footerHTML = FooterLogin();

    ContenedorFooter.innerHTML = footerHTML;
})