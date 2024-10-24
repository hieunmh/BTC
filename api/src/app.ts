/// <reference path="./types/session.d.ts" />
import express from 'express';
import dotenv from 'dotenv';
import cors from 'cors';
import morgan from 'morgan';
import bodyParser from 'body-parser';

import indexRouter from './routes/index.route';

import session from 'express-session';
import cookieParser from 'cookie-parser';
import sessionStore from './config/session';
import { connection } from './config/db-connection';

dotenv.config();

const app = express();

connection.sync().then(() => {
  console.log('Database connected!');
  
});

app.use(express.json());

app.use(session({
  name: process.env.SESSION_NAME,
  resave: false,
  saveUninitialized: false,
  secret: 'secret',
  store: sessionStore,
  proxy: true,
  cookie: {
    sameSite: process.env.SAME_SITE as 'none' | 'lax' | 'strict',
    secure: process.env.COOKIE_SECURE === 'true',
    httpOnly: process.env.COOKIE_HTTP_ONLY === 'true',
    // maxAge: 30 * 24 * 60 * 60 * 1000,
  }
}))

app.use(cookieParser());

app.use(bodyParser.json());

// parse requests of content-type - application/x-www-form-urlencoded
app.use(bodyParser.urlencoded({ extended: true }));

app.use(cors({ origin: process.env.FRONTEND_HOST, credentials: true }));

app.use(morgan('combined'));

app.use(indexRouter);

app.set('trust proxy', true);

const PORT = process.env.PORT || 5000;

app.get('/', (req, res) => {
  res.status(200).send('Hello from BTC app!');
});

app.listen(PORT, () => {
  console.log(`server running on PORT ${PORT}`);
});