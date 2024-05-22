<?php
// Se incluye la clase para trabajar con la base de datos.
require_once('/Api/Helpers/database.php');
/*
 *  Clase para manejar el comportamiento de los datos de la tabla tb_marcas.
 */
class MarcasHandler
{
    /*
     *  Declaración de atributos para el manejo de datos.
     */
    protected $id = null;
    protected $nombre = null;
    protected $imagen = null;

    /*
     *  Métodos para realizar las operaciones SCRUD (search, create, read, update, and delete).
     */
    public function searchRows()
    {
        $value = '%' . Validator::getSearchValue() . '%';
        $sql = 'SELECT id_marca, nombre, imagen 
                FROM tb_marcas
                WHERE nombre LIKE ?
                ORDER BY nombre';
        $params = array($value);
        return Database::getRows($sql, $params);
    }

    public function createRow()
    {
        $sql = 'INSERT INTO tb_marcas(nombre, imagen)
                VALUES(?, ?)';
        $params = array($this->nombre, $this->imagen);
        return Database::executeRow($sql, $params);
    }

    public function readAll()
    {
        $sql = 'SELECT id_marca, nombre, imagen
                FROM tb_marcas
                ORDER BY nombre';
        return Database::getRows($sql);
    }

    public function readOne()
    {
        $sql = 'SELECT id_marca, nombre, imagen
                FROM tb_marcas
                WHERE id_marca = ?';
        $params = array($this->id);
        return Database::getRow($sql, $params);
    }

    public function updateRow()
    {
        $sql = 'UPDATE tb_marcas
                SET nombre = ?, imagen = ?
                WHERE id_marca = ?';
        $params = array($this->nombre, $this->imagen, $this->id);
        return Database::executeRow($sql, $params);
    }

    public function deleteRow()
    {
        $sql = 'DELETE FROM tb_marcas
                WHERE id_marca = ?';
        $params = array($this->id);
        return Database::executeRow($sql, $params);
    }
}