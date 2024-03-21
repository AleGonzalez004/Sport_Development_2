function MenuIndex() {
    const Menu =
        `<header class="custom-header text-white" style="background-color: #245C9D;">
        <div class="container" style="background-color: #245C9D;">
            <h1>SPORT DEVELOPMENT <img src="/Recursos/Imagenes/logo_blanco.png" style="height: 5%; width: 5%;"></h1>
            <nav class="navbar navbar-expand-lg navbar-light text-white" style="background-color: #245C9D;">
                <!-- Botón para dispositivos móviles -->
                <button class="navbar-toggler text-white" type="button" data-toggle="collapse" data-target="#navbarNav"
                    aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="bi bi-list"></span>
                </button>
                <!-- Menú de navegación -->
                <div class="collapse navbar-collapse" id="navbarNav">
                    <ul class="navbar-nav">
                        <li class="nav-item active">
                            <a class="nav-link text-white" href="/Vistas/Publico/catalogo.html">Descuentos <span class="sr-only"></span></a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link text-white" href="/Vistas/Publico/catalogo.html">Hombres</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link text-white" href="/Vistas/Publico/catalogo.html">Mujeres</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link text-white" href="/Vistas/Publico/catalogo.html">Niños</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link text-white" href="/Vistas/Publico/catalogo.html">Deportes</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link text-white" href="/Vistas/Publico/catalogo.html">Accesorios</a>
                        </li>
                    </ul>
                </div>
            </nav>
            <div class="container">
                <div class="row justify-content-end">
                    <div class="col-auto">
                        <input class="form-control" type="search" placeholder="Buscar" aria-label="Buscar">
                    </div>
                    <div class="col-auto">
                        <button class="btn btn-dark" type="submit">Buscar</button>
                        <a href="/Vistas/Publico/lista_deseo.html"><i class="bi bi-heart fs-5 px-2"></i></a>
                        <a href="/Vistas/Publico/login.html"><i class="bi bi-person-add fs-5 px-2"></i></a>
                        <a href="/Vistas/Publico/carrito_lleno.html"><i class="bi bi-cart fs-5 px-2"></i></a>


                    </div>
                </div>
            </div>
            <div class="p-2"></div>
        </div>
    </header>`;

    return Menu;
}


