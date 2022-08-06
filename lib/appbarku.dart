import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AppBarKU extends StatelessWidget {
  const AppBarKU({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      expandedHeight: 200,
      elevation: 0,
      backgroundColor: Colors.white,
      flexibleSpace: FlexibleSpaceBar(
          background: Image.asset(
        "assets/images/Header-image.png",
        fit: BoxFit.cover,
      )),
      leading: Padding(
        padding: const EdgeInsets.only(left: 16),
        child: CircleAvatar(
          backgroundColor: Colors.white,
          child: SvgPicture.asset("assets/icons/back.svg"),
        ),
      ),
      actions: [
        CircleAvatar(
          backgroundColor: Colors.white,
          child: SvgPicture.asset(
            "assets/icons/share.svg",
            color: Colors.black,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: CircleAvatar(
            backgroundColor: Colors.white,
            child: SvgPicture.asset(
              "assets/icons/search.svg",
              color: Colors.black,
            ),
          ),
        )
      ],
    );
  }
}
