# Kayabe LIMS Mobile App

Currently only support Android - IOS Support on progress

## Setup
1. Clone the repo and Go to project folder

2. Setup Signing Keys (optional)
 - Create `key.properties` file inside `android` folder, for Example:
```properties
storePassword=
keyPassword=
keyAlias=
storeFile=
```

3. Install pub dependencies
```console
flutter pub get
```

## Architecture
We utilize GetX as a state management library.
