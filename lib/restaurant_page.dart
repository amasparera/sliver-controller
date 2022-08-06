import 'package:flutter/material.dart';
import 'package:foodly/components/menu_card.dart';
import 'package:foodly/components/restaruant_categories.dart';
import 'package:foodly/components/restaurant_info.dart';
import 'package:foodly/models/menu.dart';

import 'appbarku.dart';

class RestaurantPage extends StatefulWidget {
  const RestaurantPage({Key? key}) : super(key: key);

  @override
  State<RestaurantPage> createState() => _RestaurantPageState();
}

class _RestaurantPageState extends State<RestaurantPage> {
  final ScrollController _controller = ScrollController();
  int selectIndexItems = 0;

  double restourantinfo = 200 + 150 - kToolbarHeight;

  @override
  void initState() {
    createBreaksPoint();
    _controller.addListener(() {
      onUpdateCategiries(_controller.offset);
    });
    super.initState();
  }

  void scrollToCategory(int index) {
    int totalIndex = 0;
    for (var i = 0; i < index; i++) {
      totalIndex += demoCategoryMenus[i].items.length;
    }

    if (index == 0) {
      _controller.animateTo(restourantinfo + (116 * totalIndex) + (50 * index),
          duration: const Duration(milliseconds: 200), curve: Curves.ease);
      setState(() {
        selectIndexItems = index;
      });
    } else if (selectIndexItems != index) {
      _controller.animateTo(restourantinfo + (116 * totalIndex) + (50 * index),
          duration: const Duration(milliseconds: 200), curve: Curves.ease);
      setState(() {
        selectIndexItems = index;
      });
    }
  }

  // scoll to select category
  List<double> breakPoinst = [];

  void createBreaksPoint() {
    double firtBreakPoint =
        restourantinfo + 50 + (116 * demoCategoryMenus[0].items.length);
    breakPoinst.add(firtBreakPoint);

    for (var i = 1; i < demoCategoryMenus.length; i++) {
      double breakPoint =
          breakPoinst.last + 50 + (116 * demoCategoryMenus[i].items.length);
      breakPoinst.add(breakPoint);
    }
    print(breakPoinst);
  }

  void onUpdateCategiries(double offset) {
    for (var i = 0; i < breakPoinst.length; i++) {
      if (i == 0) {
        if (i == 0 && offset < breakPoinst.first && selectIndexItems != 0) {
          setState(() {
            selectIndexItems = 0;
          });
        }
      } else if (breakPoinst[i - 1] <= offset &&
          offset < breakPoinst[i] &&
          selectIndexItems != i) {
        setState(() {
          selectIndexItems = i;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: _controller,
        slivers: [
          const AppBarKU(),
          const SliverToBoxAdapter(child: RestaurantInfo()),
          // SliverToBoxAdapter(
          //     child: Categories(onChanged: (value) {}, selectedIndex: 0)),
          SliverPersistentHeader(
              delegate: RestourantCategories(
                onChange: scrollToCategory,
                selectedIndex: selectIndexItems,
              ),
              pinned: true),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                    childCount: demoCategoryMenus.length, (context, index) {
              List<Menu> items = demoCategoryMenus[index].items;
              return MenuCategoryItem(
                  title: demoCategoryMenus[index].category,
                  items: List.generate(
                      items.length,
                      (intemIndex) => MenuCard(
                          image: items[index].image,
                          title: items[index].title,
                          price: items[index].price)));
            })),
          )
        ],
      ),
    );
  }
}
