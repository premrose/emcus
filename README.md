# EMCUS Flutter App

This is a Flutter project for EMCUS, featuring authentication (sign in/sign up) and a dashboard with a custom bottom navigation bar. The app uses the BLoC pattern for state management and GetIt for dependency injection.

## Getting Started
1. Clone this repository.
2. Run `flutter pub get` to install dependencies.
3. Run the app with `flutter run`.

## Features
  - Auth page checks if the user is authenticated and redirect to the dashboard or signin page
  - Sign In and Sign Up screens using firebase
  - Upon successful Signin or Signup, Dashboard screen will be navigated
  - Dashboard screens has a logout feature and bottom bar based navigation

## Project Structure
- `lib/`
   `models/`
    `modules/`
    `network/`
    `utils/` 


