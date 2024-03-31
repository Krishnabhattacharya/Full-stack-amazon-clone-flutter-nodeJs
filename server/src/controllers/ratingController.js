import { Product } from "../model/productModel.js";

const ratingProductController = async (req, res) => {
    try {
        const { id, rating } = req.body;
        console.log(id);
        const userid = req.user._id;
        console.log(userid);
        let product = await Product.findById(id);
        let userRatingIndex = -1;
        for (let index = 0; index < product.rating.length; index++) {
            if (product.rating[index].userId == userid) {
                userRatingIndex = index;
                product.rating.splice(index, 1);
                break;
            }

        }
        if (userRatingIndex !== -1) {
            product.rating.splice(userRatingIndex, 1);
        }
        product.rating.push({
            userId: userid,
            rating: rating
        })
        product = await product.save();
        res.status(200).send({
            success: true,
            product
        })
    } catch (error) {
        res.status(500).send({
            success: false,
            message: error.message
        })
    }
}
export default ratingProductController;