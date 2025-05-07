import 'package:flutter/material.dart';
import 'package:shc/patient_page/patient_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MedicalHistoryPage extends StatelessWidget {
  final String patientId;

  MedicalHistoryPage({required this.patientId});

  final supabase = Supabase.instance.client;

  Future<List<dynamic>> fetchMedicalHistory() async {
    final response = await supabase
        .from('medical_history')
        .select()
        .eq('patient_id', patientId)
        .order('date', ascending: false);

    // Optional: Add error handling
    if (response == null || response is PostgrestException) {
      throw Exception('Failed to fetch medical history');
    }

    return response as List<dynamic>;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Medical History')),
      body: FutureBuilder<List<dynamic>>(
        future: fetchMedicalHistory(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          final history = snapshot.data ?? [];

          if (history.isEmpty) {
            return Center(child: Text('No medical history found.'));
          }

          return ListView.builder(
            itemCount: history.length,
            itemBuilder: (context, index) {
              final h = history[index];
              return ListTile(
                title: Text('Date: ${h['date']}'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Allergies: ${h['known_allergies']}'),
                    Text('Conditions: ${h['past_current_med_condition']}'),
                    Text('STI: ${h['sti_history']}'),
                    Text('Hospitalization: ${h['hospitalization_history']}'),
                    Text('Medication: ${h['current_medication']}'),
                    Text('Family History: ${h['family_med_history']}'),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
