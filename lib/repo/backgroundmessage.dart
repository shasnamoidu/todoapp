import 'package:firebase_messaging/firebase_messaging.dart';

class BackgroundRepo{
  Future <void> BackgroundMessageHandler(RemoteMessage message) async{
   print('handling a background message${message.messageId}');

  }
}