import 'package:flutter/material.dart';


class ImageView extends StatefulWidget {
  final String imgUrl="" ; 
 ImageView({required  imgUrl});

  @override
  State<ImageView> createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget> [
          Hero(
            tag: widget.imgUrl,
            child: Container(
              height: MediaQuery.of(context).size.height,
              width:MediaQuery.of(context).size.width ,
              child: Image.network(widget.imgUrl, 
              fit: BoxFit.cover,
              ),
            ),
          ), 
          Container(
            child: Column(children:<Widget> [
              Container(
                decoration:  BoxDecoration(
                gradient: LinearGradient(colors: [
                  Color(0x36FFFFFF),
                  Color(0x0FFFFFFF)

                ]
                ),
                ),
                child:Column(
                  children:<Widget> [
                    Text("Download Wallpaper",style: TextStyle(),),
                    Text("Check your gallery",style: TextStyle(),)
                  ],
                ) ,
              ),
              Text("Cancel",
              style: TextStyle(
                color: Colors.white
              ),)
            ]),
          )
        ],
      ),
    ) ;
  } 
}