import 'package:flutter/material.dart';
import 'package:group_tablelist/group_tablelist.dart';
import 'showcase.dart';

void main() {
  runApp(const MyApp());
}

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

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Group Tableview'),
          ),
          body: CustomScrollView(
            slivers: [
              SliverPadding(
                  padding: EdgeInsets.symmetric(
                    vertical: 0,
                    horizontal: 0,
                  ),
                  sliver: GroupSliverList(
                    numberOfSections: showcaseList.length,
                    numberOfRowsInSection: (section) =>
                        showcaseList[section].item.length,
                    cellForRowAtIndexPath: (indexPath) => _flutterShowcaseCell(
                        showcaseList[indexPath.section].item[indexPath.row]),
                    headerInSection: (section) => _headerInSection(section),
                    overallHeader: () => Text('overallHeader'),
                    overallFooter: () => Text('overallFooter'),
                    footerInSection: (section) => _footerInSection(section),
                  )),
            ],
          )),
    );
  }

  Widget? _headerInSection(int section) {
    if (section == 0) {
      return Container(
        height: 30,
        color: Colors.green.withOpacity(0.3),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'header ${section + 1}',
              style: TextStyle(
                fontSize: 18,
                color: Colors.black,
              ),
            ),
          ],
        ),
      );
    } else {
      return null;
    }
  }

  Widget? _footerInSection(int section) {
    if (section == 0) {
      return Text('seaction one footer');
    } else {
      return null;
    }
  }

  Widget _flutterShowcaseCell(ShowcaseItemEntity item) {
    return Container(
      height: 44,
      padding: EdgeInsets.only(left: 20, right: 20),
      child: Column(
        children: [
          SizedBox(
            height: 43,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  item.name,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
                Spacer(),
              ],
            ),
          ),
          Spacer(),
          Divider(height: 1),
        ],
      ),
    );
  }
}
