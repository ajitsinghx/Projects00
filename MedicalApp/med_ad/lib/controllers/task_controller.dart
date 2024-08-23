import 'package:get/get.dart';
import 'package:med_add/db/db_helper.dart';
import 'package:med_add/models/task.dart';

class TaskController extends GetxController{

  @override
  void onReady(){
    super.onReady();
  }

  var taskList = <Task>[].obs;

  Future<int> addTask({Task? task}) async{
    return await DBHelper.insert(task);
  }

  // get all the data from table
  void getTasks() async {
    List<Map<String, dynamic>> tasks = await DBHelper.query();
    taskList.assignAll(tasks.map((data) => new Task.fromJson(data)).toList());
  }

  void delete(Task task){
    // var val =
    DBHelper.delete(task);
    getTasks();
    // print(val);
  }

  void markTaskCompleted(int id) async{
    await DBHelper.update(id);
    getTasks();
  }

}