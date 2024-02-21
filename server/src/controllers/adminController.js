import Product from "../model/productModel.js";

const adminController = async (req, res) => {
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
            message: error
        })
    }
}
export default adminController;