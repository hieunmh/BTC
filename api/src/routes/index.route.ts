import { Router } from "express";
import authRouter from './auth.route';
import userRouter from './user.route';
import coinRouter from './coin.route';

const router: Router = Router();

router.use('/auth', authRouter);
router.use('/', userRouter);
router.use('/', coinRouter);

export default router;