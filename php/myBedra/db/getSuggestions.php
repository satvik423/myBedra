<?php
$item=array();
$item1=array();
$item_list=array();
$item_list1=array();
$item_list_final=array();


include 'dbcon.php';
$patern=$_GET['q'];
//$patern='advoc';
$query=mysqli_query($conn,"select distinct(category) from connect where category like '%$patern%'");
while ($f=mysqli_fetch_array($query)) {
// $data= $f['name'];
$cat= $f['category'];

// $item["data"]=$data;
$item["data"]=$cat;


$item_list[]=$item;
// $item_list1[]=$item1;


}


$query1=mysqli_query($conn,"select distinct(cname) from connect where cname like '%$patern%'");
while ($f1=mysqli_fetch_array($query1)) {
$data1= $f1['cname'];
// $cat= $f['category'];

$item1["data"]=$data1;
// $item1["data"]=$cat;

$item_list1[]=$item1;



}





$item_list_final=array_merge($item_list,$item_list1);
echo '{'.json_encode($item_list_final).'}';





?>
