
<?php
error_reporting(E_ALL);
include('includes/config.php');
if(!empty($_POST["request_id"])) 
{
  $request_id=intval($_POST['request_id']);

 if(!is_numeric($request_id))
 {
 
 	echo htmlentities("invalid bus_time");
     exit;
 }
 else{
    $review_flag =1;
    $sql="UPDATE new_bus_requests SET review_flag =1 WHERE request_id=$request_id ";
    $query = $dbh->prepare($sql);
  //  $query->bindParam(':review_flag',$review_flag,PDO::PARAM_STR);
    $query->execute();


}

}


?>

