void main(){
  String inputString = '1-5-1,2-10-2,3-25-1,4-268-2';
  var splitVal = inputString.split(",");
  print("splited comma val$splitVal");
  List<List<int>> resultList = [];

  for (String pair in splitVal) {
    List<int> values = pair.split('-').map((value) => int.parse(value)).toList();
    resultList.add(values);
  }
  print(resultList);
}