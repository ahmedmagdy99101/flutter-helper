import 'dart:io';
import 'dart:ui';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

/// A data model to hold information about the app update.
class UpdateData {
  /// The name of the application.
  final String name;

  /// The current version of the application.
  final String currentVersion;

  /// The latest available version of the application.
  final String latestVersion;

  /// The URL to the app store (Google Play or App Store).
  final String storeUrl;

  /// Indicates whether an update is available.
  final bool hasUpdate;

  /// Indicates whether the update is mandatory.
  final bool isForceUpdate;

  UpdateData({
    required this.name,
    required this.currentVersion,
    required this.latestVersion,
    required this.storeUrl,
    required this.hasUpdate,
    required this.isForceUpdate,
  });
}

/// Manages app updates by checking for new versions and displaying update dialogs.
class AppUpdateManager {
  /// Singleton instance of [AppUpdateManager].
  static final AppUpdateManager _instance = AppUpdateManager._internal();

  /// Factory constructor to return the singleton instance.
  factory AppUpdateManager() => _instance;

  /// Private constructor for singleton pattern.
  AppUpdateManager._internal();

  /// Base URL for fetching update data from the server.
  static const String _baseUrl = 'http://209.250.237.58:5670/versions/';

  /// HTTP client for making requests to the server.
  late final Dio _dio;

  /// The bundle ID of the application.
  late final String _bundleId;

  /// Navigator key to access the app's navigation context.
  late final GlobalKey<NavigatorState> _navigatorKey;

  /// Indicates whether the manager is initialized.
  bool _isInitialized = false;

  /// Indicates whether an update check is in progress.
  bool _isChecking = false;

  /// Indicates whether an update dialog is currently visible.
  bool _dialogVisible = false;

  /// Overlay entry for displaying dialogs.
  OverlayEntry? _overlayEntry;

  /// Initializes the [AppUpdateManager] with the given bundle ID and navigator key.
  ///
  /// [bundleId] is the unique identifier of the app.
  /// [navigatorKey] is used to access the app's navigation context.
  static Future<void> initialize(
      String bundleId, GlobalKey<NavigatorState> navigatorKey) async {
    await AppUpdateManager()._init(bundleId, navigatorKey);
  }

  /// Internal initialization logic for setting up the manager.
  Future<void> _init(
      String bundleId, GlobalKey<NavigatorState> navigatorKey) async {
    if (_isInitialized) return;
    _bundleId = bundleId;
    _navigatorKey = navigatorKey;
    _dio = Dio(BaseOptions(
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
    ))
      ..interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        compact: true,
        maxWidth: 80,
      ));
    _isInitialized = true;
    WidgetsBinding.instance.addObserver(_LifecycleObserver());
    WidgetsBinding.instance.addPostFrameCallback((_) => _checkSilently());
  }

  /// Checks for updates and shows a dialog to inform the user of the result.
  Future<void> checkWithDialog() async {
    final data = await _fetchUpdateData();
    if (data == null) {
      _showDialog(_errorDialog('فشل في التحقق من التحديثات'));
      return;
    }
    if (data.hasUpdate) {
      _showDialog(_updateDialog(data));
    } else {
      _showDialog(_noUpdateDialog());
    }
  }

  /// Checks for updates silently and shows a dialog only if an update is available.
  Future<void> _checkSilently() async {
    final data = await _fetchUpdateData();
    if (data?.hasUpdate == true) {
      _showDialog(_updateDialog(data!));
    }
  }

  /// Fetches update data from the server.
  ///
  /// Returns an [UpdateData] object if successful, or `null` if the fetch fails.
  Future<UpdateData?> _fetchUpdateData() async {
    if (_isChecking || !_isInitialized) return null;
    try {
      _isChecking = true;
      final packageInfo = await PackageInfo.fromPlatform();
      final currentVersion = packageInfo.version;
      final response = await _dio.get('$_baseUrl$_bundleId');
      if (response.statusCode != 200) return null;
      final json = response.data as Map<String, dynamic>;
      final appName = json['name']?.toString() ?? 'التطبيق';
      final latestVersion = Platform.isAndroid
          ? json['androidVersion']?.toString() ??
          json['version']?.toString() ??
          '0.0'
          : json['iosVersion']?.toString() ??
          json['version']?.toString() ??
          '0.0';
      final storeUrl = Platform.isAndroid
          ? json['googlePlayUrl']?.toString() ?? ''
          : json['appStoreUrl']?.toString() ?? '';
      final isForceUpdate = json['isForceUpdate'] == true;
      if (storeUrl.isEmpty) return null;
      final hasUpdate = _needsUpdate(currentVersion, latestVersion);
      return UpdateData(
        name: appName,
        currentVersion: currentVersion,
        latestVersion: latestVersion,
        storeUrl: storeUrl,
        hasUpdate: hasUpdate,
        isForceUpdate: isForceUpdate,
      );
    } catch (e) {
      debugPrint('Update check failed: $e');
      return null;
    } finally {
      _isChecking = false;
    }
  }

  /// Compares the current and latest versions to determine if an update is needed.
  ///
  /// [current] is the current app version.
  /// [latest] is the latest available version.
  /// Returns `true` if an update is needed, `false` otherwise.
  bool _needsUpdate(String current, String latest) {
    try {
      final currentParts = current.split('.').map(int.parse).toList();
      final latestParts = latest.split('.').map(int.parse).toList();
      final maxLength = [currentParts.length, latestParts.length]
          .reduce((a, b) => a > b ? a : b);
      while (currentParts.length < maxLength) {
        currentParts.add(0);
      }
      while (latestParts.length < maxLength) {
        latestParts.add(0);
      }
      for (int i = 0; i < maxLength; i++) {
        if (latestParts[i] > currentParts[i]) return true;
        if (latestParts[i] < currentParts[i]) return false;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  /// Displays a dialog as an overlay with a blur effect.
  ///
  /// [dialog] is the widget to be displayed.
  void _showDialog(Widget dialog) {
    final context = _navigatorKey.currentContext;
    if (context == null || _dialogVisible) return;
    _dialogVisible = true;
    _overlayEntry = OverlayEntry(
      builder: (_) => Stack(
        children: [
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
            child: Container(color: Colors.black.withOpacity(0.3)),
          ),
          Center(child: dialog),
        ],
      ),
    );
    final overlay = _navigatorKey.currentState?.overlay;
    if (overlay != null && _overlayEntry != null) {
      overlay.insert(_overlayEntry!);
    }
  }

  /// Dismisses the currently displayed dialog.
  void _dismissDialog() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    _dialogVisible = false;
  }

  /// Builds a dialog to prompt the user to update the app.
  ///
  /// [data] contains the update information.
  Widget _updateDialog(UpdateData data) {
    return PopScope(
      canPop: !data.isForceUpdate,
      child: Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.symmetric(horizontal: 24),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                color: Colors.white.withOpacity(0.85),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: (Colors.red).withOpacity(0.1),
                    child: Icon(
                      data.isForceUpdate
                          ? Icons.warning_rounded
                          : Icons.system_update_alt_rounded,
                      size: 40,
                      color: Colors.red,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    data.isForceUpdate ? 'تحديث إجباري' : 'تحديث متاح',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    data.isForceUpdate
                        ? 'لا يمكنك متابعة استخدام ${data.name} بدون التحديث.'
                        : 'يوجد إصدار جديد من ${data.name}.',
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 15, color: Colors.black87),
                  ),
                  const SizedBox(height: 20),
                  _versionRow(
                      'الإصدار الحالي', data.currentVersion, Colors.orange),
                  const SizedBox(height: 8),
                  _versionRow(
                      'الإصدار الجديد', data.latestVersion, Colors.green),
                  const SizedBox(height: 30),
                  Column(
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          await _openStore(data.storeUrl);
                          if (!data.isForceUpdate) _dismissDialog();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          minimumSize: const Size.fromHeight(48),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16)),
                        ),
                        child: const Text('تحديث الآن',
                            style: TextStyle(fontSize: 16)),
                      ),
                      if (!data.isForceUpdate)
                        TextButton(
                          onPressed: _dismissDialog,
                          child: const Text('لاحقًا',
                              style: TextStyle(color: Colors.grey)),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Builds a dialog to inform the user that no updates are available.
  Widget _noUpdateDialog() {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.85),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.check_circle_outline,
                    size: 50, color: Colors.green),
                const SizedBox(height: 12),
                const Text('أنت تستخدم أحدث إصدار',
                    style:
                    TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                const Text('لا يوجد تحديث متاح حالياً.',
                    textAlign: TextAlign.center),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _dismissDialog,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    minimumSize: const Size.fromHeight(45),
                  ),
                  child: const Text('موافق'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Builds a dialog to display an error message.
  ///
  /// [message] is the error message to display.
  Widget _errorDialog(String message) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.85),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.error_outline, size: 50, color: Colors.red),
                const SizedBox(height: 12),
                const Text('حدث خطأ',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.red)),
                const SizedBox(height: 10),
                Text(message, textAlign: TextAlign.center),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _dismissDialog,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    minimumSize: const Size.fromHeight(45),
                  ),
                  child: const Text('حسناً'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Builds a row to display version information.
  ///
  /// [label] is the version label (e.g., 'Current Version').
  /// [version] is the version number.
  /// [color] is the color for the version text and background.
  Widget _versionRow(String label, String version, Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontSize: 14)),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            version,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }

  /// Opens the app store URL in an external application.
  ///
  /// [url] is the store URL to open.
  Future<void> _openStore(String url) async {
    try {
      final uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      }
    } catch (e) {
      debugPrint('Store launch failed: $e');
    }
  }

  /// Called when the app is resumed to check for updates silently.
  void _onAppResumed() {
    if (_isInitialized && !_dialogVisible) {
      _checkSilently();
    }
  }
}

/// Observes the app lifecycle to trigger update checks when the app is resumed.
class _LifecycleObserver extends WidgetsBindingObserver {
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      AppUpdateManager()._onAppResumed();
    }
  }
}