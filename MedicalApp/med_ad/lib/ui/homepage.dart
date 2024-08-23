import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:med_add/controllers/task_controller.dart';
import 'package:med_add/MyApp.dart';
import 'package:med_add/models/task.dart';
import 'package:med_add/services/notification_services.dart';
import 'package:med_add/services/theme_services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:med_add/ui/add_task_bar.dart';
import 'package:med_add/ui/theme.dart';
import 'package:med_add/ui/widgets/button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:med_add/ui/widgets/task_file.dart';
import 'package:med_add/services/notification_services.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime _selectedDate = DateTime.now();
  final _taskController = Get.put(TaskController());
  var notifyHelper;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    notifyHelper=NotifyHelper();
    notifyHelper.initializeNotification();
    notifyHelper.requestIOSPermissions();
    setState(() {
      print("I am here");
    });
  }

  @override
  Widget build(BuildContext context) {
    print("build method called");
    return Scaffold(
      appBar: _appBar(),
      backgroundColor: context.theme.backgroundColor,
      body: Column(
        children: [
          _addTaskBar(),
          _addDateBar(),
          SizedBox(height: 10,),
          _showTasks(),

        ],
      ),
    );
  }

    _showTasks(){
      return Expanded(
        child:Obx((){
          return ListView.builder(
            itemCount: _taskController.taskList.length,

            itemBuilder: (_, index){
              
              Task task = _taskController.taskList[index];
              print(task.toJson());
              if(task.repeat=='Daily') {
                DateTime date = DateFormat.jm().parse(task.startTime.toString());
                var myTime = DateFormat("HH:mm").format(date);
                notifyHelper.scheduledNotification(
                  int.parse(myTime.toString().split(":")[0]),
                  int.parse(myTime.toString().split(":")[1]),
                  task

                );
                return AnimationConfiguration.staggeredList(
                  position: index,
                  child: SlideAnimation(
                    child:FadeInAnimation(
                      child: Row(
                        children: [
                             GestureDetector(
                              onTap: (){
                                _showBottomSheet(context, task);
                              },
                              child: TaskTile(task),
                             )
                        ],
                        ),
                    )
                    ));
              
              }
              if(task.date==DateFormat.yMd().format(_selectedDate)){
                return AnimationConfiguration.staggeredList(
                  position: index,
                  child: SlideAnimation(
                    child:FadeInAnimation(
                      child: Row(
                        children: [
                             GestureDetector(
                              onTap: (){
                                _showBottomSheet(context, task);
                              },
                              child: TaskTile(task),
                             )
                        ],
                        ),
                    )
                    ));
              }
              else{
                return Container();
              }
              
          });
        }),
      );
    }


    _showBottomSheet(BuildContext context, Task task){
       Get.bottomSheet(
        Container(
           padding: const EdgeInsets.only(top: 4),
           height: task.isCompleted==1?
           MediaQuery.of(context).size.height*0.24:
           MediaQuery.of(context).size.height*0.32,
           color:Get.isDarkMode?darkGreyClr:Colors.white,
           child: Column(
            children: [
              Container(
                height: 6,
                width: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(120),
                  color:Get.isDarkMode?Colors.grey[600]:Colors.grey[300]
                ),
              ),
              Spacer(),
              task.isCompleted==1
              ?Container()
                  :_bottomSheetButton(
                    label:"Med Taken",
                    onTap:(){
                      _taskController.markTaskCompleted(task.id!);
                      _taskController.getTasks();
                      Get.back();
                    },
                    clr: primaryClr,
                    context:context,
                  ),
                  
                  _bottomSheetButton(
                    label:"Delete Med",
                    onTap:(){
                      _taskController.delete(task);
                      _taskController.getTasks();
                      Get.back();  
                    },
                    clr: Colors.red[400]!,
                    context:context,
                  ),
                  SizedBox(height: 17,),
                  _bottomSheetButton(
                    label:"Close",
                    onTap:(){
                      Get.back();  
                    },
                    clr: Colors.red[400]!,
                    isClose: true,
                    context:context,
                  ),
                   SizedBox(
                    height: 10,
                   ),
            ],
           ),
        ),
       );
    }
 
   _bottomSheetButton({
    required String label,
       required Function()? onTap,
       required Color clr,
       bool isClose=false,
       required BuildContext context,
   }){
     return GestureDetector(
      onTap:onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical:4),
        height: 55,
        width: MediaQuery.of(context).size.width*0.9,
        
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: isClose==true?Get.isDarkMode?Colors.grey[600]!:Colors.grey[300]!:clr
          ),
          borderRadius: BorderRadius.circular(20),
          color: isClose==true?Colors.transparent:clr,
        ),

        child: Center(
          child: Text(
            label,
            style: isClose?titleStyle:titleStyle.copyWith(color:Colors.white),
          ),
        ) ,

      ),
     );


   }

   _addDateBar(){
     return Container(
            margin: const EdgeInsets.only(top: 15,left: 20),
            child: DatePicker(
              DateTime.now(),
              height: 100,
              width: 80,
              initialSelectedDate: DateTime.now(),
              selectionColor: primaryClr,
              selectedTextColor: Colors.white,
              dateTextStyle: GoogleFonts.lato(
                textStyle: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color:Colors.grey[600],
              )
              ),
              dayTextStyle: GoogleFonts.lato(
                textStyle: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color:Colors.grey[600],
              )
              ),
              monthTextStyle: GoogleFonts.lato(
                textStyle: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color:Colors.grey[600],
              )
              ),
              onDateChange: (date){
                 setState(() {
                   _selectedDate=date;
                 });
              },
            ),
          );
   }


  _addTaskBar(){
    return Container(
            margin: const EdgeInsets.only(left:20, right: 20,top: 10 ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                // margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                   Text( DateFormat.yMMMMd().format(DateTime.now()),
                   style: subHeadingStyle,
                   ),
                   Text("Today",
                   style: headingStyle,
                   )
                  ],
                )
                ),
                MyButton(label: "+ Add Med", onTap: () async{
                  await Get.to(AddTaskPage());
                  _taskController.getTasks();
                  }
                )
              ],
            
            ),
          );
  }

  _appBar(){
  return AppBar(
    elevation: 0,
    backgroundColor: Colors.white70,
    leading: GestureDetector( 
      onTap: (){
            ThemeService().switchTheme();
            notifyHelper.displayNotification(
              title:"Theme Changed",
              body:Get.isDarkMode?"Activated light Theme":"Activated Dark Theme"
            );

            // notifyHelper.scheduledNotification();   

      },
      child: Icon(Get.isDarkMode ?Icons.wb_sunny_outlined:Icons.nightlight_round,
      size: 23,
      color:Get.isDarkMode ? Colors.black:Colors.black
      ),
    ),
    actions: [
      CircleAvatar(
        backgroundImage: AssetImage(
          "images/user1.jpg"
        ),
      ),
      SizedBox(width: 20,),
    ],
   
  );
}


}