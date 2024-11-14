const express = require('express');
const mongoose = require('mongoose');
const bodyParser = require('body-parser');
const weatherRoutes = require('./routes/weatherRoutes'); // Adjust the path as needed
require('dotenv').config();

const app = express();
const PORT = process.env.PORT || 3000;

// Middleware
app.use(express.json());

// Connect to MongoDB
const mongoURI = process.env.MONGODB_URI; // Use the environment variable
mongoose.connect(mongoURI, { useNewUrlParser: true, useUnifiedTopology: true })
    .then(() => console.log('MongoDB connected'))
    .catch(err => console.error('MongoDB connection error:', err));

// Use the weather routes with the correct path
app.use('/api', weatherRoutes); // Ensure this line is present

app.listen(PORT, () => {
    console.log(`Server running on port ${PORT}`);
});
