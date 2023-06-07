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

// Check if user is authorized
$isAuthorized = true; // Assuming user is authorized

if (!$isAuthorized) {
  $response = array('success' => false, 'message' => 'Unauthorized');
  echo json_encode($response);
  exit();
}

// Check if URL is provided
if (!isset($_POST['url'])) {
  $response = array('success' => false, 'message' => 'Please provide a URL');
  echo json_encode($response);
  exit();
}

// Get URL from request
$url = $_POST['url'];

// Check if URL is empty
if (empty($url)) {
  $response = array('success' => false, 'message' => 'Please enter a URL');
  echo json_encode($response);
  exit();
}

// Generate short URL
$shortUrl = generateShortUrl();

// Check if generated short URL already exists in the database
$stmt = $conn->prepare("SELECT * FROM urls WHERE short_url = ?");
$stmt->bind_param("s", $shortUrl);
$stmt->execute();
$result = $stmt->get_result();

// Regenerate short URL if it already exists in the database
while ($result->num_rows > 0) {
  $shortUrl = generateShortUrl();
  $stmt->execute();
  $result = $stmt->get_result();
}

// Save URL in the database
$stmt = $conn->prepare("INSERT INTO urls (url, short_url) VALUES (?, ?)");
$stmt->bind_param("ss", $url, $shortUrl);

if ($stmt->execute()) {
  $response = array('success' => true, 'message' => 'URL saved successfully', 'short_url' => $shortUrl);
  echo json_encode($response);
} else {
  $response = array('success' => false, 'message' => 'URL save failed');
  echo json_encode($response);
}

$stmt->close();
$conn->close();

// Function to generate short URL
function generateShortUrl() {
  $characters = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
  $shortUrl = '';

  for ($i = 0; $i < 6; $i++) {
    $index = rand(0, strlen($characters) - 1);
    $shortUrl .= $characters[$index];
  }

  return $shortUrl;
}
?>
