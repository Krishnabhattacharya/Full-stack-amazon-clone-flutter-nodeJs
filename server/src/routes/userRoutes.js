import express from 'express';
import { signupController, loginController, addToCart, deleteFromCartController, addAddress } from '../controllers/userController.js';
import auth from '../middleware/authMiddleWare.js';
const authRoute = express.Router();

authRoute.post("/api/auth/user/signup", signupController);
authRoute.post("/api/auth/user/signin", loginController);
authRoute.post("/api/add-to-cart", auth, addToCart);
authRoute.post("/api/delete-from-cart", auth, deleteFromCartController);
authRoute.post("/api/add-address", auth, addAddress)
export default authRoute;