const mongoose = require('mongoose');

const ratingSchema = new mongoose.Schema({
    userId: {
        type: String,
        required: ['true','Must have a rattings']
    },
    rating: {
        type: Number,
        required: ['true', 'Must need to put rattings']
    }
});

module.exports = ratingSchema;