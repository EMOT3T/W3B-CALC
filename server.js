require('dotenv').config();
const express = require('express');

const app = express();

app.get('/', (req, res) => {
    res.send(`O servidor está rodando na porta ${process.env.PORT}`);
});

const PORT = process.env.PORT || 3000;
app.listen(PORT, (err) => {
    if (err) {
        console.log(err);
    } else {
        console.log(`O servidor está rodando na porta ${PORT}`);
    }
});
