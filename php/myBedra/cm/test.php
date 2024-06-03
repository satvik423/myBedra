<!DOCTYPE html>
<html lang="en">

    <body >
     
            <?php 
           
    $randomNum=substr(str_shuffle("0123456789abcdefghijklmnopqrstvwxyz"), 0, 6);
             $to="harshad@alvasinsiemria.com";
    $from = "sheikmohammedalfaz@gmail.com"; // this is the sender's Email address
    $first_name = $_POST['fullanme'];
    $subject = "Welcome to Academics";
    $subject2 = "Parents In Touch";
    $message = "We keep you to stay updated regarding your childs progress.Your Academics Login Student ID : " ."alfaz" . "\n Temporary password : \n" . $randomNum;

    $headers = "From:" . $from;
    $headers2 = "From:" . $to;
    mail($to,$subject,$message,$headers);
    mail($from,$subject,$message,$headers2); 
    ?>  
         
    </body>
</html>

