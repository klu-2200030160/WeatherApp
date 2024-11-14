// models/Weather.js
const mongoose = require('mongoose');

const weatherSchema = new mongoose.Schema({
    city: { type: String, required: true },
    date: { type: Date, required: true },
    time: { type: String, required: true }, // Add time field
    day: { type: String, required: true },
    tempMax: { type: Number, required: true },
    tempMin: { type: Number, required: true },
    windSpeed: { type: Number, required: true },
    humidity: { type: Number, required: true },
    weatherDescription: { type: String },
    weatherIcon: { type: String }
});

module.exports = mongoose.model('Weather', weatherSchema);
