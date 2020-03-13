import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class BaseModule with ChangeNotifier{
  String email;
  String password;
  List business = [];
  List smsReports = [];
  List paymentReports = [];

  static const String baseUrl = 'http://kitebirdalpha.kiteholdings.biz:8800/';

  set setEmail(String value){
    email = value;
    notifyListeners();
  }
  set setPassword(String value){
    password = value;
    notifyListeners();
  }
  set setBusinesses(List value){
    business = value;
    notifyListeners();
  }
  set setSmsReports(List value){
    smsReports = value;
    notifyListeners();
  }
  set setPaymentReports(List value){
    paymentReports = value;
    notifyListeners();
  }
  

  Future<bool> login(String _email, String _password)async{
    setEmail = _email;
    password = _password;
    return await fetchBusinesses();

  }

  Future<bool> registerAcc(String _email, String _password)async{
    final Map<String, String> _headers = {'content-type': 'application/json',};
    try {
      final http.Response _response = await http.post(
        '$baseUrl/users', 
        body: json.encode(<String, String>{
          "email": _email,
          "password": _password
        }),
        headers: _headers
      );
      if(_response.statusCode == 200 || _response.statusCode == 202){
        setEmail = _email;
        password = _password;
        return await fetchBusinesses();
      } else {
        // print(_response.statusCode);
        // print(_response.body);
        return false;
      }
    } catch (e) {
      // print("error");
      // print(e);
      return false;
    }
  }

  Future<bool> fetchBusinesses()async{
    final _base64E = base64Encode(utf8.encode('$email:$password'));
    final String basicAuth = 'Basic $_base64E';
    try{
      final http.Response _response = await http.get(
        '$baseUrl/business',
        headers: {'authorization': basicAuth}
      );
      if(_response.statusCode == 200 || _response.statusCode == 202){
        setBusinesses = json.decode(_response.body) as List;
        return true;
      } else {
        return false;
      }
    }catch (e){
      // print("error");
      // print(e);
      return false;
    }
  }


  Future<bool> createBusinesses(String _label, String _shortCode, String _consumerKey, String _consumerSecret)async{
    final _base64E = base64Encode(utf8.encode('$email:$password'));
    final String basicAuth = 'Basic $_base64E';
    try{
      final http.Response _response = await http.post(
        '$baseUrl/business',
        body: json.encode({
          "label": _label,
          "shortCode": _shortCode,
          "consumerKey": _consumerKey,
          "consumerSecret": _consumerSecret
        }),
        headers: {'authorization': basicAuth, 'content-type': 'application/json'}
      );
      if(_response.statusCode == 200 || _response.statusCode == 202){
        await fetchBusinesses();
        return true;
      } else {
        return false;
      }
    }catch (e){
      return false;
    }
  }
  Future<bool> simulatePayment(String _businessId, String _amount, String _refNo,)async{
    final _base64E = base64Encode(utf8.encode('$email:$password'));
    final String basicAuth = 'Basic $_base64E';
    try{
      final http.Response _response = await http.post(
        '$baseUrl/business/simulate/$_businessId',
        body: json.encode({
          "amount": _amount,
          "refNo": _refNo
        }),
        headers: {'authorization': basicAuth, 'content-type': 'application/json'}
      );
      if(_response.statusCode == 200 || _response.statusCode == 202){
        return true;
      } else {
        // print(_response.statusCode);
        // print(_response.body);
        return false;
      }
    }catch (e){
      return false;
    }
  }

  Future<bool> fetchSmsReports(String _businessId)async{
    setSmsReports = [];
    final _base64E = base64Encode(utf8.encode('$email:$password'));
    final String basicAuth = 'Basic $_base64E';
    try{
      final http.Response _response = await http.get(
        '$baseUrl/business/smsReports/$_businessId',
        headers: {'authorization': basicAuth}
      );
      if(_response.statusCode == 200 || _response.statusCode == 202){
        setSmsReports = json.decode(_response.body) as List;
        return true;
      } else {
        return false;
      }
    }catch (e){
      // print("error");
      // print(e);
      return false;
    }
  }

  Future<bool> fetchpaymentReports(String _businessId)async{
    setPaymentReports = [];
    final _base64E = base64Encode(utf8.encode('$email:$password'));
    final String basicAuth = 'Basic $_base64E';
    try{
      final http.Response _response = await http.get(
        '$baseUrl/business/paymentReports/$_businessId',
        headers: {'authorization': basicAuth}
      );
      if(_response.statusCode == 200 || _response.statusCode == 202){
        setPaymentReports = json.decode(_response.body) as List;
        return true;
      } else {
        return false;
      }
    }catch (e){
      // print("error");
      // print(e);
      return false;
    }
  }

  Future<Map<String, dynamic>> verifyOtp(String _refNo, String _otp)async{
    final _base64E = base64Encode(utf8.encode('$email:$password'));
    final String basicAuth = 'Basic $_base64E';
    final Map<String, String> _headers = {'authorization': basicAuth, 'content-type': 'application/json',};
    try {
      final http.Response _response = await http.post(
        '$baseUrl/otp/verify', 
        body: json.encode(<String, String>{
          "refNo": _refNo,
          "otp": _otp
        }),
        headers: _headers
      );
      if(_response.statusCode == 200 || _response.statusCode == 202){
        return {
          "status": 0,
          "body": json.decode(_response.body)
        };
      } else {
        if(_response.statusCode == 400){
          return {
            "status": 1,
            "message": json.decode(_response.body)['message']
          };
        } else {
          return {
            "status": 2,
            "message": "An error occured"
          };
        }
      }
    } catch (e) {
      // print("error");
      // print(e);
      return {
        "error": e.toString(),
        "status": 111
      };
    }
  }

  
  

}