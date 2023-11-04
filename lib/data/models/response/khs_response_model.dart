import 'dart:convert';

class KhsResponseModel {
  final List<Khs> data;

  KhsResponseModel({
    required this.data,
  });

  factory KhsResponseModel.fromJson(String str) =>
      KhsResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory KhsResponseModel.fromMap(Map<String, dynamic> json) =>
      KhsResponseModel(
        data: List<Khs>.from(json["data"].map((x) => Khs.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "data": List<dynamic>.from(data.map((x) => x.toMap())),
      };
}

class Khs {
  final int id;
  final int subjectId;
  final int studentId;
  final String nilai;
  final String grade;
  final String keterangan;
  final String tahunAkademik;
  final String semester;
  final String createdBy;
  final String updatedBy;
  final dynamic deletedBy;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Subject subject;
  final Student student;

  Khs({
    required this.id,
    required this.subjectId,
    required this.studentId,
    required this.nilai,
    required this.grade,
    required this.keterangan,
    required this.tahunAkademik,
    required this.semester,
    required this.createdBy,
    required this.updatedBy,
    required this.deletedBy,
    required this.createdAt,
    required this.updatedAt,
    required this.subject,
    required this.student,
  });

  factory Khs.fromJson(String str) => Khs.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Khs.fromMap(Map<String, dynamic> json) => Khs(
        id: json["id"],
        subjectId: json["subject_id"],
        studentId: json["student_id"],
        nilai: json["nilai"],
        grade: json["grade"],
        keterangan: json["keterangan"],
        tahunAkademik: json["tahun_akademik"],
        semester: json["semester"],
        createdBy: json["created_by"],
        updatedBy: json["updated_by"],
        deletedBy: json["deleted_by"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        subject: Subject.fromMap(json["subject"]),
        student: Student.fromMap(json["student"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "subject_id": subjectId,
        "student_id": studentId,
        "nilai": nilai,
        "grade": grade,
        "keterangan": keterangan,
        "tahun_akademik": tahunAkademik,
        "semester": semester,
        "created_by": createdBy,
        "updated_by": updatedBy,
        "deleted_by": deletedBy,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "subject": subject.toMap(),
        "student": student.toMap(),
      };
}

class Student {
  final int id;
  final String name;
  final String email;
  final String roles;
  final String phone;
  final String address;
  final DateTime emailVerifiedAt;
  final dynamic twoFactorSecret;
  final dynamic twoFactorRecoveryCodes;
  final dynamic twoFactorConfirmedAt;
  final DateTime createdAt;
  final DateTime updatedAt;

  Student({
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

  factory Student.fromJson(String str) => Student.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Student.fromMap(Map<String, dynamic> json) => Student(
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
      };
}
