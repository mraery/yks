import 'package:flutter/material.dart';
import '../models/lesson_models.dart';
import '../services/curriculum_remote_service.dart';
import 'duo_button.dart';

class UnitDownloadDialog extends StatefulWidget {
  final String repoName;
  final LearningUnit skeleton;

  const UnitDownloadDialog({
    super.key,
    required this.repoName,
    required this.skeleton,
  });

  static Future<LearningUnit?> show(
    BuildContext context, {
    required String repoName,
    required LearningUnit skeleton,
  }) {
    return showDialog<LearningUnit>(
      context: context,
      barrierDismissible: false,
      builder: (_) => UnitDownloadDialog(
        repoName: repoName,
        skeleton: skeleton,
      ),
    );
  }

  @override
  State<UnitDownloadDialog> createState() => _UnitDownloadDialogState();
}

class _UnitDownloadDialogState extends State<UnitDownloadDialog> {
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _startDownload();
  }

  Future<void> _startDownload() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final unit = await CurriculumRemoteService.loadUnitContent(
        repoName: widget.repoName,
        skeleton: widget.skeleton,
      );
      if (mounted) {
        Navigator.of(context).pop(unit);
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _errorMessage =
              'İnternet bağlantınızı kontrol edin. Konu soruları indirilemedi.';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      backgroundColor: Colors.white,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                color: Color(widget.skeleton.colorHex).withOpacity(0.15),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Icon(
                  _errorMessage != null
                      ? Icons.wifi_off_rounded
                      : Icons.cloud_download_rounded,
                  size: 38,
                  color: Color(widget.skeleton.colorHex),
                ),
              ),
            ),
            const SizedBox(height: 18),
            Text(
              _errorMessage != null
                  ? 'Bağlantı Hatası'
                  : 'Konu İndiriliyor... 🚀',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w900,
                color: Color(0xFF1E293B),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              _errorMessage ??
                  '${widget.skeleton.title} soruları ve hap bilgileri internetten çekiliyor. Boyut tasarrufu sağlandı! ✨',
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF64748B),
                fontWeight: FontWeight.w600,
                height: 1.4,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            if (_isLoading) ...[
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: LinearProgressIndicator(
                  minHeight: 8,
                  backgroundColor: const Color(0xFFE2E8F0),
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Color(widget.skeleton.colorHex),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Lütfen bekleyin...',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF94A3B8),
                ),
              ),
            ] else ...[
              DuoButton(
                text: 'TEKRAR DENE 🔄',
                color: DuoButtonColor.green,
                onPressed: _startDownload,
              ),
              const SizedBox(height: 10),
              TextButton(
                onPressed: () => Navigator.of(context).pop(null),
                child: const Text(
                  'Vazgeç',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF64748B),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
