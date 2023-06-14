import 'package:flutter/material.dart';
class CategoriesTile extends StatelessWidget {
  final String imgUrl;
  final String title;

  CategoriesTile({required this.title, required this.imgUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 5),
      child: Stack(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: Image.network(
              imgUrl,height: 100,width: 100,
              fit: BoxFit.cover,
            ),
          ),
          Container(
           color: Colors.black12,
           height: 150,width: 150, 
            alignment: Alignment.center,
            child: Text(title,style: TextStyle(color: Colors.white),),
          ),
        ],
      ),
    );
  }
}