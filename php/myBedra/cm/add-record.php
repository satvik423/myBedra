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
if(isset($_POST['submit']))
{
    
$string = $_POST['cname'];
$substring = substr($string, 0, strpos($string, ' '));


function generateRandomString($length = 10) 
{
  return substr(str_shuffle(str_repeat($x='abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ', ceil($length/strlen($x)))),1,$length);
}

$substring2 = $substring. generateRandomString(6);
//move_uploaded_file($_FILES['image']['tmp_name'], "profile/".$img); 

$cname=$_POST['cname'].', '.$_POST['address'];
$category=$_POST['category']; 
$contact1=$_POST['contact1']; 
$contact2=$_POST['contact2']; 
// $lat=$_POST['lat']; 
// $lng=$_POST['lng'];
//$img=$_POST['cname'].".png";
// $img=$substring2.'.png';
$status=1;

 move_uploaded_file($_FILES['img']['tmp_name'], "profile/".$img);


$sql="INSERT INTO connect(cname,category,contact1,contact2) VALUES(:cname,:category,:contact1,:contact2)"; //'$img'
$query = $dbh->prepare($sql);
$query->bindParam(':cname',$cname,PDO::PARAM_STR);
$query->bindParam(':category',$category,PDO::PARAM_STR);
$query->bindParam(':contact1',$contact1,PDO::PARAM_STR);
$query->bindParam(':contact2',$contact2,PDO::PARAM_STR);



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

           <!-- <script>
function getStudent(val) 
{
    $.ajax({
    type: "POST",
    url: "get_student_id",
    data: {"classid": val, "roll":  document.getElementById("roolid").value},

    success: function(data)
    {
        $("#stdid").html(data);
        
    }
    });

}
    </script> -->

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
                                    <h2 class="title">Add Business Record</h2>
                                
                                </div>
                                
                                <!-- /.col-md-6 text-right -->
                            </div>
                            <!-- /.row -->
                            <div class="row breadcrumb-div">
                                <div class="col-md-6">
                                    <ul class="breadcrumb">
                                        <li><a href="dashboard"><i class="fa fa-home"></i> Home</a></li>
                                
                                        <li class="active">Add Business Record</li>
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
                                                    <h5>Fill details to add Business record</h5>
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
                                    <label for="default" class="col-sm-2 control-label">Business name</label>
                                    <div class="col-sm-10">
                                    <!-- <input type="text"  pattern="[A-Za-z]{1,32}" name="fullanme" class="form-control" id="fullanme" required="required" autocomplete="off"  title="Enter valid name"> -->

                                    <input type="text" name="cname" class="form-control" id="cname" required="required" autocomplete="off"  title="Enter valid name">
                                    <!-- pattern="[A-Za-z\s]{1,32}" -->
                                </div>
                                    </div>
                                    <div class="form-group">
                                    <label for="default" class="col-sm-2 control-label">Full address</label>
                                    <div class="col-sm-10">
                                    <!-- <input type="text"  pattern="[A-Za-z]{1,32}" name="fullanme" class="form-control" id="fullanme" required="required" autocomplete="off"  title="Enter valid name"> -->

                                    <input type="text" name="address" class="form-control" id="address" required="required" autocomplete="off"  title="Enter valid name">
                                    <!-- pattern="[A-Za-z\s]{1,32}" -->
                                </div>
                                    </div>

                                 
                                    <div class="form-group">
                                                         <label for="default" class="col-sm-2 control-label">Category</label>
                                          <div class="col-sm-10">
                                     <select name="category" class="form-control" id=" " required="required" >
                                    <option value="">Category</option>
                                    <?php $sql = "SELECT * from category";
                                    $query = $dbh->prepare($sql);
                                    $query->execute();
                                    $results=$query->fetchAll(PDO::FETCH_OBJ);
                                    if($query->rowCount() > 0)
                                    {
                                    foreach($results as $result)
                                    {   ?>
                                    <option value="<?php echo htmlentities($result->name); ?>"><?php echo htmlentities($result->name); ?></option>
                                    <?php }} ?>
                                     </select>
                                     </div>
                                    </div>


                                    <div class="form-group">
                                    <label for="default" class="col-sm-2 control-label">Contact1</label>
                                    <div class="col-sm-10">
                                    <input type="tel" maxlength=10 name="contact1" class="form-control" id="contact1" pattern="[7-9]{1}[0-9]{9}" required="required" autocomplete="off">
                                    </div>
                                    </div>

                                    <div class="form-group">
                                    <label for="default" class="col-sm-2 control-label">Contact2</label>
                                    <div class="col-sm-10">
                                    <input type="tel" name="contact2" maxlength=10 class="form-control" id="contact2" pattern="[7-9]{1}[0-9]{9}" required="required" autocomplete="off">
                                    </div>
                                    </div>

                                    <!-- <div class="form-group">
                                    <label for="default" class="col-sm-2 control-label">lat</label>
                                    <div class="col-sm-10">
                                    <input type="text" name="lat" class="form-control" id="lat"  autocomplete="off">
                                    </div>
                                    </div>

                                    <div class="form-group">
                                    <label for="default" class="col-sm-2 control-label">lng</label>
                                    <div class="col-sm-10">
                                    <input type="text" name="lng" class="form-control" id="lng" autocomplete="off">
                                    </div>
                                    </div> -->

                
                                    <!-- <div class="form-group">
                                    <label for="default" class="col-sm-2 control-label">Select photo</label>
                                    <div class="col-sm-10"><input type="file" name="img" id="img" accept="image/*" >
                                    </div> 
                                    </div> -->
                                        
                                    
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
