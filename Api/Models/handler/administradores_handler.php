<?php

require_once('../../Helpers/database.php');

class AdministradorHandler
{
    protected $id = null;
    protected $nombre = null;
    protected $apellido = null;
    protected $correo = null;
    protected $usuario = null;
    protected $clave = null;
    protected $cargo = null;

    public function checkUser($username, $password)
    {
        $sql = 'SELECT id_admin, usuario, clave
                FROM tb_administradores
                WHERE  usuario = ?';
        $params = array($username);
        $data = Database::getRow($sql, $params);
        if (password_verify($password, $data['clave'])) {
            $_SESSION['idAdmin'] = $data['id_admin'];
            $_SESSION['usuarioAdmin'] = $data['usuario'];
            return true;
        } else {
            return false;
        }
    }

    public function checkPassword($password)
    {
        $sql = 'SELECT clave
                FROM tb_administradores
                WHERE id_admin = ?';
        $params = array($_SESSION['idAdmin']);
        $data = Database::getRow($sql, $params);

        if (password_verify($password, $data['clave'])) {
            return true;
        } else {
            return false;
        }
    }

    public function changePassword()
    {
        $sql = 'UPDATE tb_administradores
                SET clave = ?
                WHERE id_admin = ?';
        $params = array($this->clave, $_SESSION['idadminp']);
        return Database::executeRow($sql, $params);
    }

    public function readProfile()
    {
        $sql = 'SELECT id_admin, nombre, apellido, correo, usuario, cargo
                FROM tb_administradores
                WHERE id_admin = ?';
        $params = array($_SESSION['idAdmin']);
        return Database::getRow($sql, $params);
    }

    public function editProfile()
    {
        $sql = 'UPDATE tb_administradores
                SET nombre = ?, apellido = ?, correo = ?, usuario = ?
                WHERE id_admin = ?';
        $params = array($this->nombre, $this->apellido, $this->correo, $this->usuario, $_SESSION['idAdmin']);
        return Database::executeRow($sql, $params);
    }

    public function searchRows()
    {
        $value = '%' . Validator::getSearchValue() . '%';
        $sql = 'SELECT id_admin, nombre, apellido, correo, usuario, cargo
                FROM tb_administradores
                WHERE apellido LIKE ? OR nombre LIKE ?
                ORDER BY apellido';
        $params = array($value, $value);
        return Database::getRows($sql, $params);
    }

    public function createRow()
    {
        $sql = 'INSERT INTO tb_administradores(nombre, apellido, correo, usuario, clave, cargo)
                VALUES(?, ?, ?, ?, ?, ?)';
        $params = array($this->nombre, $this->apellido, $this->correo, $this->usuario, $this->clave, $this->cargo);
        return Database::executeRow($sql, $params);
    }

    public function readAll()
    {
        $sql = 'SELECT id_admin, nombre, apellido, correo, usuario, cargo
                FROM tb_administradores
                ORDER BY apellido';
        return Database::getRows($sql);
    }

    public function readOne()
    {
        $sql = 'SELECT id_admin, nombre, apellido, correo, usuario, cargo
                FROM tb_administradores
                WHERE id_admin = ?';
        $params = array($this->id);
        return Database::getRow($sql, $params);
    }

    public function updateRow()
    {
        $sql = 'UPDATE tb_administradores
                SET nombre = ?, apellido = ?, correo = ?
                WHERE id_admin = ?';
        $params = array($this->nombre, $this->apellido, $this->correo, $this->id);
        return Database::executeRow($sql, $params);
    }

    public function deleteRow()
    {
        $sql = 'DELETE FROM tb_administradores
                WHERE id_admin = ?';
        $params = array($this->id);
        return Database::executeRow($sql, $params);
    }
}
