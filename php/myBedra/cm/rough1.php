<!-- <html>

<body>
    <input class="input" type="text" placeholder="fill me">
    <button class="button">Click Me</button>
</body>
<script>
let input = document.querySelector(".input");
let button = document.querySelector(".button");
button.disabled = false;
input.addEventListener("change", stateHandle);

function stateHandle() {
    if(document.querySelector(".input").value === "") {
        button.disabled = false;
    } else {
        button.disabled = true;
    }
}
</script>

</html> -->

<!-- <html>

<head>
    <title>jQuery - Enable or Disable Button</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
</head>

<body> Name:
    <input type="text" id="tbName" />
    <input type="submit" id="submit" disabled="disabled" /> </body>
<script>
$(document).ready(function() {
    $('#tbName').on('input change', function() {
        if($(this).val() != '') {
            $('#submit').prop('disabled', false);
        } else {
            $('#submit').prop('disabled', true);
        }
    });
});
</script>

</html> -->

<!-- 
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>Enable and Disable Button using JavaScript</title> 
</head>
<body>
<button onclick="alert('Hello!')" id='btn'>Main Button</button> 
<button id='b1' onclick="disable()">Disable</button>
<button id='b2' onclick="disable()">Enable</button>
</body>

<script>
// function enable()
// {    
// document.getElementById("b1").disabled = true;
// }

function disable()
{    
document.getElementById("b2").disabled = true;
document.getElementById("b1").disabled = true;
}
</script>
</html> -->

