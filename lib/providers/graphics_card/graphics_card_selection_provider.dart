import 'package:flutter/material.dart';
import 'package:pc_builder/firestore.dart';
import 'package:pc_builder/models/filters/graphics_card_filter.dart';
import 'package:pc_builder/models/sort_order.dart';
import 'package:pc_builder/models/video_card.dart';
import 'package:pc_builder/providers/selection_provider.dart';

class GraphicsCardSelectionProvider extends ChangeNotifier implements SelectionProvider {
  FireStore db;

  List<VideoCard> filteredList;
  TextEditingController textController;
  GraphicsCardFilter filter;
  ScrollController scroll;
  FocusNode focus;

  bool isLoading;

  List get components => db.videoCardList;
  List get filtered => filteredList;

  GraphicsCardSelectionProvider(this.db) {
    isLoading = false;
    textController = TextEditingController();
    textController.addListener(search);
    focus = FocusNode();
    scroll = ScrollController();
  }

  unfilteredList() async {
    if (db.videoCardList == null) {
      isLoading = true;
      notifyListeners();
      await db.loadVideoCards();
      isLoading = false;
    }
    filteredList = db.videoCardList.toList();
    notifyListeners();
  }

  search() {
    filterList();
    notifyListeners();
    moveToStart();
  }

  applyFilter(dynamic filter) {
    this.filter = filter;
    filterList();
    notifyListeners();
    moveToStart();
  }

  moveToStart(){
    if(scroll.offset > 0)
    scroll.jumpTo(0);
  }

  filterList() {
    filteredList = db.videoCardList.toList();
    if (filter != null) {
      filteredList = filteredList
          .where((e) =>
              e.price != null &&
              e.price >= filter.selectedMinPrice &&
              e.price <= filter.selectedMaxPrice)
          .where((e) =>
              e.clock != null &&
              e.clock >= filter.selectedMinClock &&
              e.clock <= filter.selectedMaxClock)
          .where((e) =>
              e.memory != null &&
              e.memory >= filter.selectedMinMemory &&
              e.memory <= filter.selectedMaxMemory)
          .where((e) =>
              e.consumption != null &&
              e.consumption >= filter.selectedMinConsumption &&
              e.consumption <= filter.selectedMaxConsumption)
          .toList();

      if (!filter.allMemoryTypes)
        filteredList.removeWhere((e) => !filter.memoryTypes.contains(e.memoryType));
    }
    if (textController.text?.isNotEmpty != null)
      filteredList
          .removeWhere((e) => !e.name.toLowerCase().contains(textController.text.toLowerCase()));

    if (filter != null && filter.sort != GraphicsCardSort.none) {
      filteredList.sort(sort);
    }
  }

  int sort(VideoCard a, VideoCard b) {
    switch (filter.sort) {
      case GraphicsCardSort.clock:
        return filter.order == SortOrder.descending
            ? b.clock.compareTo(a.clock)
            : a.clock.compareTo(b.clock);
      case GraphicsCardSort.price:
        return filter.order == SortOrder.descending
            ? b.price.compareTo(a.price)
            : a.price.compareTo(b.price);
      case GraphicsCardSort.memory:
        return filter.order == SortOrder.descending
            ? b.memory.compareTo(a.memory)
            : a.memory.compareTo(b.memory);
      case GraphicsCardSort.consumption:
        return filter.order == SortOrder.descending
            ? b.consumption.compareTo(a.consumption)
            : a.consumption.compareTo(b.consumption);
      default:
        return -1;
    }
  }
}
