import { Table, Column, Model, DataType, Unique, PrimaryKey, HasMany } from 'sequelize-typescript';
import { UserType } from '../types/type';

@Table({
  tableName: 'users',
  timestamps: true
})

export class User extends Model<UserType> {
  @PrimaryKey
  @Column({
    type: DataType.UUID,
    allowNull: false
  })
  id?: string;
  
  @Column({
    type: DataType.STRING,
    allowNull: false
  })
  name?: string


  @Unique
  @Column({
    type: DataType.STRING,
    allowNull: false,
  })
  email?: string

  @Column({
    type: DataType.STRING,
    allowNull: false
  })
  password?: string

  @Column({
    type: DataType.STRING,
    allowNull: false
  })
  username?: string

  @Column({
    type: DataType.STRING,
    allowNull: false
  })
  avatar?: string
}