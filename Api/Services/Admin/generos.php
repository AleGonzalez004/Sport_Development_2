<?php
// Se incluye la clase del modelo.
require_once('/Api/Models/Data/generos_data.php');

// Se comprueba si existe una acción a realizar, de lo contrario se finaliza el script con un mensaje de error.
if (isset($_GET['action'])) {
    // Se crea una sesión o se reanuda la actual para poder utilizar variables de sesión en el script.
    session_start();
    // Se instancia la clase correspondiente.
    $generos = new GenerosData;
    // Se declara e inicializa un arreglo para guardar el resultado que retorna la API.
    $result = array('status' => 0, 'message' => null, 'dataset' => null, 'error' => null, 'exception' => null);
    // Se compara la acción a realizar.
    switch ($_GET['action']) {
        case 'searchRows':
            if (!Validator::validateSearch($_POST['search'])) {
                $result['error'] = Validator::getSearchError();
            } elseif ($result['dataset'] = $generos->searchRows()) {
                $result['status'] = 1;
                $result['message'] = 'Existen ' . count($result['dataset']) . ' coincidencias';
            } else {
                $result['error'] = 'No hay coincidencias.';
            }
            break;
        case 'createRow':
            if (!$generos->setNombre($_POST['genreName'])) {
                $result['error'] = $generos->getDataError();
            } elseif ($generos->createRow()) {
                $result['status'] = 1;
                $result['message'] = 'Género creado correctamente.';
            } else {
                $result['error'] = 'Ocurrió un problema al crear el género.';
            }
            break;
        case 'readAll':
            if ($result['dataset'] = $generos->readAll()) {
                $result['status'] = 1;
                $result['message'] = 'Existen ' . count($result['dataset']) . ' registros';
            } else {
                $result['error'] = 'No existen géneros registrados.';
            }
            break;
        case 'readOne':
            if (!$generos->setId($_POST['idGenero'])) {
                $result['error'] = $generos->getDataError();
            } elseif ($result['dataset'] = $generos->readOne()) {
                $result['status'] = 1;
            } else {
                $result['error'] = 'Género inexistente.';
            }
            break;
        case 'updateRow':
            if (!$generos->setId($_POST['idGenero']) or !$generos->setNombre($_POST['nombreGenero'])) {
                $result['error'] = $generos->getDataError();
            } elseif ($generos->updateRow()) {
                $result['status'] = 1;
                $result['message'] = 'Género modificado correctamente.';
            } else {
                $result['error'] = 'Ocurrió un problema al modificar el género.';
            }
            break;
        case 'deleteRow':
            if (!$generos->setId($_POST['idGenero'])) {
                $result['error'] = $generos->getDataError();
            } elseif ($generos->deleteRow()) {
                $result['status'] = 1;
                $result['message'] = 'Género eliminado correctamente';
            } else {
                $result['error'] = 'Ocurrió un problema al eliminar el género';
            }
            break;
        default:
            $result['error'] = 'Acción no disponible.';
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
