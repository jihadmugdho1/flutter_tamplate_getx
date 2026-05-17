# Change App Name
dart run rename_app:main all="Your App Name"

# Activate Rename Tool
dart pub global activate rename

# Change Android Bundle ID
rename setBundleId --targets android --value com.yourcompany.appname

# Change iOS Bundle ID
rename setBundleId --targets ios --value com.yourcompany.appname

# Generate App Icons
dart run flutter_launcher_icons:generate
dart run flutter_launcher_icons

# Change Flutter Package Name
dart run change_app_package_name:main com.yourcompany.appname

# Clean Project
flutter clean
flutter pub get