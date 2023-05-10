
import 'package:flutter/material.dart';

class PaginatedListView extends StatefulWidget {
  const PaginatedListView({super.key});

  @override
  _PaginatedListViewState createState() => _PaginatedListViewState();
}

class _PaginatedListViewState extends State<PaginatedListView> {
  final _scrollController = ScrollController();
  List<int> _allItems = List.generate(120, (index) => index + 1);
  List<int> _items = [];
  int _currentPage = 1;

  @override
  void initState() {
    super.initState();
    _loadItems();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _loadItems();
    }
  }

  Future<void> _loadItems() async {
    setState(() {
      _currentPage++;
    });

    final int startingIndex = (_currentPage - 1) * 10;
    final int endIndex = startingIndex + 10;

    if (endIndex >= _allItems.length) {
      setState(() {
        _items.addAll(_allItems.sublist(startingIndex));
      });
    } else {
      setState(() {
        _items.addAll(_allItems.sublist(startingIndex, endIndex));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Paginated ListView'),
      ),
      body: ListView.builder(
        controller: _scrollController,
        itemCount: _items.length + 1,
        itemBuilder: (context, index) {
          if (index == _items.length) {
            return SizedBox(height: 100);
          } else {
            return ListTile(
              title: Text('Item ${_items[index]}'),
            );
          }
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentPage - 2,
        items: List.generate(
          12,
              (index) => BottomNavigationBarItem(
            icon: Text('${index + 1}'),
            label: '',
          ),
        ),
        onTap: (index) {
          setState(() {
            _currentPage = index + 1;
            _items.clear();
          });
          _loadItems();
        },
      ),
    );
  }
}
