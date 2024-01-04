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

  @override
  void initState() {
    // initSocket();
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
            ],
          ),
        ),
      ),
    );
  }

  initSocket() {
    socket = IO.io('http://192.168.100.14:7001', <String, dynamic>{
      'autoConnect': false,
      'transports': ['websocket'],
      'extraHeaders': {
        'authorization':
            'Api_key eyJhbGciOiJSUzUxMiIsInR5cCI6IkFwaSBUb2tlbiJ9.eyJwYXlsb2FkIjoiMjE5MGM4YTA5MmFmOTI4Y2RlNDEtMDdlMmFiM2JlZjQ2ODZlYjg5NTMtODcwNjcyZmE1N2E3Y2U2MTM3MzI3NWRlYzgzMDZmYmYtZTJlMzI1YWEwNmE3OWNiOGU4OTBhODliYTlhZDNhYWI3YTY3YThiODExMmE5MjlkMmQ4MCIsImlhdCI6MTcwNDE5NjgyNCwiZXhwIjoxNzA2Nzg4ODI0LCJpc3MiOiJOYXRoYW4gJiBOYXRoYW4gRGlnaXRhbCJ9.xqE5pYavzfobUpHDujiae1HjMJiJ68sLEtamtARBYpw-81TeSFycnGSPeS9_KeqAZjWPiD-bZzEUWRdXQ0L0ogJ_LsLX8RSHBDerPW0R3u0PER_O3hEaCa2g3hbriHjxPPhmB00B0LfJh8LB51vhFctl40qr5eBeuxNjf04Pn5mFq15qPPiTA76gJ2p-gqvOvMxqe5CxB4chz3T3TvFjXJnNO7K1y3lqHvnZTE0WHDH9N6dO9mJ4U1DKvoy9A3dl2eAtSO67_CpT3yZRnHVHXRwTFVrc1Q5tz9tVWHjnXcb66URA88CQV_vOU63DTa8jyLie0JZCvT0xoohBs7nCVHpdzXvGor7rmI2CNR9ZuHxDBRS6BZlm2ipdHe15r9gJ8e5H3Y_QYsflVi-Nsjic3_cvBDG7CiTcyAEjf7bXJdAGbxNaXwbSj_LUCOU9ITS32WSgnrNWDkrpKYhmu2kjwC8DYLHyRU6nN2mhP8YpYOVbosYddGLcOQmTovpePkdz_Bx4kBtCPZUyRhSHVsaEoztsQRp_jFV3Kqz6zCGf0Y7hJzhAyvo25qhqhInlWlIcS3bGcsmpxARdtmVsuK1DmB7cdzQXNgfHF7IvYYVLSvkAkGljsLAK18bmALw1n8_uoiZJo-YGT_GizvAAxk17IFsLY-I3ACd7ueYXnfNSA0g',
        'identity': '1234'
      },
    });
    socket.connect();
    socket.onConnect((_) {
      print('Connection established');
    });

    socket.onDisconnect((_) => print('Connection Disconnection'));
    socket.on('notifications', (data) {
      print('object 212');
      print(data.toString());
    });

    socket.on('personal', (data) {
      print('object b jdc d jcd');
      print(data.toString());
      Notify(data.toString());
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
          NotificationInterval(interval: 61, timeZone: timezom, repeats: true),
    );

  }
}
