import 'dart:ui';
import 'package:amazon_clone/Screens/Results.dart';
import 'package:amazon_clone/Widgets/Button_UI.dart';
import 'package:amazon_clone/utilities/constant.dart';
import 'package:amazon_clone/utilities/theme.dart';
import 'package:amazon_clone/utilities/utility.dart';
import 'package:flutter/material.dart';

Widget more_option(String str, VoidCallback action) {
  return ElevatedButton(
    onPressed: () {
      action();
    },
    child: Text(
      str,
      style: TextStyle(color: Colors.black),
    ),
    style: ButtonStyle(
      backgroundColor: MaterialStatePropertyAll(Colors.white),
      shape: MaterialStatePropertyAll(RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
        side: BorderSide(color: Colors.black, width: 1),
      )),
    ),
  );
}

Widget rating(int rate) {
  return Container(
    child: Row(
      children: [
        for (int i = 0; i < rate; i++) Icon(Icons.star, color: Colors.amber[800],),
        for (int i = rate; i < 5; i++) Icon(Icons.star_border_outlined, color: Colors.amber[800],),
      ],
    ),
  );
}

Widget smallSquareBox(Widget str, VoidCallback action){
  return GestureDetector(
    onTap: () {
      action();
    },
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: Colors.black)
      ),
      height: 35,
      width: 35,
      child: Center(child: str),
    ),
  );
}

class ProductInCart extends StatefulWidget {
  final productName;
  final cost;
  final discount;
  final productUID;
  final sellerName;
  final sellerUID;
  final rating;
  final noOfItems;
  const ProductInCart({
    Key? key,
    required this.productName,
    required this.cost,
    required this.discount,
    required this.productUID,
    required this.sellerName,
    required this.sellerUID,
    required this.rating,
    required this.noOfItems,
  }) : super(key: key);

  @override
  State<ProductInCart> createState() => _ProductInCartState();
}

class _ProductInCartState extends State<ProductInCart> {
  Size size = getScreenSize();
  bool check = true;
  int idx = 3;

  void toggle() {
    setState(() {
      check = !check;
    });
  }

  void increase() {
    setState(() {
      idx++;
    });
  }

  void decrease() {
    setState(() {
      idx--;
    });
  }

  @override
  Widget build(BuildContext context) {
    final rs = widget.cost;
    return idx <= 0
        ? Container()
        : GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => ResultScreen(query: widget.productName),));
          },
          child: Container(
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.symmetric(horizontal: 5),
                width: size.width,
                height: size.height / 2,
                decoration: BoxDecoration(
                  color: Colors.blue.shade100.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: 
                // Column(
                //   children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Align(
                                alignment: Alignment.topLeft,
                                child: TextButton(
                                  onPressed: () {
                                    toggle();
                                  },
                                  child: check
                                      ? const Icon(
                                          Icons.check_box,
                                          color: cyanColor,
                                        )
                                      : const Icon(
                                          Icons.check_box_outline_blank,
                                          color: Colors.black,
                                        ),
                                ),
                              ),
                              Image(
                                image: NetworkImage('https://eapi.supplyhog.com/file-srv/img/i_ab712d31a3adae6586af4e3c38e7e60e.jpg'),
                                height: size.height / 4,
                                width: size.width / 3,
                                fit: BoxFit.contain,
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 10),
                                child: Row(
                                  children: [
                                    smallSquareBox(idx<=1 ? Icon(Icons.delete_outline) : Text('-') , () {decrease();}),
                                    smallSquareBox(Text('$idx'), () {}),
                                    smallSquareBox(Icon(Icons.add), () {increase();})
                                  ],
                                ),
                              ),
                              Align(alignment: Alignment.bottomCenter, child: more_option('See more like this', () { }))
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Column(
                            children: [
                              Container(
                                height: 70,
                                child: Expanded(
                                  child: Text(
                                    '${widget.productName}',
                                    style: TextStyle(fontSize: 15),
                                    softWrap: true,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 3,
                                  ),
                                ),
                              ),
                              rating(widget.rating),
                              Row(
                                children: [
                                  Text(
                                    "₹",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontFeatures: [FontFeature.superscripts()]),
                                  ),
                                  Text('${rs.toInt()}',style: TextStyle(fontSize: 25),),
                                  Text(
                                    (rs - rs.toInt()).toString(),
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontFeatures: [FontFeature.superscripts()]),
                                  ),
                                ],
                              ),
                              Expanded(
                                  child: RichText(
                                    text: TextSpan(children: [
                                      TextSpan(text: 'Sold by ', style: TextStyle(color: Colors.black, fontSize: 20)),
                                      TextSpan(text: '${widget.sellerName}', style: TextStyle(color: Colors.blue, fontSize: 20)),
                                    ]),
                                  ),
                                ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    more_option('Delete', () {
                                      setState(() {
                                        idx = 0;
                                      });
                                    }),
                                    more_option('Save for later', () {})
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    // more_option('See more like this', () {})
                //   ],
                // ),
              ),
        );
  }
}

class ProductInResultWidget extends StatefulWidget {
  final productName;
  final cost;
  final discount;
  final productUID;
  final sellerName;
  final sellerUID;
  final rating;
  final noOfRating;

  const ProductInResultWidget({
    Key? key,
    required this.productName,
    required this.cost,
    required this.discount,
    required this.productUID,
    required this.sellerName,
    required this.sellerUID,
    required this.rating,
    required this.noOfRating,
  }) : super(key: key);

  @override
  State<ProductInResultWidget> createState() => _ProductInResultWidgetState();
}

class _ProductInResultWidgetState extends State<ProductInResultWidget> {
  @override
  Widget build(BuildContext context) {
    final rs = widget.cost;
    Size size = MediaQuery.of(context).size;

    return Container(
      color: bgcolor,
      height: size.height / 2.2,
      width: size.width - 5,
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 5),
              height: size.height / 2.2,
              width: double.infinity,
              child: Image(
                image: NetworkImage('https://eapi.supplyhog.com/file-srv/img/i_ab712d31a3adae6586af4e3c38e7e60e.jpg'),
                fit: BoxFit.contain,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${widget.productName}',
                  style: TextStyle(fontSize: 18),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                rating(widget.rating),
                Row(
                  children: [
                    Text(
                      "₹",
                      style: TextStyle(
                        fontSize: 15,
                        fontFeatures: [FontFeature.superscripts()],
                      ),
                    ),
                    Text(
                      '${rs.toInt()}',
                      style: TextStyle(fontSize: 25),
                    ),
                    Text(
                      ("·"+((rs - rs.toInt())*100).toString()),
                      style: TextStyle(
                        fontSize: 15,
                        fontFeatures: [FontFeature.superscripts()],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(text: 'Sold by ', style: TextStyle(color: Colors.black, fontSize: 20)),
                        TextSpan(text: '${widget.sellerName}', style: TextStyle(color: Colors.blue, fontSize: 20)),
                      ],
                    ),
                  ),
                ),
                Expanded(child: Container()),
                Container(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: rounded_button('Add to cart', () {}),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget reviewSection(String costumer, int rate, String review){
  return Container(
    height: 88,
    padding: EdgeInsets.symmetric(vertical: 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('$costumer', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            rating(rate),
            Text(keysOfRating[rate-1],),
          ],
        ),
        Text('$review'),
      ],
    ),
  );
}

class reviewDialogBox extends StatefulWidget {
  const reviewDialogBox({Key? key}) : super(key: key);

  @override
  State<reviewDialogBox> createState() => _reviewDialogBoxState();
}

class _reviewDialogBoxState extends State<reviewDialogBox> {
  int _rate = -1;
  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    return AlertDialog(
      actions: [
        Container(
          height: 200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text('Write a review for this product!', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _rate = index;
                      });
                    },
                    child: Icon(
                      (index <= _rate) ? Icons.star : Icons.star_outline,
                      color: Colors.amber[800],
                    ),
                  );
                }),
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: controller,
                      decoration: InputDecoration(
                        hintText: 'Type your review'
                      ),
                    ),
                  ),
                ],
              ),
              Center(child: TextButton(onPressed: (){
                Navigator.pop(context);
              }, child: Text('Send'))),
            ],
          ),
        ),
      ],
    );
  }
}