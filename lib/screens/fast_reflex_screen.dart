import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/game_provider.dart';
import '../services/sound_service.dart';

class ReflexQuestion {
  final String prompt;
  final String triggerWord;
  final String correctAnswer;
  final List<String> wrongOptions;
  final String memoryCode;
  final String subject;

  const ReflexQuestion({
    required this.prompt,
    required this.triggerWord,
    required this.correctAnswer,
    required this.wrongOptions,
    required this.memoryCode,
    required this.subject,
  });
}

final List<ReflexQuestion> yksReflexBank = [
  const ReflexQuestion(
    prompt: "Türk edebiyatında ilk psikolojik roman ve yazarı hangisidir?",
    triggerWord: "İlk Psikolojik Roman",
    correctAnswer: "Eylül - Mehmet Rauf",
    wrongOptions: [
      "Mai ve Siyah - Halit Ziya",
      "Zehra - Nabizade Nazım",
      "Araba Sevdası - Recaizade Mahmut Ekrem"
    ],
    memoryCode: "Eylül = Mehmet Rauf (İlk psikolojik roman denemesi ise Zehra'dır)!",
    subject: "YKS Edebiyat",
  ),
  const ReflexQuestion(
    prompt: "İki kare farkı özdeşliği formülü nedir?",
    triggerWord: "a² - b²",
    correctAnswer: "(a - b)(a + b)",
    wrongOptions: [
      "(a - b)²",
      "a² - 2ab + b²",
      "a² + b²"
    ],
    memoryCode: "a² - b² = (a - b)(a + b) daima!",
    subject: "YKS Matematik",
  ),
  const ReflexQuestion(
    prompt: "Hücrede protein sentezinin gerçekleştiği zarsız organel hangisidir?",
    triggerWord: "Protein Fabrikası",
    correctAnswer: "Ribozom",
    wrongOptions: [
      "Mitokondri",
      "Golgi Aygıtı",
      "Lizozom"
    ],
    memoryCode: "Ribozom tüm hücrelerde bulunan evrensel protein fabrikasıdır!",
    subject: "YKS Biyoloji",
  ),
  const ReflexQuestion(
    prompt: "Işığın boşluktaki hızı c yaklaşık olarak kaçtır?",
    triggerWord: "Işık Hızı (c)",
    correctAnswer: "3 x 10⁸ m/s",
    wrongOptions: [
      "3 x 10⁶ m/s",
      "340 m/s",
      "3 x 10¹⁰ m/s"
    ],
    memoryCode: "c = 300.000 km/s = 3 x 10⁸ m/s!",
    subject: "YKS Fizik",
  ),
  const ReflexQuestion(
    prompt: "pH değeri 7'den küçük olan çözeltiler hangi özelliktedir?",
    triggerWord: "pH < 7",
    correctAnswer: "Asidik Özelliktedir",
    wrongOptions: [
      "Bazik özelliktedir",
      "Nötr özelliktedir",
      "Tuzlu özelliktedir"
    ],
    memoryCode: "0-7 arası Asit, 7 Nötr, 7-14 arası Bazdır!",
    subject: "YKS Kimya",
  ),
  const ReflexQuestion(
    prompt: "Kurtuluş Savaşı'nda Milli Mücadele'nin amacı, gerekçesi ve yöntemi nerede açıklandı?",
    triggerWord: "Milli Mücadele Programı",
    correctAnswer: "Amasya Genelgesi (Tamimi)",
    wrongOptions: [
      "Erzurum Kongresi",
      "Sivas Kongresi",
      "Havza Genelgesi"
    ],
    memoryCode: "Amaç, gerekçe, yöntem = Amasya Genelgesi!",
    subject: "YKS Tarih",
  ),
  const ReflexQuestion(
    prompt: "Türkiye'de yerel saat en ileri olan ilimiz hangisidir?",
    triggerWord: "En İleri Yerel Saat",
    correctAnswer: "Iğdır (45° Doğu Meridyeni)",
    wrongOptions: [
      "Edirne",
      "Çanakkale",
      "Hatay"
    ],
    memoryCode: "Güneş doğuda erken doğar ve batar; en doğumuz Iğdır'dır!",
    subject: "YKS Coğrafya",
  ),
  const ReflexQuestion(
    prompt: "Parabolün tepe noktası T(r, k) için r formülü nedir?",
    triggerWord: "Parabol Tepe Noktası r",
    correctAnswer: "r = -b / (2a)",
    wrongOptions: [
      "r = -b / a",
      "r = c / a",
      "r = b² - 4ac"
    ],
    memoryCode: "Simetri ekseni: r = -b / (2a)!",
    subject: "YKS AYT Matematik",
  ),
  const ReflexQuestion(
    prompt: "f(x) = xⁿ fonksiyonunun türevi f'(x) nedir?",
    triggerWord: "Kuvvet Türevi",
    correctAnswer: "n · x^(n-1)",
    wrongOptions: [
      "x^(n+1) / (n+1)",
      "n · x^(n+1)",
      "x^(n-1)"
    ],
    memoryCode: "Üs başa çarpım düşer, üs bir azalır: n · x^(n-1)!",
    subject: "YKS AYT Matematik",
  ),
  const ReflexQuestion(
    prompt: "Türk edebiyatında ilk yerli tiyatro eseri ve yazarı hangisidir?",
    triggerWord: "İlk Yerli Tiyatro",
    correctAnswer: "Şair Evlenmesi - Şinasi",
    wrongOptions: [
      "Vatan yahut Silistre - Namık Kemal",
      "Çok Bilen Çok Yanılır - Recaizade",
      "Zavallı Çocuk - Namık Kemal"
    ],
    memoryCode: "İlk yerli tiyatro Şinasi'nin Şair Evlenmesi (Sahnelenen ise Vatan yahut Silistre)!",
    subject: "YKS Edebiyat",
  ),
  const ReflexQuestion(
    prompt: "Hücre solunumunda glikoliz evresi nerede gerçekleşir?",
    triggerWord: "Glikoliz Yeri",
    correctAnswer: "Sitoplazmada (Tüm canlılarda ortak)",
    wrongOptions: [
      "Mitokondri matriksinde",
      "Krista zarlarında",
      "Çekirdek içinde"
    ],
    memoryCode: "Glikoliz sitoplazmada başlar ve tüm canlılarda ortaktır!",
    subject: "YKS Biyoloji",
  ),
  const ReflexQuestion(
    prompt: "Bir cisme etki eden net kuvvet sıfır ise ivmesi ne olur?",
    triggerWord: "F_net = 0",
    correctAnswer: "İvme Sıfırdır (Durgun kalır veya Sabit Hızla gider)",
    wrongOptions: [
      "Düzgün hızlanır",
      "Düzgün yavaşlar",
      "Dairesel döner"
    ],
    memoryCode: "Newton 1. Yasa (Eylemsizlik): F_net = 0 => a = 0!",
    subject: "YKS Fizik",
  ),
  const ReflexQuestion(
    prompt: "Periyodik cetvelde soldan sağa gidildikçe elektronegatiflik genelde nasıl değişir?",
    triggerWord: "Elektronegatiflik Eğilimi",
    correctAnswer: "Artar (Sağa ve yukarı doğru artış)",
    wrongOptions: [
      "Azalır",
      "Önce artar sonra azalır",
      "Değişmez sabittir"
    ],
    memoryCode: "Ametalik özellik ve elektronegatiflik sağa ve yukarı (Flor'a) doğru artar!",
    subject: "YKS Kimya",
  ),
  const ReflexQuestion(
    prompt: "İstiklal Marşı'mız hangi tarihi savaşın ardından TBMM'de kabul edilmiştir?",
    triggerWord: "İstiklal Marşı Kabulü",
    correctAnswer: "I. İnönü Zaferi (12 Mart 1921)",
    wrongOptions: [
      "Sakarya Meydan Muharebesi",
      "Büyük Taarruz",
      "II. İnönü Zaferi"
    ],
    memoryCode: "1. İnönü sonrası: MİLAL (Moskova, İstiklal Marşı, Londra, Afgan, Anayasa)!",
    subject: "YKS Tarih",
  ),
  const ReflexQuestion(
    prompt: "Akdeniz ikliminin karakteristik doğal bitki örtüsü nedir?",
    triggerWord: "Akdeniz Bitki Örtüsü",
    correctAnswer: "Maki (Bodur çalılar)",
    wrongOptions: [
      "Bozkır (Step)",
      "Tayga ormanları",
      "Tundra"
    ],
    memoryCode: "Kızılçam tahribiyle oluşan bodur çalı topluluğu = Maki!",
    subject: "YKS Coğrafya",
  ),
  const ReflexQuestion(
    prompt: "30-60-90 dik üçgeninde hipotenüs 2a ise 30 ve 60 derecelerin karşısı?",
    triggerWord: "30 - 60 - 90 Üçgeni",
    correctAnswer: "30° karşısı a, 60° karşısı a√3",
    wrongOptions: [
      "30° karşısı a√2, 60° karşısı a",
      "30° karşısı a, 60° karşısı 2a",
      "30° karşısı a/2, 60° karşısı a"
    ],
    memoryCode: "30'un karşısı hipotenüsün YARISI (a), 60'ın karşısı a√3!",
    subject: "YKS Geometri",
  ),
  const ReflexQuestion(
    prompt: "Türevde f'(x) = 0 yapan ve işaret değiştiren noktaya ne denir?",
    triggerWord: "f'(x) = 0 Noktası",
    correctAnswer: "Yerel Ekstremum (Maksimum veya Minimum)",
    wrongOptions: [
      "Dönüm (Büküm) Noktası",
      "Düşey Asimptot",
      "Süreksizlik Noktası"
    ],
    memoryCode: "1. türevin kökü ve işaret değişimi = Ekstremum!",
    subject: "YKS AYT Matematik",
  ),
  const ReflexQuestion(
    prompt: "Divan edebiyatında şairlerin takma adına ne denir?",
    triggerWord: "Şair Takma Adı",
    correctAnswer: "Mahlas (Halkta Tapşırma)",
    wrongOptions: [
      "Mazmun",
      "Müstezat",
      "Münşeat"
    ],
    memoryCode: "Divanda Mahlas, Halk edebiyatında Tapşırma!",
    subject: "YKS Edebiyat",
  ),
  const ReflexQuestion(
    prompt: "Mendel genetiğinde iki melez (Heterozigot Aa x Aa) çaprazlandığında fenotip oranı?",
    triggerWord: "Monohibrit Fenotip",
    correctAnswer: "3 : 1",
    wrongOptions: [
      "9 : 3 : 3 : 1",
      "1 : 2 : 1",
      "1 : 1"
    ],
    memoryCode: "Monohibrit fenotip oranı 3:1, genotip oranı 1:2:1'dir!",
    subject: "YKS Biyoloji",
  ),
  const ReflexQuestion(
    prompt: "Serbest düşmeye bırakılan bir cismin t sürede aldığı yol formülü?",
    triggerWord: "Serbest Düşme h",
    correctAnswer: "h = 1/2 · g · t² (g=10 için 5t²)",
    wrongOptions: [
      "h = g · t",
      "h = v · t",
      "h = 1/2 · m · v²"
    ],
    memoryCode: "h = 5, 15, 25... metre yolları alır (h = 5t²)!",
    subject: "YKS Fizik",
  ),
];

class FastReflexScreen extends ConsumerStatefulWidget {
  const FastReflexScreen({super.key});

  @override
  ConsumerState<FastReflexScreen> createState() => _FastReflexScreenState();
}

class _FastReflexScreenState extends ConsumerState<FastReflexScreen> {
  int _score = 0;
  int _combo = 0;
  int _currentIndex = 0;
  int _timeLeft = 7;
  Timer? _timer;
  bool _isAnswered = false;
  int? _selectedOptionIndex;
  late List<ReflexQuestion> _questions;
  late List<String> _currentShuffledOptions;

  @override
  void initState() {
    super.initState();
    _questions = List.from(yksReflexBank)..shuffle();
    _prepareQuestion();
  }

  void _prepareQuestion() {
    if (_currentIndex >= _questions.length) {
      _questions.shuffle();
      _currentIndex = 0;
    }
    final q = _questions[_currentIndex];
    final allOps = [q.correctAnswer, ...q.wrongOptions];
    allOps.shuffle();
    _currentShuffledOptions = allOps;
    _isAnswered = false;
    _selectedOptionIndex = null;
    _timeLeft = 7;

    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) return;
      setState(() {
        if (_timeLeft > 1) {
          _timeLeft--;
        } else {
          _onTimeOut();
        }
      });
    });
  }

  void _onTimeOut() {
    _timer?.cancel();
    _isAnswered = true;
    _combo = 0;
    HapticFeedback.heavyImpact();
    SoundService.playIncorrect();
    setState(() {});
    _scheduleNext();
  }

  void _onOptionSelected(int index) {
    if (_isAnswered) return;
    _timer?.cancel();
    _isAnswered = true;
    _selectedOptionIndex = index;

    final q = _questions[_currentIndex];
    final isCorrect = (_currentShuffledOptions[index] == q.correctAnswer);

    if (isCorrect) {
      _combo++;
      final addedScore = 100 + (_combo * 20) + (_timeLeft * 10);
      _score += addedScore;
      HapticFeedback.mediumImpact();
      SoundService.playCorrect();
      ref.read(userProfileProvider.notifier).addXp(15);
    } else {
      _combo = 0;
      HapticFeedback.heavyImpact();
      SoundService.playIncorrect();
    }

    setState(() {});
    _scheduleNext();
  }

  void _scheduleNext() {
    Future.delayed(const Duration(milliseconds: 1800), () {
      if (!mounted) return;
      setState(() {
        _currentIndex++;
        _prepareQuestion();
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final q = _questions[_currentIndex];

    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white70),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFF10B981).withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const Text('⚡ ', style: TextStyle(fontSize: 16)),
                  Text(
                    'Puan: $_score',
                    style: const TextStyle(
                      color: Color(0xFF34D399),
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            if (_combo > 1)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.amber.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '${_combo}x Seri!',
                  style: const TextStyle(
                    color: Colors.amberAccent,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              const SizedBox(height: 10),
              // Geri sayım barı
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: LinearProgressIndicator(
                  value: _timeLeft / 7.0,
                  minHeight: 8,
                  backgroundColor: Colors.white10,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    _timeLeft <= 2 ? Colors.redAccent : const Color(0xFF10B981),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Konu & Tetikleyici Rozeti
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1E293B),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      q.subject,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: const Color(0xFF10B981).withOpacity(0.15),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '⚡ ${q.triggerWord}',
                      style: const TextStyle(
                        color: Color(0xFF34D399),
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              // Soru Metni
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E293B),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.08),
                    width: 1.5,
                  ),
                ),
                child: Column(
                  children: [
                    Text(
                      q.prompt,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        height: 1.4,
                      ),
                    ),
                    if (_isAnswered) ...[
                      const SizedBox(height: 14),
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: const Color(0xFF334155),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            const Text('💡 ', style: TextStyle(fontSize: 16)),
                            Expanded(
                              child: Text(
                                q.memoryCode,
                                style: const TextStyle(
                                  color: Color(0xFF93C5FD),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              const Spacer(),
              // Şıklar
              ...List.generate(_currentShuffledOptions.length, (idx) {
                final optionText = _currentShuffledOptions[idx];
                final isCorrectOption = (optionText == q.correctAnswer);
                final isSelected = (_selectedOptionIndex == idx);

                Color btnBg = const Color(0xFF1E293B);
                Color borderC = Colors.white.withOpacity(0.1);
                Color textC = Colors.white;

                if (_isAnswered) {
                  if (isCorrectOption) {
                    btnBg = const Color(0xFF059669).withOpacity(0.3);
                    borderC = const Color(0xFF10B981);
                    textC = const Color(0xFF34D399);
                  } else if (isSelected) {
                    btnBg = Colors.redAccent.withOpacity(0.3);
                    borderC = Colors.redAccent;
                    textC = Colors.redAccent;
                  }
                }

                return Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: InkWell(
                    onTap: _isAnswered ? null : () => _onOptionSelected(idx),
                    borderRadius: BorderRadius.circular(14),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                      decoration: BoxDecoration(
                        color: btnBg,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: borderC, width: 2),
                      ),
                      child: Text(
                        optionText,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: textC,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                );
              }),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
