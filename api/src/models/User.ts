import { Table, Column, Model, DataType, Unique, PrimaryKey } from 'sequelize-typescript';
import { UserType } from '../types/type';

@Table({
  tableName: 'Users',
  timestamps: true
})

export class User extends Model<UserType> {
  @PrimaryKey
  @Column({
    type: DataType.UUID,
    allowNull: false
  })
  id!: string;
  
  @Column({
    type: DataType.STRING,
    allowNull: true
  })
  name!: string


  @Unique
  @Column({
    type: DataType.STRING,
    allowNull: false,
  })
  email!: string

  @Column({
    type: DataType.STRING,
    allowNull: false
  })
  password!: string

  @Column({
    type: DataType.STRING,
    allowNull: true
  })
  username!: string

  @Column({
    type: DataType.STRING,
    allowNull: true
  })
  avatar!: string
}