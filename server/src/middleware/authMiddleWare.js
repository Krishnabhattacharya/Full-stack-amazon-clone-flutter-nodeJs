
//----------
import jwt from 'jsonwebtoken';
import User from '../model/userModel.js';

const auth = async (req, res, next) => {
    try {
        const token = req.header("Authorization").replace("Bearer ", "");
        if (!token) {
            throw new Error("Authentication token is missing.");
        }

        const decoded = jwt.verify(token, process.env.TOKEN);
        if (!decoded || !decoded._id) {
            throw new Error("Invalid token or user ID.");
        }

        const user = await User.findOne({ _id: decoded._id, "tokens.token": token });
        if (!user) {
            throw new Error("User not found.");
        }

        req.user = user;
        req.token = token;
        next();
    } catch (error) {
        console.error("Authentication error:", error);
        res.status(401).send({
            success: false,
            message: `Error in authentication middleware: ${error.message}`
        });
    }
}

export default auth;
