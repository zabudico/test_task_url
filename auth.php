<?php
header('Content-Type: application/json');

// Database configuration
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "url_shortener";

$conn = new mysqli($servername, $username, $password, $dbname);

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error); 
}

// Registration
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
  $name = $_POST['name'];
  $login = $_POST['login'];
  $password = $_POST['password'];

  // Check if user with same login already exists
  $stmt = $conn->prepare("SELECT * FROM users WHERE login = ?");
  $stmt->bind_param("s", $login);
  $stmt->execute();
  $result = $stmt->get_result();

  if ($result->num_rows > 0) {
    $response = array('success' => false, 'message' => 'User with this login already exists');
    echo json_encode($response);
  } elseif (empty($name) || empty($login) || empty($password)) {
    $response = array('success' => false, 'message' => 'Please fill in all fields');
    echo json_encode($response);
  } else {
    $hashedPassword = password_hash($password, PASSWORD_DEFAULT);

    // Registration
    $stmt = $conn->prepare("INSERT INTO users (name, login, password) VALUES (?, ?, ?)");
    $stmt->bind_param("sss", $name, $login, $hashedPassword);

    if ($stmt->execute()) {
      $response = array('success' => true, 'message' => 'Registration successful');
      echo json_encode($response);
    } else {
      $response = array('success' => false, 'message' => 'Registration failed');
      echo json_encode($response);
    }
  }
}

// Login
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
  $login = $_POST['login'];
  $password = $_POST['password'];

  // Get user by login
  $stmt = $conn->prepare("SELECT * FROM users WHERE login = ?");
  $stmt->bind_param("s", $login);
  $stmt->execute();
  $result = $stmt->get_result();

  if ($result->num_rows > 0) {
    $row = $result->fetch_assoc();
    $storedPassword = $row['password'];

    // Verify password
    if (password_verify($password, $storedPassword)) {
      $response = array('success' => true, 'message' => 'Login successful');
      echo json_encode($response);
    } else {
      $response = array('success' => false, 'message' => 'Incorrect password');
      echo json_encode($response);
    }
  } else {
    $response = array('success' => false, 'message' => 'User not found');
    echo json_encode($response);
  }
}

$stmt->close();
$conn->close();
?>
