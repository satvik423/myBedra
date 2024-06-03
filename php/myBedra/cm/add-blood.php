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
    

$bname=$_POST['bname'];
$contact=$_POST['contact']; 
$blood_group=$_POST['blood_group']; 

$status=1;


$sql="INSERT INTO blood(bname,contact,blood_group)VALUES(:bname,:contact,:blood_group)";
$query = $dbh->prepare($sql);
$query->bindParam(':bname',$bname,PDO::PARAM_STR);
$query->bindParam(':contact',$contact,PDO::PARAM_STR);
$query->bindParam(':blood_group',$blood_group,PDO::PARAM_STR);


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
        <title> Add data| Add Record </title>
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
                                    <h2 class="title">Add blood record</h2>
                                
                                </div>
                                
                                <!-- /.col-md-6 text-right -->
                            </div>
                            <!-- /.row -->
                            <div class="row breadcrumb-div">
                                <div class="col-md-6">
                                    <ul class="breadcrumb">
                                        <li><a href="dashboard"><i class="fa fa-home"></i> Home</a></li>
                                
                                        <li class="active">Add blood record</li>
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
                                                    <h5>Fill details to add blood record</h5>
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
                                    <label for="default" class="col-sm-2 control-label">Person name</label>
                                    <div class="col-sm-10">
                                    <input type="text" name="bname" class="form-control" id="bname" required="required" autocomplete="off"  title="Enter valid name">
                                    <!-- pattern="[A-Za-z\s]{1,32}" -->
                                    </div>
                                    </div>


                                    <div class="form-group">
                                    <label for="default" class="col-sm-2 control-label">Contact</label>
                                    <div class="col-sm-10">
                                    <input type="tel" maxlength=10 name="contact" class="form-control" id="contact" pattern="[7-9]{1}[0-9]{9}" required="required" autocomplete="off">
                                    </div>
                                    </div>


                                    <!-- MAKE CORRECTION BELOW AFTER TESTING THIS PAGE  -->
                                    <div class="form-group">
                                    <label for="default" class="col-sm-2 control-label">blood group</label>
                                    <div class="col-sm-10">
                                     <select name="blood_group" class="form-control" id=" " required="required" >
                                    <option value="">blood_group</option>
                                    <?php $sql = "SELECT DISTINCT blood_group FROM blood";
                                    $query = $dbh->prepare($sql);
                                    $query->execute();
                                    $results=$query->fetchAll(PDO::FETCH_OBJ);
                                    if($query->rowCount() > 0)
                                    {
                                    foreach($results as $result)
                                    {   ?>
                                    <option value="<?php echo htmlentities($result->blood_group); ?>"><?php echo htmlentities($result->blood_group); ?></option>
                                    <?php }} ?>
                                     </select>
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
