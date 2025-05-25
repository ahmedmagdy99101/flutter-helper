# publish app in google play store

## Flutter Projects created before flutter version 3.29

### Prerequisites
- Ensure the app launcher icon is present and correctly configured.
- Add all required permissions and capabilities in **AndroidManifest.xml**.
- Verify that each package/plugin’s configuration (e.g., Firebase, Google Maps) has been added and set up.
- Test the app in release mode to confirm functionality:
  ```bash
  flutter run --release
  ```

---

### 1. Create & Configure Keystore
Generate a new keystore:

#### Windows
```bash
keytool -genkey -v -keystore $env:USERPROFILE\appName-keystore.jks `
        -storetype JKS -keyalg RSA -keysize 2048 -validity 10000 `
        -alias appName
```

#### macOS / Linux
```bash
keytool -genkey -v -keystore ~/appName-keystore.jks -keyalg RSA \
        -keysize 2048 -validity 10000 -alias appName
```

Create an `android/key.properties` file with:
```properties
storePassword=<YOUR_STORE_PASSWORD>
keyPassword=<YOUR_KEY_PASSWORD>
keyAlias=appName
storeFile=<RELATIVE_PATH_TO>/appName-keystore.jks
```

Update `android/app/build.gradle`:
```groovy
def keystoreProperties = new Properties()
def keystorePropertiesFile = rootProject.file('key.properties')
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(new FileInputStream(keystorePropertiesFile))
}

android {
    ...

    signingConfigs {
        release {
            keyAlias = keystoreProperties['keyAlias']
            keyPassword = keystoreProperties['keyPassword']
            storeFile = keystoreProperties['storeFile'] ? file(keystoreProperties['storeFile']) : null
            storePassword = keystoreProperties['storePassword']
        }
    }
    buildTypes {
        release {
            signingConfig signingConfigs.release
            minifyEnabled true
            proguardFiles getDefaultProguardFile('proguard-android.txt'), 'proguard-rules.pro'
        }
    }
}
```

---

### 2. Update Version (pubspec.yaml)
```yaml
version: 1.0.0+1
```
- **1.0.0** → User-visible version
- **+1** → Build number

---

### 3. Build Android App Bundle
```bash
flutter clean
flutter pub get
flutter build appbundle --release
```
Output: `build/app/outputs/bundle/release/app-release.aab`

---

### 4. Upload to Google Play
1. Sign in to **Google Play Console**.
2. Select your app → **Release** → **Production** .
3. Create a new release, upload `app-release.aab`.
4. Add release notes.
5. Click **Review** → **Start rollout to production**.

---

*End of Deployment Guide for Google Play*  
