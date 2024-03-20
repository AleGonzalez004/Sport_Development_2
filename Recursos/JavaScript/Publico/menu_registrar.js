function MenuRegistar() {
    const MenuL = 
    `<nav class="navbar navbar-expand-md bg-body ">
    <div class="container-fluid d-flex justify-content-end">
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarTogglerDemo01"
            aria-controls="navbarTogglerDemo01" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="justify-content-end collapse navbar-collapse" id="navbarTogglerDemo01">
            <div id="menu">
                <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                </ul>
                <form class="d-flex">
                    <ul class="navbar-nav me-auto mb-2 mb-lg-0 justify-content-end " id="menu">
                        <li class="nav-item p-2">
                            <a class="nav-link p-2" href="/Vistas/Publico/index.html"> Inicio .<span
                                    class="icon bi-box2-fill"></span></a>
                        </li>
                        <li class="nav-item p-2">
                            <a class="nav-link p-2 justify-content-end" href="/Vistas/Publico/login.html"> Iniciar Sesión
                                .<span class="icon bi-door-open-fill"></span></a>
                        </li>
                        <li class="nav-item p-2">
                            <a class="nav-link p-2 justify-content-end" href="/Vistas/Publico/catalogo.html"> Catalogo
                                .<span class="icon bi-wallet-fill"></span></a>
                        </li>
                    </ul>
                </form>
            </div>
        </div>
    </div>
</nav>`;

    return MenuL;
}