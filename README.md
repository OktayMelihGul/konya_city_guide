# Konya City Guide

A Flutter application that serves as a comprehensive guide to Konya, Turkey. The app features attractions, weather information, and public transportation options.

## Features

- **Real-time Weather**: Displays current weather conditions in Konya
- **Attractions Directory**: Browse and filter attractions by categories
  - Historical sites
  - Shopping centers
  - Parks
  - Restaurants and food spots
- **Public Transportation**: Quick access to
  - Bus tracking
  - Tram schedules
  - Taxi services
  - Bicycle and e-scooter rentals

## Project Structure

```
lib/
├── main.dart                 # App initialization and navigation
├── models/
│   └── attraction.dart       # Data model for attractions
├── pages/
│   ├── home_page.dart        # Homepage with weather and quick access
│   ├── attractions_page.dart # Attractions listing and filtering
│   └── transportation_page.dart # Transportation options
└── services/
    ├── weather_service.dart  # Weather API integration
    └── attraction_service.dart # Firebase service for attractions
```

## Setup Instructions

1. **Prerequisites**
   - Flutter SDK
   - Firebase account
   - Android Studio or VS Code with Flutter extensions

2. **Installation**
   ```bash
   # Clone the repository
   git clone https://github.com/OktayMelihGul/konya_city_guide

   # Install dependencies
   flutter pub get
   ```

3. **Firebase Setup**
   - Create a new Firebase project
   - Enable Firestore Database
   - Add your `google-services.json` to `android/app/`
   - Configure Firestore security rules

4. **Running the App**
   ```bash
   flutter run
   ```

## Firebase Data Structure

### Attractions Collection
```json
attractions/
├── [document_id]/
    ├── name: string
    ├── description: string
    ├── imageUrl: string
    ├── category: string
    └── location: string
```

## Adding New Attractions

1. Go to Firebase Console
2. Navigate to Firestore Database
3. Add a new document to the 'attractions' collection with:
   - name: Attraction name
   - description: Detailed description
   - imageUrl: URL to the attraction's image
   - category: One of ["History", "Shopping", "Parks", "Food"]
   - location: Physical address

## External Services

- **Weather API**: Open-Meteo API for weather data
- **Transportation Links**:
  - Konya Metropolitan Municipality bus tracking
  - Konya tram system
  - Local taxi services
  - Bicycle and e-scooter rental apps

## Contributing

This is a course project for Mobile App Development. While it's not open for contributions, feel free to fork and modify for your own use.

## License

This project is created for educational purposes as part of a Mobile App Development course.
