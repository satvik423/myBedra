<?php
$item=array();
$item1=array();
$item_list=array();



include 'dbcon.php';
$query=mysqli_query($conn,"select distinct(auto_stand)from auto_rikshaw");
while ($f=mysqli_fetch_array($query)) {
$data= $f['auto_stand'];

$item["data"]=$data;


$item_list[]=$item;




}
echo json_encode($item_list);





?>