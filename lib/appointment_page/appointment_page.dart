import 'package:flutter/material.dart';
import 'package:shc/home_page/home_page.dart';
import 'package:shc/login_page/login_page.dart';
import 'package:shc/patient_page/patient_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AppointmentPage extends StatefulWidget {
  const AppointmentPage({super.key});

  @override
  _AppointmentPageState createState() => _AppointmentPageState();
}

class _AppointmentPageState extends State<AppointmentPage> {
  final supabase = Supabase.instance.client;
  List<Map<String, dynamic>> appointments = [];
  List<Map<String, dynamic>> filteredAppointments = [];
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    fetchAppointments();
  }

  Future<void> fetchAppointments() async {
    final response = await supabase
        .from('appointment')
        .select('id, appointment_date, type_of_patient, purpose, status, patient_id, patient (patient_number)')
        .order('appointment_date', ascending: true);

    final List<Map<String, dynamic>> data = List<Map<String, dynamic>>.from(response);

    setState(() {
      appointments = data;
      filteredAppointments = appointments;
    });
  }

  void filterSearch(String query) {
    final lowerQuery = query.toLowerCase();
    setState(() {
      searchQuery = query;
      filteredAppointments = appointments.where((appointment) {
        final patientNumber = appointment['patient']?['patient_number']?.toString().toLowerCase() ?? '';
        return patientNumber.contains(lowerQuery);
      }).toList();
    });
  }

  void handleCheckAction(int appointmentId) async {
    await supabase
        .from('appointment')
        .update({'status': 'Checked'})
        .eq('id', appointmentId);
    fetchAppointments();
  }

  void handleCrossAction(int appointmentId) async {
    await supabase
        .from('appointment')
        .update({'status': 'Cancelled'})
        .eq('id', appointmentId);
    fetchAppointments();
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
                                          builder: (context) => AppointmentPage(),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      'Appointments',
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
  children: [
    Container(
      color: const Color.fromARGB(255, 255, 245, 245),
      height: MediaQuery.of(context).size.height,
      width: screenWidth * 0.7,
      child: Column(
        children: [
          SizedBox(height: screenHeight * 0.02),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Appointment',
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
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    hintText: 'Search Patient ID',
                  ),
                  onChanged: filterSearch,
                ),
              ),
            ],
          ),
          SizedBox(height: screenHeight * 0.05),

            Center(
              child: Container(
                height: screenHeight * 0.7,
                width: screenWidth * 0.65,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Table(
                      border: TableBorder.all(color: Colors.black12),
                      columnWidths: {
                        0: FixedColumnWidth(screenWidth * 0.1), // Patient ID
                        1: FixedColumnWidth(screenWidth * 0.15), // Appointment Date
                        2: FixedColumnWidth(screenWidth * 0.13), // Type of Patient
                        3: FixedColumnWidth(screenWidth * 0.1), // Purpose
                        4: FixedColumnWidth(screenWidth * 0.13), // Action
                      },
                      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                      children: [
                        // Header row
                        TableRow(
                          decoration: const BoxDecoration(color: Color(0xFFE0E0E0)),
                          children: [
                            Center(child: Padding(padding: EdgeInsets.all(8), child: Text('Patient ID', style: TextStyle(fontFamily: 'OpenSansEB', fontSize: 18)))),
                            Center(child: Padding(padding: EdgeInsets.all(8), child: Text('Appointment Date', style: TextStyle(fontFamily: 'OpenSansEB', fontSize: 18)))),
                            Center(child: Padding(padding: EdgeInsets.all(8), child: Text('Type of Patient', style: TextStyle(fontFamily: 'OpenSansEB', fontSize: 18)))),
                            Center(child: Padding(padding: EdgeInsets.all(8), child: Text('Purpose', style: TextStyle(fontFamily: 'OpenSansEB', fontSize: 18)))),
                            Center(child: Padding(padding: EdgeInsets.all(8), child: Text('Action', style: TextStyle(fontFamily: 'OpenSansEB', fontSize: 18)))),
                          ],
                        ),

                        // Data rows
                        for (var appointment in filteredAppointments)
                          TableRow(
                            decoration: const BoxDecoration(color: Colors.white),
                            children: [
                              Center(child: Padding(padding: EdgeInsets.all(8), child: Text(appointment['patient']?['patient_number'] ?? 'N/A', style: TextStyle(fontFamily: 'OpenSansSB', fontSize: 15)))),
                              Center(child: Padding(padding: EdgeInsets.all(8), child: Text(appointment['appointment_date'] ?? '', style: TextStyle(fontFamily: 'OpenSansSB', fontSize: 15)))),
                              Center(child: Padding(padding: EdgeInsets.all(8), child: Text(appointment['type_of_patient'] ?? '', style: TextStyle(fontFamily: 'OpenSansSB', fontSize: 15)))),
                              Center(child: Padding(padding: EdgeInsets.all(8), child: Text(appointment['purpose'] ?? '', style: TextStyle(fontFamily: 'OpenSansSB', fontSize: 15)))),
                              Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.check, color: Colors.green),
                                      onPressed: () => handleCheckAction(appointment['id']),
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.clear, color: Colors.red),
                                      onPressed: () => handleCrossAction(appointment['id']),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            )


        ],
      ),
    ),
  ],
)

                        
                      
                    
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
