<?php 
// DB credentials.

try
{
$con = mysqli_connect("localhost","root","","connectm");
}
catch (PDOException $e)
{
exit("Error: " . $e->getMessage());
}
?>