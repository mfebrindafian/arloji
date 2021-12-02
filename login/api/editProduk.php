<?php

require "../config/connect.php";

if ($_SERVER['REQUEST_METHOD'] == "POST") {
    # code...
    $response = array();
    $namaProduk = $_POST['namaProduk'];
    $qty = $_POST['qty'];
    $desProduk = $_POST['desProduk'];
    $harga = $_POST['harga'];
    $idProduk = $_POST['idProduk'];

    $insert = "UPDATE produk SET namaProduk ='$namaProduk', qty = '$qty', desProduk = '$desProduk' , harga = '$harga' WHERE id='$idProduk' ";
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
