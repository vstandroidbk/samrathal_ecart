import 'logic/services/formatter.dart';

void main() {
  String inputString = '1 - 5 - 1';
  var splitVal = inputString.split(",");
  print("splited comma val$splitVal");
  List<List<int>> resultList = [];

  for (String pair in splitVal) {
    List<int> values =
        pair.split('-').map((value) => int.parse(value)).toList();
    resultList.add(values);
  }
  print("total order price ${getTotalAmount(resultList)}");
  print(resultList);
}

num getTotalAmount(List<List<int>> resultList) {
  var retailPrice = 5000;
  var wholePrice = 4000;
  var minWholeSaleTon = 5;
  num totalQty = 0;
  num totalPrice = 0;
  for (var size in resultList) {
    if (size[2] == 1) {
      totalQty = totalQty += (size[1] * 1000);
    } else {
      totalQty = totalQty += size[1];
    }
  }
  num qtyInTon = totalQty / 1000;
  if (qtyInTon >= minWholeSaleTon) {
    totalPrice = wholePrice * qtyInTon;
  } else {
    totalPrice = retailPrice * qtyInTon;
  }
  print("total quantity ${totalQty / 1000}");
  return totalPrice;
}
