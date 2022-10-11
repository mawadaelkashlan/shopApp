import 'package:flutter/material.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/styles/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../shared/network/local/cache_helper.dart';

class BoardingModel {
  late final String image;
  late final String title;
  late final String body;

  BoardingModel({
    required this.image,
    required this.title,
    required this.body,
  });
}

class OnBoradingScreen extends StatefulWidget {
  @override
  State<OnBoradingScreen> createState() => _OnBoradingScreenState();
}

class _OnBoradingScreenState extends State<OnBoradingScreen> {
  List<BoardingModel> boarding = [
    BoardingModel(
      image: 'assets/images/onBoarding_1.jpeg',
      title: 'On Board 1 Title',
      body: 'On Board 1 body',
    ),
    BoardingModel(
      image: 'assets/images/onBoarding_2.jpeg',
      title: 'On Board 2 Title',
      body: 'On Board 2 body',
    ),
    BoardingModel(
      image: 'assets/images/onBoarding_1.jpeg',
      title: 'On Board 3 Title',
      body: 'On Board 3 body',
    ),
  ];

  bool isLast = false;

  var boardController = PageController();
  void submit (){
    CacheHelper.saveData(key: 'onBoarding', value: true).then((value) {
      navigateAndFinish(context, ShopLoginScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          defaultTextButton(
            text: 'skip',
            function: () {
              submit();
            },
          ),
          SizedBox(
            width: 15,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                onPageChanged: (int index) {
                  if (index == boarding.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
                physics: BouncingScrollPhysics(),
                controller: boardController,
                itemBuilder: (context, index) => buildPageView(boarding[index]),
                itemCount: boarding.length,
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: boardController,
                  count: boarding.length,
                  effect: ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    dotHeight: 10,
                    dotWidth: 10,
                    expansionFactor: 4,
                    spacing: 5,
                    activeDotColor: defaultColor,
                  ),
                ),
                Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (isLast == true) {
                      submit();
                    } else {
                      boardController.nextPage(
                          duration: Duration(milliseconds: 500),
                          curve: Curves.fastLinearToSlowEaseIn);
                    }
                  },
                  child: Icon(Icons.arrow_forward_ios_outlined),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

Widget buildPageView(BoardingModel model) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Image(
            image: AssetImage('${model.image}'),
          ),
        ),
        SizedBox(
          height: 30,
        ),
        Text(
          '${model.title}',
          style: TextStyle(fontSize: 24.0),
        ),
        SizedBox(
          height: 30,
        ),
        Text(
          '${model.body}',
          style: TextStyle(fontSize: 15.0),
        ),
        SizedBox(
          height: 30,
        ),
      ],
    );
