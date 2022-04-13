# group_tablelist

A flutter grouped list widget similar to the iOS UITableview method name.

# Group tablelist package for Flutter.

[![Pub](https://img.shields.io/pub/v/group_tablelist.svg)](https://pub.dev/packages/grouped_list)![CI](https://github.com/cocoonbud/group_tablelist/workflows/CI/badge.svg?branch=master)

<img src="https://tva1.sinaimg.cn/large/e6c9d24egy1h16sblahmuj20r01gcmz6.jpg" alt="WeChat72b21c420d6bb06007a44d196e78906a" style="zoom:25%;" />

#### Features

* iOS tableview-style method names.
* Sound null safety.
* List Items can be separated in groups.
* The header and footer of the overall tablelist can be set.
* You can use almost all the original parameters of the Listview in the GroupTableList.

## Getting Started

Add the package to your pubspec.yaml:

```yaml
group_tablelist: ^0.0.4
```

 In your dart file, import the library:

 ```Dart
import 'package:group_tablelist/group_tablelist.dart';
 ```

 Instead of using a `SliverList` create a `SliverGroupTableList` Widget:

 ```dart
SliverGroupTableList(
  numberOfSections: showcaseList.length,
  numberOfRowsInSection: (section) => showcaseList[section].item.length,
  cellForRowAtIndexPath: (indexPath) => _flutterShowcaseCell(
      showcaseList[indexPath.section].item[indexPath.row]),
  headerInSection: (section) => _makeHeaderOrFooterInSection(section),
  overallHeader: () => _makeOverAll('overallHeader'),
  overallFooter: () => _makeOverAll('overallFooter'),
  footerInSection: (section) => _makeHeaderOrFooterInSection(section),
  didSelectRowAtIndexPath: (indexPath) => _handleDidSelectAtIndexPath(indexPath),
) 
 ```

**or**

 Instead of using a `Listview` create a `GroupTableList` Widget:

```dart
SliverGroupTableList(
  numberOfSections: showcaseList.length,
  numberOfRowsInSection: (section) => showcaseList[section].item.length,
  cellForRowAtIndexPath: (indexPath) => _flutterShowcaseCell(
      showcaseList[indexPath.section].item[indexPath.row]),
  headerInSection: (section) => _makeHeaderOrFooterInSection(section),
  overallHeader: () => _makeOverAll('overallHeader'),
  overallFooter: () => _makeOverAll('overallFooter'),
  footerInSection: (section) => _makeHeaderOrFooterInSection(section),
  didSelectRowAtIndexPath: (indexPath) => _handleDidSelectAtIndexPath(indexPath),
) 
```

### Parameters:

#### GroupTableList

| Name                      | Description                                                  | Required | Default value |
| :------------------------ | ------------------------------------------------------------ | :------: | :-----------: |
| `numberOfSections`        | Asks the data source to return the number of sections in the tablelist. |    no    |       1       |
| `numberOfRowsInSection`   | Returns the number of rows (table cells) in a specified section. | required |       -       |
| `cellForRowAtIndexPath`   | Returns the table cell at the index path you specify.        | required |       -       |
| `separatorAtIndexPath`    | Returns the separator at the index path you specify.         |    no    |       -       |
| `sectionSeparator`        | Asks for a separator to display of the specified section of the tablelist. |    no    |       -       |
| `headerInSection`         | Asks for a view to display in the header of the specified section of the tablelist. |    no    |       -       |
| `footerInSection`         | Asks for a view to display in the footer of the specified section of the tablelist. |    no    |       -       |
| `overallHeader`           | Headerview of the entire tablelist.                          |    no    |       -       |
| `overallFooter`           | Footerview of the entire tablelist.                          |    no    |       -       |
| `placeholderView`         | The no data view  is displayed when no data.                 |    no    |       -       |
| `didSelectRowAtIndexPath` | The callback when a list item is clicked.                    |    no    |       -       |

#### SliverGroupTableList

| Name                                                  | Description                                                  | Required | Default value |
| :---------------------------------------------------- | ------------------------------------------------------------ | :------: | :-----------: |
| `numberOfSections`                                    | Asks the data source to return the number of sections in the tablelist. |    no    |       1       |
| `numberOfRowsInSection`                               | Returns the number of rows (table cells) in a specified section. | required |       -       |
| `cellForRowAtIndexPath`                               | Returns the table cell at the index path you specify.        | required |       -       |
| `separatorAtIndexPath`                                | Returns the separator at the index path you specify.         |    no    |       -       |
| `sectionSeparator`                                    | Asks for a separator to display of the specified section of the tablelist. |    no    |       -       |
| `headerInSection`                                     | Asks for a view to display in the header of the specified section of the tablelist. |    no    |       -       |
| `footerInSection`                                     | Asks for a view to display in the footer of the specified section of the tablelist. |    no    |       -       |
| `overallHeader`                                       | Headerview of the entire tablelist.                          |    no    |       -       |
| `overallFooter`                                       | Footerview of the entire tablelist.                          |    no    |       -       |
| `placeholderView`                                     | The no data view  is displayed when no data.                 |    no    |       -       |
| `didSelectRowAtIndexPath`                             | The callback when a list item is clicked.                    |    no    |       -       |
| other parameters that the **Listview** originally had |                                                              |          |               |

