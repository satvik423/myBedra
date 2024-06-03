const express = require('express')
const bodyParser = require('body-parser')
const mysql = require('mysql')


const app = express()

const port = process.env.PORT || 500;

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

//GET by ID
app.get('/:id', (req, res) => {

    pool.getConnection((err, connection) => {
        var keyword = ("%" + req.query.id + "%")
        if(err) throw err
        console.log('connected as id ${connection.threadId}')
        connection.query('select distinct(category) from connect where category=?' ,[req.params.id]  , (err, rows) => {
        

        //connection.query('SELECT * from beers where id=?', [req.params.id], (err, rows) => {
        connection.release() // return the connection to pool

            if(!err) 
            {
            res.send(rows);
            } 
            else 
            {
                console.log(err)
            }

            // if(err) throw err
            //console.log('The data from users table are: \n', rows)
        })
    })
})

//DELETE the record
app.delete('/:id', (req, res) => {

    pool.getConnection((err, connection) => {
        if(err) throw err
        console.log('connected as id ${connection.threadId}')

        connection.query('Delete from beers where id=?', [req.params.id], (err, rows) => {
        connection.release() // return the connection to pool

            if(!err) 
            {
            res.send('beer with record id:${[req.params.id]} has been removed');
            } 
            else 
            {
                console.log(err)
            }

            // if(err) throw err
            //console.log('The data from users table are: \n', rows)
        })
    })
})


//Add a record to table beers
app.post('', (req, res) => {

    pool.getConnection((err, connection) => {
        if(err) throw err
        console.log('connected as id ${connection.threadId}')

        const params=req.body

        connection.query('insert into beers set ?', params, (err, rows) => {
        connection.release() // return the connection to pool

            if(!err) 
            {
            res.send('beer with record id: ${[params.name]} has been added');
            } 
            else 
            {
                console.log(err)
            }

            
        })
    })
})

//UPDATE record to table beers
app.put('', (req, res) => {

    pool.getConnection((err, connection) => {
        if(err) throw err
        console.log('connected as id ${connection.threadId}')

        
        const{id,name,tagline,description} = req.body

        connection.query('update beers set name= ? where id = ?', [name,id], (err, rows) => {
        connection.release() // return the connection to pool

            if(!err) 
            {
            res.send('beer with record id: ${[params.name]} has been added');
            } 
            else 
            {
                console.log(err)
            }

            
        })
    })
})


app.listen(port, () => console.log(`Listening on port ${port}`))