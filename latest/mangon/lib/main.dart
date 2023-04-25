import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(const BlockInternetApp());
  // runApp(MaterialApp(
  //   debugShowCheckedModeBanner: false,
  //   home: BlockInternetApp(),
  // ));
}

class BlockInternetApp extends StatefulWidget {
  const BlockInternetApp({Key? key}) : super(key: key);

  @override
  _BlockInternetAppState createState() => _BlockInternetAppState();
}

class _BlockInternetAppState extends State<BlockInternetApp> {
  bool _isBlocked = false;

  @override
  void initState() {
    super.initState();
    _checkInternetConnection();
  }

  void _checkInternetConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Không có kết nối Internet!')));
    }
  }

  void _blockInternet() async {
    var status = await Permission.manageExternalStorage.status;
    if (status.isGranted) {
      setState(() {
        _isBlocked = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Đã chặn quyền truy cập Internet!')));
    } else if (status.isDenied) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Bạn cần cấp quyền truy cập Internet!'),
        action: SnackBarAction(
          label: 'Cấp quyền',
          onPressed: () async {
            if (await Permission.manageExternalStorage.request().isGranted) {
              setState(() {
                _isBlocked = true;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Đã cấp quyền truy cập Internet!')));
            }
          },
        ),
      ));
    }
  }

  void _unblockInternet() async {
    var status = await Permission.manageExternalStorage.status;
    if (status.isGranted) {
      setState(() {
        _isBlocked = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Đã gỡ chặn quyền truy cập Internet!')));
    } else if (status.isDenied) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Bạn cần cấp quyền truy cập Internet!'),
        action: SnackBarAction(
          label: 'Cấp quyền',
          onPressed: () async {
            if (await Permission.manageExternalStorage.request().isGranted) {
              setState(() {
                _isBlocked = false;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Đã cấp quyền truy cập Internet!')));
            }
          },
        ),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Block Internet App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: _isBlocked ? null : () => _blockInternet(),
              child: Text('Chặn quyền truy cập Internet'),
              style: ElevatedButton.styleFrom(
                primary: Colors.red,
                textStyle: TextStyle(fontSize: 20),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isBlocked ? () => _unblockInternet() : null,
              child: Text('Gỡ chặn quyền truy cập Internet'),
              style: ElevatedButton.styleFrom(
                primary: Colors.green,
                textStyle: TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
