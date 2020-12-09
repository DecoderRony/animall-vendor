import 'package:multi_image_picker/multi_image_picker.dart';

class ProductModel{
  String productName;
  String productDescription;
  double price;
  List<Asset> productImages;
  List<dynamic> imageUrls;
  var timestamp;

  ProductModel(
    {
      this.productName,
      this.productDescription,
      this.price,
      this.productImages,
      this.imageUrls,
      this.timestamp,
    }
  );
}