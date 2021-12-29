import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muaho/common/my_theme.dart';
import 'package:muaho/domain/models/address/address_entity.dart';
import 'package:muaho/presentation/cart_update_bloc/cart_update_bloc.dart';
import 'package:muaho/presentation/components/app_bar_component.dart';
import 'package:muaho/presentation/payment/payment_screen.dart';

import '../../main.dart';
import 'bloc/address_bloc.dart';

class AddressScreen extends StatelessWidget {
  const AddressScreen({Key? key}) : super(key: key);
  static final String routeName = 'Address';

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AddressBloc>(
      create: (context) =>
          getIt(param1: BlocProvider.of<CartUpdateBloc>(context))
            ..add(
              RequestListAddressEvent(),
            ),
      child: BlocBuilder<AddressBloc, AddressState>(
        buildWhen: (p, currentState) => (currentState is GetListAddressSuccess),
        builder: (ctx, state) {
          return Builder(builder: (ctx) {
            return BlocListener<AddressBloc, AddressState>(
              listener: (context, state) {
                if (state is ChangeAddressSuccess) {
                  Navigator.popAndPushNamed(ctx, PaymentScreen.routeName);
                }
              },
              child: Container(
                color: Colors.white,
                child: SafeArea(
                  child: Scaffold(
                    backgroundColor: Colors.white,
                    appBar: AppBarComponent.titleOnly(title: "Chọn địa chỉ"),
                    body: Container(
                      margin: const EdgeInsets.only(top: 32),
                      child: _handleBuilder(state, ctx),
                    ),
                  ),
                ),
              ),
            );
          });
        },
      ),
    );
  }

  Widget _handleBuilder(AddressState state, BuildContext context) {
    if (state is GetListAddressSuccess) {
      return Column(
        children: state.addressInfoEntities
            .map((e) => _addressBuilder(e, context))
            .toList(),
      );
    } else {
      return CircularProgressIndicator();
    }
  }

  Widget _addressBuilder(
      AddressInfoEntity addressInfoEntity, BuildContext context) {
    return GestureDetector(
      onTap: () {
        showWarningChangeAddressDialog(context, addressInfoEntity);
      },
      child: Stack(
        children: [
          Container(
            padding:
                const EdgeInsets.only(top: 16, bottom: 16, left: 16, right: 35),
            margin: const EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 16,
            ),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Theme.of(context).backgroundColor,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                  color: Theme.of(context).primaryColorLight, width: 0.5),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Địa chỉ: ",
                        style: Theme.of(context).textTheme.headline1?.copyWith(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                          text: addressInfoEntity.address,
                          style: Theme.of(context).textTheme.subtitle1)
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "SĐT: ",
                        style: Theme.of(context).textTheme.headline1?.copyWith(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                          text: addressInfoEntity.contactPhoneNumber,
                          style: Theme.of(context).textTheme.subtitle1)
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            right: 20,
            bottom: 10,
            top: 10,
            child: IconButton(
              icon: Icon(
                Icons.highlight_off_outlined,
                size: 28,
                color: Colors.deepOrange,
              ),
              onPressed: () {},
            ),
          )
        ],
      ),
    );
  }

  Future<dynamic> showWarningChangeAddressDialog(
      BuildContext context, AddressInfoEntity addressInfoEntity) {
    return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: MyTheme.backgroundColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16.0))),
        title: Text(
          "Chọn Địa Chỉ",
          style: Theme.of(context).textTheme.headline1,
        ),
        content: Text(
          "Địa chỉ này sẽ là địa chỉ giao hàng của bạn!",
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyText1,
        ),
        actions: [
          CupertinoDialogAction(
            child: Text("Yes"),
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pop();
              BlocProvider.of<AddressBloc>(context).add(
                  ChangeCurrentAddress(addressInfoEntity: addressInfoEntity));
            },
          ),
          CupertinoDialogAction(
            child: Text("No"),
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pop();
            },
          )
        ],
      ),
    );
  }
}
