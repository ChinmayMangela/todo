import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:todo/features/task/domain/models/task.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationApi {
  static final _notifications = FlutterLocalNotificationsPlugin();

  // Request notification permission for user
  static Future<void> requestNotificationPermission() async {
    // check for notification status
    final status = await Permission.notification.status;

    if (status.isGranted) {
      // Permission is already granted
      print("Notification permission is already granted.");
      return;
    }

    if (status.isDenied) {
      // Request permission
      final result = await Permission.notification.request();
      if (result.isGranted) {
        print("Notification permission granted.");
      } else if (result.isDenied) {
        print("Notification permission denied. Please enable it in settings.");
      } else if (result.isPermanentlyDenied) {
        // Open app settings if permission is permanently denied
        print(
            "Notification permission permanently denied. Opening app settings.");
        openAppSettings();
      }
    } else if (status.isPermanentlyDenied) {
      // Open app settings if permission is permanently denied
      print(
          "Notification permission permanently denied. Opening app settings.");
      openAppSettings();
    }
  }

  // Initialization method for notifications
  static Future<void> initialize() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('ic_notification');

    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    await _notifications.initialize(initializationSettings);
  }

  static NotificationDetails _notificationDetails() {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        'task channel',
        'Task notifications',
        channelDescription: 'Channel for task due notification',
        importance: Importance.max,
        icon: 'ic_notification',
        showWhen: true,
      ),
    );
  }


  static Future<void> scheduleNotification({
    required Task task,
  }) async {
    var scheduleTime = tz.TZDateTime.from(
      DateTime(
        task.dueDate.year,
        task.dueDate.month,
        task.dueDate.day,
        task.dueTime.hour,
        task.dueTime.minute,
      ),
      tz.local,
    );

    print('Scheduling notification for: $scheduleTime');
    await _notifications.zonedSchedule(
      task.id.hashCode,
      'Task Reminder',
      task.name,
      scheduleTime,
      _notificationDetails(),
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
    print('Notification display');
  }
}
