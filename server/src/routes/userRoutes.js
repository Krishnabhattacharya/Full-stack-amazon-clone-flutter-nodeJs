import express from 'express';
import { signupController, loginController } from '../controllers/userController.js';
const authRoute = express.Router();

authRoute.post("/user/signup", signupController);
authRoute.post("/user/signin", loginController);
export default authRoute;