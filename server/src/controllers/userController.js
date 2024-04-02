import User from "../model/userModel.js";
import bcrypt from 'bcryptjs';
import validator from "validator";
import { Product } from "../model/productModel.js";
import Order from "../model/order.js";
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
const addToCart = async (req, res) => {
    try {
        const { id } = req.body;
        const product = await Product.findById(id);
        if (!product) {
            return res.status(404).send({ success: false, message: 'Product not found' });
        }
        let user = await User.findById(req.user._id);
        if (!user) {
            return res.status(404).send({ success: false, message: 'User not found' });
        }
        const cartItemIndex = user.cart.findIndex(item => item.product.equals(product._id));
        if (cartItemIndex !== -1) {
            user.cart[cartItemIndex].cartQuantity += 1;
        } else {
            user.cart.push({ product: product, cartQuantity: 1 });
        }
        await user.save();
        res.status(200).send({ success: true, user: user });
    } catch (error) {
        res.status(500).send({ success: false, message: error.message });
    }
};
const deleteFromCartController = async (req, res) => {
    try {
        const { id } = req.body;
        const product = await Product.findById(id);
        if (!product) {
            return res.status(404).send({ success: false, message: 'Product not found' });
        }
        let user = await User.findById(req.user._id);
        if (!user) {
            return res.status(404).send({ success: false, message: 'User not found' });
        }
        const cartItemIndex = user.cart.findIndex(item => item.product.equals(product._id));


        if (cartItemIndex !== -1) {
            if (user.cart[cartItemIndex].cartQuantity > 1) {
                user.cart[cartItemIndex].cartQuantity -= 1;
            } else {

                user.cart.splice(cartItemIndex, 1);
            }
            await user.save();
            return res.status(200).send({
                success: true,
                user: user
            });
        } else {
            return res.status(404).send({ success: false, message: 'Product not found in cart' });
        }
    } catch (error) {
        return res.status(500).send({
            success: false,
            message: error.message
        });
    }
};
const addAddress = async (req, res) => {
    try {
        const { address } = req.body;
        let user = await User.findById(req.user._id);
        user.address = address;
        await user.save();
        res.status(200).send({ success: true, user: user });
    } catch (error) {
        return res.status(500).send({
            success: false,
            message: error.message
        });
    }

}
const ordersControllers = async (req, res) => {
    try {
        const { cart, price, address } = req.body;
        let products = [];
        console.log(cart);
        for (let index = 0; index < cart.length; index++) {
            let product = await Product.findById(cart[index].product._id);
            console.log("hiiii");
            console.log(product);
            if (!product) {
                return res.status(400).send({ message: "Product not found" });
            }
            if (product.quantity >= cart[index].cartQuantity) {
                product.quantity -= cart[index].cartQuantity;
                products.push({ product, quantity: cart[index].cartQuantity });
                await product.save();

            }
            else {
                res.send({ message: `${product.name} is out of stock` });
            }

        }
        let user = await User.findById(req.user._id);
        user.cart = [];
        //  console.log("hiii");
        await user.save();
        let order = new Order({
            products,
            price,
            address,
            userId: req.user._id,
            orderAt: new Date().getTime(),
        })
        //  console.log(order);
        order = await order.save();
        res.status(200).send({
            success: true,
            order: order
        })
    } catch (error) {
        return res.status(500).send({
            success: false,
            message: error.message
        });
    }

}
const getOrdersController = async (req, res) => {
    const id = req.user._id;
    try {
        const products = await Order.find({ userId: id });
        if (!products) {
            Error("No products found");
        }
        res.status(200).send({
            success: true,
            products: products
        })
    } catch (error) {
        res.status(500).send({
            success: false,
            message: error.message
        })
    }

}
export { signupController, loginController, addToCart, deleteFromCartController, addAddress, ordersControllers, getOrdersController };