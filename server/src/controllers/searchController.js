import Product from "../model/productModel.js"
const searchController = async (req, res) => {
    try {
        const productName = req.params.productName;
        const product = await Product.find({
            name: { $regex: productName, $options: 'i' },
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
export default searchController;