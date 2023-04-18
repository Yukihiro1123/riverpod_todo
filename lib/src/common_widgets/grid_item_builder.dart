import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_todo/src/common_widgets/empty_content.dart';
import 'package:riverpod_todo/src/common_widgets/shimmer_effect.dart';

typedef ItemWidgetBuilder<T> = Widget Function(BuildContext context, T item);

class GridItemsBuilder<T> extends StatelessWidget {
  const GridItemsBuilder({
    Key? key,
    required this.data,
    required this.itemBuilder,
  }) : super(key: key);
  final AsyncValue<List<T>> data;
  final ItemWidgetBuilder<T> itemBuilder;

  @override
  Widget build(BuildContext context) {
    print("width ${MediaQuery.of(context).size.width}");
    return data.when(
      data: (items) => items.isNotEmpty
          ? GridView.builder(
              padding: const EdgeInsets.all(10.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisSpacing: 10, //ボックス左右間のスペース
                crossAxisCount: MediaQuery.of(context).size.width < 600
                    ? 1
                    : MediaQuery.of(context).size.width < 1200
                        ? 3
                        : 6, //ボックスを横に並べる数
              ),
              itemCount: items.length,
              itemBuilder: (context, index) {
                return itemBuilder(context, items[index]);
              },
            )
          : const EmptyContent(),
      loading: () {
        return GridView.builder(
            padding: const EdgeInsets.all(10.0),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisSpacing: 10, //ボックス左右間のスペース
              crossAxisCount: MediaQuery.of(context).size.width < 600
                  ? 1
                  : MediaQuery.of(context).size.width < 1200
                      ? 3
                      : 6, //ボックスを横に並べる数
            ),
            itemCount: 10,
            itemBuilder: (context, index) {
              return const ShimmerImage(height: 10);
            });
      },
      error: (_, error) {
        return const EmptyContent(
          title: 'Something went wrong',
          message: 'Can\'t load items right now',
        );
      },
    );
  }
}
