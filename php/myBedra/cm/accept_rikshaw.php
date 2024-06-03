
<?php
error_reporting(E_ALL);
include('includes/config.php');
if(!empty($_POST["rikshaw_id"])) 
{
  $rikshaw_id=intval($_POST['rikshaw_id']);

 if(!is_numeric($rikshaw_id)){
 
 	echo htmlentities("invalid bus_time");exit;
 }
 else{
    $review_flag =1;
    $sql="UPDATE new_rikshaw_requests SET review_flag =1 WHERE rikshaw_id=$rikshaw_id ";
    $query = $dbh->prepare($sql);
  //  $query->bindParam(':review_flag',$review_flag,PDO::PARAM_STR);
    $query->execute();

 $sql = "SELECT * from new_rikshaw_requests where rikshaw_id=$rikshaw_id";
    $query = $dbh->prepare($sql);
    $query->execute();
    $results=$query->fetchAll(PDO::FETCH_OBJ);
$cnt=1;
if($query->rowCount() > 0)
{
foreach($results as $result)
{ 
  

    $sql="INSERT INTO auto_rikshaw(autodriver_name,auto_number,auto_stand)VALUES(:autodriver_name,:auto_number,:auto_stand)";
$query = $dbh->prepare($sql);
$query->bindParam(':autodriver_name',$result->autodriver_name,PDO::PARAM_STR);
$query->bindParam(':auto_number',$result->auto_number,PDO::PARAM_STR);
$query->bindParam(':auto_stand',$result->auto_stand,PDO::PARAM_STR);

$query->execute();
}
  //  header("Location: index.php"); 
    
}

}

}


?>

