import 'package:flutter/material.dart';
import 'package:shc/appointment_page/appointment_page.dart';
import 'package:shc/login_page/login_page.dart';
import 'package:shc/home_page/home_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:shc/forms/medical.dart';
import 'package:shc/patient_page/personal_information.dart';

class PatientsPage extends StatefulWidget {
  const PatientsPage({super.key});

  @override
  _PatientListPageState createState() => _PatientListPageState();
}

class _PatientListPageState extends State<PatientsPage> {
  final supabase = Supabase.instance.client;

  List<dynamic> _allPatients = [];
  List<dynamic> _filteredPatients = [];
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _fetchPatients();
  }

  Future<void> _fetchPatients() async {
    final response = await supabase
        .from('patient')
        .select()
        .order('patient_number', ascending: true);

    setState(() {
      _allPatients = response;
      _filteredPatients = response;
    });
  }

  void _filterPatients(String query) {
    final filtered = _allPatients.where((patient) {
      final fullName = _formatFullName(patient).toLowerCase();
      final patientNumber = patient['patient_number']?.toLowerCase() ?? '';
      final search = query.toLowerCase();

      return fullName.contains(search) || patientNumber.contains(search);
    }).toList();

    setState(() {
      _searchQuery = query;
      _filteredPatients = filtered;
    });
  }

  String _formatFullName(Map patient) {
    final first = patient['first_name'] ?? '';
    final middle = patient['middle_name'] == 'N/A' ? '' : patient['middle_name'] ?? '';
    final last = patient['last_name'] ?? '';
    final suffix = patient['suffix'] == 'N/A' ? '' : patient['suffix'] ?? '';
    return '$first ${middle.isNotEmpty ? '$middle ' : ''}$last ${suffix.isNotEmpty ? suffix : ''}'.trim();
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
                                        hintText: 'Search Patient ID or Name',
                                      ),
                                      onChanged: _filterPatients,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: screenHeight * 0.03),
                              Center(
                                child: Container(
                                  height: screenHeight * 0.75,
                                  width: screenWidth * 0.7,
                                  padding: const EdgeInsets.all(8.0),
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: ConstrainedBox(
                                      constraints: BoxConstraints(
                                        maxHeight: screenHeight * 0.55,
                                      ),
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.vertical,
                                        child: Table(
                                          border: TableBorder.all(color: Colors.black12),
                                          columnWidths: {
                                            0: FixedColumnWidth(screenWidth * 0.12),
                                            1: FixedColumnWidth(screenWidth * 0.2),
                                            2: FixedColumnWidth(screenWidth * 0.1),
                                            3: FixedColumnWidth(screenWidth * 0.1),
                                            4: FixedColumnWidth(screenWidth * 0.15),
                                          },
                                          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                                          children: [
                                            // Header Row
                                            TableRow(
                                              decoration: const BoxDecoration(color: Color(0xFFE0E0E0)),
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.all(8),
                                                  child: Center(
                                                  child: Text('Patient ID', style: TextStyle(fontFamily: 'OpenSansEB', fontSize: 18, fontWeight: FontWeight.bold)),
                                                ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.all(8),
                                                  child: Center(
                                                  child: Text('Patient Name', style: TextStyle(fontFamily: 'OpenSansEB', fontSize: 18, fontWeight: FontWeight.bold)),
                                                ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.all(8),
                                                  child: Center(
                                                  child: Text('Birthday', style: TextStyle(fontFamily: 'OpenSansEB', fontSize: 18, fontWeight: FontWeight.bold)),
                                                ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.all(8),
                                                  child: Center(
                                                  child: Text('Civil Status', style: TextStyle(fontFamily: 'OpenSansEB', fontSize: 18, fontWeight: FontWeight.bold)),
                                                ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.all(8),
                                                  child: Center(
                                                  child: Text('Action', style: TextStyle(fontFamily: 'OpenSansEB', fontSize: 18, fontWeight: FontWeight.bold)),
                                                ),
                                                ),
                                              ],
                                            ),
                                            // Patient Rows
                                            ..._filteredPatients.map((patient) {
                                              return TableRow(
                                                decoration: const BoxDecoration(color: Colors.white),
                                                children: [
                                                  Padding(
                                                      padding: const EdgeInsets.all(8),
                                                      child: Center(
                                                      child: Text(patient['patient_number'] ?? '', style: TextStyle(fontFamily: 'OpenSansSB', fontSize: 15)),
                                                      ),
                                                  ),
                                                  Padding(
                                                      padding: const EdgeInsets.all(8),
                                                      child: Center(
                                                      child: Text(_formatFullName(patient), style: TextStyle(fontFamily: 'OpenSansSB', fontSize: 15)),
                                                    ),
                                                  ),
                                                  Padding(
                                                      padding: const EdgeInsets.all(8),
                                                      child: Center(
                                                      child: Text(patient['birthday'] ?? '', style: TextStyle(fontFamily: 'OpenSansSB', fontSize: 15)),
                                                    ),
                                                  ),
                                                  Padding(
                                                      padding: const EdgeInsets.all(8),
                                                      child: Center(
                                                      child: Text(patient['civil_status'] ?? '', style: TextStyle(fontFamily: 'OpenSansSB', fontSize: 15)),
                                                    ),
                                                  ),
                                                  Container(
                                                    color: Colors.white,
                                                    child: Padding(
                                                      padding: const EdgeInsets.all(8),
                                                      child: ElevatedButton(
                                                        onPressed: () {
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder: (_) => MedicalHistoryPage(
                                                                patientId: patient['patient_id'],
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                        child: const Text('View Details'),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              );

                                            }).toList(),
                                          ],
                                        ),
                                      ),
                                    ),
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
                                            MaterialPageRoute(builder: (context) => AddMedicalRecord()),
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
                                          'Add New Patient',
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