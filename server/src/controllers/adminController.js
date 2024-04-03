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
const updateStatusController = async (req, res) => {
    try {
        const { id, status } = req.body;
        let order = await Order.findById(id);
        order.status = status;
        await order.save();
        res.status(200).send({
            success: true,
            products: order
        })
    } catch (error) {
        res.status(500).send({
            success: false,
            message: `error in get admin orders ${error.message}`
        })
    }
}
const adminGetTotalEarning = async (req, res) => {
    try {
        let totalEarning = 0;
        let orders = await Order.find({});
        for (let i = 0; i < orders.length; i++) {

            for (let j = 0; j < orders[i].products.length; j++) {
                // console.log(orders[i].products[j].Product);
                totalEarning = totalEarning + (orders[i].products[j].product.quantity) * (orders[i].products[j].product.price);
            }
        }
        let mobileEarnings = await categoryWiseEarning("Mobiles");
        // console.log(mobileEarnings);
        let essentialEarnings = await categoryWiseEarning("Essentials");
        let applianceEarnings = await categoryWiseEarning("Appliances");
        let booksEarnings = await categoryWiseEarning("Books");
        let fashionEarnings = await categoryWiseEarning("Fashion");
        let earnings = {
            totalEarning,
            mobileEarnings,
            essentialEarnings,
            applianceEarnings,
            booksEarnings,
            fashionEarnings,
        };
        res.status(200).send({
            success: true,
            earnings: earnings
        })
    } catch (error) {
        res.status(500).send({
            success: false,
            message: `error in get admin earning ${error.message}`
        })
    }
}
const categoryWiseEarning = async (category) => {
    let earning = 0;
    // console.log(products.products.product.catagory);
    let orders = await Order.find({
        "products.product.catagory": category
    });
    //  console.log(orders);
    for (let i = 0; i < orders.length; i++) {
        for (let j = 0; j < orders[i].products.length; j++) {
            earning = earning + (orders[i].products[j].product.quantity) * (orders[i].products[j].product.price);
            //console.log(orders[i].products[j].product.price);
        }
    }
    return earning;
}
export { adminControllerAddProduct, adminControllerGetProduct, adminControllerDeleteProduct, adminGetAllOrders, updateStatusController, adminGetTotalEarning };