# Kayabe LIMS Mobile App

Currently only support Android - IOS Support on progress

## Setup
## Setup
1. Clone the repo and all of it's submodules and go to project folder
```
git clone <URL>
```
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

4. Build generated files
```console
flutter pub run build_runner build --delete-conflicting-outputs
```

5. Start debugging
- Just press F5 and you go

## Architecture
We utilize GetX as a state management library and some Riverpod.

##  Dependencies

To list all used dependencies run
```
flutter pub deps
```
