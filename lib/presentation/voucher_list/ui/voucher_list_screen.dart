import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muaho/common/common.dart';
import 'package:muaho/domain/models/voucher/voucher.dart';
import 'package:muaho/generated/locale_keys.g.dart';
import 'package:muaho/presentation/components/app_bar_component.dart';
import 'package:muaho/presentation/voucher_list/bloc/voucher_list_bloc.dart';

import '../../../../main.dart';

class VoucherListScreen extends StatefulWidget {
  static const routeName = '/voucher_list';

  const VoucherListScreen({Key? key}) : super(key: key);

  @override
  _VoucherListScreenState createState() => _VoucherListScreenState();
}

class _VoucherListScreenState extends State<VoucherListScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<VoucherListBloc>(
      create: (_) => inject()..add(RequestVoucherListEvent()),
      child: Container(
        color: Theme.of(context).backgroundColor,
        child: SafeArea(
          child: Scaffold(
            appBar: AppBarComponent.titleOnly(
              title: LocaleKeys.voucherList_titleScreen.translate(),
            ),
            body: BlocBuilder<VoucherListBloc, VoucherListState>(
              builder: (ctx, state) {
                if (state is VoucherListLoadingState) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is VoucherListSuccessState) {
                  return _buildSuccessState(context, state);
                } else {
                  return Center(
                    child: Text(LocaleKeys.voucherList_errorMsg.translate()),
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSuccessState(
      BuildContext context, VoucherListSuccessState state) {
    var vouchers = state.vouchers;
    return ListView.builder(
      itemBuilder: (ctx, index) {
        return _buildVoucherItem(ctx, vouchers[index]);
      },
      itemCount: vouchers.length,
    );
  }

  Widget _buildVoucherItem(BuildContext ctx, VoucherListItem voucher) {
    String voucherValue = "";

    switch (voucher.type) {
      case VoucherType.discount:
        voucherValue = "-${voucher.value.format()}";
        break;
      case VoucherType.percent:
        voucherValue = "-${voucher.value}%";
        break;
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withOpacity(0.8),
            ),
            child: Center(
              child: Text(
                voucherValue,
                style: Theme.of(context).textTheme.headline3?.copyWith(color: Colors.white),
              ),
            ),
          ),
          SizedBox.square(
            dimension: 8,
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  voucher.code,
                  style: Theme.of(context).textTheme.bodyText1,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  voucher.description,
                  style: Theme.of(context).textTheme.bodyText2,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
