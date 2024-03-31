import mongoose from 'mongoose';

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
    },
    rating: [
        {
            userId: {
                type: String,
                required: true
            },
            rating: {
                type: Number,
                required: true
            }
        }
    ]
});
const Product = mongoose.model("Product", productSchema);
export { Product, productSchema };