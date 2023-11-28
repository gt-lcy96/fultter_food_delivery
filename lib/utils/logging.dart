import 'dart:convert';

void prettyPrintJsonEncodedString(String jsonString) {
    var jsonObject = jsonDecode(jsonString);
    var prettyString = JsonEncoder.withIndent('  ').convert(jsonObject);
    print(prettyString);
}

void prettyPrintJsonEncodedStringList(List<String> jsonStringList) {
  for(var i=0; i< jsonStringList!.length; i++) {      
      prettyPrintJsonEncodedString(jsonStringList[i]);
    }
}