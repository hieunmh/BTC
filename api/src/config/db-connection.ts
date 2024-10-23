import { Sequelize } from "sequelize-typescript";
import dotenv from 'dotenv';
import { User } from "../models/User";

dotenv.config();

export const connection = new Sequelize({
  database: process.env.DB_NAME as string,
  username: process.env.DB_USERNAME as string,
  password: process.env.DB_PASSWORD as string,
  host: process.env.DB_HOST,
  port: Number(process.env.DB_PORT),
  dialect: 'postgres',
  dialectOptions: {
    ssl: {
      require: true,
      rejectUnauthorized: false,
    }
  },
  models: [User]
})