import 'package:Betal/layouts/mainLayout.dart';
import 'package:Betal/shared/components/components.dart';
import 'package:Betal/shared/data/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var pageController = PageController();

  List<BoardingModel> boarding = [
    BoardingModel(
      image: 'assets/images/prayer.png',
      title: 'Prayer',
      body: 'Ability to manage daily prayer\nalerts.',
    ),
    BoardingModel(
      image: 'assets/images/pray.png',
      title: 'Call To Prayer With',
      body:
          'Choose a call to prayer sounds and calendar type between Hijri and Georgian.',
    ),
    BoardingModel(
      image: 'assets/images/compas_on.png',
      title: 'In advance or delay\nprayer alert (minutes)',
      body:
          'Managing default setting for the prayers and the ability to add duration or delay it.',
    ),
    BoardingModel(
      image: 'assets/images/dark_theme.png',
      title: 'Dark Mode & Home\nWidget',
      body:
          'Ability to activate the dark mode and add Widget to your phone\'s Home screen.',
    ),
  ];

  void submit() {
    CacheHelper.saveData(key: 'onBoarding', value: true).then((value) {
      if (value!) navigateAndFinish(context, const MainLayout());
    });
  }

  bool isLast = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfffafafa),
      appBar: AppBar(
        backgroundColor: const Color(0xfffafafa),
        elevation: 0.0,
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 570.0,
            child: PageView.builder(
              controller: pageController,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) =>
                  buildBoardingItems(boarding[index]),
              itemCount: boarding.length,
              onPageChanged: (value) {
                if (value == boarding.length - 1) {
                  setState(() {
                    isLast = true;
                  });
                } else {
                  isLast = false;
                }
              },
            ),
          ),
          const SizedBox(
            height: 15.0,
          ),
          SmoothPageIndicator(
            controller: pageController,
            count: boarding.length,
            effect: ExpandingDotsEffect(
              dotWidth: 12.0,
              dotHeight: 12.0,
              spacing: 5.0,
              expansionFactor: 3.0,
              dotColor: Colors.grey,
              activeDotColor: Colors.green.shade800,
            ),
          ),
          const SizedBox(
            height: 36.0,
          ),
          Container(
            width: 140.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadiusDirectional.circular(10.0),
              color: Colors.green.shade800,
            ),
            child: MaterialButton(
              onPressed: () {
                submit();
              },
              height: 47.0,
              child: const Text(
                'Get Started',
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  } //end build()

  Widget buildBoardingItems(BoardingModel model) => Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          children: [
            Image(
              image: AssetImage(model.image),
              fit: BoxFit.cover,
              height: 275.0,
            ),
            const SizedBox(
              height: 90.0,
            ),
            Text(
              textAlign: TextAlign.center,
              model.title,
              style: const TextStyle(
                height: 1.2,
                fontSize: 26.0,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            const SizedBox(
              height: 25.0,
            ),
            Text(
              textAlign: TextAlign.center,
              model.body,
              style: const TextStyle(
                height: 1.5,
                fontSize: 20.0,
                color: Colors.black,
              ),
            ),
          ],
        ),
      );
} //end class

class BoardingModel {
  final String image;
  final String title;
  final String body;

  BoardingModel({
    required this.image,
    required this.title,
    required this.body,
  });
}
