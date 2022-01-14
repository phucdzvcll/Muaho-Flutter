import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muaho/common/extensions/ui/inject.dart';
import 'package:muaho/common/localization/app_localization.dart';
import 'package:muaho/domain/models/address/address_entity.dart';
import 'package:muaho/generated/locale_keys.g.dart';
import 'package:muaho/presentation/address/create_address/create_location_screen.dart';
import 'package:muaho/presentation/cart_update_bloc/cart_update_bloc.dart';
import 'package:muaho/presentation/components/app_bar_component.dart';

import 'bloc/address_bloc.dart';

class AddressScreen extends StatelessWidget {
  const AddressScreen({Key? key}) : super(key: key);
  static final String routeName = 'Address';

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AddressBloc>(
      create: (context) =>
          inject(param1: BlocProvider.of<CartUpdateBloc>(context))
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
                  Navigator.pop(context, state.addressInfoEntity);
                }
              },
              child: Container(
                color: Theme.of(context).backgroundColor,
                child: SafeArea(
                  child: Scaffold(
                    backgroundColor: Theme.of(context).backgroundColor,
                    appBar: AppBarComponent.titleOnly(
                      title: LocaleKeys.addressList_titleScreen.translate(),
                    ),
                    body: Stack(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 32),
                          child: _handleBuilder(state, ctx),
                        ),
                        Positioned.fill(
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              width: double.infinity,
                              height: 60,
                              margin: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  color: Theme.of(context).primaryColorLight),
                              child: GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onTap: () async {
                                  var result = await Navigator.pushNamed(
                                      context, CreateAddressScreen.routeName);
                                  if (result != null &&
                                      result is bool &&
                                      result == true) {
                                    BlocProvider.of<AddressBloc>(ctx)
                                        .add(RefreshListAddressEvent());
                                  }
                                },
                                child: Center(
                                  child: Text(
                                    LocaleKeys.addressList_addAddressButton
                                        .translate(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline2
                                        ?.copyWith(
                                            color: Theme.of(context)
                                                .backgroundColor),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
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
      return ListView.builder(
        padding: const EdgeInsets.only(bottom: 76),
        itemBuilder: (context, index) {
          return _addressBuilder(state.addressInfoEntities[index], context);
        },
        itemCount: state.addressInfoEntities.length,
      );
    } else {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
  }

  Widget _addressBuilder(
      AddressInfoEntity addressInfoEntity, BuildContext context) {
    return GestureDetector(
      onTap: () {
        BlocProvider.of<AddressBloc>(context)
            .add(ChangeCurrentAddress(addressInfoEntity: addressInfoEntity));
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
              color: Theme.of(context).cardColor,
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
                        text: LocaleKeys.addressList_address.translate(),
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
                        text: LocaleKeys.addressList_phone.translate(),
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
          Visibility(
            visible: false,
            //todo handle remove address
            child: Positioned(
              right: 20,
              bottom: 10,
              top: 10,
              child: IconButton(
                icon: Icon(
                  Icons.delete_rounded,
                  size: 28,
                  color: Colors.deepOrange,
                ),
                onPressed: () {},
              ),
            ),
          )
        ],
      ),
    );
  }
}
