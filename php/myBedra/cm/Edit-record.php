<?php
session_start();
error_reporting(0);
include('includes/config.php');
if(strlen($_SESSION['alogin'])=="")
    {   
    header("Location: index.php"); 
    }
    else{

$stid=intval($_GET['stid']);
if(isset($_POST['submit']))
{
    $string = $_POST['cname'];
   $substring = substr($string, 0, strpos($string, ' '));
   
   function generateRandomString($length = 10) 
   {
    return substr(str_shuffle(str_repeat($x='abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ', ceil($length/strlen($x)) )),1,$length);
   }
   
//    $substring = $substring. generateRandomString(6);
//     move_uploaded_file($_FILES['img']['tmp_name'], "images/".$substring.".png");

$rowid=$_POST['cname'];
$category=$_POST['category'];
 $contact1=$_POST['contact1'];
$contact2=$_POST['contact2']; 
// $lat=$_POST['lat']; 
// $lng=$_POST['lng']; 
// $img=$string.'.png';
 
$sql="update connect set cname=:cname,category=:category,contact1=:contact1,contact2=:contact2 where id=:stid "; 
$query = $dbh->prepare($sql);
$query->bindParam(':cname',$rowid,PDO::PARAM_STR);
$query->bindParam(':category',$category,PDO::PARAM_STR);
$query->bindParam(':contact1',$contact1,PDO::PARAM_STR);
$query->bindParam(':contact2',$contact2,PDO::PARAM_STR);
// $query->bindParam(':lat',$lat,PDO::PARAM_STR);
// $query->bindParam(':lng',$lng,PDO::PARAM_STR);
// $query->bindParam(':img',$img,PDO::PARAM_STR);
$query->bindParam(':stid',$stid,PDO::PARAM_STR);
$query->execute();

$msg="Result info updated successfully";

}

?>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
    	<meta name="viewport" content="width=device-width, initial-scale=1">
        <title> Admin|  Business details < </title>
        <link rel="icon" type="image/png" href="logo.png">
        <link rel="stylesheet" href="css/bootstrap.min.css" media="screen" >
        <link rel="stylesheet" href="css/font-awesome.min.css" media="screen" >
        <link rel="stylesheet" href="css/animate-css/animate.min.css" media="screen" >
        <link rel="stylesheet" href="css/lobipanel/lobipanel.min.css" media="screen" >
        <link rel="stylesheet" href="css/prism/prism.css" media="screen" >
        <link rel="stylesheet" href="css/select2/select2.min.css" >
        <link rel="stylesheet" href="css/main.css" media="screen" >
        <script src="js/modernizr/modernizr.min.js"></script>
    </head>
    <body class="top-navbar-fixed">
        <div class="main-wrapper">

            <!-- ========== TOP NAVBAR ========== -->
  <?php include('includes/topbar.php');?> 
            <!-- ========== WRAPPER FOR BOTH SIDEBARS & MAIN CONTENT ========== -->
            <div class="content-wrapper">
                <div class="content-container">

                    <!-- ========== LEFT SIDEBAR ========== -->
                   <?php include('includes/leftbar.php');?>  
                    <!-- /.left-sidebar -->

                    <div class="main-page">

                     <div class="container-fluid">
                            <div class="row page-title-div">
                                <div class="col-md-6">
                                    <h2 class="title">Business details</h2>
                                
                                </div>
                                
                                <!-- /.col-md-6 text-right -->
                            </div>
                            <!-- /.row -->
                            <div class="row breadcrumb-div">
                                <div class="col-md-6">
                                    <ul class="breadcrumb">
                                        <li><a href="dashboard"><i class="fa fa-home"></i> Home</a></li>
                                
                                        <li class="active">Listing</li>
                                    </ul>
                                </div>
                             
                            </div>
                            <!-- /.row -->
                        </div>
                        <div class="container-fluid">
                           
                        <div class="row">
                                    <div class="col-md-12">
                                        <div class="panel">
                                            <div class="panel-heading">
                                                <div class="panel-title">
                                                    <h5>Update your exsisting records</h5>
                                                </div>
                                            </div>
                                            <div class="panel-body">
<?php if($msg){?>
<div class="alert alert-success left-icon-alert" role="alert">
 <strong>Well done!</strong><?php echo htmlentities($msg); ?>
 </div><?php } 
else if($error){?>
    <div class="alert alert-danger left-icon-alert" role="alert">
                                            <strong>Oh snap!</strong> <?php echo htmlentities($error); ?>
                                        </div>
                                        <?php } ?>
                                                <form class="form-horizontal" method="post">

<?php 

$ret = "SELECT * from connect where id=:stid ";
$stmt = $dbh->prepare($ret);
$stmt->bindParam(':stid',$stid,PDO::PARAM_STR);
$stmt->execute();
$result=$stmt->fetchAll(PDO::FETCH_OBJ);
$cnt=1;
if($stmt->rowCount() > 0)
{
foreach($result as $row)
{  ?>

<div class="form-group">
<label for="default" class="col-sm-2 control-label">Business name</label>
<div class="col-sm-10">
<input  type="text" name="cname" class="form-control" id="cname" value="<?php echo htmlentities($row->cname)?>" required="required" autocomplete="off">
</div>
</div>

<div class="form-group">
<label for="default" class="col-sm-2 control-label">category</label>
<div class="col-sm-10">
<input  type="text" readonly name="category" class="form-control" id="category" value="<?php echo htmlentities($row->category)?>" maxlength="5" required="required" autocomplete="off">
</div>
</div>

<div class="form-group">
<label for="default" class="col-sm-2 control-label">contact1</label>
<div class="col-sm-10">
<input  type="text" name="contact1" class="form-control" id="contact1" maxlength=10 value="<?php echo htmlentities($row->contact1)?>" required="required" autocomplete="off">
</div>
</div>

<div class="form-group">
<label for="default" class="col-sm-2 control-label">contact2</label>
<div class="col-sm-10">
<input  type="text" name="contact2" class="form-control" id="contact2" maxlength=10 value="<?php echo htmlentities($row->contact2)?>" required="required" autocomplete="off">
</div>
</div>





 <!-- <div class="form-group">  accept="image/*"
<label for="default" class="col-sm-2 control-label">Select photo</label>
<div class="col-sm-10"><input type="file" name="img" id="img" accept="image/*" required="">
</div> 
</div> -->

<?php } }?>        

                                                 
                                                    <div class="form-group">
                                                        <div class="col-sm-offset-2 col-sm-10">
                                                        <button type="submit" name="submit" class="btn btn-primary">Update</button>

                                                        <!-- BACK TO PREVIOUS PAGE -->
                                                        
                                                        <input type="button" value="Back" class="btn btn-primary" onClick="history.go(-1);">
                                                        <input type="button" value="Delete" class="btn btn-primary" onClick="return confirm('Are you sure you want to delete a record?')">
                                                        <!-- <a href="delete.php?id=22" onclick="return confirm('Are you sure?')">Link</a> -->
                                                                
                                                        </div>
                                                    </div>
                                                </form>

                                            </div>
                                        </div>
                                    </div>
                                    <!-- /.col-md-12 -->
                                </div>
                    </div>
                </div>
                <!-- /.content-container -->
            </div>
            <!-- /.content-wrapper -->
        </div>
        <!-- /.main-wrapper -->
        <script src="js/jquery/jquery-2.2.4.min.js"></script>
        <script src="js/bootstrap/bootstrap.min.js"></script>
        <script src="js/pace/pace.min.js"></script>
        <script src="js/lobipanel/lobipanel.min.js"></script>
        <script src="js/iscroll/iscroll.js"></script>
        <script src="js/prism/prism.js"></script>
        <script src="js/select2/select2.min.js"></script>
        <script src="js/main.js"></script>
        <script>
            $(function($) {
                $(".js-states").select2();
                $(".js-states-limit").select2({
                    maximumSelectionLength: 2
                });
                $(".js-states-hide").select2({
                    minimumResultsForSearch: Infinity
                });
            });
        </script>
    </body>
</html>
<?PHP } ?>
