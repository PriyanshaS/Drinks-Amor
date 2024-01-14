
import 'package:coffee_app/Providers/cart_provider.dart';
import 'package:coffee_app/Widget/toast.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
 

  final ref = FirebaseDatabase.instance.ref('cart');
  @override
  Widget build(BuildContext context) {
        final provider = Provider.of<CartProvider>(context , listen: false);

    return Scaffold(
     
      appBar: AppBar(
        title:Text('Cart' , style: TextStyle(color: Colors.white, fontSize: 24),), 
        centerTitle: true,
        backgroundColor: Colors.purple[100],
      ),
      body: Column(
        children: [
          Expanded(
            
            child: StreamBuilder(builder: (context, snapshot) {
               
               if(snapshot.connectionState==ConnectionState.waiting){
                  return Center(child: CircularProgressIndicator());
                 }
                  
                 else {
                  var list = [];
                  if(snapshot.data!.snapshot.value!=null){
                 Map<dynamic , dynamic> mp = snapshot.data!.snapshot.value as dynamic;
                 list =mp.values.toList();
                  }
              return ListView.builder(
                itemCount: list.length ,
                itemBuilder:(context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    color: Color.fromARGB(255, 208, 193, 211),
                    height: 100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                        Container(
                        width: 150,
                        height: 100,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(list[index]['picture'] , height: 70),
                            Text(list[index]['name'] , style: TextStyle(fontSize: 15),)
                          ],
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('\$ ${list[index]['price']}' , style: TextStyle(fontSize: 22),),
                          Container(
                            width: 200,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                  InkWell(
                                    onTap: () {
                                      String name = list[index]['name'];
                                      int quan = list[index]['quantity'];
                                      if(quan>0){
                                      ref.child(name).update({
                                     'quantity' : list[index]['quantity']-1,
                                       }).then((value){
                                        quan--;
                                     provider.removePrice(double.parse(list[index]['price'].toString()));
                                     if(quan==0){
                                      print('ehere');
                                      deleteItem(list[index]);
                                     }
                                     });}
                                     else{
                                      Utils().flutterToast('Cannot remove');
                                     }
                                    },
                                    child: Container(
                                    height: 30,
                                    width: 30,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(4)),
                                      color: Colors.white , border: Border.all(style:BorderStyle.none ,  )),
                                     child: Center(child: Icon(Icons.remove ,))
                                                               ),
                                  ),
                                 SizedBox(width: 10,),
                                Text(list[index]['quantity'].toString() , style: TextStyle(fontSize: 14),),
                                SizedBox(width: 10,),
                                 InkWell(
                                  onTap: () {
                                   String name = list[index]['name'];
                                    int quan = list[index]['quantity'];
                                      if(quan<5){
                                      ref.child(name).update({
                                     'quantity' :list[index]['quantity']+1,
                                       }).then((value){
                                     provider.addPrice(double.parse(list[index]['price'].toString()));
                                     }).onError((error, stackTrace) {
                                      print(error.toString());
                                     });}
                                     else{
                                      Utils().flutterToast('Cannot add more');
                                     }
                                  },
                                   child: Container(
                                    height: 30,
                                    width: 30,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(4)),
                                      color: Colors.white , border: Border.all(style:BorderStyle.none ,  )),
                                     child: Icon(Icons.add ,)
                                   ),
                                 ),
                              ],
                            ),
                          )
                        ],
                      ),
                       ],
                    ),
                  ),
                );
              },);}
             
             
            },
                
            stream: ref.onValue,
            ),
          ),
          Expanded(
           
            child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(height: 1,color: const Color.fromARGB(255, 213, 211, 211),),
                SizedBox(height: 5,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  Text('Sub Total' , style: TextStyle(fontWeight: FontWeight.bold , fontSize: 18),),
                  Consumer<CartProvider>(
                  builder: (context, value, child) {
                    return Text('\$${value.getPrice().toString()}',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18));
                  },
                  ),
                ],),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  Text('Delivery Charges' , ),
                  Consumer<CartProvider>(
                  builder: (context, value, child) {
                    return Text('\$40.0',);
                  },
                  ),
                ],),
                SizedBox(height: 5,),
                 Container(height: 1,color: const Color.fromARGB(255, 213, 211, 211),),
                 SizedBox(height: 5,),
                  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  Text('Total' ,  style: TextStyle(fontWeight: FontWeight.bold , fontSize: 18)),
                  Consumer<CartProvider>(
                  builder: (context, value, child) {
                    return Text('\$${(value.getPrice()+40.00).toString()}', style: TextStyle(fontWeight: FontWeight.bold , fontSize: 18));
                  },
                  ),
                ],),
              ],
            ),
          )),Container(
            height: 60,
            width: double.infinity,
            
            child: ElevatedButton(onPressed: () {
            
                        },
                        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            backgroundColor: Color.fromARGB(255, 208, 193, 211) ,
                        ),
                        child: Text('Proceed to checkout' , style: TextStyle(color: Colors.black),)),
          )
        ],
      ),
    );
  }
  void deleteItem(dynamic item)async{
    await ref.child(item['name']).remove().then((value) {
      Utils().flutterToast('Deleted');
    }).onError((error, stackTrace) {
      print(error.toString());
    });
  }
  
   
}
