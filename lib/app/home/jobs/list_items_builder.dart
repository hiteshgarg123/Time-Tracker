import 'package:flutter/material.dart';
import 'package:time_tracker/app/home/jobs/empty_page_content.dart';

typedef ItemWidgetBuilder<T> = Widget Function(BuildContext context, T items);

class ListItemsBuilder<T> extends StatelessWidget {
  const ListItemsBuilder({
    Key key,
    @required this.snapshot,
    @required this.itemBuilder,
  }) : super(key: key);

  final AsyncSnapshot<List<T>> snapshot;
  final ItemWidgetBuilder<T> itemBuilder;

  @override
  Widget build(BuildContext context) {
    if (snapshot.hasData) {
      final List<T> items = snapshot.data;
      if (items.isNotEmpty) {
        return _buildList(items);
      } else {
        return EmptyPageContent();
      }
    } else if (snapshot.hasError) {
      return EmptyPageContent(
        title: 'Something went wrong',
        message: 'Can\'t load data right now',
      );
    }
    return Center(child: CircularProgressIndicator());
  }

  Widget _buildList(List<T> items) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) => itemBuilder(
        context,
        items[index],
      ),
    );
  }
}
