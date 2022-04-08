import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

enum IndexPathType {
  overallHeader,
  overallFooter,
  sectionHeader,
  sectionFooter,
  sectionSeparator,
  row,
  separator,
  placeholder,
}

class IndexPath {
  final int section;
  final int row;
  final IndexPathType type;
  IndexPath({required this.section, required this.row, required this.type});
}

typedef SectionSeparator = Widget Function(int section);

typedef SeparatorAtIndexPath = Widget Function(IndexPath indexPath);

typedef HeaderInSection = Widget? Function(int section);

typedef FooterInSection = Widget? Function(int section);

typedef CellForRowAtIndexPath = Widget Function(IndexPath indexPath);

typedef NumberOfRowsInSection = int Function(int section);

class GroupSliverList extends StatefulWidget {
  final int numberOfSections;

  final NumberOfRowsInSection? numberOfRowsInSection;

  final CellForRowAtIndexPath? cellForRowAtIndexPath;

  final SeparatorAtIndexPath? separatorAtIndexPath;

  final SectionSeparator? sectionSeparator;

  final HeaderInSection? headerInSection;

  final FooterInSection? footerInSection;

  final Widget Function()? overallHeader;

  final Widget Function()? overallFooter;

  final Widget Function()? placeholderView;

  // ignore: prefer_const_constructors_in_immutables
  GroupSliverList(
      {Key? key,
      this.numberOfSections = 1,
      required this.numberOfRowsInSection,
      required this.cellForRowAtIndexPath,
      this.separatorAtIndexPath,
      this.sectionSeparator,
      this.headerInSection,
      this.footerInSection,
      this.overallHeader,
      this.overallFooter,
      this.placeholderView})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _GroupSliverListState();
}

class _GroupSliverListState extends State<GroupSliverList> {
  late List<IndexPath> _allItemList;

  @override
  void initState() {
    _allItemList = [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _calIndexPath();

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (content, index) => GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {},
          child: _itemBuilder(index),
        ),
        childCount: _allItemList.length,
      ),
    );
  }

  void _calIndexPath() {
    _allItemList = [];
    IndexPath indexPath;

    // add overallHeader
    if (widget.overallHeader != null) {
      indexPath =
          IndexPath(section: 0, row: 0, type: IndexPathType.overallHeader);
      _allItemList.add(indexPath);
    }

    int sectionCount = widget.numberOfSections;
    int rows = 0;

    for (int i = 0; i < sectionCount; i++) {
      // add sectionHeader
      if (widget.headerInSection!(i) != null) {
        indexPath =
            IndexPath(section: i, row: 0, type: IndexPathType.sectionHeader);
        _allItemList.add(indexPath);
      }

      rows = widget.numberOfRowsInSection!(i);

      for (int j = 0; j < rows; j++) {
        // add row
        indexPath = IndexPath(section: i, row: j, type: IndexPathType.row);
        _allItemList.add(indexPath);

        //Add separator
        if (widget.separatorAtIndexPath != null) {
          indexPath =
              IndexPath(section: i, row: j, type: IndexPathType.separator);
          _allItemList.add(indexPath);
        }
      }

      // add sectionFooter
      if (widget.footerInSection!(i) != null) {
        indexPath =
            IndexPath(section: i, row: 0, type: IndexPathType.sectionFooter);
        _allItemList.add(indexPath);
      }

      // add section separator
      if (widget.sectionSeparator != null) {
        indexPath =
            IndexPath(section: i, row: 0, type: IndexPathType.sectionSeparator);
        _allItemList.add(indexPath);
      }
    }

    // add overallFooter
    if (widget.overallFooter != null) {
      indexPath =
          IndexPath(section: 0, row: 0, type: IndexPathType.overallFooter);
      _allItemList.add(indexPath);
    }
  }

  Widget? _itemBuilder(int index) {
    final IndexPath item = _allItemList[index];

    switch (item.type) {
      case IndexPathType.overallHeader:
        return widget.overallHeader!();
      case IndexPathType.overallFooter:
        return widget.overallFooter!();
      case IndexPathType.sectionHeader:
        return widget.headerInSection!(item.section);
      case IndexPathType.sectionFooter:
        return widget.footerInSection!(item.section);
      case IndexPathType.sectionSeparator:
        return widget.sectionSeparator!(item.section);
      case IndexPathType.row:
        return widget.cellForRowAtIndexPath!(item);
      case IndexPathType.separator:
        return widget.separatorAtIndexPath!(item);
      case IndexPathType.placeholder:
        return widget.placeholderView!();
      default:
        break;
    }
    return null;
  }
}
