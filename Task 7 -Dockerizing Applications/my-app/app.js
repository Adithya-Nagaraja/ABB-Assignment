const fs = require('fs');
const express = require('express');
const app = express();
const PORT = 3000;

app.get('/', (req, res) => {
  fs.readFile('hello-word.txt', 'utf8', (err, data) => {
    if (err) {
      res.status(500).send('Error reading file');
      return;
    }
    res.send(data);
  });
});

app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
