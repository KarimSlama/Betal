import 'package:Betal/layouts/mainLayout.dart';
import 'package:Betal/shared/components/components.dart';
import 'package:Betal/shared/components/constants.dart';
import 'package:Betal/shared/cubit/cubit/main_cubit.dart';
import 'package:Betal/shared/cubit/states/main_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, MainState>(
      listener: (context, state) {},
      builder: (context, state) {
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
            padding:
                const EdgeInsets.symmetric(vertical: 18.0, horizontal: 14.0),
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
                Theme(
                  data: ThemeData().copyWith(dividerColor: Colors.transparent),
                  child: ExpansionTile(
                    onExpansionChanged: (value) {
                      // MainCubit.getContext(context)
                      //     .changeExpansionTileIcon(value);
                    },
                    title: const Text(
                      'Location',
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                    collapsedTextColor: Colors.green.shade800,
                    trailing: MainCubit.getContext(context).isOpen
                        ? const Icon(Icons.arrow_forward_ios_outlined)
                        : Icon(Icons.keyboard_arrow_down_rounded,
                            color: Colors.green.shade800),
                    children: [
                      customSwitch(
                        context,
                        'Location Permission',
                        MainCubit.getContext(context).isSwitch,
                        (value) {
                          MainCubit.getContext(context).changeSwitchIcon(value);
                        },
                      ),
                    ],
                  ),
                ),
                divider(),
                Theme(
                  data: ThemeData().copyWith(dividerColor: Colors.transparent),
                  child: ExpansionTile(
                    onExpansionChanged: (value) {
                      // MainCubit.getContext(context)
                      //     .changeExpansionTileIcon(value);
                    },
                    title: const Text(
                      'Call To Prayer With',
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                    collapsedTextColor: Colors.green.shade800,
                    trailing: MainCubit.getContext(context).isOpen
                        ? const Icon(Icons.arrow_forward_ios_outlined)
                        : Icon(Icons.keyboard_arrow_down_rounded,
                            color: Colors.green.shade800),
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              Expanded(
                                child: ListView.separated(
                                  itemBuilder: (context, index) =>
                                      buildPrayerCall(),
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(
                                    height: 5.0,
                                  ),
                                  itemCount: 5,
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          CircleAvatar(
                            radius: 20.0,
                            backgroundColor: Colors.green.shade800,
                            child: IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.add),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget customSwitch(
          context, String text, bool isSwitch, Function onChangeMethod) =>
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 7.0,
            ),
            if (MainCubit.getContext(context).isSwitch == false)
              InkWell(
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  width: double.infinity,
                  child: const Text(
                    'choose city',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            const SizedBox(
              height: 7.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  text,
                ),
                const Spacer(),
                Transform.scale(
                  scale: 0.7,
                  child: CupertinoSwitch(
                    activeColor: Colors.green.shade800,
                    trackColor: Colors.grey,
                    value: isSwitch,
                    onChanged: (value) {
                      onChangeMethod(value);
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      );

  Widget buildPrayerCall() => const Text('Ahmed Al Nafis');
}
