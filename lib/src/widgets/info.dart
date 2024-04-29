
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';


class InfoApp extends StatefulWidget {
    const InfoApp({super.key});

  @override
  State<InfoApp> createState() => _InfoAppState();
}

class _InfoAppState extends State<InfoApp> {
   AndroidDeviceInfo? androidInfo;

  @override
  void initState() {
    super.initState();
    initDeviceInfo();
  }

  Future<void> initDeviceInfo() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    try {
      if (Theme.of(context).platform == TargetPlatform.android) {
        androidInfo = await deviceInfo.androidInfo;
        print('Android device info: $androidInfo');
      } 
    } catch (e) {
      print('Failed to get device info: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Device Info Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Device Info:'),
            if (Theme.of(context).platform == TargetPlatform.android &&
                androidInfo != null)
              Text('Model: ${androidInfo?.model}'),
            if (Theme.of(context).platform == TargetPlatform.android &&
                androidInfo != null)
              Text('Version: ${androidInfo?.version}'),
            if (Theme.of(context).platform == TargetPlatform.android &&
                androidInfo != null)
              Text('ID: ${androidInfo?.id}'),
            
          ],
        ),
      ),
    );
  }
}
