<?php

require "../config/connect.php";

if ($_SERVER['REQUEST_METHOD'] == "POST") {
    # code...
    $response = array();
    $username = $_POST['username'];
    $password = md5($_POST['password']);


    $cek = "SELECT * FROM users WHERE username='$username' and password='$password'";
    $result = mysqli_fetch_array(mysqli_query($con, $cek));

    if (isset($result)) {
        # code...
        $response['value'] = 1;
        $response['message'] = "Login Berhasil";
        $response['username'] = $result['username'];
        $response['nama'] = $result['nama'];
        $response['id'] = $result['id'];
        echo json_encode($response);
    } else {
        $response['value'] = 0;
        $response['message'] = "Login Gagal";
        echo json_encode($response);
    }
}
