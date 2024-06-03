<?php
include 'dbcon.php';
$value=array();
$valu_list=array();
$patern=$_GET['Patern'];
$query=mysqli_query($conn,"select * from connect where name like '%$patern%' or category like '%$patern%' order by name ASC ");
while ($f=mysqli_fetch_array($query)) {
	$value['name']=$f['name'];
	$value['contact1']=$f['contact1'];
	$value['contact2']=$f['contact2'];
	$value['category']=$f['category'];
	$value['imgPath']=$f['imgPath'];
	$valu_list[]=$value;
}
echo json_encode($valu_list) ;

?>