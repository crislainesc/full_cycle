const express = require('express');
const mysql = require('mysql');

const app = express();
const port = 3000;
const config = {
  host: 'db',
  user: 'root',
  password: 'root',
  database: 'nodedb'
}
const connection = mysql.createConnection(config);
const sql = `INSERT INTO people(name) VALUES ('Name');`
connection.query(sql)
connection.end()

app.get('/', (_, res) => {
  res.send('<h1>Full Cycle Node</h1>');
});

app.listen(port, () => {
  console.log('🚀 Running on port: ' + port);
});
