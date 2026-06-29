enum DocumentType { general, membershipRenewal, letterToParent, waiver, medicalCertificate, attendance }

class Document {
  final String id;
  final String rpagId;
  final String title;
  final DocumentType type;
  final DateTime uploadDate;
  final String fileUrl;
  final String? description;

  const Document({
    required this.id,
    required this.rpagId,
    required this.title,
    required this.type,
    required this.uploadDate,
    required this.fileUrl,
    this.description,
  });
}

class MembershipRenewal {
  final String id;
  final String rpagId;
  final String memberName;
  final String position;
  final String contactNumber;
  final String email;
  final DateTime dateSubmitted;
  final String status;

  const MembershipRenewal({
    required this.id,
    required this.rpagId,
    required this.memberName,
    required this.position,
    required this.contactNumber,
    required this.email,
    required this.dateSubmitted,
    this.status = 'Pending',
  });
}

class AttendanceRecord {
  final String id;
  final String rpagId;
  final String memberName;
  final DateTime date;
  final String status;
  final String? notes;

  const AttendanceRecord({
    required this.id,
    required this.rpagId,
    required this.memberName,
    required this.date,
    required this.status,
    this.notes,
  });
}
