<?php
$item=array();
$item_list=array();

include 'dbcon.php';
//$route="Karkala";
$route=$_GET['route'];
// $route="manglore";

$query=mysqli_query($conn,"select bus_name,bus_time,destination_name from bus_table where destination_name='$route' ");
while ($f=mysqli_fetch_array($query)) {
$bus_name= $f['bus_name'];
$bus_time= $f['bus_time'];
$destination_name= $f['destination_name'];


$item["bus_name"]=$bus_name;
$item["bus_time"]=$bus_time;
$item["destination_name"]=$destination_name;
$item_list[]=$item;




}
echo json_encode($item_list);





?>