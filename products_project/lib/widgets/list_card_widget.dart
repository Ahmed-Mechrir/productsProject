import 'package:flutter/material.dart';

class ListCardWidget extends StatefulWidget {
  final Map<String, dynamic> product;

  const ListCardWidget({super.key, required this.product});

  @override
  State<ListCardWidget> createState() => _ListCardWidgetState();
}

class _ListCardWidgetState extends State<ListCardWidget> {
  int quantity = 1;

  void incrementQuantity() {
    setState(() {
      quantity++;
    });
  }

  void decrementQuantity() {
    if (quantity > 1) {
      setState(() {
        quantity--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: const Color(0xff2D2D2D),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 15,
          horizontal: 10,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.45,
                  child: Text(
                    '${widget.product['product_name']}',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Color(0xffDBDBDB),
                      fontSize: 16,
                    ),
                  ),
                  // child: FittedBox(
                  //   fit: BoxFit.contain,
                  //   alignment: Alignment.topLeft,
                  //   child: Text(
                  //     '${widget.product['product_name']}',
                  //     overflow: TextOverflow.ellipsis,
                  //     maxLines: 2,
                  //     textAlign: TextAlign.left,
                  //     style: const TextStyle(
                  //       fontWeight: FontWeight.w600,
                  //       color: Color(0xffDBDBDB),
                  //       fontSize: 15,
                  //     ),
                  //   ),
                  // ),
                ),
                const SizedBox(height: 5),
                Text(
                  '${quantity} x ${widget.product['price'].toStringAsFixed(2)} Dhs / u',
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xffDBDBDB),
                    fontSize: 15,
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: const Color(0xffDBDBDB),
                      width: 2,
                    ),
                  ),
                  padding: const EdgeInsets.all(0.0),
                  constraints: const BoxConstraints(),
                  child: IconButton(
                    icon: const Icon(
                      Icons.remove,
                      color: Colors.white,
                    ),
                    onPressed: decrementQuantity,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                  ),
                  child: Text(
                    '$quantity',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xffDBDBDB),
                      fontSize: 20,
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: const Color(0xffDBDBDB),
                      width: 2,
                    ),
                  ),
                  padding: const EdgeInsets.all(0.0),
                  constraints: const BoxConstraints(),
                  child: IconButton(
                    icon: const Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                    onPressed: incrementQuantity,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
