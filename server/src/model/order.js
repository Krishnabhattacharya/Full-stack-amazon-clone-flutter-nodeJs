import mongoose from "mongoose"
import { productSchema } from "./productModel"

const orderSchema = mongoose.Schema({
    products: [
        {
            product: productSchema,
            quantity: {
                type: Number,
                required: true
            }
        },

    ],
    price: {
        type: Number,
        required: true
    },
    address: {
        type: String,
        required: true
    },
    userId: {
        type: String,
        required: true
    },
    orderAt: {
        type: Number,
        required: true
    },
    status: {
        type: Number,
        default: 0
    }
});
const Order = mongoose.model("Order", orderSchema);
export default Order;