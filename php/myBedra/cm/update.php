
<?php
session_start();
error_reporting(0);
include('includes/config.php');
$stid=1427;
$cname='Gendi';
$sql="update connect set cname=:cnamee where id=$stid "; 

$query = $dbh->prepare($sql);
//$query->bindParam(':stid',$stid,PDO::PARAM_STR);
$query->bindParam(':cnamee',$cname,PDO::PARAM_STR);

//$query->bindParam(':img',$simgtid,PDO::PARAM_STR);

$query->execute();
$msg="Data has been updated successfully";

?>