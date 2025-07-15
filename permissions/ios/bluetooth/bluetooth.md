# Bluetooth Permission Handler

A service to check and request Bluetooth-related permissions in Flutter, compatible with Android and iOS.

## Dart Usage

Place this code in `permissions/ios/bluetooth/bluetooth_permission.dart`:

```dart
import 'package:permission_handler/permission_handler.dart';

/// Checks and requests Bluetooth permissions (Android & iOS).
Future<bool> checkAndRequestBluetoothPermission() async {
  try {
    // Check Bluetooth permission status
    PermissionStatus bluetoothStatus = await Permission.bluetooth.request();

    // Check Bluetooth Scan permission (required for Android 12+)
    PermissionStatus bluetoothScanStatus = await Permission.bluetoothScan.request();

    // Check Bluetooth Connect permission (required for Android 12+)
    PermissionStatus bluetoothConnectStatus = await Permission.bluetoothConnect.request();

    // Return true if all required permissions are granted
    return bluetoothStatus.isGranted && 
           bluetoothScanStatus.isGranted && 
           bluetoothConnectStatus.isGranted;
  } catch (e) {
    print('Error checking Bluetooth permissions: $e');
    return false;
  }
}
```

## iOS Podfile Configuration

For iOS, requesting Bluetooth permissions via code alone is not sufficient.  
You must add Bluetooth macros in your `ios/Podfile` under `post_install`:

```ruby
post_install do |installer|
  installer.pods_project.targets.each do |target|
    flutter_additional_ios_build_settings(target)

    target.build_configurations.each do |config|
      config.build_settings['GCC_PREPROCESSOR_DEFINITIONS'] ||= ['$(inherited)',
        # Enable only the permissions your app needs.
        'PERMISSION_BLUETOOTH=1',
        'PERMISSION_BLUETOOTH_SCAN=1',
        'PERMISSION_BLUETOOTH_CONNECT=1',
      ]
    end
  end
end
```

- **PERMISSION_BLUETOOTH**: General Bluetooth permission
- **PERMISSION_BLUETOOTH_SCAN**: Required on iOS 13+ for scanning
- **PERMISSION_BLUETOOTH_CONNECT**: Required on iOS 13+ for connecting

## Info.plist Entries

Add the following keys to your `Info.plist`:

```xml
<key>NSBluetoothAlwaysUsageDescription</key>
<string>This app requires Bluetooth access to connect to devices.</string>
<key>NSBluetoothPeripheralUsageDescription</key>
<string>This app requires Bluetooth access to scan for devices.</string>
```

## Additional Notes

- Test on a physical iOS device, as simulators do not support Bluetooth.
- Ensure your app's privacy policy explains why Bluetooth permissions are needed.
