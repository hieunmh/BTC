import express from 'express';
import dotenv from 'dotenv';
import cors from 'cors';
import bodyParser from 'body-parser';
import morgan from 'morgan';

dotenv.config();

const app = express();

app.use(express.json());

app.use(bodyParser.json());

app.use(bodyParser.urlencoded({ extended: true }));

app.use(cors({ origin: process.env.FRONTEND_HOST, credentials: true }));

app.use(morgan('combined'));



const PORT = process.env.PORT || 5000;

app.get('/', (req, res) => {
  res.status(200).send('Hello from BTC app!');
});

app.listen(PORT, () => {
  console.log(`server running on PORT ${PORT}`);
});