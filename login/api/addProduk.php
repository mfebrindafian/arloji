<?php

require "../config/connect.php";

if ($_SERVER['REQUEST_METHOD'] == "POST") {
    # code...
    $response = array();
    $namaProduk = $_POST['namaProduk'];
    $qty = $_POST['qty'];
    $desProduk = $_POST['desProduk'];
    $harga = $_POST['harga'];
    $idUsers = $_POST['idUsers'];

    $image = date('dmYHis') . str_replace(" ", "", basename($_FILES['image']['name']));
    $imagePath = "../upload/" . $image;
    move_uploaded_file($_FILES['image']['tmp_name'], $imagePath);


    $insert = "INSERT INTO produk VALUE(NULL,'$namaProduk','$qty','$desProduk','$harga','$image',NOW(),'$idUsers')";
    if (mysqli_query($con, $insert)) {
        # code...
        $response['value'] = 1;
        $response['message'] = "Berhasil ditambahkan";
        echo json_encode($response);
    } else {
        $response['value'] = 0;
        $response['message'] = "gagal ditambahkan";
        echo json_encode($response);
    }
}
