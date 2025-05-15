import 'package:flutter/material.dart';
import 'package:shc/appointment_page/appointment_page.dart';
import 'package:shc/login_page/login_page.dart';
import 'package:shc/home_page/home_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:shc/forms/medical.dart';
import 'package:intl/intl.dart';
import 'package:shc/patient_page/medical_page.dart';

class PatientsPage extends StatefulWidget {
  @override
  _PatientListPageState createState() => _PatientListPageState();
}

class _PatientListPageState extends State<PatientsPage> {
 late Future<List<Map<String, dynamic>>> _patientsFuture;

  @override
  void initState() {
    super.initState();
    _patientsFuture = _fetchPatients();
  }

  Future<List<Map<String, dynamic>>> _fetchPatients() async {
    final response = await Supabase.instance.client
        .from('patient')
        .select('patient_id, patient_number, first_name, middle_name, last_name, civil_status, sex, birthday');

    return (response as List).cast<Map<String, dynamic>>();
  }

  void _viewDetails(String patientId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => MedicalHistoryPage(patientId: patientId),
      ),
    );
  }


  Widget _buildHeaderCell(String text) {
    return Center(
      child: Container(
        height: 50,
        alignment: Alignment.center,
        color: const Color.fromARGB(255, 241, 241, 241),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 15,
            fontFamily: 'OpenSansEB',
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  Widget _buildDataCell(String text) {
    return Center(
      child: Container(
        alignment: Alignment.center,
        color: Colors.white,
        height: 55,
        child: Text(
          text,
          style: TextStyle(
            fontFamily: 'OpenSansLight',
            fontWeight: FontWeight.bold,
            fontSize: 15,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: screenWidth * 1,
          height: screenHeight * 1,
          color: Color.fromARGB(255, 255, 245, 245),
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
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.05,
                              ),
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
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => PatientsPage(),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      'Patients',
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
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => AppointmentPage(),
                                        ),
                                      );
                                    },
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
                                      MaterialPageRoute(
                                        builder: (context) => AdminLoginPage(),
                                      ),
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
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          color: const Color.fromARGB(255, 255, 245, 245),
                          height: MediaQuery.of(context).size.height,
                          width: screenWidth * 0.7,
                          child: Column(
                            children: [
                              SizedBox(height: screenHeight * 0.02),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Patients',
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
                              Center(
                                child: Container(
          color: const Color.fromARGB(255, 255, 245, 245),
          padding: const EdgeInsets.all(8.0),
          child: FutureBuilder<List<Map<String, dynamic>>>(
            future: _patientsFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }

              final patients = snapshot.data ?? [];
              if (patients.isEmpty) {
                return Center(child: Text('No patients found.'));
              }

              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Table(
                    border: TableBorder.all(color: Colors.black),
                    columnWidths: {
                      0: FixedColumnWidth(screenWidth * 0.1),
                      1: FixedColumnWidth(screenWidth * 0.2),
                      2: FixedColumnWidth(screenWidth * 0.1),
                      3: FixedColumnWidth(screenWidth * 0.1),
                      4: FixedColumnWidth(screenWidth * 0.15),
                    },
                    children: [
                      TableRow(
                        decoration: BoxDecoration(color: Colors.grey[300]),
                        children: [
                          _buildHeaderCell('Patient ID'),
                          _buildHeaderCell('Patient Name'),
                          _buildHeaderCell('Birthday'),
                          _buildHeaderCell('Civil Status'),
                          _buildHeaderCell('Action'),
                        ],
                      ),
                      ...patients.map((p) {
                        final fullName =
                            '${p['first_name'] ?? ''} ${p['middle_name'] ?? ''} ${p['last_name'] ?? ''}'.trim();
                        final birthday = p['birthday'] != null
                            ? DateFormat('yyyy-MM-dd').format(DateTime.parse(p['birthday']))
                            : 'N/A';

                        return TableRow(
                          children: [
                            _buildDataCell(p['patient_id']?.toString() ?? ''),
                            _buildDataCell(fullName),
                            _buildDataCell(birthday),
                            _buildDataCell(p['civil_status']?.toString() ?? 'N/A'),

                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ElevatedButton(
                                onPressed: () => _viewDetails(p['patient_id']),
                                child: Text('View Details'),
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
                              ),
                              SizedBox(height: screenHeight * 0.02),
                              Center(
                                child: SizedBox(
                                      width: screenWidth * 0.15,
                                      height: screenHeight * 0.06,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.push(
						context,
						MaterialPageRoute(builder: (context) => MedicalRecord()),
					);
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: const Color.fromRGBO(247, 198, 226, 1),
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 20,
                                            vertical: 12,
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              5,
                                            ),
                                            side: BorderSide(
                                              color: Colors.green.shade900,
                                              width: 2,
                                            ), // Border
                                          ),
                                        ),
                                        child: Text(
                                          'Medical History Form',
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                              )
                            ],
                          ),
                        ),
                      ],
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
