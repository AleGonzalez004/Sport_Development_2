<?php
// Se incluye la clase del modelo.
require_once('/Api/Models/Data/marcas_data.php');

// Se comprueba si existe una acción a realizar, de lo contrario se finaliza el script con un mensaje de error.
if (isset($_GET['action'])) {
    // Se crea una sesión o se reanuda la actual para poder utilizar variables de sesión en el script.
    session_start();
    // Se instancia la clase correspondiente.
    $marcas = new MarcasData;
    // Se declara e inicializa un arreglo para guardar el resultado que retorna la API.
    $result = array('status' => 0, 'session' => 0, 'message' => null, 'dataset' => null, 'error' => null, 'exception' => null);
    // Se verifica si existe una sesión iniciada como administrador, de lo contrario se finaliza el script con un mensaje de error.
    if (isset($_SESSION['idAdmin'])) {
        $result['session'] = 1;
        // Se compara la acción a realizar cuando un administrador ha iniciado sesión.
        switch ($_GET['action']) {
            case 'searchRows':
                if (!Validator::validateSearch($_POST['search'])) {
                    $result['error'] = Validator::getSearchError();
                } elseif ($result['dataset'] = $marcas->searchRows()) {
                    $result['status'] = 1;
                    $result['message'] = 'Existen ' . count($result['dataset']) . ' coincidencias';
                } else {
                    $result['error'] = 'No hay coincidencias.';
                }
                break;
            case 'createRow':
                $_POST = Validator::validateForm($_POST);
                if (!$marcas->setNombre($_POST['nombreMarca'])) {
                    $result['error'] = $marcas->getDataError();
                } elseif (!$marcas->setImagen($_POST['imagenMarca'])) {
                    $result['error'] = $marcas->getDataError();
                } elseif ($marcas->createRow()) {
                    $result['status'] = 1;
                    $result['message'] = 'Marca creada correctamente.';
                } else {
                    $result['error'] = 'Ocurrió un problema al crear la marca.';
                }
                break;
            case 'readAll':
                if ($result['dataset'] = $marcas->readAll()) {
                    $result['status'] = 1;
                    $result['message'] = 'Existen ' . count($result['dataset']) . ' registros';
                } else {
                    $result['error'] = 'No existen marcas registradas.';
                }
                break;
            case 'readOne':
                if (!$marcas->setId($_POST['idMarca'])) {
                    $result['error'] = $marcas->getDataError();
                } elseif ($result['dataset'] = $marcas->readOne()) {
                    $result['status'] = 1;
                } else {
                    $result['error'] = 'Marca inexistente.';
                }
                break;
            case 'updateRow':
                $_POST = Validator::validateForm($_POST);
                if (!$marcas->setId($_POST['idMarca'])) {
                    $result['error'] = $marcas->getDataError();
                } elseif (!$marcas->setNombre($_POST['nombreMarca'])) {
                    $result['error'] = $marcas->getDataError();
                } elseif (!$marcas->setImagen($_POST['imagenMarca'])) {
                    $result['error'] = $marcas->getDataError();
                } elseif ($marcas->updateRow()) {
                    $result['status'] = 1;
                    $result['message'] = 'Marca modificada correctamente.';
                } else {
                    $result['error'] = 'Ocurrió un problema al modificar la marca.';
                }
                break;
            case 'deleteRow':
                if (!$marcas->setId($_POST['idMarca'])) {
                    $result['error'] = $marcas->getDataError();
                } elseif ($marcas->deleteRow()) {
                    $result['status'] = 1;
                    $result['message'] = 'Marca eliminada correctamente';
                } else {
                    $result['error'] = 'Ocurrió un problema al eliminar la marca';
                }
                break;
            default:
                $result['error'] = 'Acción no disponible dentro de la sesión.';
        }
    } else {
        // Se compara la acción a realizar cuando el administrador no ha iniciado sesión.
        switch ($_GET['action']) {
            case 'readRows':
                if ($marcas->readAll()) {
                    $result['status'] = 1;
                    $result['message'] = 'Debe autenticarse para ingresar.';
                } else {
                    $result['error'] = 'Debe crear una marca para comenzar.';
                }
                break;
            default:
                $result['error'] = 'Acción no disponible fuera de la sesión';
        }
    }
    // Se obtiene la excepción del servidor de base de datos por si ocurrió un problema.
    $result['exception'] = Database::getException();
    // Se indica el tipo de contenido a mostrar y su respectivo conjunto de caracteres.
    header('Content-type: application/json; charset=utf-8');
    // Se imprime el resultado en formato JSON y se retorna al controlador.
    print(json_encode($result));
} else {
    print(json_encode('Recurso no disponible'));
}