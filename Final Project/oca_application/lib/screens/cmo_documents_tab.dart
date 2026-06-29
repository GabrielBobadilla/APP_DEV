import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants/app_theme.dart';
import '../models/document_model.dart';
import '../services/data_service.dart';

class CmoDocumentsTab extends StatelessWidget {
  final String rpagId;

  const CmoDocumentsTab({super.key, required this.rpagId});

  @override
  Widget build(BuildContext context) {
    final data = context.watch<DataService>();
    final docs = data.getDocumentsForRpag(rpagId);

    final cmoTypes = [DocumentType.letterToParent, DocumentType.waiver, DocumentType.medicalCertificate];
    final cmoDocs = docs.where((d) => cmoTypes.contains(d.type)).toList();

    if (cmoDocs.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.folder_copy_rounded, size: 56, color: Colors.grey[300]),
            const SizedBox(height: 14),
            const Text('No CMO documents available', style: TextStyle(fontSize: 15, color: AppColors.textSecondary)),
          ],
        ),
      );
    }

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
      children: [
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.primary.withValues(alpha: 0.15)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Icon(Icons.info_outline_rounded, color: AppColors.primary, size: 16),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Required CMO documents that members must submit upon enrollment or renewal.',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 13,
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        ...cmoDocs.map((doc) => _buildDocCard(context, doc)),
      ],
    );
  }

  Widget _buildDocCard(BuildContext context, Document doc) {
    IconData icon;
    Color color;
    String typeLabel;
    switch (doc.type) {
      case DocumentType.letterToParent:
        icon = Icons.mail_outline_rounded;
        color = AppColors.info;
        typeLabel = 'Letter to Parent';
        break;
      case DocumentType.waiver:
        icon = Icons.gavel_rounded;
        color = AppColors.warning;
        typeLabel = 'Waiver Form';
        break;
      case DocumentType.medicalCertificate:
        icon = Icons.medical_services_rounded;
        color = AppColors.success;
        typeLabel = 'Medical Certificate';
        break;
      default:
        icon = Icons.description_rounded;
        color = Colors.grey;
        typeLabel = 'Document';
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border(
          left: BorderSide(color: color, width: 3),
        ),
        boxShadow: AppShadows.subtle,
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Opening ${doc.title}...'),
              backgroundColor: AppColors.primary,
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: color, size: 22),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      typeLabel,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: color,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      doc.title,
                      style: const TextStyle(fontSize: 13, color: AppColors.textPrimary),
                    ),
                    if (doc.description != null) ...[
                      const SizedBox(height: 2),
                      Text(
                        doc.description!,
                        style: AppTextStyles.caption,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(Icons.file_download_outlined, color: color, size: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
