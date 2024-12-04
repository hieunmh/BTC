import {  Router } from 'express';
import * as coinController from '../controllers/coin.controller';

const router: Router  = Router();

router.get('/coin', coinController.getCoinMarket);

export default router;