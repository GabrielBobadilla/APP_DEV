import 'package:flutter/material.dart';
import '../constants/app_theme.dart';
import '../models/rpag_model.dart';
import 'documents_tab.dart';
import 'membership_renewal_tab.dart';
import 'cmo_documents_tab.dart';
import 'attendance_tab.dart';
import 'calendar_tab.dart';

class RpagDetailScreen extends StatelessWidget {
  const RpagDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final rpag = ModalRoute.of(context)!.settings.arguments as RPAG;

    return DefaultTabController(
      length: 5,
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          title: Text(
            rpag.name,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
          ),
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          elevation: 0,
          bottom: const TabBar(
            isScrollable: true,
            indicatorColor: Colors.white,
            indicatorWeight: 3,
            indicatorSize: TabBarIndicatorSize.label,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white60,
            labelStyle: TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
            tabs: [
              Tab(icon: Icon(Icons.description_rounded, size: 18), text: 'Documents'),
              Tab(icon: Icon(Icons.replay_rounded, size: 18), text: 'Renewal'),
              Tab(icon: Icon(Icons.folder_copy_rounded, size: 18), text: 'CMO Docs'),
              Tab(icon: Icon(Icons.checklist_rounded, size: 18), text: 'Attendance'),
              Tab(icon: Icon(Icons.calendar_month_rounded, size: 18), text: 'Calendar'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            DocumentsTab(rpagId: rpag.id),
            MembershipRenewalTab(rpagId: rpag.id, rpagName: rpag.name),
            CmoDocumentsTab(rpagId: rpag.id),
            AttendanceTab(rpagId: rpag.id),
            CalendarTab(rpagId: rpag.id),
          ],
        ),
      ),
    );
  }
}
