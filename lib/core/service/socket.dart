import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:kzm/viewmodels/base_model.dart';
import 'package:socket_io_client/socket_io_client.dart' as socket_client;

class KZMSocket extends BaseModel {
  final String socketUrl;
  socket_client.Socket _socket;

  KZMSocket({
    @required this.socketUrl,
  }) {
    _socket = socket_client.io(socketUrl);
  }

  void activateSocket({@required String userId}) {
    // log('-->> $fName, activateSocket ->> userId: $userId');
    _socket.onConnect((_) {
      log('-->> $fName, main ->> onConnect');
      _socket.emit(
        jsonEncode(<String, String>{
          'action': 'create',
          'userId': userId,
        }),
      );
    });

    _socket.on('event', (dynamic data) {
      log('-->> $fName, main ->> $data');
    });

    _socket.onDisconnect((_) {
      log('-->> $fName, main ->> onDisconnect');
      _socket.emit(
        jsonEncode(<String, String>{
          'action': 'delete',
          'userId': userId,
        }),
      );
    });
  }
}
