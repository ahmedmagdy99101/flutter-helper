# Socket Service

A service to manage WebSocket (Socket.io) connections in your Flutter app. This service wraps the `socket_io_client` package and provides:

- Initialization with customizable options
- Automatic reconnection handling
- `connect` and `disconnect` methods
- `emit` and `on` methods to send and listen for events
- A simple boolean getter to check connection status
- A `dispose` method to fully clean up the socket

---

## 1. Prerequisites

1. Add `socket_io_client` to your `pubspec.yaml`:
   ```yaml
   dependencies:
     flutter:
       sdk: flutter
     socket_io_client: ^3.1.2
   ```
2. Ensure your backend Socket.IO server is up and running (e.g., a Node.js + Socket.IO server).
3. Verify your server’s base URL (e.g., `https://your-domain.com/` or `http://localhost:3000/`).

---

## 2. Overview of `SocketService`

- **Singleton Pattern**  
  The factory constructor `SocketService()` always returns the same instance. This ensures that there is only one active socket connection throughout the app.

- **Initialization Once**
    - Call `initializeSocket(...)` exactly once before any `connect()`, `emit()`, or `on()` calls.
    - Passing a `customUrl` overrides the default `EndPoints.baseUrl`.

- **Automatic Reconnection**
    - By default, `reconnection: true` and up to 10 `reconnectionAttempts`.
    - Configure reconnection delay and maximum delay via `additionalOptions`.

- **Event Handling**
    - Three public callback properties:
        - `onConnect`: Called whenever a connection (or reconnection) is successful.
        - `onDisconnect`: Called whenever the socket is disconnected.
        - `onError`: Called on any socket error or failed reconnection.

- **Clean Shutdown**
    - Call `dispose()` when your widget (or the entire app) is disposed to close streams and free resources.

---

## 3. Usage Examples

Below are a few examples showing how to integrate `SocketService` into your Flutter widgets and service layers.

### 3.1. Basic Initialization & Connection

```dart
// main.dart (or in a top-level service initializer)
import 'package:flutter/material.dart';
import 'services/socket/socket_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize the socket once before runApp()
  SocketService().initializeSocket(
    customUrl: 'https://your-server.com/', // or use EndPoints.baseUrl
  );

  runApp(MyApp());
}
```

### 3.2. Listening for Connection Events (in a StatefulWidget)

```dart
import 'package:flutter/material.dart';
import 'services/socket/socket_service.dart';

class ChatScreen extends StatefulWidget {
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final SocketService _socketService = SocketService();
  List<String> _messages = [];

  @override
  void initState() {
    super.initState();

    // Set up connection / disconnection callbacks
    _socketService.onConnect = () {
      print('Socket connected!');
    };

    _socketService.onDisconnect = () {
      print('Socket disconnected');
    };

    _socketService.onError = (error) {
      print('Socket error: $error');
    };

    // Listen for a custom event "chat_message"
    _socketService.on('chat_message', (data) {
      setState(() {
        _messages.add(data.toString());
      });
    });

    // Finally, ensure the socket connects
    _socketService.connect();
  }

  @override
  void dispose() {
    // Clean up: remove the event listener and dispose the socket if needed
    _socketService.off('chat_message');
    // Optionally call dispose() on the service if
    // you are certain no other widget will use it:
    // _socketService.dispose();

    super.dispose();
  }

  void _sendMessage(String text) {
    
      _socketService.emit('chat_message', text);
   
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat (${_connected ? "Online" : "Offline"})'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: _messages.map((msg) => ListTile(title: Text(msg))).toList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    onSubmitted: (value) {
                      _sendMessage(value);
                    },
                    decoration: InputDecoration(
                      hintText: 'Enter message...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () => _sendMessage('Hello from Flutter!'),
                  child: Text('Send'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
```

### 3.3. Emitting Custom Events

You can emit any event you define on your Socket.IO server. For example, a “typing” status:

```dart
// Typing indicator example
void sendTypingStatus(bool isTyping) {
  // The server should listen for "typing" and broadcast it to other clients
  SocketService().emit('typing', { 'typing': isTyping });
}
```

### 3.4. Passing Authentication Token or Headers

If your server requires a JWT token or custom headers, you can include it in `additionalOptions` during initialization:

```dart
SocketService().initializeSocket(
  customUrl: 'https://secure-server.com/',
  additionalOptions: {
    'transports': ['websocket'],
    'extraHeaders': { 'Authorization': 'Bearer your_jwt_token_here' },
  },
);
```

---

## 4. Best Practices & Tips

1. **Initialize Once**  
   Call `initializeSocket(...)` at app startup (e.g., in `main()` or `HomeScreen()`or `CallScreen()` or `ChatScreen()` or `TripScreen()` ), not inside every screen.

2. **Use Callbacks Judiciously**
    - Set `onConnect`/`onDisconnect` for global UI updates (e.g., show connectivity icon).
    - Use `on(event, callback)` in individual screens or services that need specific events.

3. **Clean Up Listeners**  
   Always call `off(event)` when the widget or service is disposed to avoid memory leaks.

4. **Handle Reconnection Logic**  
   The default logic will attempt to reconnect automatically. If you need to detect “max reconnection failures,” observe the `onError` callback for a “Reconnection failed” message.

5. **Secure Your Socket**
    - If you use authentication, send a valid token via `extraHeaders` or a `auth` query parameter (depending on your server setup).
    - Always use HTTPS/WSS in production.

6. **Debug Prints**  
   Debug statements are sprinkled throughout the class for clarity. In production, consider removing or toggling them off to reduce log noise.

---

## 5. Removing the Service

If, at any point, you want to fully tear down the socket and all listeners (for example, on user logout), simply call:

```dart
SocketService().dispose();
```

This will:
- Disconnect from the server
- Remove all internal listeners
- Reset `_isInitialized` and `_isConnected` flags

---

## 6. Summary

- **SocketService** is a ready-made singleton to handle Socket.IO connections in Flutter.
- Configure it once, then call `connect()`, `emit(...)`, and `on(...)` wherever you need to send or receive events.
- Always remove listeners (via `off(...)`) when the listener is no longer needed.
- Properly dispose of the socket if your app’s lifecycle requires it (e.g., logout or app termination).

With this setup, you have a clean, maintainable way to integrate real-time, bidirectional communication into any Flutter project using Socket.IO.

Happy coding!
