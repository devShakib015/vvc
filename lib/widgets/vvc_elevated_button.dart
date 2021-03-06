import 'package:flutter/material.dart';
import 'package:vvc/constants/color_constants.dart';

class VvcElevatedButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;
  final EdgeInsetsGeometry padding;
  final double? width;
  final double? height;
  final double borderRadius;

  const VvcElevatedButton({
    Key? key,
    required this.child,
    required this.onPressed,
    this.padding = const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
    this.width,
    this.height,
    this.borderRadius = 10,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: ShapeDecoration(
        shadows: [],
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius)),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [VvcColors.primaryColor1, VvcColors.primaryColor2],
        ),
      ),
      child: MaterialButton(
        minWidth: width,
        height: height,
        padding: padding,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius)),
        splashColor: VvcColors.accentColor2,
        child: child,
        onPressed: onPressed,
      ),
    );
  }

  static Widget text({
    required String label,
    required VoidCallback onPressed,
  }) {
    return VvcElevatedButton(
      child: Text(
        label,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      onPressed: onPressed,
      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
    );
  }

  static Widget iconWithText({
    required String label,
    required Icon icon,
    required VoidCallback onPressed,
  }) {
    return VvcElevatedButton(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 5,
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            width: 2,
          ),
          icon,
        ],
      ),
      onPressed: onPressed,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    );
  }

  static Widget icon({
    required Icon icon,
    required VoidCallback onPressed,
    required String tooltip,
  }) {
    return Tooltip(
      decoration: BoxDecoration(
        color: VvcColors.primaryColor1.withOpacity(0.4),
        borderRadius: BorderRadius.circular(10),
      ),
      textStyle: TextStyle(color: Colors.white),
      message: tooltip,
      child: VvcElevatedButton(
        borderRadius: 50,
        padding: EdgeInsets.zero,
        width: 55,
        height: 55,
        child: icon,
        onPressed: onPressed,
      ),
    );
  }
}
