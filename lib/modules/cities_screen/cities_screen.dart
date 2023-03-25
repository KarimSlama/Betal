import 'package:Betal/layouts/mainLayout.dart';
import 'package:Betal/shared/components/components.dart';
import 'package:Betal/shared/components/constants.dart';
import 'package:Betal/shared/cubit/cubit/main_cubit.dart';
import 'package:Betal/shared/cubit/cubit/mode_cubit.dart';
import 'package:Betal/shared/cubit/states/main_state.dart';
import 'package:Betal/shared/data/local_storage/cache_helper.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

class CityScreen extends StatefulWidget {
  const CityScreen({Key? key}) : super(key: key);

  @override
  State<CityScreen> createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, MainState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Cities'.tr,
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
          body: ConditionalBuilder(
            condition: MainCubit.getContext(context).cities.isNotEmpty,
            builder: (context) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 18.0),
              child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) =>
                    buildCitiesList(context, index),
                separatorBuilder: (context, index) => divider(),
                itemCount: MainCubit.getContext(context).cities.length,
              ),
            ),
            fallback: (context) => const Center(
              child: (SpinKitFadingCube(
                color: green,
                size: 40,
              )),
            ),
          ),
        );
      },
    );
  }

  Widget buildCitiesList(context, index) => InkWell(
        onTap: () {
          setState(() {
            CacheHelper.saveData(
                    key: 'selectedCity',
                    value: MainCubit.getContext(context).cities[index].capital)
                .then((value) {
              setState(() {
                dynamicCity = CacheHelper.getData(key: 'selectedCity');
                navigateTo(context, MainLayout());
              });
            });
          });
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 16.0),
          child: Text(
            '${MainCubit.getContext(context).cities[index].capital}',
            style: TextStyle(
                color: ModeCubit.getContext(context).isDark == true
                    ? Colors.black
                    : Colors.white,
                fontSize: 17.0),
          ),
        ),
      );
}
