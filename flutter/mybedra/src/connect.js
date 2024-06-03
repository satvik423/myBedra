const express = require('express')
const bodyParser = require('body-parser')
const mysql = require('mysql')
const multer = require('multer');

const admin = require('firebase-admin');

const path = require('path');

const cors = require("cors");
const app = express()

//itemArray for suggestions
const item = [];
const item1 = [];
const item_list = [];
const item_list1 = [];
const item_list_final = [];



app.use(cors());
const port = process.env.PORT || 600;
app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json()); // Remove
//app.use(express.json()); // New

const pool = mysql.createPool({
  connectionLimit: 10000,
  host: 'localhost',
  user: 'root',
  password: '',
  database: 'connectm' //'nodejs_beers'
})




const storage = multer.diskStorage({
  destination: function (req, file, cb) {
    cb(null, 'uploads/')
  },
  filename: function (req, file, cb) {
    cb(null, Date.now() + '-' + file.originalname)
  }
});

const fileFilter = function (req, file, cb) {
  const allowedTypes = ['image/jpeg', 'image/png'];
  if (!allowedTypes.includes(file.mimetype)) {
    const error = new Error('Wrong file type');
    error.code = 'LIMIT_FILE_TYPES';
    return cb(error, false);
  }
  cb(null, true);
};

const upload = multer({
  storage: storage,
  fileFilter: fileFilter,
  limits: {
    fileSize: 1024 * 1024 * 5 // 5 MB (max file size)
  }
})

app.post('/upload', upload.single('file'), (req, res) => {



  pool.getConnection((err, connection) => {




    console.log(req.file);

    const { filename, path, mimetype, size } = req.file;

    const sql = `INSERT INTO images (filename, path, mimetype, size) VALUES (?, ?, ?, ?)`;
    connection.query(sql, [filename, path, mimetype, size], (err, result) => {
      if (err) {
        console.error(err);
        return res.status(500).send('Internal Server Error');
      }
    })
    // req.file contains information about the uploaded file
    res.send('File uploaded successfully!');
  })





});





//GET by ID
app.get('/bus/:destination_name', (req, res) => {

  pool.getConnection((err, connection) => {
    var keyword = ("%" + req.query.destination_name + "%")
    if (err) throw err
    console.log('connected as id ${connection.threadId}')
    connection.query('select bus_name,bus_time,destination_name from bus_table where destination_name=? ', [req.params.destination_name], (err, rows) => {



      connection.release() // return the connection to pool

      if (!err) {
        res.send(rows);
      }
      else {
        console.log(err)
      }


    })
  })
})

app.get('/pattern/:cname', (req, res) => { // path as the above path is same.

  pool.getConnection((err, connection) => {

    console.log(req.params.cname);


    if (err) throw err
    console.log('connected as id ${connection.threadId}')
    connection.query('select * from connect where cname like ? or category like ? order by cname ASC ', ['%' + req.params.cname + '%', '%' + req.params.cname + '%'], (err, rows) => {
      connection.release() // return the connection to pool

      if (!err) {
        res.send(rows);
      }
      else {
        console.log(err)
      }
    })
  })
})



app.get('/autos/:auto_stand', (req, res) => { // path as the above path is same.

  pool.getConnection((err, connection) => {
    console.log("%" + req.params.auto_stand + "%")


    if (err) throw err
    console.log('connected as id ${connection.threadId}')
    connection.query('select autodriver_name,auto_number,auto_stand from auto_rikshaw where auto_stand = ? ', [req.params.auto_stand], (err, rows) => {

      connection.release() // return the connection to pool

      if (!err) {
        res.send(rows);
      }
      else {
        console.log(err)
      }


    })
  })
})

app.get('/autostands/', (req, res) => { // path as the above path is same.

  pool.getConnection((err, connection) => {
    if (err) throw err
    console.log('connected as id ${connection.threadId}')
    connection.query('select autodriver_name,auto_number,auto_stand from auto_rikshaw ', (err, rows) => {

      connection.release() // return the connection to pool

      if (!err) {
        res.send(rows);
      }
      else {
        console.log(err)
      }


    })
  })
})


app.get('/getCat/:cat', (req, res) => {

  pool.getConnection((err, connection) => {
    var keyword = ('%' + req.params.cat + '%');
    if (err) throw err
    console.log('connected as id ${connection.threadId}')

    connection.query('SELECT distinct (category) FROM connect WHERE category like ? ', keyword, (err, rows) => {

      connection.release() // return the connection to pool

      if (!err) {
        res.send(rows);
      }
      else {
        console.log(err)
      }
    });
  })

});

const url = require('url');
const grocery_upload = multer({ dest: 'mybedra/img/' });

app.post('/grocery_upload', grocery_upload.single('item_pic'), (req, res) => {
  const { item_name, item_price } = req.body;
  const item_image = req.file; // Get the uploaded file

  const uploadDir = path.join(__dirname, '../mybedra/img'); // Specify the upload directory outside the src folder
  const imageName = `${Date.now()}-${item_image.originalname}`; // Generate a unique image name
  const imagePath = path.join(uploadDir, imageName); // Set the image path

  // Move the uploaded file to the specified directory
  const fs = require('fs');
  fs.rename(item_image.path, imagePath, (err) => {
    if (err) {
      console.error('Error saving image:', err);
      res.status(500).send('Error saving image');
    } else {
      const sql = 'INSERT INTO grocery (item_name, item_price, item_image) VALUES (?, ?, ?)';
      const values = [item_name, item_price, `img/${imageName}`]; // Store the image path in the database
      pool.query(sql, values, (err, result) => {
        if (err) {
          console.error('Error uploading data:', err);
          res.status(500).send('Error uploading data');
        } else {
          console.log('Data uploaded successfully');
          res.redirect('http://localhost/mybedra/cm/grocery.php'); // Redirect the client to the specified URL
        }
      });
    }
  });
});

const food_upload = multer({ dest: 'mybedra/img/' });
app.post('/food_upload', food_upload.single('item_pic'), (req, res) => {
  const { item_name, item_price, hotel_name } = req.body;
  const item_image = req.file; // Get the uploaded file

  const uploadDir = path.join(__dirname, '../mybedra/img'); // Specify the upload directory outside the src folder
  const imageName = `${Date.now()}-${item_image.originalname}`; // Generate a unique image name
  const imagePath = path.join(uploadDir, imageName); // Set the image path

  // Move the uploaded file to the specified directory
  const fs = require('fs');
  fs.rename(item_image.path, imagePath, (err) => {
    if (err) {
      console.error('Error saving image:', err);
      res.status(500).send('Error saving image');
    } else {
      const sql = 'INSERT INTO foods (item_name, item_price, hotel_name, item_image) VALUES (?, ?, ?, ?)';
      const values = [item_name, item_price, hotel_name, `img/${imageName}`]; // Store the image path in the database
      pool.query(sql, values, (err, result) => {
        if (err) {
          console.error('Error uploading data:', err);
          res.status(500).send('Error uploading data');
        } else {
          console.log('Data uploaded successfully');
          res.redirect('http://localhost/mybedra/cm/food.php');
        }
      });
    }
  });
});
// Fetch data from the database
app.get('/grocery_fetch', (req, res) => {
  const sql = 'SELECT * FROM grocery';

  pool.query(sql, (err, result) => {
    if (err) {
      console.error('Error fetching data:', err);
      return res.status(500).send('Error fetching data'); // Add return statement here
    }

    console.log('Data fetched successfully');
    res.status(200).json(result);
  });
});


app.get('/food_fetch', (req, res) => {
  const sql = 'SELECT * FROM foods';

  pool.query(sql, (err, result) => {
    if (err) {
      console.error('Error fetching data:', err);
      return res.status(500).send('Error fetching data'); // Add return statement here
    }

    console.log('Data fetched successfully');
    res.status(200).json(result);
  });
});



app.post('/grocery_ordered', (req, res) => {
  const orderedItems = req.body;

  // Display the received contents
  console.log('Ordered Items:');
  console.log('Type of orderedItems:', typeof orderedItems);
  console.log('Value of orderedItems:', orderedItems);


  // Insert data into the "order" table
  orderedItems.forEach(item => {
    const { user_name, item_name, item_price, quantity, address, phoneNumber } = item;
    const query = `INSERT INTO groceryorder (user_id, item_name, item_price, item_quantity, status, user_address, user_phoneNumber) VALUES (?, ?, ?, ?, ?,?,?)`;
    const values = [user_name, item_name, item_price, quantity, "ordered", address, phoneNumber];

    // Execute the SQL query
    pool.query(query, values, (error, results) => {
      if (error) throw error;
      console.log('Inserted data into "order" table.');
    });
  });
  // Send a response back to the Flutter app
  res.status(200).json({ message: 'Received the order successfully.' });
});


app.post('/food_ordered', (req, res) => {
  const orderedItems = req.body;

  // Display the received contents
  console.log('Ordered Items:');
  console.log('Type of orderedItems:', typeof orderedItems);
  console.log('Value of orderedItems:', orderedItems);


  // Insert data into the "order" table
  orderedItems.forEach(item => {
    const { user_name, hotel_name, item_name, item_price, quantity, address, phoneNumber } = item;
    const query = `INSERT INTO foodorder (user_id,hotel_name, item_name, item_price, item_quantity, status, user_address, user_phoneNumber) VALUES (?, ?, ?, ?, ?, ?,?,?)`;
    const values = [user_name, hotel_name, item_name, item_price, quantity, "ordered", address, phoneNumber];

    // Execute the SQL query
    pool.query(query, values, (error, results) => {
      if (error) throw error;
      console.log('Inserted data into "order" table.');
    });
  });
  // Send a response back to the Flutter app
  res.status(200).json({ message: 'Received the order successfully.' });
});

app.get('/grocery_userorderlist', (req, res) => {
  const query = `SELECT * FROM groceryorder WHERE status='ordered'`;

  pool.query(query, (err, results) => {
    if (err) throw err;

    res.json(results);
  });
});
app.get('/grocery_acceptlist', (req, res) => {
  const query = `SELECT * FROM groceryorder WHERE status='accepted'`;

  pool.query(query, (err, results) => {
    if (err) throw err;

    res.json(results);
  });
});

app.get('/food_userorderlist', (req, res) => {
  const query = `SELECT * FROM foodorder WHERE status='ordered'`;

  pool.query(query, (err, results) => {
    if (err) throw err;

    res.json(results);
  });
});
app.get('/food_acceptlist', (req, res) => {
  const query = `SELECT * FROM foodorder WHERE status='accepted'`;

  pool.query(query, (err, results) => {
    if (err) throw err;

    res.json(results);
  });
});

app.post('/grocery_acceptOrders', (req, res) => {
  const { userName } = req.body;

  // Update the status in the database
  const sql = 'UPDATE groceryorder SET status = "accepted" WHERE user_id = ?';
  pool.query(sql, [userName], (error, results) => {
    if (error) {
      console.error('Failed to update order status:', error);
      res.status(500).json({ message: 'Failed to update order status' });
    } else {
      console.log('Order status updated');
      res.status(200).json({ message: 'Order status updated successfully' });
    }
  });
});


app.post('/food_acceptOrders', (req, res) => {
  const { userName } = req.body;

  // Update the status in the database
  const sql = 'UPDATE foodorder SET status = "accepted" WHERE user_id = ?';
  pool.query(sql, [userName], (error, results) => {
    if (error) {
      console.error('Failed to update order status:', error);
      res.status(500).json({ message: 'Failed to update order status' });
    } else {
      console.log('Order status updated');
      res.status(200).json({ message: 'Order status updated successfully' });
    }
  });
});

app.post('/grocery_search', (req, res) => {
  const searchTerm = req.body.searchTerm;

  // Perform the search query
  const query = `SELECT * FROM grocery WHERE item_name LIKE '%${searchTerm}%'`;
  pool.query(query, (err, results) => {
    if (err) {
      console.error('Error executing the search query:', err);
      res.status(500).json({ error: 'Internal server error' });
      return;
    }
    console.log('Searched .');
    // Send the matched results back to the client
    res.json(results);
  });
});


app.post('/food_search', (req, res) => {
  const searchTerm = req.body.searchTerm;

  // Perform the search query
  const query = `SELECT * FROM foods WHERE item_name LIKE '%${searchTerm}%' OR hotel_name LIKE '%${searchTerm}%'`;
  pool.query(query, (err, results) => {
    if (err) {
      console.error('Error executing the search query:', err);
      res.status(500).json({ error: 'Internal server error' });
      return;
    }
    console.log('Searched .');
    // Send the matched results back to the client
    res.json(results);
  });
});

app.get('/categories_search', (req, res) => {
  const searchString = req.query.searchString;

  // Perform the database query
  const query = `SELECT cname, contact1, contact2 FROM connect WHERE category LIKE '%${searchString}%'`;

  pool.query(query, (err, results) => {
    if (err) {
      console.error('Error executing query: ', err);
      res.status(500).json({ error: 'Error executing query' });
      return;
    }
    res.json(results);
    console.log(results);
  });
});


app.get('/getbuses', (req, res) => {
  const route = req.query.route;

  const query = `SELECT bus_name, bus_time, destination_name FROM bus_table WHERE destination_name='${route}'`;

  pool.query(query, (err, result) => {
    if (err) {
      res.status(500).json({ error: 'An error occurred' });
    } else {
      const item_list = result.map((row) => {
        return {
          bus_name: row.bus_name,
          bus_time: row.bus_time,
          destination_name: row.destination_name
        };
      });

      res.json(item_list);
    }
  });
});

// Initialize Firebase Admin SDK
const serviceAccount = require('../mybedraauth.json');
admin.initializeApp({
  credential: admin.credential.cert(serviceAccount)
});

// Firebase Firestore
const db = admin.firestore();

app.get('/api/fetch-data', async (req, res) => {
  try {
    const snapshot = await db.collection('User').get();

    snapshot.forEach((doc) => {
      const docData = doc.data();
      const docId = doc.id;

      const username = docData.username;
      const phoneNumber = docData.phoneNumber;
      const address = docData.address;
      const email = docId;

      const selectQuery = `SELECT * FROM user_details WHERE email = ?`;
      const selectValues = [email];

      pool.query(selectQuery, selectValues, (error, results) => {
        if (error) {
          console.error('Error selecting data from MySQL:', error);
        } else {
          if (results.length > 0) {
            // Email exists, perform update
            const updateQuery = `UPDATE user_details SET user_name = ?, phone_number = ?, location = ? WHERE email = ?`;
            const updateValues = [username, phoneNumber, address, email];

            pool.query(updateQuery, updateValues, (error, results) => {
              if (error) {
                console.error('Error updating data in MySQL:', error);
              }
            });
          } else {
            // Email does not exist, perform insert
            const insertQuery = `INSERT INTO user_details (user_name, email, phone_number, location) VALUES (?, ?, ?, ?)`;
            const insertValues = [username, email, phoneNumber, address];

            pool.query(insertQuery, insertValues, (error, results) => {
              if (error) {
                console.error('Error inserting data into MySQL:', error);
              }
            });
          }
        }
      });
    });

    console.log('Data has been fetched from Firestore and stored in the SQL table');
    res.status(200).json({ message: 'Data fetched and stored successfully' });
  } catch (error) {
    console.error('Error fetching Firestore data:', error);
    res.status(500).json({ error: 'An error occurred while fetching data' });
  }
});

//auto search 
app.get('/search_auto_list', (req, res) => {
  const stand = req.query.standName;

  const query = `SELECT autodriver_name, auto_number, auto_stand FROM auto_rikshaw WHERE auto_stand = '${stand}'`;

  pool.query(query, (error, results) => {
    if (error) {
      console.error('Error executing MySQL query:', error);
      res.status(500).json({ error: 'An error occurred while fetching data' });
    } else {
      const item_list = results.map((row) => {
        return {
          auto_name: row.autodriver_name,
          auto_number: row.auto_number,
          auto_stand: row.auto_stand
        };
      });
      console.log(item_list);
      res.json(item_list);
    }
  });
});

app.get('/api/destinations/auto', (req, res) => {
  const query = 'SELECT DISTINCT auto_stand FROM auto_rikshaw';

  // Execute the query
  pool.query(query, (error, results) => {
    if (error) {
      console.error('Error executing the query: ', error);
      res.status(500).json({ error: 'Internal server error' });
      return;
    }

    // Process the query results
    const destinations = results.map((row) => row.auto_stand);
    res.json({ destinations });
  });
});

app.get('/api/destinations/bus', (req, res) => {
  const query = 'SELECT DISTINCT destination_name FROM bus_table';

  // Execute the query
  pool.query(query, (error, results) => {
    if (error) {
      console.error('Error executing the query: ', error);
      res.status(500).json({ error: 'Internal server error' });
      return;
    }

    // Process the query results
    const destinations = results.map((row) => row.destination_name);
    res.json({ destinations });
  });
});

app.listen(port, () => console.log(`Listening on port ${port}`))