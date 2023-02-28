import 'package:Betal/layouts/mainLayout.dart';
import 'package:Betal/shared/components/components.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Setting',
          style: TextStyle(fontWeight: FontWeight.w400),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            navigateTo(context, const MainLayout());
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: const [
                Icon(Icons.settings),
                SizedBox(
                  width: 10.0,
                ),
                Text(
                  'Setting',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 14.0,
            ),
            Row(
              children: [
                const Text('Location',
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400)),
                const Spacer(),
              ],
            )
          ],
        ),
      ),
    );
  }
}
