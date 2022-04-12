import 'package:flutter/material.dart';
import 'package:group_tablelist/scr/index_path.dart';
import 'package:group_tablelist/group_tablelist.dart';
import 'showcase.dart';

List<ShowcaseEntity> showcaseList = <ShowcaseEntity>[
  ShowcaseEntity(title: 'UI', item: <ShowcaseItemEntity>[
    ShowcaseItemEntity(
        name: "Some common controls",
        contentType: ShowcaseContentType.flutterUI),
    ShowcaseItemEntity(
        name: "Animation", contentType: ShowcaseContentType.flutterAnimation),
  ]),
  ShowcaseEntity(title: 'Multi-Threading', item: <ShowcaseItemEntity>[
    ShowcaseItemEntity(
        name: "Multi-Threading",
        contentType: ShowcaseContentType.flutterMultithreading),
  ]),
];

class GroupTablelistExample extends StatefulWidget {
  const GroupTablelistExample({Key? key}) : super(key: key);

  @override
  State<GroupTablelistExample> createState() => _GroupTablelistExampleState();
}

class _GroupTablelistExampleState extends State<GroupTablelistExample> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Group Tablelist Example'),
        ),
        body: GroupTableList(
          itemExtent: 50,
          numberOfSections: showcaseList.length,
          numberOfRowsInSection: (section) => showcaseList[section].item.length,
          cellForRowAtIndexPath: (indexPath) => _flutterShowcaseCell(
              showcaseList[indexPath.section].item[indexPath.row]),
          headerInSection: (section) => _makeHeaderOrFooterInSection(
              'seaction ${section + 1} header',
              (section == 0)
                  ? Colors.green.withOpacity(0.3)
                  : Colors.blue.withOpacity(0.3)),
          overallHeader: () => _makeOverAll('overallHeader'),
          overallFooter: () => _makeOverAll('overallFooter'),
          footerInSection: (section) => _makeHeaderOrFooterInSection(
              'seaction ${section + 1} footer',
              (section == 0)
                  ? Colors.green.withOpacity(0.3)
                  : Colors.blue.withOpacity(0.3)),
          didSelectAtIndexPath: (indexPath) =>
              _handleDidSelectAtIndexPath(indexPath),
        ));
  }

  void _handleDidSelectAtIndexPath(IndexPath indexPath) {
    debugPrint('${indexPath.row} - ${indexPath.section} clicked');
  }

  Widget _makeOverAll(String str) {
    return Container(
      height: 60,
      color: Colors.pink.withOpacity(0.3),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            str,
            style: const TextStyle(
              fontSize: 18,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget? _makeHeaderOrFooterInSection(String title, Color bgColor) {
    return Container(
      height: 30,
      color: bgColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _flutterShowcaseCell(ShowcaseItemEntity item) {
    return Container(
      color: Colors.purple.withOpacity(0.1),
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Column(
        children: [
          SizedBox(
            height: 49,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  item.name,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
          const Divider(height: 1),
        ],
      ),
    );
  }
}
