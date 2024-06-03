const express = require('express')
const bodyParser = require('body-parser')
const mysql = require('mysql')


const app = express()

const port = process.env.PORT || 550;

app.use(bodyParser.urlencoded({ extended: false }));


app.use(bodyParser.json()); // Remove
//app.use(express.json()); // New

const pool  = mysql.createPool({
    connectionLimit : 10,
    host            : 'localhost',
    user            : 'root',
    password        : '',
    database        : 'connectm'
})

//----------------------TEST-------
app.get('', (req, res) => {

    pool.getConnection((err, connection) => {
        if(err) throw err
        console.log('connected as id ${connection.threadId}')

        connection.query('select * from bus_table', (err, rows) => {
            connection.release() // return the connection to pool

            if (!err) {
            
                  res.send(rows);
            } else {
                console.log(err)
            }

            // if(err) throw err
            //console.log('The data from users table are: \n', rows)
        })
    })
})

//------------------------add_bus---------------------
app.get('/check/:src/:dst', (req, res) => {

    pool.getConnection((err, connection) => {
        var keyword = ("%" + req.query.name + "%")
        if(err) throw err
        console.log('connected as id')
        connection.query('"select stop_id from stops_table where name=?',[req.params.src,req.params.dst]  , (err, rows) => {
            
        connection.release() // return the connection to pool

            if(!err) 
            {

            res.send(rows[0].route_id); 
        
            } 
            else 
            {
                console.log(err)
            }

            
        })
    })
})

//---------------------------------------check_route_all---------------
app.get('/check/:stop_id', (req, res) => {

    pool.getConnection((err, connection) => {
        var keyword = ("%" + req.query.stop_id + "%")
        if(err) throw err
        console.log('connected as id')
        //connection.query('select bus_id,route_id from route_stop_table where stop_id=? order by time ASC',[req.params.stop_id],(err, rows) => {
        connection.query('select bus_id,route_id from route_stop_table where stop_id=? order by time ASC',[ req.params.stop_id],(err, rows) => {
        connection.release() 
            if(!err) 
            {
                res.send(rows);
               //  rows[0].total;
        
            } 
            else 
            {
                console.log(err)
            }

        })
    })
})

//---------------------------------------add bus---------------
//Created on 23 Aug'22 for the POST method
app.use(express.json());

app.post('', (req, res) => {

    pool.getConnection((err, connection) => {
        if(err) throw err
        console.log('connected as id ${connection.threadId}')
        //const data={bus_name:"Test1", bus_time:"448" ,destination_name: "Dest" }
        //OR the below

        const data=req.body;
        connection.query("INSERT INTO new_bus_requests SET ? ",data,(err, result)=>{
        connection.release() // return the connection to pool

            if(err)
        {
            res.send('error');
        }
            else
            {
                res.send(result);
            }

        })
    })
})


app.listen(port, () => console.log(`Listening on port ${port}`))