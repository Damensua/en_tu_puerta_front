List<Map<String, dynamic>> data=[
    {
        "date": "2025-03-02",
        "day": "domingo",
        "available_slots": []
    },
    {
        "date": "2025-03-03",
        "day": "lunes",
        "available_slots": [
            "09:45",
            "10:42",
            "11:39",
            "12:36",
            "13:33",
            "14:30",
            "15:27",
            "16:24"
        ]
    },
    {
        "date": "2025-03-04",
        "day": "martes",
        "available_slots": [
            "09:45",
            "10:42",
            "11:39",
            "14:30",
            "15:27",
            "16:24"
        ]
    },
    {
        "date": "2025-03-05",
        "day": "miércoles",
        "available_slots": [
            
            "13:33",
            "14:30",
            "15:27",
            "16:24"
        ]
    }
];


class Info{
  
  Info(){
    getInfo();
  }

  List<String> dates = [];
  List<String> days = [];
  Map<String, List<dynamic>> availableSlotsMap = {};
  int daysShown=data.length;

void getInfo(){
  for (var entry in data) {
    // Add date and day to their respective lists
    dates.add(entry["date"]);
    days.add(entry["day"]);

    // Add date and available slots to the map
    availableSlotsMap[entry["date"]] = entry["available_slots"];
    print(availableSlotsMap);
  }
}

List<String> getDays(){
  return days;
}

List<String> getDates(){
  return dates;
}
int getDaysShown() {
  return daysShown;
}

Map<String, dynamic> getAvailableSlots() {
  return availableSlotsMap;
}
}