import jwt from 'jsonwebtoken';
import User from '../model/userModel.js';
const admin = async (req, res, next) => {
    try {
        const token = req.header("Authorization").replace("Bearer ", "");
        const decoded = jwt.verify(token, process.env.TOKEN);
        const admin = await User.findOne({ _id: decoded._id, "tokens.token": token });
        if (!admin) {
            throw new Error();
        }
        if (admin.type == "user" || admin.type == "seller") {
            return res.status(401).json({ msg: "You are not an admin!" });
        }
        res.user = admin,
            req.token = token,
            next();
    } catch (error) {
        res.status(500).send({
            success: false,
            message: error
        });
    }
}
export default admin;