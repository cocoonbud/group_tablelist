import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'scr/index_path.dart';

typedef SectionSeparator = Widget Function(int section);

typedef SeparatorAtIndexPath = Widget Function(IndexPath indexPath);

typedef HeaderInSection = Widget? Function(int section);

typedef FooterInSection = Widget? Function(int section);

typedef CellForRowAtIndexPath = Widget Function(IndexPath indexPath);

typedef NumberOfRowsInSection = int Function(int section);

typedef DidSelectAtIndexPath = Function(IndexPath indexPath);

/// Signature for a function that creates a widget for a given index, e.g., in a
/// list.
///
/// Used by [ListView.builder] and other APIs that use lazily-generated widgets.
///
/// See also:
///
///  * [WidgetBuilder], which is similar but only takes a [BuildContext].
///  * [TransitionBuilder], which is similar but also takes a child.
///  * [NullableIndexedWidgetBuilder], which is similar but may return null.
typedef IndexedWidgetBuilder = Widget? Function(
    BuildContext context, int index);

class GroupTableList extends StatefulWidget {
  /// The axis along which the scroll view scrolls.
  ///
  /// Defaults to [Axis.vertical].
  final Axis scrollDirection;

  /// Whether the scroll view scrolls in the reading direction.
  ///
  /// For example, if the reading direction is left-to-right and
  /// [scrollDirection] is [Axis.horizontal], then the scroll view scrolls from
  /// left to right when [reverse] is false and from right to left when
  /// [reverse] is true.
  ///
  /// Similarly, if [scrollDirection] is [Axis.vertical], then the scroll view
  /// scrolls from top to bottom when [reverse] is false and from bottom to top
  /// when [reverse] is true.
  ///
  /// Defaults to false.
  final bool reverse;

  /// An object that can be used to control the position to which this scroll
  /// view is scrolled.
  ///
  /// Must be null if [primary] is true.
  ///
  /// A [ScrollController] serves several purposes. It can be used to control
  /// the initial scroll position (see [ScrollController.initialScrollOffset]).
  /// It can be used to control whether the scroll view should automatically
  /// save and restore its scroll position in the [PageStorage] (see
  /// [ScrollController.keepScrollOffset]). It can be used to read the current
  /// scroll position (see [ScrollController.offset]), or change it (see
  /// [ScrollController.animateTo]).
  final ScrollController? controller;

  /// Whether this is the primary scroll view associated with the parent
  /// [PrimaryScrollController].
  ///
  /// When this is true, the scroll view is scrollable even if it does not have
  /// sufficient content to actually scroll. Otherwise, by default the user can
  /// only scroll the view if it has sufficient content. See [physics].
  ///
  /// On iOS, this also identifies the scroll view that will scroll to top in
  /// response to a tap in the status bar.
  ///
  /// Defaults to true when [scrollDirection] is [Axis.vertical] and
  /// [controller] is null.
  final bool? primary;

  /// How the scroll view should respond to user input.
  ///
  /// For example, determines how the scroll view continues to animate after the
  /// user stops dragging the scroll view.
  ///
  /// Defaults to matching platform conventions. Furthermore, if [primary] is
  /// false, then the user cannot scroll if there is insufficient content to
  /// scroll, while if [primary] is true, they can always attempt to scroll.
  ///
  /// To force the scroll view to always be scrollable even if there is
  /// insufficient content, as if [primary] was true but without necessarily
  /// setting it to true, provide an [AlwaysScrollableScrollPhysics] physics
  /// object, as in:
  ///
  /// ```dart
  ///   physics: const AlwaysScrollableScrollPhysics(),
  /// ```
  ///
  /// To force the scroll view to use the default platform conventions and not
  /// be scrollable if there is insufficient content, regardless of the value of
  /// [primary], provide an explicit [ScrollPhysics] object, as in:
  ///
  /// ```dart
  ///   physics: const ScrollPhysics(),
  /// ```
  ///
  /// The physics can be changed dynamically (by providing a new object in a
  /// subsequent build), but new physics will only take effect if the _class_ of
  /// the provided object changes. Merely constructing a new instance with a
  /// different configuration is insufficient to cause the physics to be
  /// reapplied. (This is because the final object used is generated
  /// dynamically, which can be relatively expensive, and it would be
  /// inefficient to speculatively create this object each frame to see if the
  /// physics should be updated.)
  final ScrollPhysics? physics;

  /// Whether the extent of the scroll view in the [scrollDirection] should be
  /// determined by the contents being viewed.
  ///
  /// If the scroll view does not shrink wrap, then the scroll view will expand
  /// to the maximum allowed size in the [scrollDirection]. If the scroll view
  /// has unbounded constraints in the [scrollDirection], then [shrinkWrap] must
  /// be true.
  ///
  /// Shrink wrapping the content of the scroll view is significantly more
  /// expensive than expanding to the maximum allowed size because the content
  /// can expand and contract during scrolling, which means the size of the
  /// scroll view needs to be recomputed whenever the scroll position changes.
  ///
  /// Defaults to false.
  final bool shrinkWrap;

  /// The amount of space by which to inset the children.
  final EdgeInsetsGeometry? padding;

  /// If non-null, forces the children to have the given extent in the scroll
  /// direction.
  ///
  /// Specifying an [itemExtent] is more efficient than letting the children
  /// determine their own extent because the scrolling machinery can make use of
  /// the foreknowledge of the children's extent to save work, for example when
  /// the scroll position changes drastically.
  final double? itemExtent;

  /// {@template flutter.widgets.list_view.prototypeItem}
  /// If non-null, forces the children to have the same extent as the given
  /// widget in the scroll direction.
  ///
  /// Specifying an [prototypeItem] is more efficient than letting the children
  /// determine their own extent because the scrolling machinery can make use of
  /// the foreknowledge of the children's extent to save work, for example when
  /// the scroll position changes drastically.
  ///
  /// See also:
  ///
  ///  * [SliverPrototypeExtentList], the sliver used internally when this
  ///    property is provided. It constrains its box children to have the same
  ///    extent as a prototype item along the main axis.
  ///  * The [itemExtent] property, which allows forcing the children's extent
  ///    to a given value.
  /// {@endtemplate}
  final Widget? prototypeItem;

  /// Whether to wrap each child in an [AutomaticKeepAlive].
  ///
  /// Typically, children in lazy list are wrapped in [AutomaticKeepAlive]
  /// widgets so that children can use [KeepAliveNotification]s to preserve
  /// their state when they would otherwise be garbage collected off-screen.
  ///
  /// This feature (and [addRepaintBoundaries]) must be disabled if the children
  /// are going to manually maintain their [KeepAlive] state. It may also be
  /// more efficient to disable this feature if it is known ahead of time that
  /// none of the children will ever try to keep themselves alive.
  ///
  /// Defaults to true.
  final bool addAutomaticKeepAlives;

  /// Whether to wrap each child in a [RepaintBoundary].
  ///
  /// Typically, children in a scrolling container are wrapped in repaint
  /// boundaries so that they do not need to be repainted as the list scrolls.
  /// If the children are easy to repaint (e.g., solid color blocks or a short
  /// snippet of text), it might be more efficient to not add a repaint boundary
  /// and simply repaint the children during scrolling.
  ///
  /// Defaults to true.
  final bool addRepaintBoundaries;

  /// Whether to wrap each child in an [IndexedSemantics].
  ///
  /// Typically, children in a scrolling container must be annotated with a
  /// semantic index in order to generate the correct accessibility
  /// announcements. This should only be set to false if the indexes have
  /// already been provided by an [IndexedChildSemantics] widget.
  ///
  /// Defaults to true.
  ///
  /// See also:
  ///
  ///  * [IndexedChildSemantics], for an explanation of how to manually
  ///    provide semantic indexes.
  final bool addSemanticIndexes;

  /// {@macro flutter.rendering.viewport.cacheExtent}
  final double? cacheExtent;

  /// The number of children that will contribute semantic information.
  ///
  /// Some subtypes of [ScrollView] can infer this value automatically. For
  /// example [ListView] will use the number of widgets in the child list,
  /// while the [ListView.separated] constructor will use half that amount.
  ///
  /// For [CustomScrollView] and other types which do not receive a builder
  /// or list of widgets, the child count must be explicitly provided. If the
  /// number is unknown or unbounded this should be left unset or set to null.
  ///
  /// See also:
  ///
  ///  * [SemanticsConfiguration.scrollChildCount], the corresponding semantics property.
  final int? semanticChildCount;

  /// {@macro flutter.widgets.scrollable.dragStartBehavior}
  final DragStartBehavior dragStartBehavior;

  /// {@template flutter.widgets.scroll_view.keyboardDismissBehavior}
  /// [ScrollViewKeyboardDismissBehavior] the defines how this [ScrollView] will
  /// dismiss the keyboard automatically.
  /// {@endtemplate}
  final ScrollViewKeyboardDismissBehavior keyboardDismissBehavior;

  /// {@macro flutter.widgets.scrollable.restorationId}
  final String? restorationId;

  /// {@macro flutter.material.Material.clipBehavior}
  ///
  /// Defaults to [Clip.hardEdge].
  final Clip clipBehavior;

  /// Asks the data source to return the number of sections in the tablelist. default 1
  final int numberOfSections;

  /// Returns the number of rows (table cells) in a specified section.
  final NumberOfRowsInSection? numberOfRowsInSection;

  /// Returns the table cell at the index path you specify.
  final CellForRowAtIndexPath? cellForRowAtIndexPath;

  /// Returns the separator at the index path you specify.
  final SeparatorAtIndexPath? separatorAtIndexPath;

  /// Asks for a separator to display of the specified section of the tablelist.
  final SectionSeparator? sectionSeparator;

  /// Asks for a view to display in the header of the specified section of the tablelist.
  final HeaderInSection? headerInSection;

  /// Asks for a view to display in the footer of the specified section of the tablelist.
  final FooterInSection? footerInSection;

  /// Headerview of the entire tablelist.
  final Widget Function()? overallHeader;

  /// Footerview of the entire tablelist.
  final Widget Function()? overallFooter;

  /// The no data View  is displayed when no data.
  final Widget Function()? placeholderView;

  /// The callback when a list item is clicked
  final DidSelectAtIndexPath? didSelectAtIndexPath;

  const GroupTableList(
      {Key? key,
      this.scrollDirection = Axis.vertical,
      this.controller,
      this.reverse = false,
      this.primary,
      this.physics,
      this.shrinkWrap = false,
      this.padding,
      this.itemExtent,
      this.prototypeItem,
      this.addAutomaticKeepAlives = true,
      this.addRepaintBoundaries = true,
      this.addSemanticIndexes = true,
      this.cacheExtent,
      this.semanticChildCount,
      this.dragStartBehavior = DragStartBehavior.start,
      this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,
      this.restorationId,
      this.clipBehavior = Clip.hardEdge,
      this.numberOfSections = 1,
      required this.numberOfRowsInSection,
      required this.cellForRowAtIndexPath,
      this.separatorAtIndexPath,
      this.sectionSeparator,
      this.headerInSection,
      this.footerInSection,
      this.overallHeader,
      this.overallFooter,
      this.placeholderView,
      this.didSelectAtIndexPath})
      : assert(semanticChildCount == null),
        assert(
          itemExtent == null || prototypeItem == null,
          'You can only pass itemExtent or prototypeItem, not both.',
        ),
        super(key: key);

  @override
  State<StatefulWidget> createState() => _GroupTableListState();
}

class _GroupTableListState extends State<GroupTableList> {
  late List<IndexPath> _allItemList;

  @override
  void initState() {
    _allItemList = [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _calIndexPath();

    return ListView.builder(
        scrollDirection: widget.scrollDirection,
        reverse: widget.reverse,
        controller: widget.controller,
        primary: widget.primary,
        physics: widget.physics,
        shrinkWrap: widget.shrinkWrap,
        padding: widget.padding,
        itemExtent: widget.itemExtent,
        prototypeItem: widget.prototypeItem,
        itemCount: _allItemList.length,
        addAutomaticKeepAlives: widget.addAutomaticKeepAlives,
        addRepaintBoundaries: widget.addRepaintBoundaries,
        addSemanticIndexes: widget.addSemanticIndexes,
        cacheExtent: widget.cacheExtent,
        semanticChildCount: widget.semanticChildCount,
        dragStartBehavior: widget.dragStartBehavior,
        keyboardDismissBehavior: widget.keyboardDismissBehavior,
        restorationId: widget.restorationId,
        clipBehavior: widget.clipBehavior,
        itemBuilder: (context, index) {
          return _itemBuilder(context, index) ?? Container();
        });
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

        // add separator
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

  Widget? _itemBuilder(BuildContext context, int index) {
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
