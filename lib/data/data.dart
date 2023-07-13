import 'package:taswirti/models/categorie_model.dart';

List<CatModel> getCategories(){
List<CatModel> categories= [];
CatModel categorieModel = CatModel();

categorieModel.ImgUrl="https://cdn.pixabay.com/photo/2012/10/26/01/34/aircraft-63028_1280.jpg";
categorieModel.CategorieName="Aircrafts";
categories.add(categorieModel);
categorieModel=CatModel();

categorieModel.ImgUrl="https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885_1280.jpg";
categorieModel.CategorieName="Nature";
categories.add(categorieModel);
categorieModel=CatModel();

categorieModel.ImgUrl="https://cdn.pixabay.com/photo/2018/03/02/17/19/paris-3193674_1280.jpg";
categorieModel.CategorieName="Street";
categories.add(categorieModel);
categorieModel=CatModel();

categorieModel.ImgUrl="https://cdn.pixabay.com/photo/2016/11/19/14/00/code-1839406_1280.jpg";
categorieModel.CategorieName="Code";
categories.add(categorieModel);
categorieModel=CatModel();

categorieModel.ImgUrl="https://cdn.pixabay.com/photo/2019/07/07/14/03/fiat-500-4322521_1280.jpg";
categorieModel.CategorieName="Cars";
categories.add(categorieModel);
categorieModel=CatModel();
return categories ;
}