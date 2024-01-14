import 'package:coffee_app/Auth/login.dart';
import 'package:coffee_app/Providers/cart_provider.dart';
import 'package:coffee_app/Screen/cart_screen.dart';
import 'package:coffee_app/Screen/dishScreen.dart';
import 'package:coffee_app/Widget/myTab.dart';
import 'package:coffee_app/Services/splash_services.dart';
import 'package:coffee_app/Widget/toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class MyHomePage extends StatefulWidget {
  
  MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _auth = FirebaseAuth.instance;
   List<Widget> tab = [ myTab(imgPath:'assets/icons/coffee.png' ,),
  myTab(imgPath:'assets/icons/drink.png' ,),
  myTab(imgPath:'assets/icons/energy-drink.png' ,),
  myTab(imgPath:'assets/icons/milk-shake.png' ,),
  myTab(imgPath:'assets/icons/sparkling-water.png' ,)];

  List<List> items = [["Hot Coffee" , 20.00 ,"assets/images/hot-coffee.png" ,Colors.pink] ,["Cold Coffee" , 60.00,"assets/images/coffee-glass.png" , Colors.green] , ["Coffee & Cookie" , 80.00,
  "assets/images/coffee-mug.png" , Colors.yellow],
  ["Coffee Beans",  10.00,"assets/images/coffee-bean.png",Colors.blue]];

  List itemsPurchased = []; // product quantity
 @override
  

  @override
  Widget build(BuildContext context) {
    return WillPopScope(onWillPop: () async{
      return await _onWill();
    },
      child: DefaultTabController(
        length: tab.length,
        child: Scaffold(
          floatingActionButton: FloatingActionButton(onPressed: () {
           
           Navigator.push(context, MaterialPageRoute(builder: (context) => CartScreen(),));
          },
          child: Icon(Icons.shopping_bag)
         
          ),
          appBar: AppBar(
            shadowColor: Colors.grey,
            leading: Padding(
              padding: const EdgeInsets.only(left:8.0),
              child: Icon(Icons.menu ),
            ),
            actions: [Padding(
              padding: const EdgeInsets.only(right:12.0),
              child: Icon(Icons.person),
            ),Padding(
              padding: const EdgeInsets.only(right:4.0),
              child: IconButton(icon:Icon(Icons.logout),
              onPressed: () {
                _auth.signOut().then((value) {
                  Navigator.push(context, MaterialPageRoute(builder:(context) => LoginScreen(),));
                }).onError((error, stackTrace){
                  Utils().flutterToast(error.toString());
                });
                
              },),
            )],
          ),
          body: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text('I WANT TO ' , style: TextStyle(fontSize: 22, color: Colors.grey),),
                  ),
                  Text('DRINK', style: TextStyle(fontSize: 28, color:Colors.purple[100])),
                ],
              ),
              SizedBox(height: 20,),
            TabBar(tabs:tab ),
            Expanded(
              child: TabBarView(
              children: [
              GridView.builder(
                
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,),itemCount: items.length, itemBuilder: (context, index) {
                return GridTile(
                  
                  child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                  
                    decoration: BoxDecoration(
                      color: items[index][3][50],
                      borderRadius: BorderRadius.circular(18)
                    ),
                    child:Column(
                      
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
              
                              decoration: BoxDecoration(borderRadius: BorderRadius.only(topRight:Radius.circular(18) ,bottomLeft: Radius.circular(18) ),color:items[index][3][300]),
                              child: Padding(
                                padding: const EdgeInsets.only(left:14.0 ,top:8 , bottom: 12 , right: 14),
                                child: Text('\$'+items[index][1].toString(),style: TextStyle(color: Colors.grey[700])),
                              )),
                          ],
                        ),
                        Row(
                          children: [
                            Image.asset(items[index][2] , height: 70,),
                              SizedBox(height: 12,),
                             Column(
                              
                              crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(items[index][0] , style: TextStyle(color: Colors.grey[600]),maxLines: 2,overflow:TextOverflow.ellipsis,),
                            Text('Baskins' ,style: TextStyle(fontSize: 12 , color: Colors.grey[400]),),
                          ],
                        ),
                          ],
                        ),
                      SizedBox(height: 25,),
                      ElevatedButton(
                        style:ElevatedButton.styleFrom(
                          primary: items[index][3][300],
                          shape:RoundedRectangleBorder(borderRadius:BorderRadius.only(bottomRight:Radius.circular(12) , bottomLeft: Radius.circular(12),)) ) ,
                        onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => dishScreen(items: items, index: index , initPrice: items[index][1],productList: itemsPurchased,),));
                      }, child: Padding(
                        padding: const EdgeInsets.only(left: 47.0, right : 47 , top : 15 , bottom: 15),
                        child: GestureDetector(
                          child: Text('ORDER' , style: TextStyle(color: Colors.grey[700]),)),
                      ))
                        
                      ],
                    ),
                  ),
                ));
              },)
            ]))
          ]),
        ),
      ),
    );
  }
  Future<dynamic> _onWill(){
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Exit App?'),
          content: Text('Are you sure you want to exit the app?'),
          actions: <Widget>[
            TextButton(
              child: Text('No'),
              onPressed: () {
                Navigator.of(context).pop(false); // Keep the app open.
              },
            ),
            TextButton(
              child: Text('Yes'),
              onPressed: () {
                Navigator.of(context).pop(true); // Exit the app.
              },
            ),
          ],
        );});

  }
}