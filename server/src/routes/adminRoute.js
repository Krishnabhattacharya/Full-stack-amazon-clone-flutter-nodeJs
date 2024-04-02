import express from 'express';
import admin from '../middleware/adminMiddleWare.js';

import { adminControllerAddProduct, adminControllerDeleteProduct, adminControllerGetProduct, adminGetAllOrders } from '../controllers/adminController.js';
const adminRoute = express.Router();
adminRoute.post("/admin/add-product", admin, adminControllerAddProduct);
adminRoute.get("/admin/get-product", admin, adminControllerGetProduct);
adminRoute.post("/admin/delete-product", admin, adminControllerDeleteProduct);
adminRoute.get("/admin/get-all-product", admin, adminGetAllOrders);
export default adminRoute;