import 'dart:convert';

void prettyPrintJsonEncodedString(String jsonString) {
    var jsonObject = jsonDecode(jsonString);
    var prettyString = JsonEncoder.withIndent('  ').convert(jsonObject);
    print(prettyString);
}