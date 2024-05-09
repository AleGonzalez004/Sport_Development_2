document.addEventListener('DOMContentLoaded', function(){
    const ContenedorFooter = document.getElementById("footer_contenedor");
    const footerHTML = FooterIndex();

    ContenedorFooter.innerHTML = footerHTML;
})