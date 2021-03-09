import 'package:image_picker/image_picker.dart';

/// 获得图片
class WDXImage {
  static final picker = ImagePicker();

  /// 从相机获得图片
  static Future<PickedFile> getImageByCamera() async {
    return picker.getImage(source: ImageSource.camera);
  }
  /// 从相册中选择
  static Future<PickedFile> getImageByGallery() async{
    return picker.getImage(source: ImageSource.gallery);
  }
}