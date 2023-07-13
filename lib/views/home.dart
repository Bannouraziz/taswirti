import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:taswirti/ad_helper.dart';
import 'package:taswirti/data/data.dart';
import 'package:taswirti/models/categorie_model.dart';
import 'package:taswirti/widgets/widget.dart' as WidP;
import 'package:taswirti/views/SearchScreen.dart';
import 'package:taswirti/views/ImageView.dart';
import 'package:taswirti/WallpaperProvider.dart';
import 'package:taswirti/views/category.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool loading = false;
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
    fetchCategories();
  }

  @override
  void dispose() {
    _ad.dispose();
    super.dispose();
  }

  List<CatModel> categories = [];
  List<String> searchHistory = [];
  TextEditingController searchController = TextEditingController();

  void searchWallpapers(String searchTerm, int perPage) async {
    try {
      List<String> searchResults =
          await WallpaperProvider.searchWallpapers(searchTerm, perPage);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResultsScreen(
            searchTerm: searchTerm,
            wallpapers: searchResults,
          ),
        ),
      );
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Failed to load wallpapers. Please try again.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  void fetchCategories() async {
    List<CatModel> fetchedCategories = await getCategories();
    setState(() {
      categories = fetchedCategories;
    });
  }

  void addToSearchHistory(String searchTerm) {
    if (searchHistory.length >= 5) {
      searchHistory.removeAt(0);
    }
    setState(() {
      searchHistory.add(searchTerm);
    });
  }

  void removeFromSearchHistory(String searchTerm) {
    setState(() {
      searchHistory.remove(searchTerm);
    });
  }

  void navigateToImageView(String imgUrl) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ImageView(imgUrl: imgUrl),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: WidP.BrandName(),
        elevation: 0.0,
      ),
      body: SingleChildScrollView( 
        child: Column(
          children: <Widget>[
            SizedBox(height: 50),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Align(
                alignment: AlignmentDirectional.centerStart,
                child: Text(
                  "Categories",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: 18),
            Container(
              height: 80,
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 25),
                itemCount: categories.length,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return TextButton(
                    onPressed: () {
                      addToSearchHistory(categories[index].CategorieName);
                      searchWallpapers(
                          categories[index].CategorieName, 100);
                    },
                    child: CategoriesTile(
                      title: categories[index].CategorieName,
                      imgUrl: categories[index].ImgUrl,
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 60),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: searchController,
                      decoration: InputDecoration(
                        hintText: "Search wallpapers",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  InkWell(
                    onTap: () {
                      String searchTerm = searchController.text.trim();
                      if (searchTerm.isNotEmpty) {
                        addToSearchHistory(searchTerm);
                        searchWallpapers(searchTerm, 100);
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        gradient: LinearGradient(
                          colors: [
                            Color.fromARGB(255, 232, 153, 16),
                            Color.fromARGB(255, 225, 144, 4),
                          ],
                        ),
                      ),
                      child: Icon(Icons.search, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 100),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Align(
                alignment: AlignmentDirectional.centerStart,
                child: Text(
                  "Search History",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: 8),
            Container(
              height: 50,
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: ListView.builder(
                itemCount: searchHistory.length,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      String searchTerm = searchHistory[index];
                      searchController.text = searchTerm;
                      searchWallpapers(searchTerm, 100);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(right: 10),
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: Colors.black26,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Text(
                        searchHistory[index],
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 260),
            Container(
              alignment: Alignment.center,
              child: AdWidget(ad: _ad),
              width: _ad.size.width.toDouble(),
              height: _ad.size.height.toDouble(),
            ),
          ],
        ),
      ),
    );
  }
}