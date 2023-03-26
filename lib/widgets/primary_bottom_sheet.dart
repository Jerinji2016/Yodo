import 'package:flutter/material.dart';
import 'package:yodo/widgets/primary_text_button.dart';

class PrimaryBottomSheet extends StatelessWidget {
  static Future<bool> show({
    required BuildContext context,
    required String title,
    required String description,
    PrimaryBottomSheetButton? yesButton,
    PrimaryBottomSheetButton noButton = const PrimaryBottomSheetButton(
      "Close",
      TextStyle(),
    ),
  }) async =>
      await showModalBottomSheet<bool>(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12.0),
            topRight: Radius.circular(12.0),
          ),
        ),
        builder: (context) => PrimaryBottomSheet._(
          title: title,
          description: description,
          yesButton: yesButton,
          noButton: noButton,
        ),
      ) ??
      false;

  final String title, description;
  final PrimaryBottomSheetButton noButton;
  final PrimaryBottomSheetButton? yesButton;

  const PrimaryBottomSheet._({
    Key? key,
    required this.title,
    required this.description,
    this.yesButton,
    required this.noButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12.0),
          topRight: Radius.circular(12.0),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24.0, 36.0, 24.0, 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12.0),
            Text(
              description,
              style: const TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 16.0),
            Row(
              children: [
                Expanded(
                  child: PrimaryTextButton(
                    text: noButton.text,
                    textStyle: noButton.style,
                    onTap: () => Navigator.pop(context, false),
                  ),
                ),
                if (yesButton != null) ...[
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: PrimaryTextButton(
                      text: yesButton!.text,
                      textStyle: yesButton!.style,
                      onTap: () => Navigator.pop(context, true),
                    ),
                  ),
                ],
              ],
            )
          ],
        ),
      ),
    );
  }
}

class PrimaryBottomSheetButton {
  final String text;
  final TextStyle style;

  const PrimaryBottomSheetButton(this.text, this.style);
}
