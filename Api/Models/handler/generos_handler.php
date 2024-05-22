<?php
// Se incluye la clase para trabajar con la base de datos.
require_once('/Api/Helpers/database.php');

/*
 *  Clase para manejar el comportamiento de los datos de la tabla tb_generos.
 */
class GenerosHandler
{
    /*
     *  Declaración de atributos para el manejo de datos.
     */
    protected $id_genero = null;
    protected $nombre = null;

    /*
     *  Métodos para gestionar los datos de los géneros.
     */
    public function setId($value)
    {
        if (Validator::validateNaturalNumber($value)) {
            $this->id_genero = $value;
            return true;
        } else {
            $this->data_error = 'El identificador del género es incorrecto.';
            return false;
        }
    }

    public function setNombre($value, $min = 2, $max = 50)
    {
        if (!Validator::validateAlphabetic($value)) {
            $this->data_error = 'El nombre debe ser un valor alfabético';
            return false;
        } elseif (Validator::validateLength($value, $min, $max)) {
            $this->nombre = $value;
            return true;
        } else {
            $this->data_error = 'El nombre debe tener una longitud entre ' . $min . ' y ' . $max;
            return false;
        }
    }

    /*
     *  Métodos para realizar las operaciones SCRUD (search, create, read, update, and delete).
     */
    public function searchRows()
    {
        $value = '%' . Validator::getSearchValue() . '%';
        $sql = 'SELECT id_genero, nombre
                FROM tb_generos
                WHERE nombre LIKE ?
                ORDER BY nombre';
        $params = array($value);
        return Database::getRows($sql, $params);
    }

    public function createRow()
    {
        $sql = 'INSERT INTO tb_generos(nombre)
                VALUES(?)';
        $params = array($this->nombre);
        return Database::executeRow($sql, $params);
    }

    public function readAll()
    {
        $sql = 'SELECT id_genero, nombre
                FROM tb_generos
                ORDER BY nombre';
        return Database::getRows($sql);
    }

    public function readOne()
    {
        $sql = 'SELECT id_genero, nombre
                FROM tb_generos
                WHERE id_genero = ?';
        $params = array($this->id_genero);
        return Database::getRow($sql, $params);
    }

    public function updateRow()
    {
        $sql = 'UPDATE tb_generos
                SET nombre = ?
                WHERE id_genero = ?';
        $params = array($this->nombre, $this->id_genero);
        return Database::executeRow($sql, $params);
    }

    public function deleteRow()
    {
        $sql = 'DELETE FROM tb_generos
                WHERE id_genero = ?';
        $params = array($this->id_genero);
        return Database::executeRow($sql, $params);
    }
}
