import express from 'express';
const productRoute = express.Router();

import auth from '../middleware/authMiddleWare.js';
import getProductController from '../controllers/getProductController.js';
productRoute.get("/api/category-products", auth, getProductController);
export default productRoute;