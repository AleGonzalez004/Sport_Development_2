<?php
// Se incluye la clase para trabajar con la base de datos.
require_once('/Api/Helpers/database.php');
/*
*	Clase para manejar el comportamiento de los datos de la tabla PRODUCTO.
*/
class ProductoHandler
{
    /*
    *   Declaración de atributos para el manejo de datos.
    */
    protected $id = null;
    protected $nombre = null;
    protected $descripcion = null;
    protected $precio = null;
    protected $estado = null;
    protected $id_marca = null;
    protected $id_deporte = null;
    protected $id_genero = null;
    protected $id_categoria = null;

    /*
    *   Métodos para realizar las operaciones SCRUD (search, create, read, update, and delete).
    */
    public function searchRows()
    {
        $value = '%' . Validator::getSearchValue() . '%';
        $sql = 'SELECT id_producto, imagen_producto, nombre_producto, descripcion_producto, precio_producto, nombre_categoria, estado_producto
                FROM tb_productos
                INNER JOIN categoria USING(id_categoria)
                WHERE nombre_producto LIKE ? OR descripcion_producto LIKE ?
                ORDER BY nombre_producto';
        $params = array($value, $value);
        return Database::getRows($sql, $params);
    }

    public function createRow()
    {
        $sql = 'INSERT INTO tb_productos(nombre, descripcion, precio, estado_producto, id_marca, id_deporte, id_genero, id_categoria)
                VALUES(?, ?, ?, ?, ?, ?, ?, ?)';
        $params = array($this->nombre, $this->descripcion, $this->precio, $this->estado, $this->id_marca, $this->id_deporte, $this->id_genero, $this->id_categoria, $_SESSION['idAdministrador']);
        return Database::executeRow($sql, $params);
    }

    public function readAll()
    {
        $sql = 'SELECT id_producto, nombre, descripcion, precio, estado_producto, id_marca, id_deporte, id_genero, id_categoria
                FROM tb_productos
                INNER JOIN tb_categorias USING(id_categoria)
                ORDER BY nombre';
        return Database::getRows($sql);
    }

    public function readOne()
    {
        $sql = 'SELECT id_producto, nombre, descripcion, precio, estado_producto, id_marca, id_deporte, id_genero, id_categoria,
                FROM tb_productos
                WHERE id_producto = ?';
        $params = array($this->id);
        return Database::getRow($sql, $params);
    }

    public function updateRow()
    {
        $sql = 'UPDATE tb_productos
                SET nombre = ?, descripcion = ?, precio = ?, estado_producto = ?, id_marca = ?, id_deporte = ?, id_genero = ?, id_categoria = ?
                WHERE id_producto = ?';
        $params = array($this->nombre, $this->descripcion, $this->precio, $this->estado, $this->id_marca, $this->id_deporte, $this->id_genero, $this->id_categoria,);
        return Database::executeRow($sql, $params);
    }

    public function deleteRow()
    {
        $sql = 'DELETE FROM tb_productos
                WHERE id_producto = ?';
        $params = array($this->id);
        return Database::executeRow($sql, $params);
    }
}
