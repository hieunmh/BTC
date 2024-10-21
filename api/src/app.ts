import express from 'express';
import dotenv from 'dotenv';

dotenv.config();

const app = express();

const PORT = process.env.PORT || 5000;

app.get('/', (req, res) => {
  res.status(200).send('Hello from BTC app!');
})

app.listen(PORT, () => {
  console.log(`server running on PORT ${PORT}`);
  
})