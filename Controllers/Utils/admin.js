function MenuIndex() {
    const Menu =
        `<nav class="navbar navbar-expand-lg" style="background-color: #245C9D;" id="Navbar">
    <div class="container-fluid">
        <img src="/Resources/Images/logo_blanco.png" class="border-0" alt="..."
            style="height: 45px; width: 45px; background-color: #245C9D;">
        <button class="navbar-toggler border-0 text-white" type="button" data-bs-toggle="collapse"
            data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false"
            aria-label="Toggle navigation">
            <span class="bi bi-list text-white"></span>
        </button>
        <div class="collapse navbar-collapse  text-white" id="navbarNav">
            <ul class="navbar-nav  text-white">
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle text-white px-4" href="#" role="button"
                        data-bs-toggle="dropdown" aria-expanded="false">
                        <i class="bi bi-tags-fill"></i> Categorias
                    </a>
                    <ul class="dropdown-menu">
                        <li><a class="dropdown-item" href="#" onclick="Categorias()">Categorias</a></li>
                        <li><a class="dropdown-item" href="#" onclick="Deportes()">Deportes</a></li>
                        <li><a class="dropdown-item" href="#" onclick="Generos()">Generos</a></li>
                        <li><a class="dropdown-item" href="#" onclick="Imagenes()">Imagenes</a></li>
                        <li><a class="dropdown-item" href="#" onclick="Marcas()">Marcas</a></li>
                        <li><a class="dropdown-item" href="#" onclick="Tallas()">Tallas</a></li>
                    </ul>
                </li>
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle text-white px-4" href="#" role="button"
                        data-bs-toggle="dropdown" aria-expanded="false">
                        <i class="bi bi-people-fill"></i> Usuarios
                    </a>
                    <ul class="dropdown-menu">
                        <li><a class="dropdown-item" href="#" onclick="Clientes()">Clientes</a></li>
                        <li><a class="dropdown-item" href="#" onclick="Administradores()">Administradores</a></li>
                    </ul>
                </li>
                <li class="nav-item">
                    <a class="nav-link  text-white px-4" href="#" onclick="Productos()"><i class="bi bi-box-seam-fill"></i> Productos</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link  text-white px-4" href="#" onclick="Graficos()"><i class="bi bi-pie-chart-fill"></i> Graficos</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link  text-white px-4" href="#" onclick="Comentarios()"><i class="bi bi-chat-left-text-fill"></i>
                        Comentarios</a>
                </li>
                <li class="nav-item">
                  <a class="nav-link  text-white px-4" href="#" onclick="Perfil()"><i class="bi bi-person-fill-gear px-1"></i>Perfil</a>
                </li>
            </ul>
        </div>
    </div>
</nav>`;
    return Menu;
}

document.addEventListener('DOMContentLoaded', function(){
    const ContenedorMenu = document.getElementById("menu_navbar");
    const menuHTML = MenuIndex();

    ContenedorMenu.innerHTML = menuHTML;
})

function FooterIndex() {
    const MenuL =
        `<footer class="container-fluid bg-dark text-white text-center">
    <div class="row align-items-center">
        <div class="col-md-4 text-end">
            <h2 style="margin-right: 20px;">Sport Development</h2>
        </div>
        <div class="col-md-4 text-center">
            <p class="text-justify" style="font-size: 15px;">A través del deporte, tenemos el poder de
                cambiar vidas. El deporte nos mantiene en forma. Nos mantienen atentos y nos unen. Los atletas
                nos inspiran. Nos ayudan a levantarnos y movernos. Y los artículos deportivos con las últimas
                tecnologías nos
                ayudan a batir nuestra mejor marca personal.</p>
        </div>
        <div class="col-md-4 text-start">
            <div class="social-icons text-start">
                <a href="https://www.instagram.com/"><i class="bi bi-instagram fs-3 px-2 text-white"></i></a>
                <a href="https://www.facebook.com/"><i class="bi bi-facebook fs-3 px-2 text-white"></i></a>
                <a href="https://www.tiktok.com/"><i class="bi bi-tiktok fs-3 px-2 text-white"></i></a>
                <a href="https://www.youtube.com/"><i class="bi bi-youtube fs-3 px-2 text-white"></i></i></a>
                <p style="font-size: 10px; margin-left: 20px;">2024 Sport Development, San Salvador, El
                    Salvador.</p>
            </div>
        </div>
    </div>
</footer>`;
    return MenuL;
}

document.addEventListener('DOMContentLoaded', function(){
    const ContenedorFooter = document.getElementById("footer_contenedor");
    const footerHTML = FooterIndex();

    ContenedorFooter.innerHTML = footerHTML;
})

function Categorias() {
    window.location.href = "/Views/Admin/categoria.html";
}
function Deportes() {
    window.location.href = "/Views/Admin/deporte.html";
}
function Generos() {
    window.location.href = "/Views/Admin/genero.html";
}
function Imagenes() {
    window.location.href = "/Views/Admin/imagen.html";
}
function Marcas() {
    window.location.href = "/Views/Admin/marca.html";
}
function Tallas() {
    window.location.href = "/Views/Admin/talla.html";
}
function Clientes() {
    window.location.href = "/Views/Admin/cliente.html";
}
function Administradores() {
    window.location.href = "/Views/Admin/admin.html";
}
function Productos() {
    window.location.href = "/Views/Admin/producto.html";
}
function Graficos() {
    window.location.href = "/Views/Admin/grafico.html";
}
function Comentarios() {
    window.location.href = "/Views/Admin/comentario.html";
}
function Perfil() {
    window.location.href = "/Views/Admin/perfil.html";
}
