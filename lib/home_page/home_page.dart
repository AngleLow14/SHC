import 'package:flutter/material.dart';
import 'package:shc/login_page/login_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:shc/patient_page/patient_page.dart';
import 'package:shc/appointment_page/appointment_page.dart';
import 'package:shc/heat_map/heat_map.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<Dashboard> {
  final supabase = Supabase.instance.client;
  int maleCount = 0;
  int femaleCount = 0;
  int childrenCount = 0;
  int youthCount = 0;
  int adultCount = 0;
  int seniorCount = 0;
  
  int _activeCount = 0;
  bool isLoading = true;
  String? errorMessage;

@override
void initState() {
  super.initState();
  fetchSexDistribution();
  fetchCivilStatusCounts();
  fetchAndCategorizePatients();
  fetchActiveCount();
}

  int singleCount = 0;
  int marriedCount = 0;
  int annulledCount = 0;
  int widowedCount = 0;
  int liveInCount = 0;
  int separatedCount = 0;
  int otherCount = 0;

  Future<void> fetchCivilStatusCounts() async {
    try {
      final response = await supabase
          .from('patient')
          .select('civil_status');

      for (var record in response) {
        final status = (record['civil_status'] ?? '').toString().toLowerCase();

        switch (status) {
          case 'single':
            singleCount++;
            break;
          case 'married':
            marriedCount++;
            break;
          case 'annulled':
            annulledCount++;
            break;
          case 'widowed':
            widowedCount++;
            break;
          case 'live-in':
            liveInCount++;
            break;
          case 'separated':
            separatedCount++;
            break;
          default:
            otherCount++;
            break;
        }
      }

      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching civil status: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> fetchAndCategorizePatients() async {
    final supabase = Supabase.instance.client;

    try {
      final response = await supabase.from('patient').select('birthday');

      int children = 0;
      int youth = 0;
      int adult = 0;
      int senior = 0;

      final today = DateTime.now();

      for (final item in response) {
        if (item['birthday'] == null) continue;
        final birthday = DateTime.parse(item['birthday']);
        final age = today.year - birthday.year - ((today.month < birthday.month || (today.month == birthday.month && today.day < birthday.day)) ? 1 : 0);

        if (age <= 12) {
          children++;
        } else if (age <= 17) {
          youth++;
        } else if (age <= 59) {
          adult++;
        } else {
          senior++;
        }
      }

      setState(() {
        childrenCount = children;
        youthCount = youth;
        adultCount = adult;
        seniorCount = senior;
        isLoading = false;
      });
    } catch (e) {
      debugPrint('Error fetching patient data: $e');
      setState(() {
        isLoading = false;
      });
    }
  }


  Future<void> fetchSexDistribution() async {
    final data = await supabase
        .from('patient')
        .select('sex');

    setState(() {
      maleCount = data.where((item) => item['sex'] == 'Male').length;
      femaleCount = data.where((item) => item['sex'] == 'Female').length;
      isLoading = false;
    });
  }

 Future<void> fetchActiveCount() async {
    try {
      final response = await supabase
          .from('treatment_plan')
          .select('*', const FetchOptions(count: CountOption.exact))
          .eq('active', true)
          .execute();

      setState(() {
        _activeCount = response.count ?? 0;
      });
    } catch (e) {
      debugPrint('Error fetching active count: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Color.fromARGB(255, 255, 245, 245),
          height: screenHeight * 1,
          width: screenWidth * 1,
          child: Column(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Column(
                      children: [
                        Container(
                          color: const Color.fromARGB(255, 255, 251, 251),
                          height: screenHeight * 1,
                          width: screenWidth * 0.20,
                          child: Column(
                            children: [
                              SizedBox(height: screenHeight * 0.05),
                              Container(
                                height: screenHeight * 0.2,
                                width: screenWidth * 0.2,
                                padding: EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.grey,
                                ),
                                child: CircleAvatar(
                                  radius: 30,
                                  backgroundColor: Colors.transparent,
                                ),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.03,
                              ),
                              Center(
                                child: Text(
                                  'San Pablo Social Hygiene Clinic',
                                  softWrap: true,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontFamily: 'OpenSansEB',
                                    color: Color.fromARGB(255, 182, 8, 37),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.03,
                              ),
                              Center(
                                child: SizedBox(
                                  height: screenHeight * 0.05,
                                  width: screenWidth * 0.13,
                                  child: TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Dashboard(),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      'Dashboard',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontFamily: 'OpenSansEB',
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromARGB(255, 0, 0, 0),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: screenHeight * 0.02),
                              Center(
                                child: SizedBox(
                                  height: screenHeight * 0.05,
                                  width: screenWidth * 0.13,
                                  child: TextButton(
                                    onPressed: () {Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(builder: (context) => PatientsPage())
                                    );},
                                    child: Text(
                                      'Patients',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontFamily: 'OpenSansLight',
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromARGB(255, 43, 43, 43),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: screenHeight * 0.02),
                              Center(
                                child: SizedBox(
                                  height: screenHeight * 0.05,
                                  width: screenWidth * 0.13,
                                  child: TextButton(
                                    onPressed: () {Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(builder: (context) => AppointmentPage())
                                    );},
                                    child: Text(
                                      'Appointments',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontFamily: 'OpenSansLight',
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromARGB(255, 43, 43, 43),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: screenHeight * 0.20),
                              SizedBox(
                                  height: screenHeight * 0.05,
                                  width: screenWidth * 0.13,
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(builder: (context) => AdminLoginPage())
                                    );
                                  },
                                  child: Text(
                                    'Log Out',
                                    style: TextStyle(
                                      fontFamily: 'OpenSansLight',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      color: Color.fromARGB(255, 43, 43, 43),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: screenWidth * 0.05),
                    SingleChildScrollView(
                      child: Container(
                        color: Color.fromARGB(255, 255, 245, 245),
                        height: screenHeight,
                        width: screenWidth * 0.7,
                        child: Column(
                          children: [
                            SizedBox(
                              height: screenHeight * 0.02,
                              width: screenWidth * 0.03,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Dashboard',
                                  style: TextStyle(
                                    fontFamily: 'OpenSansEB',
                                    fontSize: 30,
                                    color: Color.fromARGB(255, 182, 8, 37),
                                  ),
                                ),

                                SizedBox(
                                  height: screenHeight * 0.06,
                                  width: screenWidth * 0.2,
                                  child: TextField(
                                    style: TextStyle(fontSize: 15),
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(
                                          10.0,
                                        ),
                                      ),
                                      hintText: 'Search...',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: screenHeight * 0.05),
                            SingleChildScrollView(
                              child: Container(
                                child: Row(
                                  children: [
                                    Column(
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              height: screenHeight * 0.30,
                                              width: screenWidth * 0.16,
                                              color: Colors.white,
                                              child: isLoading
                                                ? const CircularProgressIndicator()
                                                : errorMessage != null
                                                    ? Text(errorMessage!, style: const TextStyle(color: Colors.red))
                                                    :  Column(
                                                children: [
                                                  SizedBox(
                                                    height: screenHeight * 0.02,
                                                  ),
                                                  Text(
                                                    'STD Cases',
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                      fontSize: 25,
                                                      fontFamily: 'OpenSansSB',
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: screenHeight * 0.02,
                                                  ),
                                                  Text(
                                                   '$_activeCount',
                                                    style: TextStyle(
                                                      fontSize: 50,
                                                      fontFamily: 'OpenSansEB',
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(width: screenWidth * 0.01),
                                            Container(
                                              height: screenHeight * 0.30,
                                              width: screenWidth * 0.16,
                                              color: Colors.white,
                                              child: Column(
                                                children: [
                                                  SizedBox(
                                                    height: screenHeight * 0.02,
                                                  ),
                                                  Text(
                                                    'Sex',
                                                    style: TextStyle(
                                                      fontSize: 25,
                                                      fontFamily: 'OpenSansSB',
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: screenHeight * 0.03,
                                                  ),
                                                  Row(
                                                    children: [
                                                      SizedBox(
                                                        width:
                                                            screenWidth * 0.02,
                                                      ),
                                                      Text(
                                                        'Male',
                                                        style: TextStyle(
                                                          fontSize: 15,
                                                          fontFamily:
                                                              'OpenSansLight',
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),

                                                      SizedBox(
                                                        width:
                                                            screenWidth * 0.07,
                                                      ),
                                                      Text(
                                                        '$maleCount',
                                                        style: TextStyle(
                                                          fontSize: 15,
                                                          fontFamily:
                                                              'OpenSansLight',
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: screenHeight * 0.03,
                                                  ),
                                                  Row(
                                                    children: [
                                                      SizedBox(
                                                        width:
                                                            screenWidth * 0.02,
                                                      ),
                                                      Text(
                                                        'Female',
                                                        style: TextStyle(
                                                          fontSize: 15,
                                                          fontFamily:
                                                              'OpenSansLight',
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),

                                                      SizedBox(
                                                        width:
                                                            screenWidth * 0.06,
                                                      ),
                                                      Text(
                                                        '$femaleCount',
                                                        style: TextStyle(
                                                          fontSize: 15,
                                                          fontFamily:
                                                              'OpenSansLight',
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: screenHeight * 0.02),
                                        Column(
                                          children: [
                                            Container(
                                              height: screenHeight * 0.45,
                                              width: screenWidth * 0.33,
                                              color: Colors.white,
                                              child: GestureDetector(
                                                onTap: () {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(builder: (context) => HeatMap())
                                    );
                                  },
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    SizedBox(
                                                      height:
                                                          screenHeight * 0.005,
                                                    ),
                                                    Image.asset(
                                                      'assets/icon/assessment.PNG',
                                                      height: screenHeight * 0.42,
                                                      width: screenWidth * 0.32,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(width: screenWidth * 0.02),
                                    Row(
                                      children: [
                                        Column(
                                          children: [
                                            Container(
                                              height: screenHeight * 0.40,
                                              width: screenWidth * 0.16,
                                              color: Colors.white,
                                              child: Column(
                                                children: [
                                                  SizedBox(
                                                    height: screenHeight * 0.02,
                                                  ),
                                                  Text(
                                                    'Age Group',
                                                    style: TextStyle(
                                                      fontFamily: 'OpenSansSB',
                                                      fontSize: 25,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: screenHeight * 0.01,
                                                  ),
                                                  Row(
                                                    children: [
                                                      SizedBox(
                                                        width:
                                                            screenWidth * 0.03,
                                                      ),
                                                      Text(
                                                        'Children',
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'OpenSansLight',
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width:
                                                            screenWidth * 0.05,
                                                      ),
                                                      Text(
                                                        '$childrenCount',
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'OpenSansLight',
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      SizedBox(
                                                        width:
                                                            screenWidth * 0.03,
                                                      ),
                                                      Text(
                                                        'Youth',
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'OpenSansLight',
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width:
                                                            screenWidth * 0.06,
                                                      ),
                                                      Text(
                                                        '$youthCount',
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'OpenSansLight',
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      SizedBox(
                                                        width:
                                                            screenWidth * 0.03,
                                                      ),
                                                      Text(
                                                        'Adult',
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'OpenSansLight',
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width:
                                                            screenWidth * 0.065,
                                                      ),
                                                      Text(
                                                        '$adultCount',
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'OpenSansLight',
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      SizedBox(
                                                        width:
                                                            screenWidth * 0.03,
                                                      ),
                                                      Text(
                                                        'Senior Citizen',
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'OpenSansLight',
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width:
                                                            screenWidth * 0.02,
                                                      ),
                                                      Text(
                                                        '$seniorCount',
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'OpenSansLight',
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: screenHeight * 0.03,
                                                  ),
                                                  Center(
                                                    child: Text(
                                                      'Children (0-12)',
                                                      style: TextStyle(
                                                        fontFamily:
                                                            'OpenSansLight',
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height:
                                                        screenHeight * 0.005,
                                                  ),
                                                  Center(
                                                    child: Text(
                                                      'Youth (13-17)',
                                                      style: TextStyle(
                                                        fontFamily:
                                                            'OpenSansLight',
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height:
                                                        screenHeight * 0.005,
                                                  ),
                                                  Center(
                                                    child: Text(
                                                      'Adults (18-59)',
                                                      style: TextStyle(
                                                        fontFamily:
                                                            'OpenSansLight',
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height:
                                                        screenHeight * 0.005,
                                                  ),
                                                  Center(
                                                    child: Text(
                                                      'Senior Citizens (60 above)',
                                                      style: TextStyle(
                                                        fontFamily:
                                                            'OpenSansLight',
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: screenHeight * 0.03,
                                            ),
                                            Container(
                                              height: screenHeight * 0.35,
                                              width: screenWidth * 0.16,
                                              color: Colors.white,
                                              child: Column(
                                                children: [
                                                  SizedBox(
                                                    height: screenHeight * 0.02,
                                                  ),
                                                  Center(
                                                    child: Text(
                                                      'Civil Status',
                                                      style: TextStyle(
                                                        fontFamily:
                                                            'OpenSansSB',
                                                        fontSize: 25,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                                  Row(
                                                    children: [
                                                      SizedBox(
                                                        width:
                                                            screenWidth * 0.02,
                                                      ),
                                                      Text(
                                                        'Single',
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'OpenSansLight',
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width:
                                                            screenWidth * 0.075,
                                                      ),
                                                      Text(
                                                        '$singleCount',
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'OpenSansLight',
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      SizedBox(
                                                        width:
                                                            screenWidth * 0.02,
                                                      ),
                                                      Text(
                                                        'Married',
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'OpenSansLight',
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width:
                                                            screenWidth * 0.06,
                                                      ),
                                                      Text(
                                                        '$marriedCount',
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'OpenSansLight',
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      SizedBox(
                                                        width:
                                                            screenWidth * 0.02,
                                                      ),
                                                      Text(
                                                        'Widowed',
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'OpenSansLight',
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width:
                                                            screenWidth * 0.065,
                                                      ),
                                                      Text(
                                                        '$widowedCount',
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'OpenSansLight',
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      SizedBox(
                                                        width:
                                                            screenWidth * 0.02,
                                                      ),
                                                      Text(
                                                        'Separated',
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'OpenSansLight',
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width:
                                                            screenWidth * 0.055,
                                                      ),
                                                      Text(
                                                        '$separatedCount',
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'OpenSansLight',
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      SizedBox(
                                                        width:
                                                            screenWidth * 0.02,
                                                      ),
                                                      Text(
                                                        'Annulled',
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'OpenSansLight',
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width:
                                                            screenWidth * 0.065,
                                                      ),
                                                      Text(
                                                        '$annulledCount',
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'OpenSansLight',
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      SizedBox(
                                                        width:
                                                            screenWidth * 0.02,
                                                      ),
                                                      Text(
                                                        'Live-In',
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'OpenSansLight',
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black,
                                                        ),
                                                      ),

                                                      SizedBox(
                                                        width:
                                                            screenWidth * 0.07,
                                                      ),
                                                      Text(
                                                        '$liveInCount',
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'OpenSansLight',
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      SizedBox(
                                                        width:
                                                            screenWidth * 0.02,
                                                      ),
                                                      Text(
                                                        'Others',
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'OpenSansLight',
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black,
                                                        ),
                                                      ),

                                                      SizedBox(
                                                        width:
                                                            screenWidth * 0.075,
                                                      ),
                                                      Text(
                                                        '$otherCount',
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'OpenSansLight',
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(width: screenWidth * 0.01),
                                        Column(
                                          children: [
                                            Container(
                                              height: screenHeight * 0.80,
                                              width: screenWidth * 0.15,
                                              color: Colors.white,
                                              child: Column(
                                                children: [
                                                  SizedBox(
                                                    height: screenHeight * 0.03,
                                                  ),
                                                  Text(
                                                    'Cases Classification',
                                                    style: TextStyle(
                                                      fontFamily: 'OpenSansSB',
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 18,
                                                      color: Colors.black,
                                                    ),
                                                  ),

                                                  SizedBox(
                                                    height: screenHeight * 0.1,
                                                  ),
                                                  
                                                  SizedBox(
                                                    height: screenHeight * 0.1,
                                                  ),
                                                  Row(
                                                    children: [
                                                      SizedBox(
                                                        width:
                                                            screenWidth * 0.02,
                                                      ),
                                                      Container(
                                                        height: 15,
                                                        width: 15,

                                                        decoration:
                                                            BoxDecoration(
                                                              shape:
                                                                  BoxShape
                                                                      .circle,
                                                              color:
                                                                  Color.fromARGB(
                                                                    255,
                                                                    240,
                                                                    75,
                                                                    63,
                                                                  ),
                                                            ),
                                                        child: CircleAvatar(
                                                          radius: 20,
                                                          backgroundColor:
                                                              Colors
                                                                  .transparent,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width:
                                                            screenWidth * 0.01,
                                                      ),
                                                      Text(
                                                        'STD/STI 1',
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'OpenSansLight',
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 15,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width:
                                                            screenWidth * 0.01,
                                                      ),
                                                      Text(
                                                        '5',
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'OpenSansLight',
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 15,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ],
                                                  ),

                                                  SizedBox(
                                                    height: screenHeight * 0.02,
                                                  ),
                                                  Row(
                                                    children: [
                                                      SizedBox(
                                                        width:
                                                            screenWidth * 0.02,
                                                      ),
                                                      Container(
                                                        height: 15,
                                                        width: 15,
                                                        padding: EdgeInsets.all(
                                                          8.0,
                                                        ),
                                                        decoration:
                                                            BoxDecoration(
                                                              shape:
                                                                  BoxShape
                                                                      .circle,
                                                              color:
                                                                  Color.fromARGB(
                                                                    255,
                                                                    255,
                                                                    183,
                                                                    50,
                                                                  ),
                                                            ),
                                                        child: CircleAvatar(
                                                          radius: 30,
                                                          backgroundColor:
                                                              Colors
                                                                  .transparent,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width:
                                                            screenWidth * 0.01,
                                                      ),
                                                      Text(
                                                        'STD/STI 1',
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'OpenSansLight',
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 15,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width:
                                                            screenWidth * 0.01,
                                                      ),
                                                      Text(
                                                        '10',
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'OpenSansLight',
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 15,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ],
                                                  ),

                                                  SizedBox(
                                                    height: screenHeight * 0.02,
                                                  ),

                                                  Row(
                                                    children: [
                                                      SizedBox(
                                                        width:
                                                            screenWidth * 0.02,
                                                      ),
                                                      Container(
                                                        height: 15,
                                                        width: 15,

                                                        decoration:
                                                            BoxDecoration(
                                                              shape:
                                                                  BoxShape
                                                                      .circle,
                                                              color:
                                                                  Color.fromARGB(
                                                                    255,
                                                                    153,
                                                                    153,
                                                                    153,
                                                                  ),
                                                            ),
                                                        child: CircleAvatar(
                                                          radius: 30,
                                                          backgroundColor:
                                                              Colors
                                                                  .transparent,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width:
                                                            screenWidth * 0.01,
                                                      ),
                                                      Text(
                                                        'STD/STI 1',
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'OpenSansLight',
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 15,
                                                          color: Colors.black,
                                                        ),
                                                      ),

                                                      SizedBox(
                                                        width:
                                                            screenWidth * 0.01,
                                                      ),
                                                      Text(
                                                        '22',
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'OpenSansLight',
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 15,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ],
                                                  ),

                                                  SizedBox(
                                                    height: screenHeight * 0.02,
                                                  ),
                                                  Row(
                                                    children: [
                                                      SizedBox(
                                                        width:
                                                            screenWidth * 0.02,
                                                      ),
                                                      Container(
                                                        height: 15,
                                                        width: 15,

                                                        decoration:
                                                            BoxDecoration(
                                                              shape:
                                                                  BoxShape
                                                                      .circle,
                                                              color:
                                                                  Color.fromARGB(
                                                                    255,
                                                                    94,
                                                                    204,
                                                                    98,
                                                                  ),
                                                            ),
                                                        child: CircleAvatar(
                                                          radius: 30,
                                                          backgroundColor:
                                                              Colors
                                                                  .transparent,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width:
                                                            screenWidth * 0.01,
                                                      ),
                                                      Text(
                                                        'STD/STI 1',
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'OpenSansLight',
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 15,
                                                          color: Colors.black,
                                                        ),
                                                      ),

                                                      SizedBox(
                                                        width:
                                                            screenWidth * 0.01,
                                                      ),
                                                      Text(
                                                        '45',
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'OpenSansLight',
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 15,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ],
                                                  ),

                                                  SizedBox(
                                                    height: screenHeight * 0.02,
                                                  ),
                                                  Row(
                                                    children: [
                                                      SizedBox(
                                                        width:
                                                            screenWidth * 0.02,
                                                      ),
                                                      Container(
                                                        height: 15,
                                                        width: 15,

                                                        decoration:
                                                            BoxDecoration(
                                                              shape:
                                                                  BoxShape
                                                                      .circle,
                                                              color:
                                                                  Color.fromARGB(
                                                                    255,
                                                                    224,
                                                                    64,
                                                                    117,
                                                                  ),
                                                            ),
                                                        child: CircleAvatar(
                                                          radius: 30,
                                                          backgroundColor:
                                                              Colors
                                                                  .transparent,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width:
                                                            screenWidth * 0.01,
                                                      ),
                                                      Text(
                                                        'STD/STI 1',
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'OpenSansLight',
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 15,
                                                          color: Colors.black,
                                                        ),
                                                      ),

                                                      SizedBox(
                                                        width:
                                                            screenWidth * 0.01,
                                                      ),
                                                      Text(
                                                        '14',
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'OpenSansLight',
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 15,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
