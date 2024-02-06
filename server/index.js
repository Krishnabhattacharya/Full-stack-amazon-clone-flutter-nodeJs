import express from 'express';
import dotenv from 'dotenv';
import colors from "colors";
import authRoute from './src/routes/userRoutes.js';
import db from './src/db/mongoose.js';
import morgan from 'morgan';


dotenv.config();
const app = express();


app.use(express.json());
app.use("/api/auth", authRoute);
app.use(morgan("dev"));
db();



const port = process.env.PORT || 3000;









app.listen(port, () => {
    console.log(`server running on port === ${port}`.bgCyan);
});