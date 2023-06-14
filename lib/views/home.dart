import 'package:flutter/material.dart';
import 'package:taswirti/data/data.dart';
import 'package:taswirti/models/categorie_model.dart';
import 'package:taswirti/widgets/widget.dart' as WidP;
import 'package:taswirti/WallpaperProvider.dart';
import 'package:taswirti/views/SearchScreen.dart';
import 'package:taswirti/views/category.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CatModel> categories = [];
  List<String> searchHistory = [];
  TextEditingController searchController = TextEditingController();

  void searchWallpapers(String searchTerm) async {
    try {
      List<String> searchResults = await WallpaperProvider.searchWallpapers(searchTerm);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SearchResultsScreen(searchTerm: searchTerm, wallpapers: searchResults),
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

  @override
  void initState() {
    super.initState();
    fetchCategories();
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
      body: Column(
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
                return SizedBox(
                  height: 100,
                  width: 100,
                  child: ElevatedButton(
                    onPressed: () {
                      searchWallpapers(categories[index].CategorieName);
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                    ),
                    child: CategoriesTile(
                      title: categories[index].CategorieName,
                      imgUrl: categories[index].ImgUrl,
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 50),
          Container(
            height: 70,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.grey[300],
            ),
            padding: EdgeInsets.symmetric(horizontal: 24),
            margin: EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      hintText: "Search Wallpaper",
                      border: InputBorder.none,
                    ),
                    onSubmitted: (value) {
                      addToSearchHistory(value);
                      searchWallpapers(value);
                    },
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    final searchTerm = searchController.text;
                    addToSearchHistory(searchTerm);
                    searchWallpapers(searchTerm);
                  },
                  child: Icon(Icons.search),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Search History',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Expanded(
                    child: ListView.builder(
                      itemCount: searchHistory.length,
                      itemBuilder: (context, index) {
                        final history = searchHistory[index];
                        return Card(
                          margin: EdgeInsets.only(bottom: 8),
                          child: ListTile(
                            title: Text(history),
                            trailing: IconButton(
                              icon: Icon(Icons.close),
                              onPressed: () {
                                removeFromSearchHistory(history);
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
