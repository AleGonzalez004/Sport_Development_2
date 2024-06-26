function MenuIndex() {
    const Menu =
        `<nav class="navbar navbar-expand-lg" style="background-color: #245C9D;" id="Navbar">
    <div class="container-fluid">
        <img src="/Recursos/Imagenes/logo_blanco.png" class="border-0" alt="..."
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
                        <li><a class="dropdown-item" href="#" onclick="Clientes()">Administradores</a></li>
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


