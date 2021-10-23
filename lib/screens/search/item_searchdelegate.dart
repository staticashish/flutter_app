import 'package:flutter/material.dart';
import 'package:flutter_app/models/item_model.dart';
import 'package:flutter_app/screens/custom/custom_data_list_tile.dart';
import 'package:flutter_app/screens/item/item_details.dart';

class ItemSearchDelegate extends SearchDelegate {
  final List<ItemModel> items;

  ItemSearchDelegate(this.items);

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
    if (items.isEmpty) {
      return Container(
        child: Text("No Items available"),
      );
    }

    List<ItemModel> filteredItems = items
        .where((item) =>
            item.itemName.toLowerCase().contains(query.toLowerCase()) ||
            item.itemDescription.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      shrinkWrap: true,
      itemCount: filteredItems.length,
      itemBuilder: (BuildContext context, int index) {
        ItemModel currentItem = filteredItems[index];

        return Container(
          child: InkWell(
            splashColor: Color(0Xff334a7d),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ItemDetails(
                    item: currentItem,
                  ),
                ),
              );
            },
            child: Hero(
              tag: currentItem.itemImageUrl,
              child: CustomDataListTile(
                nameTitle: "Name",
                nameValue: currentItem.itemName,
                noOfChildTitle: "",
                noOfChildvalue: "",
                imageUrl: currentItem.itemImageUrl,
              ),
            ),
          ),
        );
      },
    );
  }
}
