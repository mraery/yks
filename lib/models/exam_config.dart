import 'package:flutter/material.dart';

enum ExamFranchise {
  yks,
  dgs,
  lgs,
  kpss,
}

class ExamConfig {
  final ExamFranchise franchise;
  final String title;
  final String shortTitle;
  final String badgeText;
  final String description;
  final String targetExamDateText;
  final Color primaryColor;
  final Color secondaryColor;
  final String mascotGreeting;
  final List<String> sections; // Örn: ['TYT', 'AYT'] veya ['Sayısal', 'Sözel']
  final List<Map<String, String>> subjects; // List of {'name': ..., 'icon': ...}
  final String officialBody; // 'MEB' veya 'ÖSYM'
  final int penaltyRatio; // LGS için 3 (3 yanlış 1 doğru), YKS/DGS/KPSS için 4 (4 yanlış 1 doğru)
  final String penaltyRuleText; // 'MEB Kuralı: 3 Yanlış 1 Doğruyu Götürür' vs.
  final String officialExamDetails;

  const ExamConfig({
    required this.franchise,
    required this.title,
    required this.shortTitle,
    required this.badgeText,
    required this.description,
    required this.targetExamDateText,
    required this.primaryColor,
    required this.secondaryColor,
    required this.mascotGreeting,
    required this.sections,
    required this.subjects,
    required this.officialBody,
    required this.penaltyRatio,
    required this.penaltyRuleText,
    required this.officialExamDetails,
  });

  /// MEB ve ÖSYM resmi kurallarına göre Net hesaplama fonksiyonu
  /// LGS (MEB): Net = Doğru - (Yanlış / 3)
  /// YKS / DGS / KPSS (ÖSYM): Net = Doğru - (Yanlış / 4)
  double calculateNet(int correct, int wrong) {
    if (correct <= 0 && wrong <= 0) return 0.0;
    final double net = correct - (wrong / penaltyRatio);
    final clamped = net < 0 ? 0.0 : net;
    return double.parse(clamped.toStringAsFixed(2));
  }

  static const ExamConfig yks = ExamConfig(
    franchise: ExamFranchise.yks,
    title: 'YKS Quest',
    shortTitle: 'YKS',
    badgeText: 'YKS Quest 🎓',
    description: 'YKS (TYT & AYT) Sınav Macerası & Derece Patikası',
    targetExamDateText: '2026 YKS Hedefi 🎯',
    primaryColor: Color(0xFF58CC02),
    secondaryColor: Color(0xFF1CB0F6),
    mascotGreeting: 'Selam Şampiyon! Bugün YKS Quest ile hangi dersi fethediyoruz?',
    sections: ['TYT', 'AYT'],
    officialBody: 'ÖSYM',
    penaltyRatio: 4,
    penaltyRuleText: 'ÖSYM Kuralı: 4 Yanlış 1 Doğruyu Götürür',
    officialExamDetails: 'Yükseköğretim Kurumları Sınavı (TYT & AYT)',
    subjects: [
      {'name': 'Tümü', 'icon': '🌟'},
      {'name': 'TYT Türkçe', 'icon': '📚'},
      {'name': 'TYT Matematik', 'icon': '📐'},
      {'name': 'TYT Fizik', 'icon': '⚡'},
      {'name': 'TYT Kimya', 'icon': '🧪'},
      {'name': 'TYT Biyoloji', 'icon': '🧬'},
      {'name': 'TYT Tarih', 'icon': '🏛️'},
      {'name': 'TYT Coğrafya', 'icon': '🌍'},
      {'name': 'TYT Felsefe', 'icon': '💭'},
      {'name': 'TYT Din Kültürü', 'icon': '📖'},
      {'name': 'AYT Matematik', 'icon': '📐'},
      {'name': 'AYT Edebiyat', 'icon': '📜'},
      {'name': 'AYT Fizik', 'icon': '⚡'},
      {'name': 'AYT Kimya', 'icon': '🧪'},
      {'name': 'AYT Biyoloji', 'icon': '🧬'},
    ],
  );

  static const ExamConfig dgs = ExamConfig(
    franchise: ExamFranchise.dgs,
    title: 'DGS Quest',
    shortTitle: 'DGS',
    badgeText: 'DGS Quest ⚡',
    description: 'DGS Sayısal, Sözel & Mantık Soru Dünyası',
    targetExamDateText: '2026 DGS Lisans Hedefi 🎯',
    primaryColor: Color(0xFF8B5CF6),
    secondaryColor: Color(0xFF06B6D4),
    mascotGreeting: 'Paşam DGS Quest seni bekliyor! Sayısal ve Sözel Mantık netlerini uçurmaya hazır mısın?',
    sections: ['Sayısal', 'Sözel'],
    officialBody: 'ÖSYM',
    penaltyRatio: 4,
    penaltyRuleText: 'ÖSYM Kuralı: 4 Yanlış 1 Doğruyu Götürür',
    officialExamDetails: 'Dikey Geçiş Sınavı (Sayısal & Sözel Yetenek)',
    subjects: [
      {'name': 'Tümü', 'icon': '🌟'},
      {'name': 'DGS Temel Matematik', 'icon': '📐'},
      {'name': 'DGS Problemler', 'icon': '🧮'},
      {'name': 'DGS Sayısal Mantık', 'icon': '⚡'},
      {'name': 'DGS Geometri', 'icon': '📏'},
      {'name': 'DGS Sözel Anlam', 'icon': '📚'},
      {'name': 'DGS Paragraf', 'icon': '📖'},
      {'name': 'DGS Sözel Mantık', 'icon': '🧩'},
    ],
  );

  static const ExamConfig lgs = ExamConfig(
    franchise: ExamFranchise.lgs,
    title: 'LGS Quest',
    shortTitle: 'LGS',
    badgeText: 'LGS Quest 🎒',
    description: '8. Sınıf LGS Liselere Geçiş Sınavı Macerası',
    targetExamDateText: '2026 Nitelikli Lise Hedefi 🏫',
    primaryColor: Color(0xFFF97316),
    secondaryColor: Color(0xFF3B82F6),
    mascotGreeting: 'Genç Dostum LGS Quest seni bekliyor! Fen lisesi yolunda bugün Zeki Paşa ile uçalım!',
    sections: ['Sayısal', 'Sözel'],
    officialBody: 'MEB',
    penaltyRatio: 3,
    penaltyRuleText: 'MEB Kuralı: 3 Yanlış 1 Doğruyu Götürür',
    officialExamDetails: 'Liselere Geçiş Sistemi (8. Sınıf MEB Müfredatı)',
    subjects: [
      {'name': 'Tümü', 'icon': '🌟'},
      {'name': 'LGS Matematik', 'icon': '📐'},
      {'name': 'LGS Fen Bilimleri', 'icon': '🧪'},
      {'name': 'LGS Türkçe', 'icon': '📚'},
      {'name': 'LGS T.C. İnkılap Tarihi', 'icon': '🇹🇷'},
      {'name': 'LGS Din Kültürü', 'icon': '📖'},
      {'name': 'LGS İngilizce', 'icon': '🌍'},
    ],
  );

  static const ExamConfig kpss = ExamConfig(
    franchise: ExamFranchise.kpss,
    title: 'KPSS Quest',
    shortTitle: 'KPSS',
    badgeText: 'KPSS Quest 🏛️',
    description: 'KPSS Genel Yetenek & Genel Kültür Atama Patikası',
    targetExamDateText: '2026 KPSS Atama Hedefi 🏛️',
    primaryColor: Color(0xFF0284C7),
    secondaryColor: Color(0xFF10B981),
    mascotGreeting: 'Memur Adayım hoş geldin! KPSS Quest ile Tarih, Coğrafya ve Vatandaşlık cebinde!',
    sections: ['Genel Yetenek', 'Genel Kültür'],
    officialBody: 'ÖSYM',
    penaltyRatio: 4,
    penaltyRuleText: 'ÖSYM Kuralı: 4 Yanlış 1 Doğruyu Götürür',
    officialExamDetails: 'Kamu Personel Seçme Sınavı (Genel Yetenek & Genel Kültür)',
    subjects: [
      {'name': 'Tümü', 'icon': '🌟'},
      {'name': 'KPSS Türkçe & Mantık', 'icon': '📚'},
      {'name': 'KPSS Matematik', 'icon': '📐'},
      {'name': 'KPSS Tarih', 'icon': '🏛️'},
      {'name': 'KPSS Coğrafya', 'icon': '🌍'},
      {'name': 'KPSS Vatandaşlık & Anayasa', 'icon': '⚖️'},
      {'name': 'KPSS Güncel Bilgiler', 'icon': '📰'},
    ],
  );

  static ExamConfig fromFranchise(ExamFranchise franchise) {
    switch (franchise) {
      case ExamFranchise.yks:
        return yks;
      case ExamFranchise.dgs:
        return dgs;
      case ExamFranchise.lgs:
        return lgs;
      case ExamFranchise.kpss:
        return kpss;
    }
  }

  static ExamFranchise fromString(String key) {
    switch (key.trim().toLowerCase()) {
      case 'dgs':
      case 'dgsquest':
        return ExamFranchise.dgs;
      case 'lgs':
      case 'lgsquest':
        return ExamFranchise.lgs;
      case 'kpss':
      case 'kpssquest':
        return ExamFranchise.kpss;
      case 'yks':
      case 'yksquest':
      default:
        return ExamFranchise.yks;
    }
  }
}
