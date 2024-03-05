import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class NotificationExample extends StatefulWidget {
  const NotificationExample({super.key});

  @override
  State<NotificationExample> createState() => _NotificationExampleState();
}

class _NotificationExampleState extends State<NotificationExample> {
  late IO.Socket socket;

  bool isMessageReceived = false;
  Map message = {};

  @override
  void initState() {
    initSocket();
    super.initState();
  }

  @override
  void dispose() {
    socket.disconnect();
    socket.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Test Me'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    initSocket();
                  },
                  child: Text('data'),
                ),
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    socket.disconnect();
                    socket.dispose();
                  },
                  child: Text('disconnect'),
                ),
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    createUser('kevnlan', '#Polerity99', 'dev@kevlangat.com');
                  },
                  child: Text('create user'),
                ),
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    sendMessage('polomana', 'kevnlan',
                        'this is a test send message I see if it works');
                  },
                  child: Text('send message'),
                ),
              ),
              if (message == {} || message.isEmpty)
                SizedBox()
              else
                ListTile(
                  title: Text('Message : ${message['message']}'),
                  subtitle:  Text('Sender : ${message['senderID']}'),
                )
            ],
          ),
        ),
      ),
    );
  }

  initSocket() {
    print('object 212');
    socket = IO.io('http://192.168.100.122:3000', <String, dynamic>{
      'autoConnect': false,
      'transports': ['websocket'],
      'extraHeaders': {
        'authorization':
            'Api_key eyJhbGciOiJSUzUxMiIsInR5cCI6IkFwaSBUb2tlbiJ9.eyJwYXlsb2FkIjoiN2RjNTdkMWYyMjg4Y2Y0YzU3ZmItNjY4OWI5ZDQxOTYyYzE2OTkxMjktYTg4MjcyYTU4MmJkNGJkNDQyMDc1NGRmYzJhN2I2OWQtMzc5YTNlNjM4ZTRjYjMwOTZlZDVjOTc4YjI3ZDJhOTkwYzdkMzU4YzNiODdjZTk0MzM5YiIsImlhdCI6MTcwNTQxNDE2NSwiZXhwIjoxNzA4MDA2MTY1LCJpc3MiOiJOYXRoYW4gJiBOYXRoYW4gRGlnaXRhbCJ9.MU8pnHb7TQ09HP9ljASCac2N91eOIaDbO1Af42MnbHrkWYtSyzRdPD2br8eFn9iDHUoBw2zmNQlC78P7IUjgofdHacWaJo7MvSwZfPbenRKhhPdWzj-7kPrC-ffRagvSTXSWXkYDQcOg5sz-AFxO8mCN0llpzabd6rdmY4nwyYni9wFW_XO8BfhLY3dOfE3lkrGc0dn0EX0-zkMElETKoMjyxZmAdQT3sSG4reJYotsi_BxDiDtq9R_WapLSRpwWOspMUxUSf6E7aPcnKRAny6TGZPPKLfiDHne0fdFCqkZbVUijrytyyKMVxAgYlzU5pMOn3bpB-TfWfhiJKo_hhuYBT1Y8qT5IBk-daQmzR1YXilJMHD2DombYeqU6AdvoSH3gTrqQxY6OkZM65BjZPNn6KjDc6jiC-QTmCuN3SLxXETQlecUuebznmu2FPyLHcTyAW4y1yMrQy3voyv5fHbh5FGHk3-xbXntvF_3pMUDJVaNs4VLnuhbEwWKif_tzViurDZX_B6MLa9gySvFPHrY_h14o8Wua_5A4p1dnpx1X5rpeBsS8ERARXdoLLV76YURLXfXLgSHh8Ne8xkxrIJI2hFQWVmUgxC_tlCwFp6Ryo0Au3k1oHtKDhVPRb7aoi7it4NYxaJ5U_qNK-Voya8Y-HBa0qc-K-ExlHUzAhuM',
        'identity': '1234'
      },
    });
    print('object 212');
    socket.connect();
    socket.onConnect((_) {
      print('Connection established');
      authenticateUser('kevnlan', '#Polerity99');
    });

    socket.onDisconnect((_) => print('Connection Disconnection'));
    socket.on('notifications', (data) {
      print('object 212');
      print(data.toString());
    });

    socket.on('personal', (data) {
      print('object b jdc d jcd');
      print(data.toString());
    });

    socket.on('chat message', (data) {
      print('object b jdc d jcd');
      print(data.toString());
      setState(() {
        isMessageReceived = true;
        message = data;
      });
    });
    // socket.onConnectError((err) {
    //   print('error $err');
    // });
    // socket.onError((err) {
    //   print('err $err');
    // });

    // socket.on('getMessageEvent', (newMessage) {
    //   print('object');
    //   print(newMessage);
    // });
  }

  void Notify(String message) async {
    String timezom = await AwesomeNotifications().getLocalTimeZoneIdentifier();
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
          id: 1,
          channelKey: 'key1',
          title: 'This is Notification title',
          body: message,
          bigPicture:
              'https://protocoderspoint.com/wp-content/uploads/2021/05/Monitize-flutter-app-with-google-admob-min-741x486.png',
          notificationLayout: NotificationLayout.BigPicture),
      schedule:
          NotificationInterval(interval: 1, timeZone: timezom, repeats: false),
    );
  }

  void createUser(String username, String password, String email) {
    // Send the user data to the server with the 'create user' event
    socket.emit('create user', {
      'username': username,
      'password': password,
      'email': email,
    });
  }

  void sendMessage(String senderID, String receiverID, String message) {
    // Send the message to the server with the 'chat message' event
    socket.emit('chat message', {
      'senderID': senderID,
      'receiverID': receiverID,
      'message': message,
    });
  }

  void authenticateUser(String username, String password) {
    // Send the user ID to the server for authentication
    print('v bjsnjsnjsn');
    socket.emit('authenticate', {
      'username': username,
      'password': password,
    });
  }
}
