import mongoose from 'mongoose';

const RatingSchema = mongoose.Schema({
    userId: {
        type: String,
        required: true
    },
    rating: {
        type: Number,
        required: true
    }
})
export default RatingSchema;