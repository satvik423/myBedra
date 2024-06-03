<!DOCTYPE html>
<html>
<head>
<title>Warning Page</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />

<?php
session_start();

if (isset($_POST['Accept'])) {
if ($_POST['Accept'] == 'Accept') {
    $_SESSION['did_accept'] = true;
    header ('Location: https://www.google.com');
    die('<a href="https://www.google.com">Click here to continue</a>');
}
}
if (isset($_POST['Accept'])) {
if ($_POST['Accept'] == 'Decline') {
    $_SESSION['did_accept'] = true;
    header ('Location: http://www.yahoo.com');
    die('<a href="http://www.yahoo.com">Click here to continue</a>');
}
}
?>

</head>
<body>
<p>Some text</p>

<form method="post" action="">

<label>
<input type="submit" name="Accept" value="Accept" id="Accept" onClick="Accept()">
Accept</label>
<br>
<label>
<input type="radio" name="Accept" value="Decline" id="Decline" onClick="Decline()">
Decline</label>
<br>
<input type="submit" value="Submit">

</form>
</body>
</html>