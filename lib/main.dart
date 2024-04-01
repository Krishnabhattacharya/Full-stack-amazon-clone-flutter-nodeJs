import 'package:amazon_clone/constant/global_variable.dart';
import 'package:amazon_clone/route.dart';
import 'package:amazon_clone/admin/screen/admin_screen.dart';
import 'package:amazon_clone/screens/auth/auth_screen.dart';
import 'package:amazon_clone/services/SharedServices/Preferences.dart';
import 'package:amazon_clone/services/SharedServices/Sharedservices.dart';
import 'package:amazon_clone/services/provider/admin_add_product_screen_isprograssing_change.dart';
import 'package:amazon_clone/services/provider/api_services_provider.dart';
import 'package:amazon_clone/services/provider/auth_provider.dart';
import 'package:amazon_clone/services/provider/radio_button_state_change.dart';
import 'package:amazon_clone/services/provider/bottom_bar_index_change_provider.dart';
import 'package:amazon_clone/widgets/reuseable_widgets.dart/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  preferences = await SharedPreferences.getInstance();
  Stripe.publishableKey =
      //  'pk_test_51OPlQHBj29jFqCmNolRqeZUyEhkmOkyyLOrnlYcmf8mKrGMJMmwd2T7yp40tgpPx7m5tKQTgSXL388yfgOJZmsud00FIqHlDUM'; //thai

      "pk_test_51P0imGSIysZLwg2EJiipYmOFEYIvuE6LFek6TofrQfUYiW7BYb3vhf10eo79XKqTuj0U16vRF3s95hupyIKgzz5f00x1jDWWtG";
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => RadioButtonStateChange()),
        ChangeNotifierProvider(create: (context) => BottobarIndexChange()),
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => IsprograssingChange()),
        ChangeNotifierProvider(create: (context) => ApiProviderServices())
      ],
      child: ScreenUtilInit(
          designSize: const Size(360, 690),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) {
            return MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Amazon Clone',
                theme: ThemeData(
                  scaffoldBackgroundColor: GlobalVariables.backgroundColor,
                  appBarTheme: const AppBarTheme(
                      elevation: 0,
                      iconTheme: IconThemeData(color: Colors.black)),
                  colorScheme: const ColorScheme.light(
                      primary: GlobalVariables.secondaryColor),
                  useMaterial3: true,
                ),
                onGenerateRoute: (settings) => geneRateRoute(settings),
                home: SharedServices.isLoggedIn()
                    ? SharedServices.getLoginDetails()!
                                .user!
                                .type!
                                .toLowerCase() ==
                            'admin'
                        ? const AdminScreen()
                        : const BottomBar()
                    : const AuthScreen());
          }),
    );
  }
}
