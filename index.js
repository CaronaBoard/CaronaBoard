const express = require('express');
const app = express();

const PORT = process.env.PORT || 3000;

app.get('/', (req, res) => {
  res.sendFile(`${__dirname}/index.html`);
});

app.get('/v2', (req, res) => {
  res.sendFile(`${__dirname}/index2.html`);
});

app.use(express.static(`${__dirname}/public`));
app.listen(PORT, () => {
  console.log(`Listening on ${PORT}`);
});
