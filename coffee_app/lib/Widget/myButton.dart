import 'package:flutter/material.dart';
class myButton extends StatelessWidget {
  String ? title;
  final VoidCallback onTap;
  final bool loading ;
   myButton({super.key , required this.title ,required this.onTap , this.loading=false});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color.fromARGB(255, 225, 190, 231)),
       ),
        height: 60,
        width: 380,
        child: Center(child: loading? CircularProgressIndicator(strokeWidth: 3,color: Colors.white,): Text(title!,)),
      ),
    );
  }
}