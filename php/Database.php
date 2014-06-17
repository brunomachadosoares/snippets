<?php

class Database
{
    private $connection;
    private $query;
    private $database;
    private $host;
    private $user;
    private $passwd;

    function Database()
    {
        $this->query = NULL;
        $this->connection = NULL;

        $this->host = 'localhost';
        $this->user = 'root';
        $this->passwd = 'root';
        $this->database = 'tutor';
    }

    function connect()
    {
        $this->connection = new mysqli($this->host, $this->user, $this->passwd, 'tutor');
    }

    function disconnect()
    {
        $this->connection = NULL;
        $this->query = NULL;
        $this->database = NULL;
        $this->host = NULL;
        $this->user = NULL;
        $this->passwd = NULL;
    }

    function selectById($tableName, $id)
    {
        $mainRow = Array();
        $statement = $this->connection->prepare( "SELECT * FROM $tableName WHERE id = ?" );
        $statement->bind_param("i", $id);
        $statement->execute();
        $res = $statement->get_result();
        while($row = $res->fetch_assoc()) {
            $mainRow[] = $row;
        }
        return json_encode($mainRow);
    }

    function selectAll($tableName)
    {
        $mainRow = Array();
        $statement = $this->connection->prepare( "SELECT * FROM $tableName" );
        $statement->execute();
        $res = $statement->get_result();
        while($row = $res->fetch_assoc()) {
            $mainRow[] = $row;
        }

        return json_encode($mainRow);
    }

}

?>
