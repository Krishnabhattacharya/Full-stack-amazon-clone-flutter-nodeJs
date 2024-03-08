import express from 'express';
const searchRoute = express.Router();

import auth from '../middleware/authMiddleWare.js';
import searchController from '../controllers/searchController.js';

searchRoute.get("/api/search-products/:productName", auth, searchController);
export default searchRoute;