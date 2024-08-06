import 'package:flutter/material.dart';
import 'package:grocery_app/models/productmodel.dart';
import 'package:grocery_app/resources/appcolors/appcolors.dart';

class CardChildrenWidget extends StatefulWidget {
  final ProductModel product;
  const CardChildrenWidget({super.key, required this.product});

  @override
  State<CardChildrenWidget> createState() => _CardChildrenWidgetState();
}

class _CardChildrenWidgetState extends State<CardChildrenWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Colors.black,
      elevation: 5.0,
      color: AppColors.background,
      child: SizedBox(
        height: 220,
        width: 170,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: SizedBox(
                  height: 140,
                  width: 140,
                  child: Container(
                    height: 50,
                    width: 50,
                    color: AppColors.primary.withOpacity(0.2),
                    child: Image.network(
                        height: 20,
                        width: 20,
                        fit: BoxFit.scaleDown,
                        widget.product.imageurl.toString()),
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: Text(
                      widget.product.name.toString(),
                      style: const TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Flexible(
                    child: Text(
                      widget.product.category.toString(),
                      style: const TextStyle(fontSize: 12.0),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "\$${widget.product.price}",
                        style: const TextStyle(
                            color: AppColors.primary,
                            fontSize: 23.0,
                            fontWeight: FontWeight.bold),
                      ),
                      Icon(
                        Icons.shopping_bag,
                        size: 30,
                        color: AppColors.amber.withOpacity(0.7),
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
