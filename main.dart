import 'package:flutter/material.dart';

void main() {
  runApp(const StudentGradeApp());
}

class StudentGradeApp extends StatelessWidget {
  const StudentGradeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Student Grade Calculator',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.indigo,
      ),
      home: const GradeCalculatorPage(),
    );
  }
}

class GradeCalculatorPage extends StatefulWidget {
  const GradeCalculatorPage({super.key});

  @override
  State<GradeCalculatorPage> createState() =>
      _GradeCalculatorPageState();
}

class _GradeCalculatorPageState extends State<GradeCalculatorPage> {
  final nameController = TextEditingController();
  final grade1Controller = TextEditingController();
  final grade2Controller = TextEditingController();
  final grade3Controller = TextEditingController();

  double? average;
  String result = '';
  String remarks = '';

  void calculateGrade() {
    final name = nameController.text.trim();
    final grade1 = double.tryParse(grade1Controller.text);
    final grade2 = double.tryParse(grade2Controller.text);
    final grade3 = double.tryParse(grade3Controller.text);

    if (name.isEmpty ||
        grade1 == null ||
        grade2 == null ||
        grade3 == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please complete all fields.'),
        ),
      );
      return;
    }

    if (grade1 < 0 ||
        grade1 > 100 ||
        grade2 < 0 ||
        grade2 > 100 ||
        grade3 < 0 ||
        grade3 > 100) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Grades must be between 0 and 100.'),
        ),
      );
      return;
    }

    setState(() {
      average = (grade1 + grade2 + grade3) / 3;

      if (average! >= 90) {
        result = 'PASSED';
        remarks = 'Excellent';
      } else if (average! >= 85) {
        result = 'PASSED';
        remarks = 'Very Good';
      } else if (average! >= 75) {
        result = 'PASSED';
        remarks = 'Good';
      } else {
        result = 'FAILED';
        remarks = 'Needs Improvement';
      }
    });
  }

  void clearFields() {
    nameController.clear();
    grade1Controller.clear();
    grade2Controller.clear();
    grade3Controller.clear();

    setState(() {
      average = null;
      result = '';
      remarks = '';
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    grade1Controller.dispose();
    grade2Controller.dispose();
    grade3Controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Student Grade Calculator',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

            // Header
            const Icon(
              Icons.school,
              size: 70,
              color: Colors.indigo,
            ),

            const SizedBox(height: 10),

            const Text(
              'Grade Management System',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 5),

            const Text(
              'Enter student information and grades',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),

            const SizedBox(height: 25),

            // Student Name
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Student Name',
                hintText: 'Enter student name',
                prefixIcon: const Icon(Icons.person),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 15),

            // Grade 1
            TextField(
              controller: grade1Controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Subject 1 Grade',
                hintText: 'Enter grade',
                prefixIcon: const Icon(Icons.book),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 15),

            // Grade 2
            TextField(
              controller: grade2Controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Subject 2 Grade',
                hintText: 'Enter grade',
                prefixIcon: const Icon(Icons.book),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 15),

            // Grade 3
            TextField(
              controller: grade3Controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Subject 3 Grade',
                hintText: 'Enter grade',
                prefixIcon: const Icon(Icons.book),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 25),

            // Calculate Button
            ElevatedButton.icon(
              onPressed: calculateGrade,
              icon: const Icon(Icons.calculate),
              label: const Text(
                'CALCULATE GRADE',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 10),

            // Clear Button
            OutlinedButton.icon(
              onPressed: clearFields,
              icon: const Icon(Icons.clear),
              label: const Text('CLEAR'),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 25),

            // Result Card
            if (average != null)
              Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      const Text(
                        'RESULT',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 15),

                      Text(
                        nameController.text,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      const SizedBox(height: 15),

                      Text(
                        average!.toStringAsFixed(2),
                        style: const TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Colors.indigo,
                        ),
                      ),

                      const Text(
                        'Average Grade',
                        style: TextStyle(color: Colors.grey),
                      ),

                      const SizedBox(height: 15),

                      Text(
                        result,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: result == 'PASSED'
                              ? Colors.green
                              : Colors.red,
                        ),
                      ),

                      const SizedBox(height: 5),

                      Text(
                        remarks,
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

            const SizedBox(height: 20),

            const Text(
              'Developed using Flutter & Dart',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
