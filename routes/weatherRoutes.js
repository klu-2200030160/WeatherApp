// routes/weatherRoutes.js
const express = require('express');
const router = express.Router();
const Weather = require('../models/weather'); // Adjust the path to your Weather model

// POST /api/weather - Add new weather data
router.post('/weather', async (req, res) => {
    const {
        city,
        date,
        time,
        day,
        tempMax,
        tempMin,
        windSpeed,
        humidity,
        weatherDescription,
        weatherIcon
    } = req.body;

    // Check for missing fields
    if (!city || !date || !time || !day || tempMax == null || tempMin == null || windSpeed == null || humidity == null) {
        return res.status(400).json({ message: 'Please provide all required fields' });
    }

    // Check if city already exists
    const existingWeather = await Weather.findOne({ city });
    if (existingWeather) {
        return res.status(400).json({ message: 'City already exists and cannot be modified' });
    }

    const newWeather = new Weather({
        city,
        date,
        time,
        day,
        tempMax,
        tempMin,
        windSpeed,
        humidity,
        weatherDescription,
        weatherIcon
    });

    try {
        await newWeather.save();
        res.status(201).json(newWeather); // Respond with the created weather object
    } catch (error) {
        console.error('Error saving weather data:', error);
        res.status(500).json({ message: 'Error saving weather data', error });
    }
});



router.get('/weather', async (req, res) => {
    const { city } = req.query; // Access the city parameter from the query string
    if (!city) {
      return res.status(400).json({ message: 'City parameter is required' }); // Handle missing city parameter
    }
  
    try {
      const weatherData = await Weather.findOne({ city });
      if (!weatherData) {
        return res.status(404).json({ message: 'Weather data for the specified city not found' });
      }
      res.status(200).json(weatherData);
    } catch (error) {
      console.error('Error retrieving weather data for city:', error);
      res.status(500).json({ message: 'Error retrieving weather data', error });
    }
  });
  

module.exports = router;
