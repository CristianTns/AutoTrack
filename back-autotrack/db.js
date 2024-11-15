const mysql = require('mysql');

const db = mysql.createConnection({
  host: 'localhost',    // adresa serverului MySQL
  user: 'root',         // numele de utilizator MySQL
  password: 'Catea2003QWERTY',         // parola pentru MySQL
  database: 'autotrack' // numele bazei de date
});

db.connect((err) => {
  if (err) throw err;
  console.log('Conectat la baza de date MySQL');
});

module.exports = db;
