// const express = require('express')
// const bodyParser = require('body-parser')
// const mysql = require('mysql');
// const { connection } = require('mongoose');


// const app = express()

// const port = process.env.PORT || 550;

// app.use(bodyParser.urlencoded({ extended: false }));


// app.use(bodyParser.json()); // Remove
// //app.use(express.json()); // New

// const pool = mysql.createPool({
//     connectionLimit: 10,
//     host: 'localhost',
//     user: 'root',
//     password: '',
//     database: 'connectm'
// })

// //---------test---------


// app.get('', (req, res) => {

//     pool.getConnection((err, connection) => {
//         if (err) throw err
//         console.log('connected as id ${connection.threadId}')

//         connection.query('select * from connect', (err, rows) => {
//             connection.release() // return the connection to pool

//             if (!err) {

//                 res.send(rows);
//             } else {
//                 console.log(err)
//             }

//             // if(err) throw err
//             //console.log('The data from users table are: \n', rows)
//         })
//     })
// })

// //get suggestions
// app.get('/cat/:category', (req, res) => { // path as the above path is same.

//     pool.getConnection((err, connection) => {
//         var keyword = ("%" + req.query.category + "%")


//         if (err) throw err
//         console.log('connected as id ${connection.threadId}')
//         connection.query('select distinct category from connect where category like ?', ['%' + req.params.category + '%'], (err, rows) => {

//             connection.release() // return the connection to pool

//             if (!err) {
//                 res.send(rows);
//             }
//             else {
//                 console.log(err)
//             }

//             // if(err) throw err
//             //console.log('The data from users table are: \n', rows)
//         })
//     })
// })





const express = require('express');
const mysql = require('mysql');
const app = express();

// Create a MySQL connection pool
const pool = mysql.createPool({
    host: 'localhost',
    user: 'root',
    password: '',
    database: 'connnectm'
});

// Handle GET requests to /cat/:category
app.get('/cat/:category', (req, res) => {
    // Build the search keyword using the request query parameter
    const keyword = `%${req.query.category}%`;

    // Acquire a connection from the pool
    pool.getConnection((err, connection) => {
        if (err) {
            throw err;
        }

        console.log(`Connected as ID ${connection.threadId}`);

        // Execute the SQL query with the search keyword as a parameter
        const sql = 'SELECT DISTINCT category FROM connect WHERE category LIKE ?';
        connection.query(sql, [keyword], (err, rows) => {
            // Release the connection back to the pool
            connection.release();

            if (err) {
                console.log(err);
                res.status(500).send('Error fetching categories from database');
            } else {
                res.send(rows);
            }
        });
    });
});

// Start the server
// app.listen(3000, () => {
//   console.log('Server listening on port 3000');
// });
