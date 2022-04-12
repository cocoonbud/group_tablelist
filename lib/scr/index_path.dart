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
