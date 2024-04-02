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
            const avgRatingA = calculateAverageRating(a);
            const avgRatingB = calculateAverageRating(b);
            return avgRatingB - avgRatingA;
        });

        res.status(200).send({
            success: true,
            products: products
        });
    } catch (error) {
        res.status(500).send({
            success: false,
            message: error.message
        });
    }
};

const calculateAverageRating = (product) => {
    if (!product.ratings || product.ratings.length === 0) {
        return 0;
    }
    // const totalRating = product.ratings.reduce((acc, rating) => acc + rating.rating, 0);
    let totalRating = 0;
    for (let i = 0; i < product.ratings.length; i++) {
        totalRating += product.ratings[i].rating;
    }
    return totalRating / product.ratings.length;
};

export { getProductController, dealOfTheDayProduct };