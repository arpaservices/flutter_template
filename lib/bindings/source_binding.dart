
import 'package:get/get.dart';

import '../utils/network/DataSource.dart';



void bindingDataSource() =>
    Get.lazyPut<DataSourceClass>(() => DataSourceClass());