<?php
$item=array();
$item1=array();
$item_list=array();



include 'dbcon.php';
$query=mysqli_query($conn,"select distinct(destination_name) from bus_table");
while ($f=mysqli_fetch_array($query)) {
$data= $f['destination_name'];

$item["data"]=$data;


$item_list[]=$item;




}
echo json_encode($item_list);





?>