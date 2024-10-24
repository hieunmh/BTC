import { Router } from "express";
import authRouter from './auth.route';
import userRouter from './user.route';

const router: Router = Router();

router.use('/auth', authRouter);
router.use('/', userRouter);

export default router;