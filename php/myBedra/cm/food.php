<?php
session_start();
error_reporting(0);

include('includes/config.php');
include('connection.php');

if (strlen($_SESSION['alogin']) == "") {
    header("Location: index.php");
} else {
    // if (isset($_POST['submit'])) {


    //     $bus_name = $_POST['busname'];
    //     $bus_time = $_POST['bus_time'];
    //     $destination_name = $_POST['destination_name'];

    //     $status = 1;


    //     $sql = "INSERT INTO bus_table(bus_name,bus_time,destination_name)VALUES(:bus_name,:bus_time,:destination_name)";
    //     $query = $dbh->prepare($sql);
    //     $query->bindParam(':bus_name', $bus_name, PDO::PARAM_STR);
    //     $query->bindParam(':bus_time', $bus_time, PDO::PARAM_STR);
    //     $query->bindParam(':destination_name', $destination_name, PDO::PARAM_STR);


    //     $query->execute();

    //     $lastInsertId = $dbh->lastInsertId();
    //     if ($lastInsertId) {


    //         $msg = "added";
    //     } {
    //         $error = "Something wrong. Please try again";

    //     }
    // }
    ?>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title> Add data| Add Record </title>
        <link rel="icon" type="image/png" href="logo.png">
        <link rel="stylesheet" href="css/bootstrap.min.css" media="screen">
        <link rel="stylesheet" href="css/font-awesome.min.css" media="screen">
        <link rel="stylesheet" href="css/animate-css/animate.min.css" media="screen">
        <link rel="stylesheet" href="css/lobipanel/lobipanel.min.css" media="screen">
        <link rel="stylesheet" href="css/prism/prism.css" media="screen">
        <link rel="stylesheet" href="css/select2/select2.min.css">
        <link rel="stylesheet" href="css/main.css" media="screen">
        <script src="js/modernizr/modernizr.min.js"></script>



    </head>

    <body class="top-navbar-fixed">
        <div class="main-wrapper">

            <!-- ========== TOP NAVBAR ========== -->
            <?php include('includes/topbar.php'); ?>
            <!-- ========== WRAPPER FOR BOTH SIDEBARS & MAIN CONTENT ========== -->
            <div class="content-wrapper">
                <div class="content-container">

                    <!-- ========== LEFT SIDEBAR ========== -->
                    <?php include('includes/leftbar.php'); ?>
                    <!-- /.left-sidebar -->

                    <div class="main-page">

                        <div class="container-fluid">
                            <div class="row page-title-div">
                                <div class="col-md-6">
                                    <h2 class="title">Add Food</h2>

                                </div>

                                <!-- /.col-md-6 text-right -->
                            </div>
                            <!-- /.row -->
                            <div class="row breadcrumb-div">
                                <div class="col-md-6">
                                    <ul class="breadcrumb">
                                        <li><a href="dashboard"><i class="fa fa-home"></i> Home</a></li>

                                        <li class="active">Add Food</li>
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
                                                <h5>Fill details to add Food</h5>
                                            </div>
                                        </div>
                                        <div class="panel-body">
                                            <?php if ($msg) { ?>
                                                <div class="alert alert-success left-icon-alert" role="alert">
                                                    <strong>Records added!</strong>
                                                    <?php echo htmlentities($msg); ?>
                                                </div>
                                            <?php } else if ($error) { ?>
                                                    <div class="alert alert-danger left-icon-alert" role="alert">
                                                        <strong>Oh snap!</strong>
                                                    <?php echo htmlentities($error); ?>
                                                    </div>
                                            <?php } ?>
                                            <form class="form-horizontal" method="post" action="http://localhost:600/food_upload"
                                                enctype="multipart/form-data">



                                                <div class="form-group">
                                                    <label for="default" class="col-sm-2 control-label">Item Name</label>
                                                    <div class="col-sm-10">
                                                        <input type="text" name="item_name" class="form-control" id="item_name"
                                                            required="required" autocomplete="off" title="Enter valid name">
                                                        <!-- pattern="[A-Za-z\s]{1,32}" -->
                                                    </div>
                                                </div>


                                                <div class="form-group">
                                                    <label for="default" class="col-sm-2 control-label">Item Price</label>
                                                    <div class="col-sm-10">
                                                        <input type="text" name="item_price" class="form-control"
                                                            id="item_price" required="required" autocomplete="off">
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label for="default" class="col-sm-2 control-label">Hotel Nam</label>
                                                    <div class="col-sm-10">
                                                        <input type="text" name="hotel_name" class="form-control"
                                                            id="hotel_name" required="required" autocomplete="off">
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label for="default" class="col-sm-2 control-label">Item Image</label>
                                                    <div class="col-sm-10">
                                                        <input type="file" name="item_pic" class="form-control"
                                                            id="item_pic" required="required">
                                                    </div>
                                                </div>





                                                <div class="form-group">
                                                    <div class="col-sm-offset-2 col-sm-10">
                                                        <button type="submit" name="submit"
                                                            class="btn btn-primary">Add</button>
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
                $(function ($) {
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