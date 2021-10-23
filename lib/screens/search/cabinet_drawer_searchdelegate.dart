import 'package:flutter/material.dart';
import 'package:flutter_app/models/cabinet_drawer_model.dart';
import 'package:flutter_app/models/cabinet_model.dart';
import 'package:flutter_app/screens/cabinet/cabinet_details_data.dart';
import 'package:flutter_app/screens/custom/custom_data_list_tile.dart';
import 'package:flutter_app/screens/drawer/cabinet_drawer_details_data.dart';

class CabinetDrawerSearchDelegate extends SearchDelegate {
  final List<CabinetDrawerModel> drawers;

  CabinetDrawerSearchDelegate(this.drawers);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: AnimatedIcon(icon: AnimatedIcons.menu_close, progress: transitionAnimation),
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: AnimatedIcon(icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return getSearchResult();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return getSearchResult();
  }

  StatelessWidget getSearchResult() {
    if (drawers.isEmpty) {
      return Container(
        child: Text("No Cabinet available"),
      );
    }

    List<CabinetDrawerModel> filteredCabinetDrawers = drawers
        .where((drawer) =>
            drawer.drawerName.toLowerCase().contains(query.toLowerCase()) ||
            drawer.drawerDescription
                .toLowerCase()
                .contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      shrinkWrap: true,
      itemCount: filteredCabinetDrawers.length,
      itemBuilder: (BuildContext context, int index) {
        CabinetDrawerModel currentDrawer = filteredCabinetDrawers[index];

        return Container(
          child: InkWell(
            splashColor: Color(0Xff334a7d),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CabinetDrawerDetailsData(
                    drawer: currentDrawer,
                  ),
                ),
              );
            },
            child: Hero(
              tag: currentDrawer.drawerImageName,
              child: CustomDataListTile(
                nameTitle: "Name",
                nameValue: currentDrawer.drawerName,
                noOfChildTitle: "No. of Items",
                noOfChildvalue: currentDrawer.items != null
                    ? currentDrawer.items.length.toString()
                    : "0",
                imageUrl: currentDrawer.drawerImageUrl,
              ),
            ),
          ),
        );
      },
    );
  }
}
