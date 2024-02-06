import User from "../model/userModel.js";
import bcrypt from 'bcryptjs';
const signupController = async (req, res) => {
    const { name, email, password } = req.body;
    const existingUser = await User.findOne({ email });
    try {
        if (existingUser) {
            return res.status(200).send({
                success: true,
                message: "User Already Exist",
            });
        }
        const user = new User(req.body);
        await user.save();
        const token = await user.generateToken();
        res.status(201).send({
            success: true,
            user,
            token
        })
    }
    catch (error) {
        res.status(500).send({
            success: false,
            message: error.message,
        })
    }
}
const loginController = async (req, res) => {
    try {
        const { email, password } = req.body;
        if (!email || !password) {
            res.status(200).send({
                success: true,
                message: "Invalid email or password",
            });
        }
        const user = await User.findOne({ email });

        if (!user) {
            console.log("User not found");
            return res.status(200).send({
                success: false,
                message: "User not found",
            });
        }
        const isMatched = await bcrypt.compare(password, user.password);
        if (!isMatched) {
            return res.status(200).send({
                success: true,
                message: "Invalid user",
            });
        }

        return res.status(200).send({
            success: true,
            message: "Login successful",
            user,
        });
    } catch (error) {
        res.status(500).send({
            success: false,
            message: error.message,
        });
    }
}

export { signupController, loginController };