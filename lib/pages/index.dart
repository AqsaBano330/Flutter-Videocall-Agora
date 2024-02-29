import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:developer';

import 'package:permission_handler/permission_handler.dart';
import 'package:videocallagora/pages/call.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({super.key});

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {

  //final _channelController = TextEditingController();

  bool _validateError = false;

  ClientRole? _role =  ClientRole.Broadcaster;

  @override
  // // void dispose() {
  // //   ChannelName.dispose();
  // //   super.dispose();
  // } 

  String ChannelName = "fluttermap";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Agora Video Call")
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              const SizedBox(height: 40),
              Image.asset("asset/video_call.jpg"),
              const SizedBox(height: 20),
              // TextField(
              //   controller: _channelController,
              //   decoration: InputDecoration(
              //     errorText: _validateError ? "channel name is mandatory" : null,
              //     border: const UnderlineInputBorder(
              //       borderSide: BorderSide(
              //         width: 1
              //       ),

              //     ),
              //     hintText: "Channel name"

              //   ),
              // ),
              RadioListTile(
                title: const Text("Broadcaster"),
                value: ClientRole.Broadcaster,
                 groupValue: _role, 
                 onChanged: (ClientRole? value){
                  setState(() {
                    _role = value;
                  });
                }),

                RadioListTile(
                title: const Text("Audience"),
                value: ClientRole.Audience, 
                groupValue: _role, 
                onChanged: (ClientRole? value){
                  setState(() {
                    _role = value;
                  });
                }),

                ElevatedButton(onPressed: onJoin 
                , child: const Text("Join"),
                style: ElevatedButton.styleFrom(
                  maximumSize: const Size(double.infinity, 40)
                ))

            ],
          )))
    );
  }

  Future<void> onJoin() async {
    // setState(() {
    //   _channelController.text.isEmpty
    //   ? _validateError = true
    //   : _validateError = false;
    // });
    // if(_channelController.text.isNotEmpty){
      await _handleCameraAndMic(Permission.camera);
      await _handleCameraAndMic(Permission.microphone);
      await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CallPage(
          channelName: ChannelName,
          role: _role,
        ))
      );
    }
 // }

  Future<void> _handleCameraAndMic (Permission permission) async {
    final status = await permission.request();
    log(status.toString());
  }
}