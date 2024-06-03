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
    

//`job_desc``detailed_desc``employer``qualification``experience``job_location``salary``post_date``contactno`

$job_desc=$_POST['job_desc'];
$detailed_desc=$_POST['detailed_desc']; 
$employer=$_POST['employer']; 
$qualification=$_POST['qualification'];
$experience=$_POST['experience'];
$job_location=$_POST['job_location'];
$salary=$_POST['salary'];
$post_date=$_POST['post_date'];
$contactno=$_POST['contactno'];


$status=1;


$sql="INSERT INTO job(job_desc,detailed_desc,employer,qualification,experience,job_location,salary,post_date,contactno)VALUES(:job_desc,:detailed_desc,:employer,:qualification,:experience,:job_location,:salary,:post_date,:contactno)";
$query = $dbh->prepare($sql);
$query->bindParam(':job_desc',$job_desc,PDO::PARAM_STR);
$query->bindParam(':detailed_desc',$detailed_desc,PDO::PARAM_STR);
$query->bindParam(':employer',$employer,PDO::PARAM_STR);
$query->bindParam(':qualification',$qualification,PDO::PARAM_STR);
$query->bindParam(':experience',$experience,PDO::PARAM_STR);
$query->bindParam(':job_location',$job_location,PDO::PARAM_STR);
$query->bindParam(':salary',$salary,PDO::PARAM_STR);
$query->bindParam(':post_date',$post_date,PDO::PARAM_STR);
$query->bindParam(':contactno',$contactno,PDO::PARAM_STR);


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
                                    <h2 class="title">Add Job records</h2>
                                
                                </div>
                                
                                <!-- /.col-md-6 text-right -->
                            </div>
                            <!-- /.row -->
                            <div class="row breadcrumb-div">
                                <div class="col-md-6">
                                    <ul class="breadcrumb">
                                        <li><a href="dashboard"><i class="fa fa-home"></i> Home</a></li>
                                
                                        <li class="active">Add job details</li>
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
                                                    <h5>Fill details to add job records</h5>
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
                                    <label for="default" class="col-sm-2 control-label">Job Designation</label>
                                    <div class="col-sm-10">
                                    <input type="text" name="job_desc" class="form-control" id="job_desc" required="required" autocomplete="off"  title="Enter valid name">
                                    <!-- pattern="[A-Za-z\s]{1,32}" -->
                                    </div>
                                    </div>


                                    <div class="form-group">
                                    <label for="default" class="col-sm-2 control-label">detailed designation</label>
                                    <div class="col-sm-10">
                                    <input type="text" name="detailed_desc" class="form-control" id="detailed_desc"  required="required" autocomplete="off">
                                    </div>
                                    </div>

                                    <div class="form-group">
                                    <label for="default" class="col-sm-2 control-label">Employer</label>
                                    <div class="col-sm-10">
                                    <input type="text" name="employer" class="form-control" id="employer"  required="required" autocomplete="off">
                                    </div>
                                    </div>

                                    <div class="form-group">
                                    <label for="default" class="col-sm-2 control-label">Qualification</label>
                                    <div class="col-sm-10">
                                    <input type="text" name="qualification" class="form-control" id="qualification"  required="required" autocomplete="off">
                                    </div>
                                    </div>

                                    <div class="form-group">
                                    <label for="default" class="col-sm-2 control-label">Experience</label>
                                    <div class="col-sm-10">
                                    <input type="number" name="experience" class="form-control" id="detexperienceailed_desc"  required="required" autocomplete="off">
                                    </div>
                                    </div>


                                    <div class="form-group">
                                    <label for="default" class="col-sm-2 control-label">Job location</label>
                                    <div class="col-sm-10">
                                    <input type="text" name="job_location" class="form-control" id="job_location"  required="required" autocomplete="off">
                                    </div>
                                    </div>


                                    <div class="form-group">
                                    <label for="default" class="col-sm-2 control-label">Salary</label>
                                    <div class="col-sm-10">
                                    <input type="number" name="salary" class="form-control" id="salary"  required="required" autocomplete="off">
                                    </div>
                                    </div>


                                    <div class="form-group">
                                    <label for="default" class="col-sm-2 control-label">Post date</label>
                                    <div class="col-sm-10">
                                    <input type="date" name="post_date" class="form-control" id="post_date"  required="required" autocomplete="off">
                                    </div>
                                    </div>

                                    

                                    <div class="form-group">
                                    <label for="default" class="col-sm-2 control-label">contact number</label>
                                    <div class="col-sm-10">
                                    <input type="tel" name="contactno"  maxlength=10 class="form-control" id="contactno"  pattern="[7-9]{1}[0-9]{9}" required="required" autocomplete="off">
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
