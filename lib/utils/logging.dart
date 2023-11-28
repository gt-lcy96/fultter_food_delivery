import 'dart:convert';

void prettyPrintJsonDecodedItem(Map<String, dynamic> jsonObject) {
  var prettyString = JsonEncoder.withIndent('  ').convert(jsonObject);
  print(prettyString);
}

void prettyPrintJsonEncodedString(String jsonString) {
    var jsonObject = jsonDecode(jsonString);
    prettyPrintJsonDecodedItem(jsonObject);
}

void prettyPrintJsonEncodedStringList(List<String> jsonStringList) {
  for(var i=0; i< jsonStringList!.length; i++) {      
      prettyPrintJsonEncodedString(jsonStringList[i]);
    }
}