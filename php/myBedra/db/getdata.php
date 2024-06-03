<?php
$item=array();
$item1=array();
$item_list=array();
$item_list1=array();
$item_list_final=array();


include 'dbcon.php';
$query=mysqli_query($conn,"select distinct(category) from connect");
while ($f=mysqli_fetch_array($query)) {
// $data= $f['name'];
$cat= $f['category'];

// $item["data"]=$data;
$item["data"]=$cat;


$item_list[]=$item;
// $item_list1[]=$item1;




}



$query1=mysqli_query($conn,"select distinct(name) from connect");
while ($f1=mysqli_fetch_array($query1)) {
$data1= $f1['name'];
// $cat= $f['category'];

$item1["data"]=$data1;
// $item1["data"]=$cat;

$item_list1[]=$item1;



}





$item_list_final=array_merge($item_list,$item_list1);
echo json_encode($item_list_final);





?>