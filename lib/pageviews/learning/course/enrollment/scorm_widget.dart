// import 'package:flutter/material.dart';
// import 'package:scorm/scorm.dart';
//
// class ScormWidget extends StatefulWidget {
//   @override
//   _ScormWidgetState createState() => _ScormWidgetState();
// }
//
// class _ScormWidgetState extends State<ScormWidget> {
//   ScormVersion _version;
//   bool _foundApi = false;
//   String _value;
//   String _enteredValue = "";
//   String _key = "cmi.";
//   String _lastError;
//   String _lastErrorString;
//   String _diagnosticMessage;
//
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: SingleChildScrollView(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             DropdownButton<ScormVersion>(
//               value: _version,
//               items: [
//                 DropdownMenuItem(child: Text("Auto"), value: null),
//                 DropdownMenuItem(child: Text("v2004"), value: ScormVersion.v2004),
//                 DropdownMenuItem(child: Text("v1.2"), value: ScormVersion.v1_2),
//               ],
//               onChanged: (newVersion) => setState(() => _version = newVersion),
//               hint: Text("Auto"),
//             ),
//             RaisedButton(
//               onPressed: () {
//                 setState(() {
//                   _foundApi = ScormAPI.findApi(version: _version);
//                 });
//               },
//               child: Text("Find API"),
//             ),
//             SizedBox(height: 10),
//             RaisedButton(onPressed: _foundApi ? () => ScormAPI.initialize() : null, child: Text('Init')),
//             SizedBox(height: 10),
//             TextField(
//               controller: TextEditingController(text: _key),
//               onChanged: (newKey) => _key = newKey,
//               decoration: InputDecoration(labelText: "Key"),
//             ),
//             TextField(
//               controller: TextEditingController(text: _enteredValue),
//               onChanged: (newValue) => _enteredValue = newValue,
//               decoration: InputDecoration(labelText: "Value"),
//             ),
//             SizedBox(height: 10),
//             RaisedButton(onPressed: _foundApi ? () => ScormAPI.setValue(_key, _enteredValue) : null, child: Text('Set Value')),
//             SizedBox(height: 10),
//             Text(_value ?? "null"),
//             SizedBox(height: 5),
//             RaisedButton(onPressed: _foundApi ? () => setState(() => _value = ScormAPI.getValue(_key)) : null, child: Text('Get Value')),
//             SizedBox(height: 10),
//             Text("Error Code: ${_lastError ?? "null"}"),
//             SizedBox(height: 5),
//             Text("Error String: ${_lastErrorString ?? "null"}"),
//             SizedBox(height: 5),
//             Text("Diagnostic Message: ${_diagnosticMessage ?? "null"}"),
//             SizedBox(height: 5),
//             RaisedButton(
//               onPressed: _foundApi
//                   ? () => setState(() {
//                 _lastError = ScormAPI.getLastError();
//                 _lastErrorString = ScormAPI.getErrorString(_lastError);
//                 _diagnosticMessage = ScormAPI.getDiagnosticMessage(_lastError);
//               })
//                   : null,
//               child: Text('Get Last Error'),
//             ),
//             SizedBox(height: 10),
//             RaisedButton(onPressed: _foundApi ? () => ScormAPI.commit() : null, child: Text('Commit')),
//             SizedBox(height: 10),
//             RaisedButton(onPressed: _foundApi ? () => ScormAPI.finish() : null, child: Text('Finish')),
//             SizedBox(height: 10),
//             Visibility(visible: ScormAPI.apiFound, child: Text(ScormAPI.version.toString())),
//           ],
//         ),
//       ),
//     );
//   }
// }