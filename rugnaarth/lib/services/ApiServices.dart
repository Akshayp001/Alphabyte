import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:rugnaarth/Models/UserModels.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  String API_ENDPOINT = 'http://192.168.0.112:3000/';

  Future<List<UserModel>> _getDoctors() async {
    List<UserModel> _list = [];
    try {
      final response = await http.get(Uri.parse(API_ENDPOINT + 'doctors'));
      if (response.statusCode == 200) {
        print(response.body);
        Map<String, dynamic> responseData = jsonDecode(response.body);
        responseData.forEach(
          (key, value) {
            UserModel um = UserModel(
                name: value['name'],
                type: 'Doctor',
                email: value['email'],
                id: key);
            _list.add(um);
          },
        );
        // _list = responseData.map((e) => UserModel.fromJson(e)).toList();
      }
    } catch (e) {
      print('Error fetching doctors: $e');
    }
    return _list;
  }

  Future<List<UserModel>> _getPatients() async {
    List<UserModel> _list = [];
    try {
      final response = await http.get(Uri.parse(API_ENDPOINT + 'patients'));
      if (response.statusCode == 200) {
        final List<dynamic> responseData = jsonDecode(response.body);
        _list = responseData.map((e) => UserModel.fromJson(e)).toList();
      }
    } catch (e) {
      print('Error fetching patients: $e');
    }
    return _list;
  }

  Future<void> _createDoctor(UserModel doctor) async {
    var bodyy = {
      "name": doctor.name,
      "email": doctor.email,
      "age": doctor.age,
      "Gender": doctor.gender,
    };
    try {
      final response = await http.post(
        Uri.parse(API_ENDPOINT + 'doctors'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(bodyy),
      );
      if (response.statusCode != 201) {
        print('Failed to create doctor. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error creating doctor: $e');
    }
  }

  Future<void> _createPatient(UserModel patient) async {
    var bodyy = {
      "name": patient.name,
      "email": patient.email,
      "age": patient.age,
      "Gender": patient.gender,
    };
    try {
      final response = await http.post(
        Uri.parse(API_ENDPOINT + 'patients'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(bodyy),
      );
      if (response.statusCode != 201) {
        print('Failed to create patient. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error creating patient: $e');
    }
  }

  Future<void> _updateDoctor(String doctorId, UserModel doctor) async {
    try {
      final response = await http.put(
        Uri.parse(API_ENDPOINT + 'doctors/$doctorId'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(doctor.toJson()),
      );
      if (response.statusCode != 200) {
        print('Failed to update doctor. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error updating doctor: $e');
    }
  }

  Future<void> _updatePatient(String patientId, UserModel patient) async {
    try {
      final response = await http.put(
        Uri.parse(API_ENDPOINT + 'patients/$patientId'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(patient.toJson()),
      );
      if (response.statusCode != 200) {
        print('Failed to update patient. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error updating patient: $e');
    }
  }

  Future<void> _deleteDoctor(String doctorId) async {
    try {
      final response =
          await http.delete(Uri.parse(API_ENDPOINT + 'doctors/$doctorId'));
      if (response.statusCode != 200) {
        print('Failed to delete doctor. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error deleting doctor: $e');
    }
  }

  Future<void> _deletePatient(String patientId) async {
    try {
      final response =
          await http.delete(Uri.parse(API_ENDPOINT + 'patients/$patientId'));
      if (response.statusCode != 200) {
        print('Failed to delete patient. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error deleting patient: $e');
    }
  }

  // Public methods for accessing APIs

  Future<List<UserModel>> getDoctors() async {
    return await _getDoctors();
  }

  Future<List<UserModel>> getPatients() async {
    return await _getPatients();
  }

  Future<void> createDoctor(UserModel doctor) async {
    await _createDoctor(doctor);
  }

  Future<void> createPatient(UserModel patient) async {
    await _createPatient(patient);
  }

  Future<void> updateDoctor(String doctorId, UserModel doctor) async {
    await _updateDoctor(doctorId, doctor);
  }

  Future<void> updatePatient(String patientId, UserModel patient) async {
    await _updatePatient(patientId, patient);
  }

  Future<void> deleteDoctor(String doctorId) async {
    await _deleteDoctor(doctorId);
  }

  Future<void> deletePatient(String patientId) async {
    await _deletePatient(patientId);
  }
}
