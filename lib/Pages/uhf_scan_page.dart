import 'package:fltr_pdascan/models/user_type.dart';
import 'package:fltr_pdascan/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class UHFScanPage extends StatefulWidget {
  UHFScanPage({Key key}) : super(key: key);

  @override
  _UHFScanPageState createState() => _UHFScanPageState();
}

class _UHFScanPageState extends State<UHFScanPage> {
  List<String> _codes = List<String>();
  String _scanStatus = 'Unknown Status !';
  int _type;

  static const platform = const MethodChannel('demo.uhf/scan');
  ScrollController _scrollController;
  UserType user;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    setState(() {
      _type = int.parse(Get.arguments.toString());
    });
    var userJsonString =
        Constants.prefs.getString(Constants.PDASCR_LOGGED_USER);
    user = UserType.fromString(userJsonString);
    _setUps();
  }

  Future<void> _setUps() async {
    String scanStatus;
    try {
      final String result = await platform.invokeMethod('INIT');
      scanStatus = 'BRFID SCANNER started at $result % .';
    } on PlatformException catch (e) {
      scanStatus = "Failed to start RFID SCANNER: '${e.code}'.";
    }

    setState(() {
      _scanStatus = scanStatus;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Divider(
          color: Colors.transparent,
        ),
        Text('Scanner: $_scanStatus'),
        Divider(
          color: Colors.transparent,
        ),
        SizedBox(
          height: 250,
          child: Scrollbar(
            isAlwaysShown: true,
            controller: _scrollController,
            child: ListView.builder(
                itemCount: _codes.length,
                controller: _scrollController,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(_codes[index]),
                    trailing: IconButton(
                      icon: Icon(Icons.remove_circle, color: Colors.red[400]),
                      onPressed: () async {
                        setState(() {
                          _codes.removeWhere((code) => code == _codes[index]);
                        });
                        await Constants.prefs
                            .setStringList(Constants.PDASCR_CODES, _codes);
                      },
                    ),
                  );
                }),
          ),
        ),
      ]),
    );
  }
}
