import 'package:flutter/material.dart';
import 'package:kickweight/login.dart';
import 'package:flutter/services.dart';
import 'package:kickweight/register.dart';
import 'package:kickweight/bodyfat.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '3D Weight Tracker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(),
      routes: {
        '/results': (context) => const ResultsScreen(
              weightofuser: '',
              heightofuser: '',
              year: '',
            ),
        '/login': (context) => LoginPage(),
        '/bodyfat': (context) => const BodyFatCalculator(
              weightofuser: '',
              heightofuser: '',
            ),
        '/register': (context) => RegistrationPage(),
        '/second': (context) => const SecondPage(),
      },
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 2.0,
                ),
                child: Image.asset(
                  'images/logo.jpg',
                  width: 250,
                  height: 250,
                ),
              ),
              const SizedBox(height: 16),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Welcome',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    'to the 3D Weight Tracker',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                  onPrimary: Colors.white,
                ),
                child: const Text('Get Started'),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

class SecondPage extends StatefulWidget {
  const SecondPage({Key? key}) : super(key: key);

  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  final _formKey = GlobalKey<FormState>();

  String day = '';
  String month = '';
  String year = '';
  String selectedGender = '';
  String weightofuser = '';
  String heightofuser = '';

  List<String> days = List.generate(31, (index) => (index + 1).toString());
  List<String> months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];
  List<String> years =
      List.generate(100, (index) => (DateTime.now().year - index).toString());

  Widget buildDatePicker(List<String> items, String selectedItem,
      void Function(String?) onChanged) {
    return DropdownButtonFormField<String>(
      value: selectedItem,
      items: items.map((item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(item),
        );
      }).toList(),
      onChanged: onChanged,
      decoration: const InputDecoration(
        labelText: 'Select',
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'This field is required';
        }
        return null;
      },
    );
  }

  Widget buildGenderSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Gender', style: TextStyle(fontSize: 18)),
        RadioListTile<String>(
          title: const Text('Male'),
          value: 'Male',
          groupValue: selectedGender,
          onChanged: (String? value) => setState(() => selectedGender = value!),
        ),
        RadioListTile<String>(
          title: const Text('Female'),
          value: 'Female',
          groupValue: selectedGender,
          onChanged: (String? value) => setState(() => selectedGender = value!),
        ),
      ],
    );
  }

  Widget buildWeightField() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: 'Weight (kg)',
      ),
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly
      ],
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Weight is required';
        }
        return null;
      },
      onSaved: (value) {
        weightofuser = value!;
      },
    );
  }

  Widget buildHeightField() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: 'Height (cm)',
      ),
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly
      ],
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Height is required';
        }
        return null;
      },
      onSaved: (value) {
        heightofuser = value!;
      },
    );
  }

  Widget buildSaveButton() {
    return Container(
      width: double.infinity,
      height: 60,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      child: ElevatedButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            _formKey.currentState!.save();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BodyFatCalculator(
                  weightofuser: weightofuser,
                  heightofuser: heightofuser,
                ),
              ),
            );
          }
        },
        style: ElevatedButton.styleFrom(
          primary: Colors.blue,
          onPrimary: Colors.white,
        ),
        child: const Text(
          'SAVE',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Date of Birth'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Date of Birth', style: TextStyle(fontSize: 18)),
              Row(
                children: [
                  Expanded(
                    child: buildDatePicker(
                        days, day, (value) => setState(() => day = value!)),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: buildDatePicker(months, month,
                        (value) => setState(() => month = value!)),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: buildDatePicker(
                        years, year, (value) => setState(() => year = value!)),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              buildGenderSelector(),
              const SizedBox(height: 20),
              buildWeightField(),
              const SizedBox(height: 20),
              buildHeightField(),
              const Spacer(),
              buildSaveButton(),
            ],
          ),
        ),
      ),
    );
  }
}

class ResultsScreen extends StatelessWidget {
  final String weightofuser;
  final String heightofuser;
  final String year;

  const ResultsScreen({
    Key? key,
    required this.weightofuser,
    required this.heightofuser,
    required this.year,
  }) : super(key: key);

  double calculateBMI() {
    final double weight = double.tryParse(weightofuser) ?? 0.0;
    final double height = double.tryParse(heightofuser) ?? 0.0;
    return weight / ((height / 100) * (height / 100));
  }

  double calculateBFP() {
    final double yearvalue = double.tryParse(year) ?? 0.0;
    final age = 2023 - yearvalue;
    return (1.20 * calculateBMI()) + (0.23 * age) - 16.2;
  }

  @override
  Widget build(BuildContext context) {
    final double bmi = calculateBMI();
    final double bfp = calculateBFP();
    const double waistdiameter = 20.43;
    const double neckdiameter = 10.34;
    const double thighdiameter = 14.95;
    const double badge = 7.6;
    const double waist = 3.142 * waistdiameter;
    const double neck = 3.142 * neckdiameter;
    const double thigh = 3.142 * thighdiameter;

    return Scaffold(
      appBar: AppBar(title: const Text('Measurements')),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            _buildTextContainer('BMI: ${bmi.toStringAsFixed(2)}'),
            const SizedBox(height: 16),
            _buildTextContainer('BFP: ${bfp.toStringAsFixed(2)}'),
            const SizedBox(height: 16),
            _buildTextContainer('Waist: ${waist.toStringAsFixed(2)}'),
            const SizedBox(height: 16),
            _buildTextContainer('Neck: ${neck.toStringAsFixed(2)}'),
            const SizedBox(height: 16),
            _buildTextContainer('Thigh: ${thigh.toStringAsFixed(2)}'),
            const SizedBox(height: 16),
            _buildTextContainer('Badge: ${badge.toStringAsFixed(2)}'),
          ],
        ),
      ),
    );
  }

  Widget _buildTextContainer(String text) {
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 40),
      width: 300,
      height: 60,
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}
