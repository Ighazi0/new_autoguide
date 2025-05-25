import 'package:autoguide/app/app_style.dart';
import 'package:autoguide/services/locale_services.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class CustomReadMore extends StatefulWidget {
  final String text;
  final TextStyle? style;

  const CustomReadMore({super.key, required this.text, this.style});

  @override
  State<CustomReadMore> createState() => _CustomReadMoreState();
}

class _CustomReadMoreState extends State<CustomReadMore> {
  bool _readMore = true;
  String _firstPart = '';
  bool _isOverflowing = false;

  @override
  Widget build(BuildContext context) {
    final defaultStyle = widget.style ?? DefaultTextStyle.of(context).style;

    return LayoutBuilder(
      builder: (context, constraints) {
        final span = TextSpan(text: widget.text, style: defaultStyle);

        final tp = TextPainter(
          text: span,
          maxLines: 3,
          textDirection: TextDirection.ltr,
        )..layout(maxWidth: constraints.maxWidth);

        _isOverflowing = tp.didExceedMaxLines;

        if (_isOverflowing && _readMore) {
          final words = widget.text.split(' ');
          String visibleText = '';
          for (int i = 0; i < words.length; i++) {
            final testText = '$visibleText${words[i]} ';
            final testTp = TextPainter(
              text: TextSpan(text: testText, style: defaultStyle),
              maxLines: 3,
              textDirection: TextDirection.ltr,
            )..layout(maxWidth: constraints.maxWidth);

            if (testTp.didExceedMaxLines) {
              break;
            } else {
              visibleText = testText;
            }
          }

          _firstPart = visibleText.trim();
        } else {
          _firstPart = widget.text;
        }

        return RichText(
          text: TextSpan(
            style: defaultStyle,
            children: [
              TextSpan(
                text: _readMore && _isOverflowing
                    ? '$_firstPart... '
                    : '${widget.text} ',
              ),
              if (_isOverflowing)
                TextSpan(
                  text: (_readMore ? 'more' : 'less').tr,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppStyle.primaryColor,
                    fontFamily: 'Almarai',
                    fontSize: 12,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () => setState(() => _readMore = !_readMore),
                ),
            ],
          ),
        );
      },
    );
  }
}
