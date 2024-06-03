<div class="left-sidebar bg-black-300 box-shadow ">
    <div class="sidebar-content">
        <div class="user-info closed">
            <?php
            include('connection.php');
            // $result =mysqli_query($con,"SELECT logo_path,school_name FROM connectm");
            

            // while($row = mysqli_fetch_array($result))
// {   
            
            //    echo "<img style=\"vertical-align:middle;margin:0px 0px\" width=\"100\" height=\"100\" alt=\"Jnana\"  src=\"http://localhost/academics/Admin/images/".$row['logo_path']."\" />"; 
//    echo " <h6 class=\"title\">".$row['school_name']."</h6>";
// }  
            ?>


            <small class="info"></small>
        </div>
        <!-- /.user-info -->

        <div class="sidebar-nav">
            <ul class="side-nav color-gray">
                <li class="nav-header">
                    <span class="">Main Category</span>
                </li>
                <li>
                    <a href="dashboard"><i class="fa fa-dashboard"></i> <span>Dashboard</span> </a>

                </li>

                <li class="nav-header">
                    <span class="">Appearance</span>
                </li>
                <li class="has-children">
                    <a href="#"><i class="fa fa-file-text"></i> <span>Business Details</span> <i
                            class="fa fa-angle-right arrow"></i></a>
                    <ul class="child-nav">
                        <li><a href="add-record"><i class="fa fa-bars"></i> <span>Add business data</span></a></li>
                        <li><a href="Display-records"><i class="fa fa fa-server"></i>Display business
                                data<span></span></a></li>

                    </ul>
                </li>

                <!-- <li class="has-children">
                    <a href="#"><i class="fa fa-file-text"></i> <span>Blood Details</span> <i
                            class="fa fa-angle-right arrow"></i></a>
                    <ul class="child-nav">
                        <li><a href="add-blood"><i class="fa fa-bars"></i> <span>Add blood data</span></a></li>
                        <li><a href="Display-BloodRecords"><i class="fa fa fa-server"></i>Display blood
                                data<span></span></a></li>

                    </ul>
                </li> -->


                <li class="has-children">
                    <a href="#"><i class="fa fa-file-text"></i> <span>Bus Details</span> <i
                            class="fa fa-angle-right arrow"></i></a>
                    <ul class="child-nav">
                        <li><a href="add-bus"><i class="fa fa-bars"></i> <span>Add bus data</span></a></li>
                        <li><a href="Display-BusRecords"><i class="fa fa fa-server"></i>Display bus
                                data<span></span></a></li>
                        <!-- <li><a href="Newbus_requests"><i class="fa fa fa-server"></i>New bus requests<span></span></a> -->
                        </li>
                    </ul>
                </li>


                <li class="has-children">
                    <a href="#"><i class="fa fa-file-text"></i> <span>Auto-rikshaw Details</span> <i
                            class="fa fa-angle-right arrow"></i></a>
                    <ul class="child-nav">
                        <li><a href="add-rikshaw"><i class="fa fa-bars"></i> <span>Add rikshaw data</span></a></li>
                        <li><a href="Display-rikshawRecords"><i class="fa fa fa-server"></i>Display rikshaw
                                data<span></span></a></li>
                        <!-- <li><a href="NewRikshaw_requests"><i class="fa fa fa-server"></i>New rikshaw requests<span></span></a></li> -->
                    </ul>
                </li>


                <!-- <li class="has-children">
                    <a href="#"><i class="fa fa-file-text"></i> <span>Job Details</span> <i
                            class="fa fa-angle-right arrow"></i></a>
                    <ul class="child-nav">
                        <li><a href="add-job"><i class="fa fa-bars"></i> <span>Add job data</span></a></li>
                        <li><a href="Display-JobRecords"><i class="fa fa fa-server"></i>Display job
                                data<span></span></a></li>

                    </ul>
                </li> -->

                <!-- <li class="has-children">
                    <a href="#"><i class="fa fa-file-text"></i> <span>Tourism Details</span> <i
                            class="fa fa-angle-right arrow"></i></a>
                    <ul class="child-nav">
                        <li><a href="add-tourism"><i class="fa fa-bars"></i> <span>Add Tourism data</span></a></li>
                        <li><a href="Display-tourismRecords"><i class="fa fa fa-server"></i>Display Tourism
                                data<span></span></a></li>

                    </ul>
                </li> -->

                <li class="has-children">
                    <a href="#"><i class="fa fa-file-text"></i> <span>User Details</span> <i
                            class="fa fa-angle-right arrow"></i></a>
                    <ul class="child-nav">
                        <li><a href="Display_user"><i class="fa fa fa-server"></i>Display User Data<span></span></a>
                        </li>

                    </ul>
                </li>

                <li class="has-children">
                    <a href="#"><i class="fa fa-file-text"></i> <span>Grocery</span> <i
                            class="fa fa-angle-right arrow"></i></a>
                    <ul class="child-nav">
                        <li><a href="grocery.php"><i class="fa fa fa-server"></i>Add Grocery<span></span></a>
                        </li>
                        <li><a href="groceryorderlist.php"><i class="fa fa fa-server"></i>Order's<span></span></a>
                        </li>
                        <li><a href="groceryacceptedlist.php"><i class="fa fa fa-server"></i>Accepted Order's<span></span></a>
                        </li>

                    </ul>
                </li>

                <li class="has-children">
                    <a href="#"><i class="fa fa-file-text"></i> <span>Food</span> <i
                            class="fa fa-angle-right arrow"></i></a>
                    <ul class="child-nav">
                        <li><a href="food.php"><i class="fa fa fa-server"></i>Add Food<span></span></a>
                        </li>
                        <li><a href="foodorderlist.php"><i class="fa fa fa-server"></i>Order's<span></span></a>
                        </li>
                        <li><a href="foodacceptedlist.php"><i class="fa fa fa-server"></i>Accepted Order's<span></span></a>
                        </li>

                    </ul>
                </li>
                <!-- <li><a href="school-Info"><i class="fa fa fa-server"></i> <span> School Info</span></a></li> -->
            </ul>

        </div>
        <!-- /.sidebar-nav -->
    </div>
    <!-- /.sidebar-content -->
</div>