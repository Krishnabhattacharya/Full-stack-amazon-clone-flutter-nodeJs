import express from 'express';
import admin from '../middleware/adminMiddleWare.js';

import { adminControllerAddProduct, adminControllerDeleteProduct, adminControllerGetProduct, adminGetAllOrders, adminGetTotalEarning, updateStatusController } from '../controllers/adminController.js';
const adminRoute = express.Router();
adminRoute.post("/admin/add-product", admin, adminControllerAddProduct);
adminRoute.get("/admin/get-product", admin, adminControllerGetProduct);
adminRoute.post("/admin/delete-product", admin, adminControllerDeleteProduct);
adminRoute.get("/admin/get-all-orders", admin, adminGetAllOrders);
adminRoute.post("/admin/update-status", admin, updateStatusController);
adminRoute.get("/admin/get-total-earnings", admin, adminGetTotalEarning);
export default adminRoute;