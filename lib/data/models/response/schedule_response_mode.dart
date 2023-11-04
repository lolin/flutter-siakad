import 'dart:convert';

class ScheduleResponseModel {
  final List<Schedule> data;

  ScheduleResponseModel({
    required this.data,
  });

  factory ScheduleResponseModel.fromJson(String str) =>
      ScheduleResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ScheduleResponseModel.fromMap(Map<String, dynamic> json) =>
      ScheduleResponseModel(
        data: List<Schedule>.from(json["data"].map((x) => Schedule.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "data": List<dynamic>.from(data.map((x) => x.toMap())),
      };
}

class Schedule {
  final int id;
  final int scheduleId;
  final int studentId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final ScheduleDetail scheduleDetail;

  Schedule({
    required this.id,
    required this.scheduleId,
    required this.studentId,
    required this.createdAt,
    required this.updatedAt,
    required this.scheduleDetail,
  });

  factory Schedule.fromJson(String str) => Schedule.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Schedule.fromMap(Map<String, dynamic> json) => Schedule(
        id: json["id"],
        scheduleId: json["schedule_id"],
        studentId: json["student_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        scheduleDetail: ScheduleDetail.fromMap(json["schedule"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "schedule_id": scheduleId,
        "student_id": studentId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "schedule": scheduleDetail.toMap(),
      };
}

class ScheduleDetail {
  final int id;
  final int subjectId;
  final String hari;
  final String jamMulai;
  final String jamSelesai;
  final String ruangan;
  final String kodeAbsensi;
  final String tahunAkademik;
  final String semester;
  final String createdBy;
  final String updatedBy;
  final dynamic deletedBy;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Subject subject;

  ScheduleDetail({
    required this.id,
    required this.subjectId,
    required this.hari,
    required this.jamMulai,
    required this.jamSelesai,
    required this.ruangan,
    required this.kodeAbsensi,
    required this.tahunAkademik,
    required this.semester,
    required this.createdBy,
    required this.updatedBy,
    required this.deletedBy,
    required this.createdAt,
    required this.updatedAt,
    required this.subject,
  });

  factory ScheduleDetail.fromJson(String str) =>
      ScheduleDetail.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ScheduleDetail.fromMap(Map<String, dynamic> json) => ScheduleDetail(
        id: json["id"],
        subjectId: json["subject_id"],
        hari: json["hari"],
        jamMulai: json["jam_mulai"],
        jamSelesai: json["jam_selesai"],
        ruangan: json["ruangan"],
        kodeAbsensi: json["kode_absensi"],
        tahunAkademik: json["tahun_akademik"],
        semester: json["semester"],
        createdBy: json["created_by"],
        updatedBy: json["updated_by"],
        deletedBy: json["deleted_by"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        subject: Subject.fromMap(json["subject"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "subjectId": subjectId,
        "hari": hari,
        "jamMulai": jamMulai,
        "jamSelesai": jamSelesai,
        "ruangan": ruangan,
        "kodeAbsensi": kodeAbsensi,
        "tahunAkademik": tahunAkademik,
        "semester": semester,
        "createdBy": createdBy,
        "updatedBy": updatedBy,
        "deletedBy": deletedBy,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "subject": subject.toMap(),
      };
}

class Subject {
  final int id;
  final String title;
  final int lecturerId;
  final String semester;
  final String academicYear;
  final int sks;
  final String code;
  final String description;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Lecturer lecturer;

  Subject({
    required this.id,
    required this.title,
    required this.lecturerId,
    required this.semester,
    required this.academicYear,
    required this.sks,
    required this.code,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    required this.lecturer,
  });

  factory Subject.fromJson(String str) => Subject.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Subject.fromMap(Map<String, dynamic> json) => Subject(
        id: json["id"],
        title: json["title"],
        lecturerId: json["lecturer_id"],
        semester: json["semester"],
        academicYear: json["academic_year"],
        sks: json["sks"],
        code: json["code"],
        description: json["description"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        lecturer: Lecturer.fromMap(json["lecturer"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "lecturer_id": lecturerId,
        "semester": semester,
        "academic_year": academicYear,
        "sks": sks,
        "code": code,
        "description": description,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "lecturer": lecturer.toMap(),
      };
}

class Lecturer {
  final int id;
  final String name;
  final String email;
  final String roles;
  final dynamic phone;
  final dynamic address;
  final DateTime emailVerifiedAt;
  final dynamic twoFactorSecret;
  final dynamic twoFactorRecoveryCodes;
  final dynamic twoFactorConfirmedAt;
  final DateTime createdAt;
  final DateTime updatedAt;

  Lecturer({
    required this.id,
    required this.name,
    required this.email,
    required this.roles,
    required this.phone,
    required this.address,
    required this.emailVerifiedAt,
    required this.twoFactorSecret,
    required this.twoFactorRecoveryCodes,
    required this.twoFactorConfirmedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Lecturer.fromJson(String str) => Lecturer.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Lecturer.fromMap(Map<String, dynamic> json) => Lecturer(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        roles: json["roles"],
        phone: json["phone"],
        address: json["address"],
        emailVerifiedAt: DateTime.parse(json["email_verified_at"]),
        twoFactorSecret: json["two_factor_secret"],
        twoFactorRecoveryCodes: json["two_factor_recovery_codes"],
        twoFactorConfirmedAt: json["two_factor_confirmed_at"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "email": email,
        "roles": roles,
        "phone": phone,
        "address": address,
        "email_verified_at": emailVerifiedAt.toIso8601String(),
        "two_factor_secret": twoFactorSecret,
        "two_factor_recovery_codes": twoFactorRecoveryCodes,
        "two_factor_confirmed_at": twoFactorConfirmedAt,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
