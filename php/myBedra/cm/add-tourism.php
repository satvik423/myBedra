<?php
session_start();
error_reporting(0); 
     
include('includes/config.php');
include('connection.php');
   
if(strlen($_SESSION['alogin'])=="")
    {   
    header("Location: index.php"); 
    }
    else{
if(isset($_POST['submit']))
{
    
//`candidate_name``c_address``gender``job_type_required``skills`
//`candidate_qualifications``candidate_experience``c_email``contact_number``time``from_name``from_email`
//`job_desc``detailed_desc``employer``qualification``experience``job_location``salary``post_date``contactno`
//`tourism_name``tourism_site``tour_img_path``info`

$tourism_name=$_POST['tourism_name'];
$tourism_site=$_POST['tourism_site']; 
//$tour_img_path=$_POST['tour_img_path']; 
$info=$_POST['info'];
$id=$POST['Tid'];

$tour_img_path=$_POST['tourism_name'].".png";

$status=1;

 move_uploaded_file($_FILES['tour_img_path'],"profile/".$tour_img_path);



$sql="INSERT INTO tourism_list(tourism_name,tourism_site,tour_img_path,info)VALUES(:tourism_name,:tourism_site,'$tour_img_path',:info)";
$query = $dbh->prepare($sql);
$query->bindParam(':tourism_name',$tourism_name,PDO::PARAM_STR);
$query->bindParam(':tourism_site',$tourism_site,PDO::PARAM_STR);
$query->bindParam(':info',$info,PDO::PARAM_STR);



$query->execute();

$lastInsertId = $dbh->lastInsertId();
 if($lastInsertId)
{
  $msg="added";
}
 
{
  $error="Something wrong. Please try again";
 
}
}
?>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title> Add job </title>
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
                                    <h2 class="title">Add tourism records</h2>
                                
                                </div>
                                
                                <!-- /.col-md-6 text-right -->
                            </div>
                            <!-- /.row -->
                            <div class="row breadcrumb-div">
                                <div class="col-md-6">
                                    <ul class="breadcrumb">
                                        <li><a href="dashboard"><i class="fa fa-home"></i> Home</a></li>
                                
                                        <li class="active">Add tourism details</li>
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
                                                    <h5>Fill details to add tourism record</h5>
                                                </div>
                                            </div>
                                            <div class="panel-body">
                                                <?php if($msg)
                                                {?>
                                                <div class="alert alert-success left-icon-alert" role="alert">
                                                 <strong>Records added!</strong><?php echo htmlentities($msg); ?>
                                                 </div><?php } 
                                                else if($error){?>
                                                    <div class="alert alert-danger left-icon-alert" role="alert">
                                                <strong>Oh snap!</strong> <?php echo htmlentities($error); ?>
                                            </div>
                                        <?php } ?>
                                    <form class="form-horizontal" method="post" action="" enctype="multipart/form-data">



                                    
                                    <div class="form-group">
                                    <label for="default" class="col-sm-2 control-label">Tourism place name</label>
                                    <div class="col-sm-10">
                                    <input type="text" name="tourism_name" class="form-control" id="tourism_name" required="required" autocomplete="off"  title="Enter valid name">
                                    </div>
                                    </div>


                                    <div class="form-group">
                                    <label for="default" class="col-sm-2 control-label">Tourism website</label>
                                    <div class="col-sm-10">
                                    <input type="email" name="tourism_site" class="form-control" id="tourism_site"  required="required" autocomplete="off">
                                    </div>
                                    </div>


                                    <div class="form-group">
                                    <label for="default" class="col-sm-2 control-label">Select photo</label>
                                    <div class="col-sm-10"><input type="file" name="tour_img_path" id="tour_img_path" accept="image/*" required="">
                                    </div> 
                                    </div>

                                    <div class="form-group">
                                    <label for="default" class="col-sm-2 control-label">about Information</label>
                                    <div class="col-sm-10">
                                    <input type="text" name="info" class="form-control" id="info"  required="required" autocomplete="off">
                                    </div>
                                    </div>




                                    <div class="form-group">
                                    <div class="col-sm-offset-2 col-sm-10">
                                    <button type="submit" name="submit" class="btn btn-primary">Add</button>
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
