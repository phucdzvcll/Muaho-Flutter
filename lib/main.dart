import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:muaho/common/MyTheme.dart';
import 'package:muaho/generated/locale_keys.g.dart';

import 'generated/codegen_loader.g.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await EasyLocalization.ensureInitialized();
  runApp(
    EasyLocalization(
        supportedLocales: [Locale('en'), Locale('vi')],
        path: 'assets/translations',
        startLocale: Locale('vi'),
        fallbackLocale: Locale('vi'),
        assetLoader: CodegenLoader(),
        child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: context.locale,
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
      title: 'Flutter Demo',
      theme: MyTheme.lightTheme,
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    testingConnectFirebase();
                  },
                  child: Text(
                    "Normal".toUpperCase(),
                    style: Theme.of(context).textTheme.button,
                  ),
                  style: MyTheme.buttonStyleNormal,
                ),
                ElevatedButton(
                  onPressed: () {
                    testingConnectFirebase();
                  },
                  child: Text(
                    LocaleKeys.btn_login.tr(),
                    style: Theme.of(context)
                        .textTheme
                        .button!
                        .copyWith(color: MyTheme.primaryColor),
                  ),
                  style: MyTheme.buttonStyleNormalLessImportant,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    testingConnectFirebase();
                  },
                  child: Text(
                    "Disable".toUpperCase(),
                    style: Theme.of(context).textTheme.button,
                  ),
                  style: MyTheme.buttonStyleDisable,
                ),
                ElevatedButton(
                  onPressed: () {
                    testingConnectFirebase();
                  },
                  child: Text(
                    "Less Important".toUpperCase(),
                    style: Theme.of(context)
                        .textTheme
                        .button!
                        .copyWith(color: Color(0xff929292)),
                  ),
                  style: MyTheme.buttonStyleDisableLessImportant,
                ),
              ],
            ),
            StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection("testing").snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return const SizedBox.shrink();
                }
                return Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (BuildContext context, int index) {
                      final docData = snapshot.data!.docs[index].data();
                      return IntrinsicHeight(
                        child: ListTile(
                          title: Text(
                            docData.toString(),
                            style: Theme.of(context).textTheme.bodyText2,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
// This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void testingConnectFirebase() {
    FirebaseFirestore.instance
        .collection("testing")
        .add({"timestamp": Timestamp.fromDate(DateTime.now())});
  }
}
