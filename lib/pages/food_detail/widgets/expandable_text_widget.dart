import 'package:flutter/material.dart';
import 'package:food_delivery/common/values/colors.dart';
import 'package:food_delivery/common/values/dimensions.dart';
import 'package:food_delivery/common/widgets/base_text_widget.dart';

class ExpandableTextWidget extends StatefulWidget {
  final String text;
  final double lineHeight;

  const ExpandableTextWidget({
    super.key,
    required this.text,
    this.lineHeight=1.2,
  });

  @override
  State<ExpandableTextWidget> createState() => _ExpandableTextWidgetState();
}

class _ExpandableTextWidgetState extends State<ExpandableTextWidget> {
  late String firstHalf;
  late String secondHalf;

  bool hiddenText = false;
  double screenHeight = 0.0;

  @override
  void initState() {
    super.initState();
    screenHeight = Dimensions.screenHeight;
    double textHeight = screenHeight / 5.63;

    print("screenHeight:  ${screenHeight}");
    print("textHeight:  ${textHeight}");

    if (widget.text.length > textHeight) {
      firstHalf = widget.text.substring(0, textHeight.toInt());
      secondHalf =
          widget.text.substring(textHeight.toInt() + 1, widget.text.length);
    } else {
      firstHalf = widget.text;
      secondHalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      
      child: secondHalf.isEmpty
          ? smallText(firstHalf)
          : Column(
              children: [
                smallText(
                    height: widget.lineHeight,
                    hiddenText ? (firstHalf + "...") : (firstHalf + secondHalf),
                    overflow: TextOverflow.visible),
                InkWell(
                    onTap: () {
                      setState(() {
                        hiddenText = !hiddenText;
                      });
                    },
                    child: hiddenText ? show_more() : show_less()
                    ),
                    
              ],
            ),
    );
  }
}

Widget show_more() {
  return Row(children: [
    smallText("Show more", color: AppColors.primaryElement),
    Icon(Icons.arrow_drop_down, color: AppColors.primaryElement),
  ]);
}

Widget show_less() {
  return Row(children: [
    smallText("Show less", color: AppColors.primaryElement),
    Icon(Icons.arrow_drop_up, color: AppColors.primaryElement),
  ]);
}
