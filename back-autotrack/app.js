const express = require('express');
const db = require('./db');

const app = express();
app.use(express.json());

//endpoint pentru adaugarea vehiculelor in baza de date (POST)
app.post('/add-vehicle', (req, res) => {
  const { brand, model, year, mileage, fuelType } = req.body;
  const sql = 'INSERT INTO cars (brand, model, year, mileage, fuel_type) VALUES (?, ?, ?, ?, ?)';
  //VALUES ('Audi', 'A4', 2020, 15000, 'Petrol');
  db.query(sql, [brand, model, year, mileage, fuelType], (err, result) => {
    if (err) {
      return res.status(500).json({ error: 'Eroare la adăugarea vehiculului' });
    }
    res.status(201).json({ message: 'Vehicul adăugat cu succes' });
  });
});

//endpoint pentru prelucrarea vehiculelor (GET)
app.get('/get-vehicles', (req, res) => {
  const sql = 'SELECT * FROM cars';
  db.query(sql, (err, results) => {
    if (err) {
      return res.status(500).json({ error: 'Eroare la preluarea vehiculelor' });
    }
    res.status(200).json(results);
  });
});

//endpoint pentru adaugarea cheltuielilor de asigurare (POST)
app.post('/add-expense', (req, res) => {
  const { cost, date, description, vehicleId } = req.body;
  const sql = 'INSERT INTO insurance (cost, date, description) VALUES (?, ?, ?)';
  db.query(sql, [cost, date, description], (err, result) => {
    if (err) {
      return res.status(500).json({ error: 'Eroare la adăugarea cheltuielii' });
    }
    res.status(201).json({ message: 'Cheltuială adăugată cu succes' });
  });
});

//endpoint pentru prelucrarea cheltuielilor de asigurare (GET)
app.get('/get-expenses', (req, res) => {
  const sql = 'SELECT * FROM insurance';
  db.query(sql, (err, results) => {
    if (err) {
      return res.status(500).json({ error: 'Eroare la preluarea cheltuielilor' });
    }
    res.status(200).json(results);
  });
});



/*const PORT = 3000;
app.listen(PORT, () => {
  console.log(`Serverul rulează la http://localhost:${PORT}`);
});*/

app.listen(3000, '0.0.0.0', () => {
    console.log('Serverul rulează pe toate interfețele de rețea la portul 3000');
});

