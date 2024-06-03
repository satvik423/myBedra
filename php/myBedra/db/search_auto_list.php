<?php
$item=array();
$item_list=array();

include 'dbcon.php';
//$bg="a+";
$stand=$_GET['standName'];
 //$stand="Vidyagiri";

$query=mysqli_query($conn,"select auto_name,auto_number,auto_stand from auto_rikshaw where auto_stand='$stand' ");

while ($f=mysqli_fetch_array($query)) {
$auto_name= $f['auto_name'];
$auto_number= $f['auto_number'];
$auto_stand= $f['auto_stand'];


$item["auto_name"]=$auto_name;
$item["auto_number"]=$auto_number;
$item["auto_stand"]=$auto_stand;
$item_list[]=$item;




}
echo json_encode($item_list);





?>