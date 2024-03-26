import express from 'express';
const RatingtRoute = express.Router();

import auth from '../middleware/authMiddleWare.js';
import ratingProductController from '../controllers/ratingController.js';

RatingtRoute.post("/api/rating-products", auth, ratingProductController);
export default RatingtRoute;