import { Router } from "express";
import * as userController from '../controllers/use.controller';
import { isAuth } from "../middleware/auth";

const router: Router  = Router();

router.get('/user', isAuth, userController.getUser);

export default router;  