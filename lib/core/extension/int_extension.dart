import 'package:mentalHealthManagement/ui/shared/size_fit.dart';

extension intFit on int {
  double get px {
    return WDXSizeFit.setPx(this.toDouble());
  }
}