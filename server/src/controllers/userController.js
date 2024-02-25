import User from "../model/userModel.js";
import bcrypt from 'bcryptjs';
import validator from "validator";
const signupController = async (req, res) => {
    const { name, email, password } = req.body;
    const existingUser = await User.findOne({ email });
    try {
        if (!validator.isEmail(email)) {
            return res.status(400).send({
                success: false,
                message: "Please provide a valid email address",
            });
        }
        if (password.length < 6) {
            return res.status(400).send({
                success: false,
                message: "Please provide a Strong password",
            });
        }
        if (existingUser) {
            return res.status(400).send({
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
        if (!validator.isEmail(email)) {
            return res.status(400).send({
                success: false,
                message: "Please provide a valid email address",
            });
        }
        if (!email || !password) {
            res.status(400).send({
                success: true,
                message: "Invalid email or password",
            });
        }
        const user = await User.findOne({ email });

        if (!user) {
            console.log("User not found");
            return res.status(404).send({
                success: false,
                message: "User not found",
            });
        }
        const isMatched = await bcrypt.compare(password, user.password);
        if (!isMatched) {
            return res.status(404).send({
                success: true,
                message: "Invalid user",
            });
        }
        const token = await user.generateToken();
        //console.log(token);
        return res.status(200).send({
            success: true,
            message: "Login successful",
            user,
            token: token,
        });
    } catch (error) {
        res.status(500).send({
            success: false,
            message: error.message,
        });
    }
}

export { signupController, loginController };