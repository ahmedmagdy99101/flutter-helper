import 'package:flutter/cupertino.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import 'end_points.dart';

/// A singleton service to manage WebSocket connections using socket_io_client.
/// Provides methods to connect, emit events, listen to events, and handle reconnection logic.
class SocketService {
  static final SocketService _instance = SocketService._internal();
  late IO.Socket _socket;
  bool _isInitialized = false;
  bool _isConnected = false;

  /// Callback for connection status changes
  VoidCallback? onConnect;
  VoidCallback? onDisconnect;
  Function(dynamic)? onError;

  /// Factory constructor to return the singleton instance
  factory SocketService() {
    return _instance;
  }

  SocketService._internal();

  /// Initializes the socket connection with the specified configuration
  Future<void> initializeSocket({
    String? customUrl,
    Map<String, dynamic>? additionalOptions,
  }) async {
    if (_isInitialized) {
      debugPrint('Socket is already initialized');
      return;
    }

    try {
      // Default socket options
      final socketOptions = <String, dynamic>{
        'transports': ['websocket'],
        'autoConnect': false, // We'll connect manually
        'reconnection': true, // Enable reconnection
        'reconnectionAttempts': 10, // Number of reconnection attempts
        'reconnectionDelay': 1000, // Initial delay before reconnection
        'reconnectionDelayMax': 5000, // Maximum delay between reconnections
        ...?additionalOptions, // Allow custom options to override defaults
      };

      // Initialize socket with the provided or default base URL
      _socket = IO.io(customUrl ?? EndPoints.baseUrl, socketOptions);
      _isInitialized = true;

      // Set up connection event handlers
      _setupSocketListeners();

      // Connect to the server
      await connect();
    } catch (e) {
      debugPrint('Failed to initialize socket: $e');
      _isInitialized = false;
      onError?.call(e);
    }
  }

  /// Sets up socket event listeners
  void _setupSocketListeners() {
    _socket.onConnect((_) {
      _isConnected = true;
      debugPrint('Connected to the server');
      onConnect?.call();
    });

    _socket.onDisconnect((_) {
      _isConnected = false;
      debugPrint('Disconnected from the server');
      onDisconnect?.call();
    });

    _socket.onError((data) {
      debugPrint('Socket error: $data');
      onError?.call(data);
    });

    _socket.onReconnect((_) {
      debugPrint('Reconnected to the server');
      _isConnected = true;
      onConnect?.call();
    });

    _socket.onReconnectAttempt((attempt) {
      debugPrint('Reconnection attempt #$attempt');
    });

    _socket.onReconnectFailed((_) {
      debugPrint('Reconnection failed after max attempts');
      _isConnected = false;
      onError?.call('Reconnection failed');
    });
  }

  /// Connects to the socket server
  Future<void> connect() async {
    if (!_isInitialized) {
      debugPrint('Socket not initialized. Call initializeSocket first.');
      return;
    }
    if (!_isConnected) {
      _socket.connect();
    }
  }

  /// Disconnects from the socket server
  void disconnect() {
    if (_isInitialized && _isConnected) {
      _socket.disconnect();
      _isConnected = false;
    }
  }

  /// Sends an event with data to the server
  void emit(String event, dynamic data) {
    if (_isInitialized && _isConnected) {
      _socket.emit(event, data);
      debugPrint('Emitted event: $event with data: $data');
    } else {
      debugPrint('Cannot emit event: Socket is not connected or initialized');
    }
  }

  /// Listens for a specific event from the server
  void on(String event, Function(dynamic) callback) {
    if (_isInitialized) {
      _socket.on(event, (data) {
        debugPrint('Received event: $event with data: $data');
        callback(data);
      });
    } else {
      debugPrint('Cannot listen to event: Socket is not initialized');
    }
  }

  /// Removes a listener for a specific event
  void off(String event, [Function(dynamic)? callback]) {
    if (_isInitialized) {
      _socket.off(event, callback);
      debugPrint('Removed listener for event: $event');
    }
  }

  /// Checks if the socket is currently connected
  bool get isConnected => _isConnected;

  /// Disposes the socket connection and cleans up resources
  void dispose() {
    if (_isInitialized) {
      _socket.disconnect();
      _socket.dispose();
      _isInitialized = false;
      _isConnected = false;
      debugPrint('Socket disposed');
    }
  }
}