import 'dart:core';
import 'dart:developer';
import 'package:flutter/foundation.dart';

void main() {
  // String inputString = '1 - 5 - 1';
  // var splitVal = inputString.split(",");
  // print("split comma val$splitVal");
  // List<List<int>> resultList = [];
  //
  // for (String pair in splitVal) {
  //   List<int> values =
  //       pair.split('-').map((value) => int.parse(value)).toList();
  //   resultList.add(values);
  // }
  // print("total order price ${getTotalAmount(resultList)}");
  // print(resultList);

  if (kDebugMode) {
    print(getFactOf(5));
  }
  log("fact of 5 :- ${getFact2(5)}");
  log("get return val 0 :- ${getVal(0)}");
  log("missing numbers [1, 2, 4, 6, 7, 9] : ${findMissingNumbers([1, 2, 4, 6, 7, 9])}");
  log("missing number [1, 2, 4, 6, 7, 9] ${findAMissingNumber([1, 2, 4, 5, 6, 7, 8, 9])}");
  log("max value of arr [1, 2, 4, 3, 7, 9, 8, 5] ${findMax([
        1,
        2,
        4,
        3,
        7,
        9,
        8,
        5
      ])}");
  log("min value of arr [1, 2, 4, 3, 7, 9, 8, 5] ${findMin([
        1,
        2,
        4,
        3,
        7,
        9,
        8,
        5
      ])}");
}

int findMin(List<int> arr) {
  int min = arr[0];
  for (int i = 0; i < arr.length; i++) {
    if (arr[i] < min) {
      min = arr[i];
    }
  }
  return min;
}

int findMax(List<int> arr) {
  int max = arr[0];
  for (int i = 0; i < arr.length; i++) {
    if (arr[i] > max) {
      max = arr[i];
    }
  }
  return max;
}

int findAMissingNumber(List<int> arr) {
  // arr.sort();
  int miss = 0;
  for (int i = arr.first; i < arr.last; i++) {
    if (!arr.contains(i)) {
      miss = i;
    }
  }
  return miss;
}

List<int> findMissingNumbers(List<int> arr) {
  arr.sort();
  List<int> miss = [];
  for (int i = arr.first; i < arr.last; i++) {
    if (!arr.contains(i)) {
      miss.add(i);
    }
  }
  return miss;
}

int getVal(int val) {
  return 1 - val;
}

int getFactOf(int num) {
  int fact = 1;
  for (int i = 1; i <= num; i++) {
    fact = fact * i;
  }
  return fact;
}

int getFact2(int num) {
  log("loop called");
  if (num == 1) {
    return 1;
  }
  return num * getFactOf(num - 1);
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
  log("total quantity ${totalQty / 1000}");
  return totalPrice;
}
