import 'package:amazon_clone/model/product_model.dart';
import 'package:amazon_clone/widgets/reuseable_widgets.dart/rating_star_widget.dart';
import 'package:flutter/material.dart';

class SearchProductWidget extends StatelessWidget {
  final Product products;
  const SearchProductWidget({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(children: [
            Image.network(
              products.images![0],
              fit: BoxFit.cover,
              height: 135,
              width: 135,
            ),
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  width: 235,
                  child: Text(
                    products.name!,
                    style: const TextStyle(fontSize: 16),
                    maxLines: 2,
                  ),
                ),
                Container(
                    padding: const EdgeInsets.only(left: 10, top: 5),
                    width: 235,
                    child: const StartRatting(
                      rating: 4,
                    )),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  width: 235,
                  child: Text(
                    "Rs ${products.price!}",
                    style: const TextStyle(
                        fontSize: 17, fontWeight: FontWeight.bold),
                    maxLines: 2,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  width: 235,
                  child: const Text(
                    "Eligible for FREE shipping",
                    // style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    maxLines: 2,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  width: 235,
                  child: const Text(
                    "In stock",
                    style: TextStyle(color: Colors.teal),
                    maxLines: 2,
                  ),
                ),
              ],
            )
          ]),
        )
      ],
    );
  }
}
