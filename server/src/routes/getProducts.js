import express from 'express';
const productRoute = express.Router();

import auth from '../middleware/authMiddleWare.js';
import { getProductController, dealOfTheDayProduct } from '../controllers/getProductController.js';
productRoute.get("/api/category-products", auth, getProductController);
productRoute.get("/api/deal-of-day-products", auth, dealOfTheDayProduct)
export default productRoute;