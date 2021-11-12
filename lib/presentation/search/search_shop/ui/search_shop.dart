import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muaho/presentation/search/search_shop/bloc/search_shop_bloc.dart';

class SearchShopScreen extends StatefulWidget {
  const SearchShopScreen({Key? key}) : super(key: key);

  @override
  _SearchShopScreenState createState() => _SearchShopScreenState();
}

class _SearchShopScreenState extends State<SearchShopScreen> {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as SearchArgument;
    return Container(
      color: Theme.of(context).backgroundColor,
      child: SafeArea(
        child: Scaffold(
          appBar: new AppBar(
            automaticallyImplyLeading: true,
            centerTitle: true,
            title: Text(args.keyword),
          ),
          body: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(48),
                topRight: Radius.circular(48),
              ),
            ),
            child: BlocProvider<SearchShopBloc>(
              create: (_) => SearchShopBloc()
                ..add(
                  SearchEvent(keyword: args.keyword),
                ),
              child: BlocBuilder<SearchShopBloc, SearchShopState>(
                builder: (ctx, state) {
                  return _handleRequestSearch(state);
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _handleRequestSearch(SearchShopState state) {
    if (state is SearchShopLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else if (state is SearchShopSuccess) {
      if (state.shops.isEmpty) {
        return Center(
          child: Text("Nothing here"),
        );
      } else {
        return Center(
          child: Text(state.shops[0].name),
        );
      }
    } else {
      return Center(
        child: Text("Error"),
      );
    }
  }
}

class SearchArgument {
  final String keyword;

  SearchArgument({required this.keyword});
}
