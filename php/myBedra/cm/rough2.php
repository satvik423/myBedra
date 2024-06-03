<html>
<head>
<script type="text/javascript">
disable = new Boolean();
 function highlight(a) {
  if(disable==false)a.className='highlight'
 }

 function normal(a) {
  a.className='normal'
 }
</script>

<style type="text/css">
 table#tblTest {
  width: 100%;
  margin-top: 10px;
  font-family: verdana,arial,sans-serif;
  font-size:12px;
  color:#333333;
  border-width: 1px;
  border-color: #666666;
  border-collapse: collapse;
 }

 table#tblTest tr.highlight td {
  background-color: #8888ff;
 }

 table#tblTest tr.normal {
  background-color: #ffffff;
 }

 table#tblTest th {
  white-space: nowrap; 
  border-width: 1px;
  padding: 8px;
  border-style: solid;
  border-color: #666666;
  background-color: #dedede;
 }

 table#tblTest td {
  border-width: 1px;
  padding: 8px;
  border-style: solid;
  border-color: #666666;
  background-color: #ffffff;
 }
</style>
</head>

<body>
 <table id="tblTest">
  <thead>
   <tr>
    <th>Name</th>
    <th>Address</th>
   </tr>
</thead>
<tbody>
    <tr onMouseOver="highlight(this)" onMouseOut="normal(this)" >
        <td>Tom</td>    
        <td>UK </td>
    </tr>
    <tr onMouseOver="highlight(this)" onMouseOut="normal(this)" >
        <td>Hans</td>   
        <td>Germany</td>
    </tr>
    <tr onMouseOver="highlight(this)" onMouseOut="normal(this)" > 
        <td>Henrik</td> 
        <td>Denmark</td>
    </tr>
    <tr onMouseOver="highlight(this)" onMouseOut="normal(this)" >
        <td>Lionel</td> 
        <td>Italy</td>
    </tr>
    <tr onMouseOver="highlight(this)" onMouseOut="normal(this)" >
        <td>Ricardo</td>    
        <td>Brazil</td>
    </tr>
    <tr onMouseOver="highlight(this)" onMouseOut="normal(this)" >
        <td>Cristiano</td>  
        <td>Portugal</td>
    </tr>
</tbody>
</table>
 <input type="button" onclick="disable = true;" value="Disable" />
 <input type="button" onclick="disable = false;" value="Enable" />
 </body>
</html>