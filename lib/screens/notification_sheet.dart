import 'package:flutter/material.dart';

class NotificationBottomSheet extends StatelessWidget {
  const NotificationBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(99),
                color: const Color(0xff838BAA),
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            "Your Notifications",
            style: TextStyle(
              fontSize: 24,
              color: Color(0xff444E72),
              fontWeight: FontWeight.w900,
            ),
            textAlign: TextAlign.start,
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ExpansionTile(
                    leading:
                        const Icon(Icons.notifications, color: Colors.blue),
                    title: Text(
                      notifications[index]["title"]!,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(notifications[index]["time"]!),
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(notifications[index]["detail"]!),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

final List<Map<String, String>> notifications = [
  {
    "title": "A sunny day in your location",
    "time": "10 minutes ago",
    "detail": "Consider wearing your UV protection",
  },
  {
    "title": "A cloudy day will occur all day long",
    "time": "1 day ago",
    "detail": "Don't worry about the heat of the sun",
  },
  {
    "title": "Potential for rain today is 84%",
    "time": "2 days ago",
    "detail": "Don't forget to bring your umbrella",
  },
  {
    "title": "A sunny day in your location",
    "time": "10 minutes ago",
    "detail": "Consider wearing your UV protection",
  },
  {
    "title": "A cloudy day will occur all day long",
    "time": "1 day ago",
    "detail": "Don't worry about the heat of the sun",
  },
  {
    "title": "Potential for rain today is 84%",
    "time": "2 days ago",
    "detail": "Don't forget to bring your umbrella",
  },
];
