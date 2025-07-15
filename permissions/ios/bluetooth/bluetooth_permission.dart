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
