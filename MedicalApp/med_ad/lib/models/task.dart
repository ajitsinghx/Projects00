class Task{
  int? id;
  String? medicine;
  String? dosage;
  int? isCompleted;
  String? date;
  String? startTime;
  String? endTime;
  int? color;
  int? remind;
  String? repeat;

  Task({
    this.id,
    this.medicine,
    this.dosage,
    this.isCompleted,
    this.date,
    this.startTime,
    this.endTime,
    this.color,
    this.remind,
    this.repeat,
  });

  Task.fromJson(Map<String, dynamic> json){
    id =json['id'];
    medicine = json['medicine'];
    dosage = json['dosage'];
    isCompleted = json['isCompleted'];
    date = json['date'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    color = json['color'];
    remind = json['remind'];
    repeat = json['repeat'];

  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] =this.id;
    data['medicine'] =this.medicine;
    data['date'] =this.date;
    data['dosage'] =this.dosage;
    data['isCompleted'] =this.isCompleted;
    data['startTime'] =this.startTime;
    data['endTime'] =this.endTime;
    data['color'] =this.color;
    data['remind'] =this.remind;
    data['repeat'] =this.repeat;
    return data;
  }

   
 

}