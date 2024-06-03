
<?php
error_reporting(E_ALL);
include('includes/config.php');
if(!empty($_POST["rikshaw_id"])) 
{
  $rikshaw_id=intval($_POST['rikshaw_id']);

 if(!is_numeric($rikshaw_id))
 {
 
 	echo htmlentities("invalid time_stamp");
     exit;
 }
 else{
    $review_flag =1;
    $sql="UPDATE new_rikshaw_requests SET review_flag =1 WHERE rikshaw_id=$rikshaw_id ";
    $query = $dbh->prepare($sql);
  //  $query->bindParam(':review_flag',$review_flag,PDO::PARAM_STR);
    $query->execute();



}

}


?>

