import 'dart:async';

import 'package:coffee_app/Model/cart_model.dart';
import 'package:coffee_app/Providers/cart_provider.dart';
import 'package:coffee_app/Screen/cart_screen.dart';
import 'package:coffee_app/Widget/toast.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_database/firebase_database.dart';


class dishScreen extends StatefulWidget {
   List<List> items  ;
   int index;
    double initPrice ;
   List productList;
   dishScreen({super.key, required this.items , required this.index , required this.initPrice , required this.productList});
  @override
  State<dishScreen> createState() => _dishScreenState();
}

class _dishScreenState extends State<dishScreen> {
  final ref = FirebaseDatabase.instance.ref('cart');
   
  
  @override
  Widget build(BuildContext context) {
      CartProvider provider = Provider.of<CartProvider>(context);
      
    return Scaffold(
      appBar: AppBar(backgroundColor: widget.items[widget.index][3][100],),
      backgroundColor:widget.items[widget.index][3][100],
      body: Column(
        children: [
          Container(
            color:widget.items[widget.index][3][100] ,
            height: 200,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.only(bottom : 8.0),
              child: Image.asset('${widget.items[widget.index][2]}'),
            )),
          Container(

            decoration: BoxDecoration(borderRadius: BorderRadius.only(topLeft:Radius.circular(12),topRight: Radius.circular(12)) , color: Colors.purple[100] ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text('${widget.items[widget.index][0]}' ,style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold , color: Colors.white),),
                  /*Row(children: [
                    IconButton(
                      style: IconButton.styleFrom(backgroundColor:Colors.white , shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(12))
                     ),
                      onPressed: () {
                        if(provider.getCounter() >0){
                           provider.removeCounter();
                           provider.removePrice(widget.items[widget.index][1]);
                        }else{
                          Utils().flutterToast('Cannot remove ');
                        }
                    }, 
                    icon: Icon(Icons.remove)),
                     Padding(
                       padding: const EdgeInsets.only(left : 8.0, right: 8),
                       child: Consumer<CartProvider>(
                        builder: (context, value, child) {
                          return Text(value.getCounter().toString());
                        },
                      ),
                     ),
                     IconButton(
                      style: IconButton.styleFrom(backgroundColor:Colors.white , shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(12))),
                      onPressed: () {
                        if(provider.getCounter()<5){
                       provider.addCounter();
                      provider.addPrice(widget.items[widget.index][1]);}
                       else{
                        Utils().flutterToast('Cannot add more');}
                    }, icon: Icon(Icons.add))
                  ],)*/
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7))
                    ),
                    onPressed: () {
                     AddToCart(context);

                     }, 

                     child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Add to cart'),
                  ))
                  ]),
                  Text(
                    'Indulge in the rich, comforting embrace of a perfectly brewed cup of hot coffee, a true symphony of flavor and texture. With every sip, you\'ll experience the harmonious blend of freshly roasted coffee beans, meticulously ground to perfection. The enticing aroma of those beans is just a prelude to the exquisite taste that follows – a warm, robust elixir that tantalizes your taste buds with its deep, full-bodied essence. Its velvety texture soothes your senses as you relish the harmonious marriage of cream and sugar, enhancing the coffee\'s natural richness. Whether you savor it black or embellish it with your favorite additions, hot coffee transcends mere refreshment, it\'s a comforting ritual that awakens and invigorates, leaving you enchanted by its delightful flavors and the soothing warmth it brings to your soul.'
                    ,style: TextStyle(color: Colors.white ,fontSize: 15),),
                    SizedBox(height: 10,),
                    Row(
                      
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(width: 2 ,color: Colors.white),
                            borderRadius: BorderRadius.circular(12),color: Colors.purple[100],),
                          height: 79,
                          width: 120,
                          child: Center(
                            child: Text('\$ ${widget.items[widget.index][1].toString()}' , style: TextStyle(fontSize: 26 , color: Colors.white),),
                          )),
                          Container(
                            decoration: BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(12)), color:widget.items[widget.index][3][100] ),
                            height: 79,
                            width: 190,
                            child: InkWell(
                              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => CartScreen(),)),
                              child: Column(
                                children: [
                                  IconButton(onPressed: () {
                                    
                                  }, icon:Icon(Icons.shopping_cart , color: Colors.white,size: 30) ,
                                  
                                  ),
                                   Text('Check Out' , style: TextStyle(color: Colors.white , fontSize: 19 , fontWeight: FontWeight.bold),),
                                ],
                              ),
                            ),
                          )
                      ],
                    )
                ],
              ),
            
              
            ),
            
          ),
        ],
      ),

    );
  }
 void AddToCart(BuildContext context) async {
  final provider = Provider.of<CartProvider>(context ,listen: false);
 final cart = CartModel(name:widget.items[widget.index][0] 
                       , id:widget.index.toString(), picture: widget.items[widget.index][2] 
                       ,price: widget.items[widget.index][1],
                       quantity: 1).toJson();
                ref.child(widget.items[widget.index][0]).set(cart).then((value) {
                       Utils().flutterToast('Added to cart');
                     //  provider.addCounter();
                       provider.addPrice(widget.items[widget.index][1]);
                      }).onError((error, stackTrace) 
                      { Utils().flutterToast(error.toString());});
 }
}