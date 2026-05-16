Project Initial Setup Commands

# Change App Name
dart run rename_app:main all="AppLogo"

# Change Android Bundle ID
dart pub global activate rename
rename setBundleId --targets android --value com.yourcompany.applogo

# Change iOS Bundle ID
rename setBundleId --targets ios --value com.yourcompany.applogo

# change app icon 
dart run flutter_launcher_icons:generate
dart run flutter_launcher_icons

# Clean & Refresh Project
flutter clean
flutter pub get

