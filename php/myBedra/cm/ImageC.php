<?php
session_start();
error_reporting(0); 
//error_reporting(E_ALL);        
include('includes/config.php');
include('connection.php');
   
if(strlen($_SESSION['alogin'])=="")
    {   
    header("Location: index.php"); 
    }
    else{
        $stid = $_GET['stid'];

// for redirecting function-------------
        
        if(array_key_exists('button1', $_POST)) {
            button1();
        }
        function button1() 
        {
            echo "This is Button1 that is selected";
            header("Location: http://192.168.31.248/cm_connect/Display-records");
        }
        
    

if(isset($_POST['submit']))
{
    

//$substring = substr($string, 0, strpos($string, ' '));


function generateRandomString($length = 10) 
{
    return substr(str_shuffle(str_repeat($x='abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ', ceil($length/strlen($x)))),1,$length);
}

$substring2 = generateRandomString(6);



//$img=$_POST['cname'].".png";
$img=$substring2.'.png';
$status=1;

 move_uploaded_file($_FILES['img']['tmp_name'], "profile/".$img);


 $sql="update connect set img=:img where id=:stid "; 
 $query = $dbh->prepare($sql);
 
 $query->bindParam(':img',$img,PDO::PARAM_STR);
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
                                    <h2 class="title">Add Record</h2>
                                
                                </div>
                                
                                <!-- /.col-md-6 text-right -->
                            </div>
                            <!-- /.row -->
                            <div class="row breadcrumb-div">
                                <div class="col-md-6">
                                    <ul class="breadcrumb">
                                        <li><a href="dashboard"><i class="fa fa-home"></i> Home</a></li>
                                
                                        <li class="active">Add Record</li>
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
                                                    <h5>Fill details to add a record</h5>
                                                </div>
                                            </div>
                                            <div class="panel-body">
                                                <?php if($msg){?>
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
                                    <label for="default" class="col-sm-2 control-label">Select photo</label>
                                    <div class="col-sm-10"><input type="file" name="img" id="img" accept="image/*" required="">
                                    </div> 
                                    </div>
                                        
                                    
                             
                                 <div class="form-group">
                                     <div class="col-sm-offset-2 col-sm-10">
                                       <button type="submit" name="submit" class="btn btn-primary">Add</button>

                                       

                                       <!-- Back to previous page -->
                                       <input type="button" value="Back" class="btn btn-primary" onClick="history.go(-1);">   

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
