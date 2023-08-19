import 'package:get/get.dart';
import 'package:users_list_app/controllers/users_controller.dart';

class InitDependenices implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UsersController());
  }
}
