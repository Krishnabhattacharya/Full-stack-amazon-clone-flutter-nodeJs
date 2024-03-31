import express from 'express';
import dotenv from 'dotenv';
import colors from "colors";
import authRoute from './src/routes/userRoutes.js';
import db from './src/db/mongoose.js';
import morgan from 'morgan';
import adminRoute from './src/routes/adminRoute.js';
import productRoute from './src/routes/getProducts.js';
import searchRoute from './src/routes/searchRoute.js';
import RatingtRoute from './src/routes/ratingProduct.js';



dotenv.config();
const app = express();


app.use(express.json());
app.use(authRoute);
app.use(adminRoute);
app.use(productRoute);
app.use(searchRoute);
app.use(RatingtRoute);

app.use(morgan("dev"));
db();



const port = process.env.PORT || 3000;









app.listen(port, () => {
    console.log(`server running on port === ${port}`.bgCyan);
});