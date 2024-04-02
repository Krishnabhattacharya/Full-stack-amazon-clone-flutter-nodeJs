import Order from "../model/order.js";
import { Product } from "../model/productModel.js";

const adminControllerAddProduct = async (req, res) => {
    try {
        const { name, description, images, quantity, price, catagory } = req.body;
        let product = new Product({
            name, description, images, quantity, price, catagory
        });
        product = await product.save();
        res.status(200).send({
            success: true,
            product: product,
        });
    } catch (error) {
        console.error("Error in /admin/add-product:", error);
        res.status(500).send({
            success: false,
            message: error.message
        })
    }
}
const adminControllerGetProduct = async (req, res) => {
    try {
        const products = await Product.find({});
        res.status(200).send({
            success: true,
            products: products
        })
    } catch (error) {
        res.status(500).send({
            success: false,
            message: `error in get admin product ${error.message}`
        })
    }
}
const adminControllerDeleteProduct = async (req, res) => {
    try {
        const { _id } = req.body;
        const product = await Product.findByIdAndDelete(_id);
        if (!product) {

            return res.status(404).send({
                success: false,
                message: "Product not found",
            });
        }
        res.status(200).send({
            success: true,
            product: product,
        });
    } catch (error) {
        res.status(500).send({
            success: false,
            message: error.message,
        });
    }
};
const adminGetAllOrders = async (req, res) => {
    try {
        const orders = await Order.find({});
        res.status(200).send({
            success: true,
            products: orders
        })
    } catch (error) {
        res.status(500).send({
            success: false,
            message: `error in get admin product ${error.message}`
        })
    }
}
export { adminControllerAddProduct, adminControllerGetProduct, adminControllerDeleteProduct, adminGetAllOrders };