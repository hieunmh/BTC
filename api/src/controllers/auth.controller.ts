import { Request, Response, RequestHandler } from "express";

export const register: RequestHandler = async(req: Request, res: Response) => {
  res.status(200).send('register!!');
}