import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:taswirti/widgets/widget.dart' as WidP;
import 'package:taswirti/views/ImageView.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:taswirti/ad_helper.dart';

class ResultsScreen extends StatefulWidget {
  final String searchTerm;
  final List<String> wallpapers;

  ResultsScreen({required this.searchTerm, required this.wallpapers});

  @override
  _ResultsScreenState createState() => _ResultsScreenState();
}

class _ResultsScreenState extends State<ResultsScreen> {
  bool loading = true;
  late BannerAd _ad;

  @override
  void initState() {
    super.initState();
    _ad = BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      size: AdSize.banner,
      request: AdRequest(),
      listener: BannerAdListener(),
    );
    _ad.load();
    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        loading = false;
      });
    });
  }

  @override
  void dispose() {
    _ad.dispose();
    super.dispose();
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
        children: [
          Positioned.fill(
            bottom: _ad.size.height.toDouble(),
            child: Column(
              children: [
                SizedBox(height: 20),
                Expanded(
                  child: widget.wallpapers.isNotEmpty
                      ? Scrollbar(
                          thumbVisibility: true,
                          radius: Radius.circular(20),
                          child: GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                            ),
                            itemCount: widget.wallpapers.length,
                            itemBuilder: (context, index) {
                              final wallpaper = widget.wallpapers[index];
                              return GridTile(
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ImageView(
                                          imgUrl: wallpaper,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Hero(
                                    tag: wallpaper,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Image.network(
                                        wallpaper,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                      : Center(
                          child: Text(
                            'No images found',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                ),
                if (loading)
                  Container(
                    color: Colors.white.withOpacity(0.8),
                    child: Center(
                      child: SpinKitCircle(
                        color: Colors.orange,
                        size: 50.0,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              alignment: Alignment.center,
              child: AdWidget(ad: _ad),
              width: _ad.size.width.toDouble(),
              height: _ad.size.height.toDouble(),
            ),
          ),
        ],
      ),
    );
  }
}