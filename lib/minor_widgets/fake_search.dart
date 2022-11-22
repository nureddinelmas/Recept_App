import 'package:flutter/material.dart';
import 'package:recept_app/minor_widgets/search.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class FakeSearch extends StatelessWidget {
  const FakeSearch({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const SearchScreen(),
            ));
      },
      child: Container(
        height: 35,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.amber.shade300, width: 1.4),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Icon(
                    Icons.search,
                    color: Colors.grey,
                  ),
                ),
                Center(
                  child: SizedBox(
                    width: 200,
                    child: AnimatedTextKit(
                      animatedTexts: [
                        TypewriterAnimatedText(
                          'What are you looking for? ',
                          textStyle:
                              TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                      ],
                      repeatForever: true,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              alignment: Alignment.center,
              height: 35,
              width: 75,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.amber.shade300),
              child: AnimatedTextKit(
                animatedTexts: [
                  WavyAnimatedText(
                    'Search',
                    textStyle: TextStyle(
                        color: Colors.black.withOpacity(0.6), fontSize: 16),
                  ),
                ],
                isRepeatingAnimation: true,
                repeatForever: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
