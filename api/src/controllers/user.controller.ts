import { Request, RequestHandler, Response } from "express";
import { User } from "../models/User";

export const getUser: RequestHandler = async (req: Request,  res: Response) => {
  let userId = req.session.userId;

  const user = await User.findByPk(userId);

  if (!user) res.status(404).json({ msg: 'User not found!' });

  res.status(200).json({
    msg: 'Already login!',
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
}