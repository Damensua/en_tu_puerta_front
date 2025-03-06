
import 'package:flutter/services.dart'show rootBundle;


class ServiceSchedule{
  ServiceSchedule(){
    loadData();
  }

  void loadData(){
    rootBundle.loadString('Data/Petition.json').then((value){
      //List datos = json.decode(value);
      print(value);
      });
    
  }

}


final serviceSchedule= ServiceSchedule();