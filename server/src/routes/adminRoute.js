import express from 'express';
import admin from '../middleware/adminMiddleWare.js';

import { adminControllerAddProduct, adminControllerDeleteProduct, adminControllerGetProduct } from '../controllers/adminController.js';
const adminRoute = express.Router();
adminRoute.post("/admin/add-product", admin, adminControllerAddProduct);
adminRoute.get("/admin/get-product", admin, adminControllerGetProduct);
adminRoute.post("/admin/delete-product", admin, adminControllerDeleteProduct);
export default adminRoute;