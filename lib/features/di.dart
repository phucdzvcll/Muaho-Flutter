import 'package:get_it/get_it.dart';
import 'package:muaho/features/cart/di.dart';
import 'package:muaho/features/cart_update_bloc/di.dart';
import 'package:muaho/features/change_display_name/di.dart';
import 'package:muaho/features/chat-support/di.dart';
import 'package:muaho/features/deeplink/di.dart';
import 'package:muaho/features/main/di.dart';
import 'package:muaho/features/payment/di.dart';
import 'package:muaho/features/register/di.dart';
import 'package:muaho/features/search/di.dart';
import 'package:muaho/features/sign_in/di.dart';
import 'package:muaho/features/voucher_list/di.dart';

import 'address_info/di.dart';
import 'create_address/di.dart';
import 'home/di.dart';
import 'login/di.dart';
import 'order/di.dart';

void featuresDiConfig(GetIt injector) {
  mainConfig(injector);
  homeConfig(injector);
  addressInfoConfig(injector);
  createAddressConfig(injector);
  loginConfig(injector);
  shopProductConfig(injector);
  paymentConfig(injector);
  searchConfig(injector);
  registerConfig(injector);
  signInConfig(injector);
  userConfig(injector);
  deepLinkConfig(injector);
  cartConfig(injector);
  chatConfig(injector);
  cartUpdateConfig(injector);
  changeDisplayNameConfig(injector);
}
