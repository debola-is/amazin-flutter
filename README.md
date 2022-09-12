# Amazin

A clone of the Amazon mobile shopping application built with Flutter for the mobile client and Node.js for the backend service.

## Requirements
- [Flutter SDK and Dart](https://docs.flutter.dev/get-started/install?gclid=CjwKCAjwsfuYBhAZEiwA5a6CDKg0IENEmEpQRDwt-8cTHp6FIf8UMET-3zG9M-oiQBlKAq_imDRKgRoCnpsQAvD_BwE&gclsrc=aw.ds)
- [Android Emulator or iOS simlator](https://developer.android.com/studio?gclid=CjwKCAjwsfuYBhAZEiwA5a6CDNqyXXrWHoSk3KMamypQGg5z5MH933GAS-UYDfDMD8-OnUCSAmSHgBoC-AUQAvD_BwE&gclsrc=aw.ds#downloads)
- Physical android/iOS device can also be used in place of emulator.
- [Node.js](https://nodejs.org)

## Getting Started
- Clone the repo or download the source code
- Navigate to the project root directory in your terminal "./Amazin/"

### Backend
- run the backend server locally
- cd into "server" directory
- run ``` npm install ```
- run ``` npm run start ```
While your server is running, copy the ip address as this will be used to configure the flutter app client.

### Flutter Application
- Firstly, refer to the [flutter online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on setting up your pc for mobile development, and a full API reference.
- cd back into the project root directory
- input the server ip address from above in the global variables file "./lib/constants/global_variables.dart"
- Run the flutter application in your preferred emulator device
