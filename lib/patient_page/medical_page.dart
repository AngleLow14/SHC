import 'package:shc/patient_page/patient_page.dart';
import 'package:shc/patient_page/id_based_form/patient_medical_form.dart';
import 'package:flutter/material.dart';
import 'package:shc/patient_page/medical_record.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MedicalHistoryPage extends StatefulWidget {
  final String patientId;

  const MedicalHistoryPage({super.key, required this.patientId});

  @override
  State<MedicalHistoryPage> createState() => _MedicalHistoryPageState();
}

class _MedicalHistoryPageState extends State<MedicalHistoryPage> {
  final supabase = Supabase.instance.client;

  @override
  void initState() {
    super.initState();
    // optional, can remove since you're using FutureBuilder
  }

  // Utility to normalize potentially null or empty or 'N/A' strings to display string
  String normalizeString(dynamic val) {
    if (val == null) return 'N/A';
    final v = val.toString().trim();
    if (v.isEmpty || v.toUpperCase() == 'N/A') return 'N/A';
    return v;
  }

  Future<Map<String, dynamic>?> _fetchPatientInfo() async {
    final response = await supabase
        .from('patient')
        .select()
        .eq('patient_id', widget.patientId)
        .single();

    return response == null ? null : Map<String, dynamic>.from(response);
  }

  Future<List<Map<String, dynamic>>> fetchMedicalHistory() async {
    final response = await supabase
        .from('medical_history')
        .select()
        .eq('patient_id', widget.patientId);

    return response == null ? [] : List<Map<String, dynamic>>.from(response);
  }
  
  String _formatFullName(Map<String, dynamic> p) {
    final parts = [
      normalizeString(p['first_name']),
      normalizeString(p['middle_name']),
      normalizeString(p['last_name']),
      normalizeString(p['suffix']),
    ];

    final validParts = parts.where((part) => part != 'N/A').toList();

    return validParts.join(' ');
  }

  @override
  Widget build(BuildContext context) {
    double responsiveSpacing = 20.0;
    double responsiveRunSpacing = 10.0;
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder<List<dynamic>?>(
          future: Future.wait([
            _fetchPatientInfo(), 
            fetchMedicalHistory()
          ]),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData) {
              return const Center(child: Text('Patient not found.'));
            }

            final patientInfo = snapshot.data![0] as Map<String, dynamic>?;
            final history = snapshot.data![1] as List<Map<String, dynamic>>;

            if (patientInfo == null) {
              return const Center(child: Text('Patient not found.'));
            }

            final fullName = _formatFullName(patientInfo);

            // Normalize all fields with the new helper function
            final birthdayStr = normalizeString(patientInfo['birthday']);
            final email = normalizeString(patientInfo['email']);
            final birthPlace = normalizeString(patientInfo['place_of_birth']);
            final contact = normalizeString(patientInfo['contact_number']);
            final civilStatus = normalizeString(patientInfo['civil_status']);
            final houseNo = normalizeString(patientInfo['house_number']);
            final street = normalizeString(patientInfo['street']);
            final brgy = normalizeString(patientInfo['barangay']);
            final city = normalizeString(patientInfo['city']);
            final province = normalizeString(patientInfo['province']);
            final zcode = normalizeString(patientInfo['zip_code']);

            int calculateAge(DateTime birthday) {
              final now = DateTime.now();
              int age = now.year - birthday.year;

              if (now.month < birthday.month ||
                  (now.month == birthday.month && now.day < birthday.day)) {
                age--;
              }

              return age;
            }

            int age = 0;
            if (birthdayStr != 'N/A') {
              try {
                age = calculateAge(DateTime.parse(birthdayStr));
              } catch (_) {
                age = 0;
              }
            }
        
        return Container(
          color: const Color.fromARGB(255, 255, 242, 242),
          height: screenHeight,
          width: screenWidth,
          child: Wrap(
            spacing: responsiveSpacing,
            runSpacing: responsiveRunSpacing,
            children: [
              Row(
                children: [
                  SizedBox(height: screenHeight * 0.02),
                  Container(
                    padding: EdgeInsets.only(left: 20),
                    height: screenHeight * 0.07,
                    width: screenWidth * 0.07,
                    child: Image.asset(
                      'assets/icon/shc.png',
                    height: screenHeight * 0.06,
                    width: screenWidth * 0.06,
                    ),
                  ),
                  Text(
                      'San Pablo Social Hygiene Clinic',
                      style: TextStyle(
                        fontFamily: 'OpenSansEB',
                        fontSize: 30,
                        color: Color.fromARGB(255, 182, 8, 37),
                      ),
                    ),
                ],
              ),
              SizedBox(height: screenHeight * 0.02),
              Wrap(
                spacing: responsiveSpacing,
                runSpacing: responsiveRunSpacing,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      height: screenHeight * 0.5,
                      width: screenWidth * 0.4,
                      color: Colors.white,
                      decoration: BoxDecoration(
                        color: Colors.white, // optional: background color
                        borderRadius: BorderRadius.circular(10), // rounded corners
                      ),
                      child: Column(
                        children: [
                          SizedBox(height: screenHeight * 0.03),
                          Row(
                            children: [
                              SizedBox(
                                child: Row(
                                  children: [
                                    SizedBox(height: screenHeight * 0.02),
                                    Container(
                                height: screenHeight * 0.15,
                                width: screenWidth * 0.15,
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
                                    Column(
                                      children: [
                                        Text(
                                    fullName,
                                    style: TextStyle(
                                      fontFamily: 'OpenSansEB',
                                      fontSize: 20,
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(height: screenHeight * 0.02),
                                  Text(
                                      '$age years old',
                                      style: TextStyle(
                                        fontFamily: 'OpenSansSB',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Text(
                                    'ID: $widget.patientId',
                                    style: TextStyle(
                                      fontFamily: 'OpenSansEB',
                                      fontSize: 5,
                                      color: Colors.black,
                                    ),
                                  ),
                                      ],
                                    )                                  
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: screenHeight * 0.03),
                          Wrap(
                            spacing: responsiveSpacing,
                            runSpacing: responsiveRunSpacing,
                            children: [
                              Text(
                                  'I. PROFILE',
                                  style: TextStyle(
                                    fontFamily: 'OpenSansEB',
                                    fontSize: 20,
                                    color: Colors.black,
                                  ),
                                ),
                            ],
                          ),
                          SizedBox(height: screenHeight * 0.02),
                            Wrap(
                            spacing: responsiveSpacing, 
                            runSpacing: responsiveRunSpacing,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                'Birthday',
                                style: TextStyle(
                                  fontFamily: 'OpenSansSB',
                                  fontSize: 20,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                birthdayStr,
                                style: TextStyle(
                                  fontFamily: 'OpenSansLight',
                                  fontSize: 15,
                                  color: Colors.black,
                                ),
                              ),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                Text(
                                'Place of Birth',
                                style: TextStyle(
                                  fontFamily: 'OpenSansSB',
                                  fontSize: 20,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                birthPlace,
                                style: TextStyle(
                                  fontFamily: 'OpenSansLight',
                                  fontSize: 15,
                                  color: Colors.black,
                                ),
                              ),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                Text(
                                'Civil Status',
                                style: TextStyle(
                                  fontFamily: 'OpenSansSB',
                                  fontSize: 20,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                civilStatus,
                                style: TextStyle(
                                  fontFamily: 'OpenSansLight',
                                  fontSize: 15,
                                  color: Colors.black,
                                ),
                              ),
                                ],
                              ),
                            ],
                          ),
                            ],
                          ),
                          
                          SizedBox(height: screenHeight * 0.02),
                          Wrap(
                            spacing: responsiveSpacing,
                            runSpacing: responsiveRunSpacing,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                'Contact Number',
                                style: TextStyle(
                                  fontFamily: 'OpenSansSB',
                                  fontSize: 20,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                contact,
                                style: TextStyle(
                                  fontFamily: 'OpenSansLight',
                                  fontSize: 15,
                                  color: Colors.black,
                                ),
                              ),
                                    ]
                                  ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                'Email',
                                style: TextStyle(
                                  fontFamily: 'OpenSansSB',
                                  fontSize: 20,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                email,
                                style: TextStyle(
                                  fontFamily: 'OpenSansLight',
                                  fontSize: 15,
                                  color: Colors.black,
                                ),
                              ),
                                  ],
                                )
                                ]
                              )
                            ]
                          ),
                          
                          SizedBox(height: screenHeight * 0.02),
                          Wrap(
                            spacing: responsiveSpacing,
                            runSpacing: responsiveRunSpacing,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                'House Number',
                                style: TextStyle(
                                  fontFamily: 'OpenSansSB',
                                  fontSize: 20,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                houseNo,
                                style: TextStyle(
                                  fontFamily: 'OpenSansLight',
                                  fontSize: 15,
                                  color: Colors.black,
                                ),
                              ),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                'Street',
                                style: TextStyle(
                                  fontFamily: 'OpenSansSB',
                                  fontSize: 20,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                street,
                                style: TextStyle(
                                  fontFamily: 'OpenSansLight',
                                  fontSize: 15,
                                  color: Colors.black,
                                ),
                              ),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                'Barangay',
                                style: TextStyle(
                                  fontFamily: 'OpenSansSB',
                                  fontSize: 20,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                brgy,
                                style: TextStyle(
                                  fontFamily: 'OpenSansLight',
                                  fontSize: 15,
                                  color: Colors.black,
                                ),
                              ),

                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                          
                          SizedBox(height: screenHeight * 0.02),
                          Wrap(
                            spacing: responsiveSpacing,
                            runSpacing: responsiveRunSpacing,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                'Municipality/City',
                                style: TextStyle(
                                  fontFamily: 'OpenSansSB',
                                  fontSize: 20,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                city,
                                style: TextStyle(
                                  fontFamily: 'OpenSansLight',
                                  fontSize: 15,
                                  color: Colors.black,
                                ),
                              ),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                'Province',
                                style: TextStyle(
                                  fontFamily: 'OpenSansSB',
                                  fontSize: 20,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                province,
                                style: TextStyle(
                                  fontFamily: 'OpenSansLight',
                                  fontSize: 15,
                                  color: Colors.black,
                                ),
                              ),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                'Zip Code',
                                style: TextStyle(
                                  fontFamily: 'OpenSansSB',
                                  fontSize: 20,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                zcode,
                                style: TextStyle(
                                  fontFamily: 'OpenSansLight',
                                  fontSize: 15,
                                  color: Colors.black,
                                ),
                              ),

                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),                                                    
                        ],
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.02),
                    Center(
                      child: Container(
                        height: screenHeight * 0.6,
                        width: screenWidth * 0.4,
                        color: Colors.white,
                        decoration: BoxDecoration(
                          color: Colors.white, // optional: background color
                          borderRadius: BorderRadius.circular(10), // rounded corners
                        ),
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                             Text(
                              'Medical History',
                              style: TextStyle(
                                fontFamily: 'OpenSansEB',
                                fontSize: 25,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Column(
                              children: history.map((h) {
                                final date = h['date'] != null
                                    ? DateTime.parse(h['date']).toLocal().toString().split(' ')[0]
                                    : 'N/A';

                                return Card(
                                  child: ListTile(
                                    title: Text(h['current_medication'] ?? 'No History'),
                                    subtitle: Text('Date: $date'),
                                    trailing: ElevatedButton(
                                      child: const Text('View Details'),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) => ViewDetails(patientId: widget.patientId),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                            const SizedBox(height: 16),
                            SizedBox(
                              width: screenWidth * 0.3,
                              height: screenHeight * 0.06,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => PatientForm()),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color.fromRGBO(247, 198, 226, 1),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    side: BorderSide(color: Colors.green.shade900, width: 2),
                                  ),
                                ),
                                child: const Text(
                                  'Medical History Form',
                                  style: TextStyle(fontSize: 12, color: Colors.black, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                ]
              ),
              SizedBox(height: screenHeight * 0.02),
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => PatientsPage()),
                    );
                  },
                  style: ButtonStyle(
                    textStyle: WidgetStateProperty.all<TextStyle>(
                      TextStyle(decoration: TextDecoration.underline),
                    ),
                  ),
                  child: Text(
                    'Go Back',
                    style: TextStyle(
                      fontFamily: 'OpenSansLight',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
          },
      ),
      ),
    );
  }
}