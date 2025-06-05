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
  List<dynamic> appointments = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchAppointments();
  }

  Future<void> fetchAppointments() async {
    final response = await supabase
        .from('appointment')
        .select()
        .order('appointment_date', ascending: true);

    setState(() {
      appointments = response;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    Widget buildHeaderCell(String text) {
      return Container(
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
      );
    }

    Widget buildDataCell(String text) {
      return Container(
        alignment: Alignment.center,
        color: Colors.white,
        height: 50,
        child: Text(
          text,
          style: TextStyle(
            fontFamily: 'OpenSansLight',
            fontWeight: FontWeight.bold,
            fontSize: 15,
            color: Colors.black,
          ),
        ),
      );
    }

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
                    hintText: 'Search...',
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: screenHeight * 0.05),

          // This was incorrectly labeled as `body:`
          Expanded(
            child: isLoading
                ? Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Table(
                        border: TableBorder.all(color: Colors.black),
                        columnWidths: {
                          0: FixedColumnWidth(screenWidth * 0.15),
                          1: FixedColumnWidth(screenWidth * 0.15),
                          2: FixedColumnWidth(screenWidth * 0.1),
                          3: FixedColumnWidth(screenWidth * 0.1),
                          4: FixedColumnWidth(screenWidth * 0.1),
                          5: FixedColumnWidth(screenWidth * 0.1),
                        },
                        children: [
                          // Header Row
                          TableRow(
                            decoration:
                                BoxDecoration(color: Colors.grey[300]),
                            children: [
                              buildHeaderCell('Patient ID'),
                              buildHeaderCell('Appointment Date'),
                              buildHeaderCell('Type'),
                              buildHeaderCell('Purpose'),
                              buildHeaderCell('Note'),
                              buildHeaderCell('Action'),
                            ],
                          ),
                          // Dynamic Rows
                          ...appointments.map((appointment) {
                            return TableRow(
                              children: [
                                buildDataCell(
                                    appointment['patient_id'] ?? 'N/A'),
                                buildDataCell(
                                    appointment['appointment_date'] ?? 'N/A'),
                                buildDataCell(
                                    appointment['type_of_patient'] ?? 'N/A'),
                                buildDataCell(
                                    appointment['purpose'] ?? 'N/A'),
                                buildDataCell(appointment['note'] ?? 'N/A'),
                                Container(
                                  alignment: Alignment.center,
                                  height: 50,
                                  color: Colors.white,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      IconButton(
                                        icon: Icon(Icons.check,
                                            color: Colors.green),
                                        onPressed: () {
                                          // Confirm logic
                                        },
                                      ),
                                      SizedBox(width: 8),
                                      IconButton(
                                        icon:
                                            Icon(Icons.clear, color: Colors.red),
                                        onPressed: () {
                                          // Reject logic
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          }),
                        ],
                      ),
                    ),
                  ),
          ),
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
