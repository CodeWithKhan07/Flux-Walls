import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class TextAnimationWidget extends StatelessWidget {
 final String label;
 final VoidCallback onfinished;
final TextStyle labelstyle;
  const TextAnimationWidget({super.key,required this.label,required this.onfinished,required this.labelstyle});

  @override
  Widget build(BuildContext context) {
    return AnimatedTextKit(
      onFinished: onfinished,
        totalRepeatCount: 1,
        animatedTexts: [
          TypewriterAnimatedText(
         label,
            textStyle:labelstyle,
            speed: const Duration(milliseconds: 200),
          ),
        ],
    );
  }
}
