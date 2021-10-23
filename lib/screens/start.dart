import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/cabinet_drawer_model.dart';
import 'package:flutter_app/models/cabinet_model.dart';
import 'package:flutter_app/models/item_model.dart';
import 'package:flutter_app/models/room_model.dart';
import 'package:flutter_app/screens/custom/carousal_card.dart';
import 'package:flutter_app/screens/custom/custom_app_bar.dart';
import 'package:flutter_app/screens/custom/dashboard_data_card.dart';
import 'package:flutter_app/screens/navigation/left_navigation.dart';
import 'package:flutter_app/screens/search/item_searchdelegate.dart';
import 'package:provider/provider.dart';

class Start extends StatefulWidget {
  @override
  _StartState createState() => _StartState();
}

class _StartState extends State<Start> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    var _rooms = Provider.of<List<RoomModel>>(context);
    var _cabinets = Provider.of<List<CabinetModel>>(context);
    var _drawers = Provider.of<List<CabinetDrawerModel>>(context);
    var _items = Provider.of<List<ItemModel>>(context);

    var _recentItems = _items.length > 5 ? _items.sublist(0, 5) : _items;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        drawer: LeftNavigation(),
        appBar: CustomAppBar(
          title: "Home",
          searchDelegate: ItemSearchDelegate(_items),
        ),
        body: Stack(
          fit: StackFit.expand,
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 10.0,
                      right: 10.0,
                      top: 10.0,
                      bottom: 10.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Recent Items",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          "See all",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 10.0,
                      right: 10.0,
                      top: 10.0,
                      bottom: 10.0,
                    ),
                    child: CarouselSlider(
                      items: _recentItems.map((itemModel) {
                        return Builder(builder: (BuildContext context) {
                          return CarousalCard(
                            item: itemModel,
                          );
                        });
                      }).toList(),
                      options: CarouselOptions(
                        height: MediaQuery.of(context).size.height * 0.30,
                        autoPlay: true,
                        autoPlayInterval: Duration(seconds: 3),
                        autoPlayAnimationDuration: Duration(milliseconds: 800),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        pauseAutoPlayOnTouch: true,
                        aspectRatio: 5.0,
                        onPageChanged: (index, reason) {
                          setState(() {
                            _currentIndex = index;
                          });
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 5.0,
                      right: 5.0,
                      top: 5.0,
                      bottom: 5.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        DashboardDataCard(
                          title: "Room",
                          data: _rooms.length.toString(),
                        ),
                        DashboardDataCard(
                          title: "Cabinet",
                          data: _cabinets.length.toString(),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 2.0,
                      right: 2.0,
                      top: 10.0,
                      bottom: 10.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        DashboardDataCard(
                          title: "Drawer",
                          data: _drawers.length.toString(),
                        ),
                        DashboardDataCard(
                          title: "Item",
                          data: _items.length.toString(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
