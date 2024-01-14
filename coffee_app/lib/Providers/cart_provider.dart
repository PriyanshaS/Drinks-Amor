import 'package:coffee_app/Widget/toast.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartProvider with ChangeNotifier {
  double _price = 0.00;
  double get price => _price;

  
  void _setPrefItems() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setDouble('cart_total', _price);
    notifyListeners();
  }

  void _getPrefItems() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _price = prefs.getDouble('cart_total')?? 0.0;
    
    
    notifyListeners();

  }

  addPrice(double productPrice){
    _price += productPrice;
    _setPrefItems();
    notifyListeners();
  }

  removePrice(double productPrice){
    _price -= productPrice;
    _setPrefItems();
    notifyListeners();
  }

  double getPrice() {
    _getPrefItems();
    
    return _price;
  }
}