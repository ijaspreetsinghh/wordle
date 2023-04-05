import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:wordle/wordle/wordle.dart';

const _qwerty = [
  ['Q', 'W', 'E', 'R', 'T', 'Y', 'U', 'I', 'O', 'P'],
  ['A', 'S', 'D', 'F', 'G', 'H', 'J', 'K', 'L'],
  ['ENTER', 'Z', 'X', 'C', 'V', 'B', 'N', 'M', 'DEL']
];

class Keyboard extends StatelessWidget {
  const Keyboard(
      {super.key,
      required this.onEnterTapped,
      required this.onDeleteTapped,
      required this.letters,
      required this.onKeyTapped});

  final VoidCallback onEnterTapped;
  final VoidCallback onDeleteTapped;
  final Set<Letter> letters;
  final void Function(String) onKeyTapped;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: _qwerty
          .map((keyRow) => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: keyRow.map((letter) {
                  if (letter == 'DEL') {
                    return _KeyboardButton.delete(onTap: onDeleteTapped);
                  } else if (letter == 'ENTER') {
                    return _KeyboardButton.enter(onTap: onEnterTapped);
                  }
                  final letterKey = letters.firstWhere(
                    (e) => e.val == letter,
                    orElse: () => Letter.empty(),
                  );
                  return _KeyboardButton(
                      onTap: () => onKeyTapped(letter),
                      letter: letter,
                      backgroundColor: letterKey != Letter.empty()
                          ? letterKey.backgroundColor
                          : Colors.grey);
                }).toList(),
              ))
          .toList(),
    );
  }
}

class _KeyboardButton extends StatelessWidget {
  const _KeyboardButton(
      {super.key,
      this.height = 48,
      this.width = 30,
      required this.onTap,
      required this.backgroundColor,
      required this.letter});

  final double height;
  final double width;
  final VoidCallback onTap;
  final Color backgroundColor;
  final String letter;

  factory _KeyboardButton.delete({required VoidCallback onTap}) =>
      _KeyboardButton(
        onTap: onTap,
        backgroundColor: Colors.grey,
        letter: 'DEL',
        width: 56,
      );

  factory _KeyboardButton.enter({required VoidCallback onTap}) =>
      _KeyboardButton(
        onTap: onTap,
        backgroundColor: Colors.grey,
        letter: 'ENTER',
        width: 56,
      );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 2, vertical: 3),
      child: Material(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(4),
        child: InkWell(
          onTap: onTap,
          child: Container(
            height: height,
            width: width,
            alignment: Alignment.center,
            child: Text(
              letter,
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ),
    );
  }
}
