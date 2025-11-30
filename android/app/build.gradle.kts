plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.trying_flutter"
    compileSdk = 36
    ndkVersion = "27.0.12077973"

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = "17"
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "com.example.trying_flutter"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = 24
        targetSdk = 36
        versionCode = 1
        versionName = "1.0.0"
    }

    buildTypes {
        release {
            // TODO: Add your own signing config for the release build.
            // Signing with the debug keys for now, so `flutter run --release` works.
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}

// Copy APK to Flutter's expected location after build
afterEvaluate {
    tasks.register<Copy>("copyApkToFlutterOutput") {
        from(layout.buildDirectory.dir("outputs/apk/debug"))
        into(layout.projectDirectory.dir("../../build/app/outputs/flutter-apk"))
        include("*.apk")
    }

    tasks.register<Copy>("copyReleaseApkToFlutterOutput") {
        from(layout.buildDirectory.dir("outputs/apk/release"))
        into(layout.projectDirectory.dir("../../build/app/outputs/flutter-apk"))
        include("*.apk")
    }

    tasks.named("assembleDebug") {
        finalizedBy("copyApkToFlutterOutput")
    }

    tasks.named("assembleRelease") {
        finalizedBy("copyReleaseApkToFlutterOutput")
    }
}

