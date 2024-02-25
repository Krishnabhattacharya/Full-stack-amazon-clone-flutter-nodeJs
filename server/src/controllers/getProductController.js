import Product from "../model/productModel.js"

const getProductController = async (req, res) => {
    try {
        const category = req.query.category;
        const product = await Product.find({
            catagory: category
        });
        res.status(200).send({
            success: true,
            products: product
        })
    } catch (error) {
        res.status(500).status({
            success: false,
            message: error.message
        })
    }
}
export default getProductController;