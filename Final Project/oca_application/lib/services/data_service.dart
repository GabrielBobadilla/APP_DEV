import 'package:flutter/foundation.dart';
import '../models/rpag_model.dart';
import '../models/event_model.dart';
import '../models/document_model.dart';

class DataService extends ChangeNotifier {
  final List<RPAG> _rpags = const [
    RPAG(
      id: 'rpag_1',
      name: 'Diwayanis Dance Theater',
      description: 'The official dance theater of Batangas State University - Alangilan Campus, showcasing cultural and contemporary dance performances.',
      category: 'Dance',
      iconAsset: 'rpag_diw',
    ),
    RPAG(
      id: 'rpag_2',
      name: 'Indak Yaman Dance Varsity',
      description: 'A competitive dance varsity group representing the university in various dance competitions and events.',
      category: 'Dance',
      iconAsset: 'rpag_indak',
    ),
    RPAG(
      id: 'rpag_3',
      name: 'Adlibitum Chorus',
      description: 'The premier choral group of the campus, performing a wide repertoire from classical to contemporary pieces.',
      category: 'Music',
      iconAsset: 'rpag_adlib',
    ),
    RPAG(
      id: 'rpag_4',
      name: 'Dulaang Batangan',
      description: 'The theater arts group dedicated to stage productions, plays, and performing arts education.',
      category: 'Theater',
      iconAsset: 'rpag_dulaang',
    ),
    RPAG(
      id: 'rpag_5',
      name: 'Sikha',
      description: 'A cultural organization focused on preserving and promoting Filipino heritage through various art forms.',
      category: 'Cultural',
      iconAsset: 'rpag_sikha',
    ),
  ];

  final List<CalendarEvent> _events = [
    CalendarEvent(
      id: 'evt_1',
      rpagId: 'rpag_1',
      title: 'Diwayanis Foundation Day Showcase',
      description: 'Annual foundation day performance featuring traditional and contemporary dances.',
      date: DateTime(2026, 7, 15),
      location: 'Alangilan Gymnasium',
      time: '9:00 AM - 12:00 PM',
    ),
    CalendarEvent(
      id: 'evt_2',
      rpagId: 'rpag_1',
      title: 'Regional Dance Competition',
      description: 'Representing the university in the regional inter-collegiate dance competition.',
      date: DateTime(2026, 8, 5),
      location: 'Batangas City Convention Center',
      time: '8:00 AM - 5:00 PM',
    ),
    CalendarEvent(
      id: 'evt_3',
      rpagId: 'rpag_2',
      title: 'Indak Yaman Pep Rally Performance',
      description: 'Performace at the university-wide pep rally for upcoming sports events.',
      date: DateTime(2026, 7, 20),
      location: 'Alangilan Oval',
      time: '2:00 PM - 4:00 PM',
    ),
    CalendarEvent(
      id: 'evt_4',
      rpagId: 'rpag_2',
      title: 'Dance Varsity Exhibition',
      description: 'Exhibition match and dance showcase with other university dance varsity groups.',
      date: DateTime(2026, 9, 10),
      location: 'Alangilan Gymnasium',
      time: '1:00 PM - 5:00 PM',
    ),
    CalendarEvent(
      id: 'evt_5',
      rpagId: 'rpag_3',
      title: 'Adlibitum Choral Competition',
      description: 'Participating in the National Choral Competition.',
      date: DateTime(2026, 7, 28),
      location: 'Manila Cultural Center',
      time: '7:00 AM - 6:00 PM',
    ),
    CalendarEvent(
      id: 'evt_6',
      rpagId: 'rpag_3',
      title: 'Christmas Concert',
      description: 'Annual Christmas concert featuring holiday classics and original arrangements.',
      date: DateTime(2026, 12, 10),
      location: 'Alangilan Audio-Visual Room',
      time: '6:00 PM - 9:00 PM',
    ),
    CalendarEvent(
      id: 'evt_7',
      rpagId: 'rpag_4',
      title: 'Dulaang Batangan: Stage Play Premiere',
      description: 'Premiere of the semester\'s major theater production.',
      date: DateTime(2026, 8, 15),
      location: 'Alangilan Theater',
      time: '7:00 PM - 10:00 PM',
    ),
    CalendarEvent(
      id: 'evt_8',
      rpagId: 'rpag_4',
      title: 'Theater Workshop',
      description: 'Weekend workshop on acting, stage design, and production management.',
      date: DateTime(2026, 9, 5),
      location: 'Alangilan Creative Arts Building',
      time: '8:00 AM - 5:00 PM',
    ),
    CalendarEvent(
      id: 'evt_9',
      rpagId: 'rpag_5',
      title: 'Sikha Cultural Festival',
      description: 'Annual cultural festival showcasing Filipino traditions, arts, and crafts.',
      date: DateTime(2026, 8, 25),
      location: 'Alangilan Campus Grounds',
      time: '8:00 AM - 5:00 PM',
    ),
    CalendarEvent(
      id: 'evt_10',
      rpagId: 'rpag_5',
      title: 'Heritage Art Exhibit',
      description: 'Exhibit featuring traditional Filipino art forms and modern interpretations.',
      date: DateTime(2026, 10, 1),
      location: 'Alangilan Art Gallery',
      time: '9:00 AM - 6:00 PM',
    ),
  ];

  final List<Document> _documents = [
    Document(id: 'doc_1', rpagId: 'rpag_1', title: 'RPAG Constitution & By-laws', type: DocumentType.general, uploadDate: DateTime(2026, 1, 10), fileUrl: 'constitution_diw.pdf', description: 'Official constitution and by-laws of Diwayanis Dance Theater.'),
    Document(id: 'doc_2', rpagId: 'rpag_1', title: 'Membership Directory', type: DocumentType.general, uploadDate: DateTime(2026, 6, 1), fileUrl: 'directory_diw.pdf', description: 'List of current active members.'),
    Document(id: 'doc_3', rpagId: 'rpag_1', title: 'Letter to Parent', type: DocumentType.letterToParent, uploadDate: DateTime(2026, 5, 15), fileUrl: 'letter_parent_diw.pdf', description: 'Parent consent letter for membership.'),
    Document(id: 'doc_4', rpagId: 'rpag_1', title: 'Waiver Form', type: DocumentType.waiver, uploadDate: DateTime(2026, 5, 15), fileUrl: 'waiver_diw.pdf', description: 'Liability waiver and assumption of risk form.'),
    Document(id: 'doc_5', rpagId: 'rpag_1', title: 'Medical Certificate Template', type: DocumentType.medicalCertificate, uploadDate: DateTime(2026, 5, 15), fileUrl: 'medical_diw.pdf', description: 'Required medical clearance certificate.'),
    Document(id: 'doc_6', rpagId: 'rpag_2', title: 'RPAG Constitution & By-laws', type: DocumentType.general, uploadDate: DateTime(2026, 1, 15), fileUrl: 'constitution_indak.pdf', description: 'Official constitution and by-laws of Indak Yaman Dance Varsity.'),
    Document(id: 'doc_7', rpagId: 'rpag_2', title: 'Membership Directory', type: DocumentType.general, uploadDate: DateTime(2026, 6, 5), fileUrl: 'directory_indak.pdf', description: 'List of current active members.'),
    Document(id: 'doc_8', rpagId: 'rpag_2', title: 'Letter to Parent', type: DocumentType.letterToParent, uploadDate: DateTime(2026, 5, 20), fileUrl: 'letter_parent_indak.pdf', description: 'Parent consent letter for membership.'),
    Document(id: 'doc_9', rpagId: 'rpag_2', title: 'Waiver Form', type: DocumentType.waiver, uploadDate: DateTime(2026, 5, 20), fileUrl: 'waiver_indak.pdf', description: 'Liability waiver and assumption of risk form.'),
    Document(id: 'doc_10', rpagId: 'rpag_2', title: 'Medical Certificate Template', type: DocumentType.medicalCertificate, uploadDate: DateTime(2026, 5, 20), fileUrl: 'medical_indak.pdf', description: 'Required medical clearance certificate.'),
    Document(id: 'doc_11', rpagId: 'rpag_3', title: 'RPAG Constitution & By-laws', type: DocumentType.general, uploadDate: DateTime(2026, 2, 1), fileUrl: 'constitution_adlib.pdf', description: 'Official constitution and by-laws of Adlibitum Chorus.'),
    Document(id: 'doc_12', rpagId: 'rpag_3', title: 'Membership Directory', type: DocumentType.general, uploadDate: DateTime(2026, 6, 10), fileUrl: 'directory_adlib.pdf', description: 'List of current active members.'),
    Document(id: 'doc_13', rpagId: 'rpag_3', title: 'Letter to Parent', type: DocumentType.letterToParent, uploadDate: DateTime(2026, 5, 25), fileUrl: 'letter_parent_adlib.pdf', description: 'Parent consent letter for membership.'),
    Document(id: 'doc_14', rpagId: 'rpag_3', title: 'Waiver Form', type: DocumentType.waiver, uploadDate: DateTime(2026, 5, 25), fileUrl: 'waiver_adlib.pdf', description: 'Liability waiver and assumption of risk form.'),
    Document(id: 'doc_15', rpagId: 'rpag_3', title: 'Medical Certificate Template', type: DocumentType.medicalCertificate, uploadDate: DateTime(2026, 5, 25), fileUrl: 'medical_adlib.pdf', description: 'Required medical clearance certificate.'),
    Document(id: 'doc_16', rpagId: 'rpag_4', title: 'RPAG Constitution & By-laws', type: DocumentType.general, uploadDate: DateTime(2026, 2, 10), fileUrl: 'constitution_dulaang.pdf', description: 'Official constitution and by-laws of Dulaang Batangan.'),
    Document(id: 'doc_17', rpagId: 'rpag_4', title: 'Membership Directory', type: DocumentType.general, uploadDate: DateTime(2026, 6, 15), fileUrl: 'directory_dulaang.pdf', description: 'List of current active members.'),
    Document(id: 'doc_18', rpagId: 'rpag_4', title: 'Letter to Parent', type: DocumentType.letterToParent, uploadDate: DateTime(2026, 6, 1), fileUrl: 'letter_parent_dulaang.pdf', description: 'Parent consent letter for membership.'),
    Document(id: 'doc_19', rpagId: 'rpag_4', title: 'Waiver Form', type: DocumentType.waiver, uploadDate: DateTime(2026, 6, 1), fileUrl: 'waiver_dulaang.pdf', description: 'Liability waiver and assumption of risk form.'),
    Document(id: 'doc_20', rpagId: 'rpag_4', title: 'Medical Certificate Template', type: DocumentType.medicalCertificate, uploadDate: DateTime(2026, 6, 1), fileUrl: 'medical_dulaang.pdf', description: 'Required medical clearance certificate.'),
    Document(id: 'doc_21', rpagId: 'rpag_5', title: 'RPAG Constitution & By-laws', type: DocumentType.general, uploadDate: DateTime(2026, 2, 20), fileUrl: 'constitution_sikha.pdf', description: 'Official constitution and by-laws of Sikha.'),
    Document(id: 'doc_22', rpagId: 'rpag_5', title: 'Membership Directory', type: DocumentType.general, uploadDate: DateTime(2026, 6, 20), fileUrl: 'directory_sikha.pdf', description: 'List of current active members.'),
    Document(id: 'doc_23', rpagId: 'rpag_5', title: 'Letter to Parent', type: DocumentType.letterToParent, uploadDate: DateTime(2026, 6, 5), fileUrl: 'letter_parent_sikha.pdf', description: 'Parent consent letter for membership.'),
    Document(id: 'doc_24', rpagId: 'rpag_5', title: 'Waiver Form', type: DocumentType.waiver, uploadDate: DateTime(2026, 6, 5), fileUrl: 'waiver_sikha.pdf', description: 'Liability waiver and assumption of risk form.'),
    Document(id: 'doc_25', rpagId: 'rpag_5', title: 'Medical Certificate Template', type: DocumentType.medicalCertificate, uploadDate: DateTime(2026, 6, 5), fileUrl: 'medical_sikha.pdf', description: 'Required medical clearance certificate.'),
  ];

  final List<Document> _generalDocs = [];
  final List<AttendanceRecord> _attendanceRecords = [];

  List<RPAG> get rpags => _rpags;
  List<CalendarEvent> get events => _events;
  List<Document> get documents => _documents;
  List<AttendanceRecord> get attendanceRecords => _attendanceRecords;

  RPAG? getRpagById(String id) {
    try {
      return _rpags.firstWhere((r) => r.id == id);
    } catch (_) {
      return null;
    }
  }

  List<CalendarEvent> getEventsForRpag(String rpagId) {
    return _events.where((e) => e.rpagId == rpagId).toList();
  }

  List<Document> getDocumentsForRpag(String rpagId) {
    return _documents.where((d) => d.rpagId == rpagId).toList();
  }

  List<Document> getDocumentsByType(String rpagId, DocumentType type) {
    return _documents.where((d) => d.rpagId == rpagId && d.type == type).toList();
  }

  List<AttendanceRecord> getAttendanceForRpag(String rpagId) {
    return _attendanceRecords.where((a) => a.rpagId == rpagId).toList();
  }

  List<AttendanceRecord> getAttendanceForRpagOnDate(String rpagId, DateTime date) {
    return _attendanceRecords.where((a) =>
      a.rpagId == rpagId &&
      a.date.year == date.year &&
      a.date.month == date.month &&
      a.date.day == date.day
    ).toList();
  }

  void addAttendanceRecord(AttendanceRecord record) {
    _attendanceRecords.add(record);
    notifyListeners();
  }

  void addAttendanceRecords(List<AttendanceRecord> records) {
    _attendanceRecords.addAll(records);
    notifyListeners();
  }

  void addDocument(Document doc) {
    _generalDocs.add(doc);
    notifyListeners();
  }

  List<CalendarEvent> getEventsOnDate(DateTime date) {
    return _events.where((e) =>
      e.date.year == date.year &&
      e.date.month == date.month &&
      e.date.day == date.day
    ).toList();
  }
}
