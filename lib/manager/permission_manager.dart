import 'package:permission_handler/permission_handler.dart';

class PermissionManager {
  bool hasPermissionGiven = false;
  static final PermissionManager _instance = PermissionManager._();

  PermissionManager._();

  factory PermissionManager() => _instance;

  static Future<bool> canAccessLocation() async {
    if (!_instance.hasPermissionGiven) {
      final status = await Permission.location.request();
      _instance.hasPermissionGiven = status.isGranted;
    }
    return _instance.hasPermissionGiven;
  }
}
