import express from 'express';
import { signupController, loginController, addToCart, deleteFromCartController, addAddress, ordersControllers, getOrdersController } from '../controllers/userController.js';
import auth from '../middleware/authMiddleWare.js';
const authRoute = express.Router();

authRoute.post("/api/auth/user/signup", signupController);
authRoute.post("/api/auth/user/signin", loginController);
authRoute.post("/api/add-to-cart", auth, addToCart);
authRoute.post("/api/delete-from-cart", auth, deleteFromCartController);
authRoute.post("/api/add-address", auth, addAddress);
authRoute.post("/api/orders", auth, ordersControllers)
authRoute.get("/api/get-orders", auth, getOrdersController)
export default authRoute;