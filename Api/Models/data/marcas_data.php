<?php
// Se incluye la clase para validar los datos de entrada.
require_once('/Api/Helpers/validator.php');
// Se incluye la clase padre.
require_once('/Api/Models/Handler/marcas_handler.php');
/*
 *  Clase para manejar el encapsulamiento de los datos de la tabla tb_marcas.
 */
class MarcasData extends MarcasHandler
{
    // Atributo genérico para manejo de errores.
    private $data_error = null;

    /*
     *  Métodos para validar y asignar valores de los atributos.
     */
    public function setId($value)
    {
        if (Validator::validateNaturalNumber($value)) {
            $this->id = $value;
            return true;
        } else {
            $this->data_error = 'El identificador de la marca es incorrecto.';
            return false;
        }
    }

    public function setNombre($value, $min = 2, $max = 50)
    {
        if (!Validator::validateAlphabetic($value)) {
            $this->data_error = 'El nombre de la marca debe ser un valor alfabético';
            return false;
        } elseif (Validator::validateLength($value, $min, $max)) {
            $this->nombre = $value;
            return true;
        } else {
            $this->data_error = 'El nombre de la marca debe tener una longitud entre ' . $min . ' y ' . $max;
            return false;
        }
    }

    public function setImagen($value, $min = 0, $max = 255)
    {
        if (Validator::validateLength($value, $min, $max)) {
            $this->imagen = $value;
            return true;
        } else {
            $this->data_error = 'El campo imagen debe tener una longitud entre ' . $min . ' y ' . $max;
            return false;
        }
    }

    // Método para obtener el error de los datos.
    public function getDataError()
    {
        return $this->data_error;
    }
}
