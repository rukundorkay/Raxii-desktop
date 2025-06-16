class Attendance {
  final DateTime attendanceDate;
  final String? lockerRoom;
  final String method;
  final String serviceName;
  final String memberNames;
  final String memberGender;
  final String memberPhoneNumber;
  final String? memberParentPhoneNumber;
  final String memberRegistrationCode;
  final String attendanceId;

  Attendance({
    required this.attendanceId,
    required this.attendanceDate,
    this.lockerRoom,
    required this.method,
    required this.serviceName,
    required this.memberNames,
    required this.memberGender,
    required this.memberPhoneNumber,
    this.memberParentPhoneNumber,
    required this.memberRegistrationCode,
  });

  factory Attendance.fromJson(Map<String, dynamic> json) {
    return Attendance(
      attendanceId:json['attendanceId'],
      attendanceDate: DateTime.parse(json['attendanceDate']),
      lockerRoom: json['lockerRoom'],
      method: json['method'],
      serviceName: json['serviceName'],
      memberNames: json['memberNames'],
      memberGender: json['memberGender'],
      memberPhoneNumber: json['memberPhoneNumber'],
      memberParentPhoneNumber: json['memberParentPhoneNumber'],
      memberRegistrationCode: json['memberRegistrationCode'],
    );
  }


}