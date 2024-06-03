const express = require("express");

const multer= require ('multer');

const app = express();

const filestorageEngine = multer.diskStorage({
    destination: (req,file, cb) => 
    {
        cb(null, './fileupload')
    },
    filename: (req,file,cb)=>
    {
        cb(null,Date.now() + '--'+ file.originalname)
    }
});

const upload = multer({storage:filestorageEngine})

app.get("/",(req, res) => {
    res.sendFile(path.join(__dirname, "index.html"));
});

app.post('/single',upload.single("image") ,(req,res) =>
{
    console.log(req.file);
    res.send("single file successful");

});
app.post('/multiple',upload.array('imag', 3),(req,res) =>
{
    console.log(req.files);
    res.send("multiple file successful");
});

app.listen(5000);
