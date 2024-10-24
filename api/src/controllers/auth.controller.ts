import { Request, Response, RequestHandler } from "express";
import { v4 as uuidv4 } from 'uuid';
import bcrypt from 'bcrypt';

import { User } from "../models/User";

export const register: RequestHandler = async (req: Request, res: Response) => {
  const { email, password } = await req.body;

  if (!email || !password) res.status(400).json({ msg: 'Please fill all!' });

  await User.create({
    id: uuidv4(),
    email: email,
    password: bcrypt.hashSync(password, 10)
  }).then(user => {
    req.session.userId = user.id;

    res.status(201).json({
      msg: 'Registered successfully!',
      user: {
        id: user.id,
        name: user?.name,
        email: user?.email,
        username: user?.username,
        avatar: user?.avatar,
        createdAt: user.createdAt,
        updatedAt: user.updatedAt
      }
    });
  }).catch((err: any) => {
    res.status(500).json({ msg: err })
  }); 
}

export const login: RequestHandler = async (req: Request, res: Response) => {
  const { email, password } = req.body;

  if (!email || ! password) res.status(400).json({ msg: 'Please fill all!' });

  const user = await User.findOne({
    attributes: ['id', 'name', 'email', 'password', 'username', 'avatar', 'createdAt', 'updatedAt'],
    where: { email: email }
  });

  if (!user) res.status(404).json({ msg: 'No use found!' });

  if (bcrypt.compareSync(password, user?.password as string)) {
    req.session.userId = user?.id;

    res.status(200).json({
      msg: 'Login successfully!',
      user: {
        id: user?.id,
        name: user?.name,
        email: user?.email,
        username: user?.username,
        avatar: user?.avatar,
        createdAt: user?.createdAt,
        updatedAt: user?.updatedAt
      }
    });
  } else {
    res.status(500).json({ msg: 'Invalid credential!' });
  }
}

export const logout: RequestHandler = async (req: Request, res: Response) => {

  if (!req.session.userId) res.status(500).json({ msg: 'Logout error!' });

  req.session.destroy(err => {
    if (err) res.status(500).json({ msg: 'Internal error!' });
  })

  res.clearCookie('sid');

   res.status(200).json({
    msg: 'Logout successfully!'
  })
}