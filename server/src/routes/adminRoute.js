import express from 'express';
import admin from '../middleware/adminMiddleWare.js';
import adminController from '../controllers/adminController.js';
const adminRoute = express.Router();
adminRoute.post("/admin/add-product", admin, adminController);
export default adminRoute;