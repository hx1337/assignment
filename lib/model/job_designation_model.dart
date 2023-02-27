// To parse this JSON data, do
//
//     final designation = designationFromJson(jsonString);

import 'dart:convert';

Designation designationFromJson(String str) =>
    Designation.fromJson(json.decode(str));

String designationToJson(Designation data) => json.encode(data.toJson());

class Designation {
  Designation({
    required this.jobdesignations,
  });

  List<Jobdesignation> jobdesignations;

  factory Designation.fromJson(Map<String, dynamic> json) => Designation(
        jobdesignations: List<Jobdesignation>.from(
            json["jobdesignations"].map((x) => Jobdesignation.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "jobdesignations":
            List<dynamic>.from(jobdesignations.map((x) => x.toJson())),
      };
}

class Jobdesignation {
  Jobdesignation({
    required this.designationId,
    required this.designation,
    this.roleId,
  });

  int designationId;
  String designation;
  dynamic roleId;

  factory Jobdesignation.fromJson(Map<String, dynamic> json) => Jobdesignation(
        designationId: json["designation_id"],
        designation: json["designation"],
        roleId: json["role_id"],
      );

  Map<String, dynamic> toJson() => {
        "designation_id": designationId,
        "designation": designation,
        "role_id": roleId,
      };
}
