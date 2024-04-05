import 'package:amazon_clone/screens/product_details/product_details_screen.dart';
import 'package:amazon_clone/services/provider/api_services_provider.dart';
import 'package:amazon_clone/services/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class DealOfTheDay extends StatefulWidget {
  const DealOfTheDay({Key? key}) : super(key: key);

  @override
  State<DealOfTheDay> createState() => _DealOfTheDayState();
}

class _DealOfTheDayState extends State<DealOfTheDay> {
  @override
  void initState() {
    super.initState();
    _fetchDealOfTheDay();
    final user = Provider.of<AuthProvider>(context, listen: false).loginmodel;
    print(user);
  }

  Future<void> _fetchDealOfTheDay() async {
    await Provider.of<ApiProviderServices>(context, listen: false)
        .getDealOfTheDay(context);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ApiProviderServices>(
      builder: (context, apiProvider, child) {
        final dealOfTheProduct = apiProvider.dealOfTheProduct;

        if (dealOfTheProduct == null) {
          return const CircularProgressIndicator();
        }

        if (dealOfTheProduct.name == null) {
          return const SizedBox();
        }

        return GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, ProductdetailsScreen.routeName,
                arguments: dealOfTheProduct);
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 10, top: 0, bottom: 8),
                child: Text(
                  "Deal of the Day",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w400),
                ),
              ),
              Image.network(
                dealOfTheProduct.images![0],
                height: 0.36.sh,
                fit: BoxFit.cover,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, top: 6),
                child: Text(
                  "\$${dealOfTheProduct.price}",
                  style: const TextStyle(fontSize: 18),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, top: 6),
                child: Text(
                  dealOfTheProduct.name!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
