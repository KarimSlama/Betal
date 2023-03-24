import 'package:Betal/modules/cities_screen/cities_screen.dart';
import 'package:Betal/shared/components/components.dart';
import 'package:Betal/shared/components/constants.dart';
import 'package:Betal/shared/cubit/cubit/main_cubit.dart';
import 'package:Betal/shared/cubit/cubit/mode_cubit.dart';
import 'package:Betal/shared/cubit/states/main_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class CountriesScreen extends StatelessWidget {
  const CountriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, MainState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Countries'.tr,
            ),
            leading: IconButton(
              icon: selectedCurrentLanguage == 'Arabic'
                  ? const Icon(Icons.arrow_forward_ios_rounded)
                  : const Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 18.0),
            child: ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) =>
                  buildCountriesList(context, index),
              separatorBuilder: (context, index) => divider(),
              itemCount: MainCubit.getContext(context).countries.length,
            ),
          ),
        );
      },
    );
  }

  Widget buildCountriesList(context, index) => InkWell(
        onTap: () {
          navigateTo(context, const CityScreen());
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 16.0),
          child: Text(
            '${MainCubit.getContext(context).countries[index].name!.common}',
            style: TextStyle(
                color: ModeCubit.getContext(context).isDark == true
                    ? Colors.black
                    : Colors.white,
                fontSize: 17.0),
          ),
        ),
      );
}
