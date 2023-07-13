import 'dart:io' as o;
import 'package:permission_handler/permission_handler.dart' ;
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
class ImageView extends StatefulWidget {
  final String imgUrl;

  const ImageView({required this.imgUrl});

  @override
  State<ImageView> createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  final String filePath="" ; 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Hero(
            tag: widget.imgUrl,
            child:
            
             Container(
              //padding: EdgeInsets.only(left: 1),
              height: MediaQuery.of(context).size.height ,
              width: MediaQuery.of(context).size.width ,
              child: Image.network(
                widget.imgUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            mainAxisAlignment:MainAxisAlignment.end ,
            children :<Widget> [
              GestureDetector(
                onTap:() {
                  _save()
                  ;},
                child: Container(
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.only(left: 100),
                  width: MediaQuery.of(context).size.width/2,
                  decoration: BoxDecoration(
                    border:Border.all(color: Colors.white60 ,width:1) ,
                    borderRadius: BorderRadius.circular(30),
                    gradient: LinearGradient(colors: [
                      Colors.grey,
                      Color(0x0FFFFFFF)
                    ])
                  ),
                  child: Column(
                    children:<Widget> 
                   [ 
                      Text("Download Wallpaper"),
                      Text("Check Out Your Gallery",style:  TextStyle(
                        fontSize: 12
                      ),)
                    ],
                  ),
                
                ),
              ),
              SizedBox(height: 50,)
            ],
          ),
          Positioned(
            top: 40,
            left: 10,
            child: IconButton(
              icon: Icon(Icons.arrow_back),
              color: Colors.white,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
    
  }

  _save() async {
    if (o.Platform.isAndroid) {   
  await    _askPermission();
    }
  var response = await Dio().get(
    widget.imgUrl ,
    options: Options(responseType: ResponseType.bytes) );
    final result = 
    await ImageGallerySaver.saveImage(Uint8List.fromList(response.data));
    print(result);
    Navigator.pop(context);

}

_askPermission() async {
  if (o.Platform.isAndroid) {
    var status = await Permission.storage.status;
    if (status.isDenied) {
      await Permission.storage.request();
    }
  }
}

}