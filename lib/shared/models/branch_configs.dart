import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class BranchConfigs {
  static String? organisationId;
  static String? organisationalId;
  static String? branchId;

  static void initialize({required String orgId, required String brnchId}) {
    organisationId = orgId;
    organisationalId = orgId;
    branchId = brnchId;
  }

  static Map<String, dynamic> commonQueryParams(bool changeOrg) {
    return {
      if (!changeOrg) 'organisationId': '54321',
      if (changeOrg) 'organisationalId': '54321',
      'branchId': 'BR-1002',
    };
  }

  static Future<void> setBranchDetails(
      BuildContext context, String branchId, int organisationid) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('branchId', branchId);
    prefs.setInt('organisationId', organisationid);
    prefs.setInt('organisationalId', organisationid);
  }

  static Future<Map<String, String>> getBranchDetails(
      BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final branchId = prefs.getString('branchId');
    // final organisationId = prefs.getInt('organisationId');
    // final organisationalId = prefs.getInt('organisationalId');

    return {
      'branchId': branchId ?? '',
      // 'organisationId': organisationId ?? 0,
    };
  }
}
