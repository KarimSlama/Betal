import 'package:Betal/shared/components/constants.dart';
import 'package:Betal/styles/icon_broken.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NearestMasjedScreen extends StatelessWidget {
  const NearestMasjedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 40.0,
        ),
        buildNearestCard(),
      ],
    );
  }

  Widget buildNearestCard() => Container(
        width: double.infinity,
        child: Card(
          shadowColor: Colors.grey.shade700,
          child: Padding(
            padding: const EdgeInsetsDirectional.symmetric(
                horizontal: 14.0, vertical: 14.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: const [
                    Icon(IconBroken.Location,
                        color: Colors.deepOrange, size: 30.0),
                    SizedBox(
                      width: 16.0,
                    ),
                    Text(
                      'Nearest Masjed',
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 14.0,
                ),
                Row(
                  children: const [
                    Icon(Icons.watch_later_outlined,
                        color: Colors.deepOrange, size: 25.0),
                    SizedBox(
                      width: 16.0,
                    ),
                    Text(
                      '1.500 k',
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
}
