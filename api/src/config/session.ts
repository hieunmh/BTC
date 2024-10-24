import session from 'express-session';
import connectSessionSequelize from 'connect-session-sequelize';
import { connection } from './db-connection';

const SequelizeStore = connectSessionSequelize(session.Store);

const sessionStore = new SequelizeStore({
  db: connection,
});

export default sessionStore;