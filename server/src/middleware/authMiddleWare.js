import jwt from 'jsonwebtoken';
import User from '../model/userModel.js';
const auth = async (req, res, next) => {
    try {
        const token = req.header("Authorization").replace("Bearer ", "");
        const decoded = jwt.verify(token, process.env.TOKEN);
        const user = await User.findOne({ _id: decoded._id, "tokens.token": token });
        if (!user) {
            throw new Error();
        }

        res.user = user,
            req.token = token,
            next();
    } catch (error) {
        res.status(401).send({
            success: false,
            message: `error in adminMiddleWare ${error.message}`
        });
    }
}
export default auth;