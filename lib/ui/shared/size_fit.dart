import 'dart:ui';

class WDXSizeFit {
  static double physicalWidth;
  static double dpr;
  static double screenWidth;
  static double statusHeight;

  static double px;

  static void initialize({standardSize=750}) {
    // 1. 手机物理分辨率
    physicalWidth = window.physicalSize.width;
    // 2. 获得dpr
    dpr = window.devicePixelRatio;
    // 3. 宽度和高度
    screenWidth = physicalWidth / dpr;
    // 5. 计算rpx的大小
    px = screenWidth / standardSize * 2;
  }

  static double setPx(double size) {
    return px * size;
  }
}