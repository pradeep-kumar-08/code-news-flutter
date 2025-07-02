// create list of category model
//will call that category model in the home page
// will show all the category in home page
import 'package:newswithme/models/category_model.dart';

List<CategoryModel> getCategories() {
  List<CategoryModel> category = [];
  CategoryModel categoryModel = new CategoryModel();
  categoryModel.cateoryName = "Business";
  categoryModel.image = "images/business.jpg";
  category.add(categoryModel);
  categoryModel = new CategoryModel();

  categoryModel.cateoryName = "Entertainment";
  categoryModel.image = "images/entertainment.jpg";
  category.add(categoryModel);
  categoryModel = new CategoryModel();

  categoryModel.cateoryName = "General";
  categoryModel.image = "images/general.jpg";
  category.add(categoryModel);
  categoryModel = new CategoryModel();

  categoryModel.cateoryName = "health";
  categoryModel.image = "images/health.jpg";
  category.add(categoryModel);
  categoryModel = new CategoryModel();

  categoryModel.cateoryName = "Sports";
  categoryModel.image = "images/sports.jpg";
  category.add(categoryModel);
  categoryModel = new CategoryModel();

  return category;
}
