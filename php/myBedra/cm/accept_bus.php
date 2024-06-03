
<?php
error_reporting(E_ALL);
include('includes/config.php'); //will only produce a warning (E_WARNING) and the script will continue
if(!empty($_POST["request_id"])) //post method 
{
  $request_id=intval($_POST['requestId']);

 if(!is_numeric($request_id)){
 
 	echo htmlentities("invalid bus_time");exit;
 }
 else{
    $review_flag =1;
    $sql="UPDATE new_bus_requests SET review_flag =1 WHERE request_id=$request_id ";
    $query = $dbh->prepare($sql);
  //  $query->bindParam(':review_flag',$review_flag,PDO::PARAM_STR); PDO php data objects
    $query->execute();

 $sql = "SELECT * from new_bus_requests where request_id=$request_id";
    $query = $dbh->prepare($sql);
    $query->execute();
    $results=$query->fetchAll(PDO::FETCH_OBJ);
$cnt=1;
if($query->rowCount() > 0)
{
foreach($results as $result)
{ 
  $sql="INSERT INTO bus_table(bus_name,bus_time,destination_name)VALUES(:bus_name,:bus_time,:destination_name)";
  $query = $dbh->prepare($sql);
  $query->bindParam(':bus_name',$result->bus_name,PDO::PARAM_STR);
  $query->bindParam(':bus_time',$result->bus_time,PDO::PARAM_STR);
  $query->bindParam(':destination_name',$result->destination_name,PDO::PARAM_STR);

$query->execute();
}
  
    
}

}

}


?>

