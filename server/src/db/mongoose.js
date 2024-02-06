import mongoose from 'mongoose';

const connectionToDb = async () => {
    try {
        await mongoose.connect(process.env.URL);
        console.log("connection succesfully".bgGreen);
    } catch (error) {
        console.log(error);
    }
}
export default connectionToDb;