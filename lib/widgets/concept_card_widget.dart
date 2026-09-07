import 'package:flutter/material.dart';
import '../models/lesson_models.dart';

class ConceptCardWidget extends StatelessWidget {
  final Question question;

  const ConceptCardWidget({
    super.key,
    required this.question,
  });

  @override
  Widget build(BuildContext context) {
    final emoji = question.iconEmoji ?? '💡';
    final title = question.conceptTitle ?? 'Konu Notu';
    final rule = question.rule ?? question.prompt;
    final examples = question.examples ?? [];
    final examTip = question.examTip;

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Üst Başlık ve Rozet
          Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFFE5F6FD),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFF1CB0F6), width: 1.5),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(emoji, style: const TextStyle(fontSize: 16)),
                  const SizedBox(width: 6),
                  const Text(
                    'HAP BİLGİ & KURAL',
                    style: TextStyle(
                      color: Color(0xFF1CB0F6),
                      fontWeight: FontWeight.w800,
                      fontSize: 12,
                      letterSpacing: 0.8,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),

          // Ana Başlık
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w900,
              color: Color(0xFF4B4B4B),
              height: 1.2,
            ),
          ),
          const SizedBox(height: 20),

          // 1. KUTU: Kural & Tanım
          if (rule.isNotEmpty) ...[
            _buildSectionCard(
              icon: Icons.lightbulb_rounded,
              iconColor: const Color(0xFF58CC02),
              title: 'KURAL & TANIM',
              bgColor: const Color(0xFFF2FBF0),
              borderColor: const Color(0xFF58CC02),
              child: Text(
                rule,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF2E5A1C),
                  height: 1.45,
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],

          // 2. KUTU: Örnekler & İnceleme
          if (examples.isNotEmpty) ...[
            _buildSectionCard(
              icon: Icons.search_rounded,
              iconColor: const Color(0xFF1CB0F6),
              title: 'ÖRNEK & İNCELEME',
              bgColor: const Color(0xFFF0F9FF),
              borderColor: const Color(0xFF1CB0F6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: examples.map((ex) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          '• ',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                            color: Color(0xFF0284C7),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            ex,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF0369A1),
                              height: 1.4,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 16),
          ],

          // 3. KUTU: ÖSYM Püf Noktası / Sınav Taktiği
          if (examTip != null && examTip.isNotEmpty) ...[
            _buildSectionCard(
              icon: Icons.bolt_rounded,
              iconColor: const Color(0xFFFF9600),
              title: '⚡ ÖSYM TUZAĞI & SINAV TAKTİĞİ',
              bgColor: const Color(0xFFFFFDF0),
              borderColor: const Color(0xFFFF9600),
              child: Text(
                examTip,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFFB45309),
                  height: 1.4,
                ),
              ),
            ),
            const SizedBox(height: 12),
          ],

          // Alt İpucu Mesajı
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: const Color(0xFFF7F7F7),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFE5E5E5)),
            ),
            child: const Row(
              children: [
                Icon(Icons.info_outline_rounded, size: 18, color: Color(0xFFAFAFAF)),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Hazır hissettiğinde aşağıdaki butona tıkla; hemen ardından bu kuralı test edeceğiz!',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF777777),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildSectionCard({
    required IconData icon,
    required Color iconColor,
    required String title,
    required Color bgColor,
    required Color borderColor,
    required Widget child,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderColor.withOpacity(0.4), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: borderColor.withOpacity(0.08),
            offset: const Offset(0, 3),
            blurRadius: 0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: iconColor, size: 20),
              const SizedBox(width: 6),
              Text(
                title,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w900,
                  color: iconColor,
                  letterSpacing: 0.8,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          child,
        ],
      ),
    );
  }
}
