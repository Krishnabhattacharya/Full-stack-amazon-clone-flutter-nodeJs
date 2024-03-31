import { Product } from "../model/productModel.js"

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
const dealOfTheDayProduct = async (req, res) => {
    try {
        let products = await Product.find({});
        products = products.sort((a, b) => {
            let x = 0;
            let y = 0;
            for (let index = 0; index < a.ratings.length; index++) {
                x += a.ratings[index].rating;

            }
            for (let index = 0; index < b.ratings.length; index++) {
                y += b.ratings[index].rating;

            }
            return x < y ? 1 : -1;
        })
        res.status(200).send({
            success: true,
            products: products
        })
    } catch (error) {
        res.status(500).send({
            succes: false,
            message: error.message
        })
    }
}
export { getProductController, dealOfTheDayProduct };