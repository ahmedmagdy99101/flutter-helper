# App Update Service

A singleton service that automatically checks for new versions of your Flutter app, prompts users to update, and handles both mandatory and optional updates.  
It integrates with your app’s lifecycle, shows in-app dialogs, and directs users to the store.

---

## Features

- **Automatic Checks**: Silent version check on app resume.
- **Manual Trigger**: Call `checkWithDialog()` to prompt update check on demand.
- **Forced vs. Optional**: Prevent app use until update if mandatory.
- **Customizable UI**: Easy customization of update and error dialogs.
- **Version Comparison**: Robust semantic version parsing.
- **Store Redirection**: Opens Play Store or App Store link automatically.

---

## Use Cases

- **Critical Fixes**: Enforce updates when major bugs or security issues are discovered.
- **Feature Releases**: Prompt users to get the latest features.
- **Marketing**: Guide users to new promotional content or in-app events.
- **Compliance**: Ensure users run versions compliant with backend APIs.

---

## Usage Examples

### 1. Initialize in `main.dart`

```dart
final GlobalKey<NavigatorState>() navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppUpdateManager.initialize(
    'com.example.app',  // Your bundle ID
    navigatorKey,       // Pass the navigator key for overlay context
  );
  runApp(MyApp(navigatorKey: navigatorKey));
}
```

### 2. Trigger Manual Check (e.g., Settings Screen)

```dart
ElevatedButton(
  onPressed: () async {
    await AppUpdateManager().checkWithDialog();
  },
  child: Text('Check for Updates'),
);
```
