import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:taswirti/widgets/widget.dart' as WidP;

class SearchResultsScreen extends StatefulWidget {
  final String searchTerm;
  final List<String> wallpapers;

  

  SearchResultsScreen({required this.searchTerm, required this.wallpapers});

  @override
  _SearchResultsScreenState createState() => _SearchResultsScreenState();
}

class _SearchResultsScreenState extends State<SearchResultsScreen> {
  bool isLoading = true;
  

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: WidP.BrandName(),
        elevation: 0.0,
         iconTheme: IconThemeData(
    color: Colors.black, 
  ),
      ),
      body: Stack(
        children: [SizedBox(height: 20,),
          if (widget.wallpapers.length != 0)
            GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: widget.wallpapers.length,
              itemBuilder: (context, index) {
                final wallpaper = widget.wallpapers[index];
                return GridTile(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      wallpaper,
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            )
          else
            Center(
              child: Text(
                'No images found',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          if (isLoading)
            Container(
              color: Colors.white.withOpacity(0.8),
              child: Center(
                child: SpinKitCircle(
                  color: Colors.blue,
                  size: 50.0,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

