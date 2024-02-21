import mongoose from 'mongoose';
import { type } from 'os';

const productSchema = mongoose.Schema({
    name: {
        required: true,
        type: String,
    },
    description: {
        type: String,
        required: true,
    },
    images: [
        {
            type: String,
            required: true,
        }
    ],
    quantity: {
        type: Number,
        required: true,
    },
    price: {
        type: Number,
        required: true,
    },
    catagory: {
        type: String,
        required: true,
    }
});
const Product = mongoose.model("Product", productSchema);
export default Product;