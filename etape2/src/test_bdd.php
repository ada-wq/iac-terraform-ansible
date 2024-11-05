<?php
$mysqli = new mysqli("data", "user", "password", "testdb");

if ($mysqli->connect_error) {
    die("Connection failed: " . $mysqli->connect_error);
}

// Création de la table si elle n'existe pas déjà
$mysqli->query("CREATE TABLE IF NOT EXISTS test (id INT AUTO_INCREMENT PRIMARY KEY, content VARCHAR(255) NOT NULL)");

// Insertion d'une donnée d'exemple
$mysqli->query("INSERT INTO tesst (content) VALUES ('Hello, world!')");

// Lecture des données
$result = $mysqli->query("SELECT * FROM test");
while ($row = $result->fetch_assoc()) {
    echo "ID: " . $row['id'] . " - Content: " . $row['content'] . "<br>";
}

$mysqli->close();
?>
