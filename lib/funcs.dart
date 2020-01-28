import 'dart:io';
//import 'dart:convert';
import 'package:convert/convert.dart';
import 'dart:async';
import 'dart:typed_data';

void sendCommand(String server, String command) async {
  List<String> serverArr = server.split(':');
  if (serverArr.length!=2) {
    return;
  }
  Socket socket = await Socket.connect(serverArr[0], int.parse(serverArr[1]));
  print('connected');

  if (command=='up'){
   socket.add(hex.decode('FF010008002730'));
  }

  if (command=='down'){
    socket.add(hex.decode('FF010010002738'));
  }

  if (command=='left'){
    socket.add(hex.decode('FF0100043F0044'));
  }

  if (command=='right'){
    socket.add(hex.decode('FF010002200023'));
  }


  // wait
  await Future.delayed(Duration(milliseconds: 300));

  //  stop
  socket.add(hex.decode('FF010000000001'));

  // wait
  await Future.delayed(Duration(milliseconds: 500));

  // .. and close the socket
  socket.close();


  // listen to the received data event stream
//  socket.listen((List<int> event) {
//    print(utf8.decode(event));
//  });

}

void onClickUp(String server){
  sendCommand(server, 'up');
}

void onClickDown(String server){
  sendCommand(server, 'down');
}

void onClickLeft(String server){
  sendCommand(server, 'left');
}

void onClickRight(String server){
  sendCommand(server, 'right');
}
