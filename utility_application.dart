import 'dart:io';
import 'dart:convert';

// String Manipulation Functions
String concatenateStrings(String str1, String str2) => str1 + str2;
String reverseString(String str) => str.split('').reversed.join();
String changeCase(String str, bool toUpperCase) =>
    toUpperCase ? str.toUpperCase() : str.toLowerCase();

// File Handling Functions
void writeFile(String filename, String content) async {
  final file = File(filename);
  await file.writeAsString(content, mode: FileMode.append);
  print('Data written to $filename');
}

String readFile(String filename) {
  try {
    final file = File(filename);
    return file.readAsStringSync();
  } catch (e) {
    return 'Error reading file: $e';
  }
}

// Date and Time Functions
String getCurrentTimestamp() {
  final now = DateTime.now();
  return now.toIso8601String();
}

String calculateDateDifference(String date1, String date2) {
  final d1 = DateTime.parse(date1);
  final d2 = DateTime.parse(date2);
  final difference = d2.difference(d1);
  return '${difference.inDays} days';
}

// Main Application
void main() {
  final results = <String, String>{}; // Using a map to store input and processed results.
  final uniqueInputs = <String>{}; // A set for unique user inputs.
  final inputHistory = <String>[]; // A list to store all user inputs.

  while (true) {
    print('Enter a string (or type "exit" to quit):');
    final input = stdin.readLineSync();

    if (input == null || input.toLowerCase() == 'exit') {
      break;
    }

    inputHistory.add(input);
    uniqueInputs.add(input);

    print('Choose an operation: 1. Concatenate, 2. Reverse, 3. Change Case');
    final choice = stdin.readLineSync();

    if (choice == null) continue;

    String result;
    switch (choice) {
      case '1':
        print('Enter another string:');
        final secondInput = stdin.readLineSync() ?? '';
        result = concatenateStrings(input, secondInput);
        break;
      case '2':
        result = reverseString(input);
        break;
      case '3':
        print('Uppercase? (yes/no):');
        final toUpperCase = (stdin.readLineSync() ?? '').toLowerCase() == 'yes';
        result = changeCase(input, toUpperCase);
        break;
      default:
        print('Invalid choice!');
        continue;
    }

    results[input] = result;
    print('Result: $result');
    print('Logged at: ${getCurrentTimestamp()}');
    writeFile('results.log', '$input -> $result (Logged at: ${getCurrentTimestamp()})\n');
  }

  print('\n--- Summary ---');
  print('All inputs: $inputHistory');
  print('Unique inputs: $uniqueInputs');
  print('Results: $results');

  // Display time difference example
  print('\nEnter two dates (YYYY-MM-DD):');
  final date1 = stdin.readLineSync() ?? '';
  final date2 = stdin.readLineSync() ?? '';
  if (date1.isNotEmpty && date2.isNotEmpty) {
    print('Difference: ${calculateDateDifference(date1, date2)}');
  }
}
