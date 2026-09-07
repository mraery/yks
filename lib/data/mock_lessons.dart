import '../models/lesson_models.dart';

final List<LearningUnit> mockUnits = [
  // ===========================================================================
  // ÜNİTE 1: TYT TÜRKÇE - SÖZCÜK VE CÜMLEDE ANLAM
  // ===========================================================================
  LearningUnit(
    id: 'unit_turkce_1',
    unitNumber: 1,
    title: 'Sözcük ve Cümlede Anlam',
    subject: 'TYT Türkçe',
    colorHex: 0xFF58CC02, // Duolingo Yeşil
    lessons: [
      Lesson(
        id: 'lesson_tr_1',
        title: 'Mecaz, Yan & Terim Anlam',
        description: 'Önce kuralı öğren, hemen peşinden soruyu çöz!',
        xpReward: 35,
        gemReward: 12,
        questions: [
          // 1. KAVRAM KARTI: Mecaz Anlam
          Question(
            id: 'concept_tr_1_1',
            type: QuestionType.conceptCard,
            conceptTitle: 'Mecaz Anlam Nedir?',
            iconEmoji: '💡',
            rule: 'Bir sözcüğün gerçek (ilk/sözlük) anlamından tamamen uzaklaşarak kazandığı yeni ve genellikle SOYUT anlama "Mecaz Anlam" denir.',
            examples: [
              '"Bu soğuk tavırlarıyla herkesin kalbini kırdı." (İncitmek, gücendirmek anlamında mecaz)',
              '"Boş sözlerle beni oyalamaktan vazgeç." (Yararsız, anlamsız anlamında mecaz)',
            ],
            examTip: 'Mecaz anlam çoğunlukla somut bir eylemin (kırmak, yakmak, uçmak) duygu ve düşünce dünyasına aktarılmasıyla (soyutlama) yapılır.',
          ),
          // 1. SORU: Mecaz Anlam (ABCD)
          Question(
            id: 'q_tr_1_1',
            type: QuestionType.multipleChoice,
            prompt: 'Aşağıdaki altı çizili sözcüklerden hangisi "mecaz anlamda" kullanılmıştır?',
            options: [
              'Yere düşen bardağın "kırık" parçalarını topladı.',
              'Bu soğuk tavırlarıyla herkesin kalbini "kırdı".',
              'Rüzgarın etkisiyle ceviz ağacının dalı "kırıldı".',
              'Kilit "kırılınca" kapıyı güçlükle açabildiler.',
            ],
            correctIndex: 1,
            explanation: '"Kalp kırmak", incitmek ve gücendirmek anlamında tamamen yeni ve soyut bir anlam kazandığı için mecazdır.',
          ),

          // 2. KAVRAM KARTI: Yan Anlam
          Question(
            id: 'concept_tr_1_2',
            type: QuestionType.conceptCard,
            conceptTitle: 'Yan Anlam (Yakıştırmaca)',
            iconEmoji: '🔍',
            rule: 'Sözcüğün gerçek anlamından tamamen kopmadan, şekil veya işlev benzerliğiyle başka bir varlığa aktarılmasıdır.',
            examples: [
              '"Uçağın burnu" -> İnsan burnunun önde olması benzerliği',
              '"Masanın ayağı" -> Ayakta tutma işlevi benzerliği',
              '"Kapının kolu" -> Tutma ve hareket ettirme benzerliği',
            ],
            examTip: 'Yan anlam ile Mecaz anlamı karıştırma! Yan anlamda fiziksel benzerlik veya fonksiyonel ilişki devam eder; mecazda ise bağ kopar ve soyutlaşır.',
          ),
          // 2. SORU: Yan Anlam Boşluk Doldurma
          Question(
            id: 'q_tr_1_2',
            type: QuestionType.fillInTheBlank,
            prompt: 'Bir sözcüğün biçim veya görev benzerliğiyle yeni bir varlığı karşılamasına _____ denir.',
            blankOptions: ['yan anlam', 'mecaz anlam', 'terim anlam', 'zıt anlam'],
            correctBlankAnswer: 'yan anlam',
            explanation: 'Şekil ve işlev benzerliğiyle yapılan aktarmalar "yan anlam" olarak adlandırılır.',
          ),

          // 3. KAVRAM KARTI: Terim Anlam
          Question(
            id: 'concept_tr_1_3',
            type: QuestionType.conceptCard,
            conceptTitle: 'Terim Anlam',
            iconEmoji: '📚',
            rule: 'Bilim, sanat, spor veya meslek dalına özgü özel kavramları karşılayan sözcüklerdir.',
            examples: [
              'Spor: Penaltı, korner, faul, kırmızı kart',
              'Edebiyat: Kafiye, redif, aruz ölçüsü, teşbih',
              'Geometri: Üçgen, hipotenüs, açı, teğet',
            ],
            examTip: 'Bir sözcüğün terim olabilmesi için o alana ait teknik bir kavramı karşılaması gerekir. Günlük dildeki genel sözcükler terim sayılmaz.',
          ),
          // 3. SORU: Terim Anlam (ABCD)
          Question(
            id: 'q_tr_1_3',
            type: QuestionType.multipleChoice,
            prompt: 'Aşağıdaki cümlelerin hangisinde "terim anlamlı" bir sözcük kullanılmıştır?',
            options: [
              'Akşam güneşi odanın içine tatlı bir sıcaklık yayıyordu.',
              'Hakem ikinci yarıda oyuncuya doğrudan "kırmızı kart" gösterdi.',
              'Yolun sonundaki virajı hızla dönünce çok korktuk.',
              'Bu zor günleri hep birlikte el ele vererek aşacağız.',
            ],
            correctIndex: 1,
            explanation: '"Kırmızı kart", futbol spor dalına ait teknik bir terimdir.',
          ),

          // 4. KAVRAM KARTI: Somutlama & Soyutlama
          Question(
            id: 'concept_tr_1_4',
            type: QuestionType.conceptCard,
            conceptTitle: 'Somutlama & Soyutlama',
            iconEmoji: '🧠',
            rule: 'Soyut bir kavramı anlatırken zihinde canlandırmayı kolaylaştırmak için somut bir varlıkmış gibi ifade etmeye "Somutlama" denir.',
            examples: [
              '"Felek bana çelme taktı." (Kader/şans soyutken çelme takan insan gibi somutlaştırıldı)',
              '"Bu dert beni yedi bitirdi." (Üzüntü somut bir canlı gibi anlatıldı)',
            ],
            examTip: 'Deyimler ve benzetmeler somutlamanın en sık kullanıldığı alanlardır. ÖSYM, anlam olayları sorularında somutlamayı sık sorar.',
          ),
          // 4. SORU: Somutlama (ABCD)
          Question(
            id: 'q_tr_1_4',
            type: QuestionType.multipleChoice,
            prompt: 'Aşağıdaki cümlelerin hangisinde soyut bir kavram "somutlaştırılarak" anlatılmıştır?',
            options: [
              'Kitaplığındaki tüm eski romanları kolilere yerleştirdi.',
              'Yalnızlık bir gölge gibi peşimden hiç ayrılmıyor.',
              'Akşam serinliğinde balkonda çay içmeyi çok severdi.',
              'Tren istasyona tam vaktinde ulaştı.',
            ],
            correctIndex: 1,
            explanation: 'Soyut bir kavram olan "yalnızlık", insanı takip eden somut bir "gölge"ye benzetilerek somutlaştırılmıştır.',
          ),
        ],
      ),

      Lesson(
        id: 'lesson_tr_2',
        title: 'Deyimler & Kalıplaşmış Sözler',
        description: 'Önce deyimin sırrını kavra, sonra eşleştirmeyi tamamla!',
        xpReward: 40,
        gemReward: 15,
        questions: [
          // 1. KAVRAM KARTI: Deyimlerin Özellikleri
          Question(
            id: 'concept_tr_2_1',
            type: QuestionType.conceptCard,
            conceptTitle: 'Deyimlerin Altın Kuralları',
            iconEmoji: '⚡',
            rule: 'Deyimler en az iki sözcükten oluşan, kalıplaşmış ve genellikle mecaz anlam taşıyan zengin anlatım kalıplarıdır.',
            examples: [
              'Kalıplaşmıştır: "Ayıkla pirincin taşını" yerine "Ayıkla bulgurun taşını" diyemezsin!',
              'Eş anlamlısı konamaz: "Yüzünden düşen bin parça" yerine "Çehresinden düşen..." denemez.',
            ],
            examTip: 'ÖSYM, deyimlerin sözcüklerinin değiştirilmesiyle oluşan anlatım bozukluklarını ve cümlenin anlamına uymayan deyim kullanımını sıkça sorar!',
          ),
          // 1. SORU: Deyim Eşleştirme Oyunu
          Question(
            id: 'q_tr_2_1',
            type: QuestionType.matching,
            prompt: 'Deyimleri doğru anlamlarıyla eşleştirin:',
            explanation: 'Deyimler Türkçede kalıplaşmış ve mecaz anlam taşıyan zengin ifadelerdir.',
            matchingPairs: [
              MatchingPair(left: 'Etekleri zil çalmak', right: 'Çok sevinmek'),
              MatchingPair(left: 'Göze girmek', right: 'Beğeni kazanmak'),
              MatchingPair(left: 'Kulak kabartmak', right: 'Çaktırmadan dinlemek'),
              MatchingPair(left: 'Burnu havada olmak', right: 'Kibirli davranmak'),
            ],
          ),

          // 2. KAVRAM KARTI: Gerçek Anlamlı Deyimler Tuzağı
          Question(
            id: 'concept_tr_2_2',
            type: QuestionType.conceptCard,
            conceptTitle: 'ÖSYM Tuzağı: Gerçek Anlamlı Deyimler',
            iconEmoji: '🎯',
            rule: 'Deyimlerin çoğu mecaz anlamlı olsa da, BAZI DEYİMLER tamamen GERÇEK ANLAMLIDIR.',
            examples: [
              '"Çoğu gitti azı kaldı" -> Mecaz yok, işin bitmek üzere olduğunu bildirir.',
              '"Yükte hafif, pahada ağır" -> Değerli ama taşınması kolay eşyalar için gerçek anlamında kullanılır.',
              '"Pireyi deve yapmak" -> Mecaz anlamlıdır; ufak şeyi abartmaktır.',
            ],
            examTip: 'Soru kökünde "Hangisi gerçek anlamını korumaktadır?" diye sorulduğunda doğrudan sözcüklerin birebir karşılığına bak!',
          ),
          // 2. SORU: Deyim Çoktan Seçmeli (ABCD)
          Question(
            id: 'q_tr_2_2',
            type: QuestionType.multipleChoice,
            prompt: '"Pireyi deve yapmak" deyiminin anlamı aşağıdakilerden hangisidir?',
            options: [
              'Önemsiz bir durumu çok büyütüp abartmak',
              'Büyük işleri kolayca halletmek',
              'Çok tutumlu ve dikkatli davranmak',
              'Zor durumdaki birine destek olmak',
            ],
            correctIndex: 0,
            explanation: 'Pireyi deve yapmak; ufak, önemsiz bir meseleyi gereksizce abartıp sorun yapmaktır.',
          ),

          // 3. KAVRAM KARTI: Atasözü ile Deyim Farkı
          Question(
            id: 'concept_tr_2_3',
            type: QuestionType.conceptCard,
            conceptTitle: 'Atasözü vs Deyim Farkı',
            iconEmoji: '⚖️',
            rule: 'Deyimler bir anlık durumu, hissi veya davranışı anlatır; ders verme veya genel ahlaki kural koyma amacı taşımaz. Atasözleri ise genel geçer bir hayat dersi ve öğüt içerir.',
            examples: [
              'Deyim: "Ateş püskürmek" -> Sadece o anki aşırı öfkeyi anlatır, öğüt vermez.',
              'Atasözü: "Öfkeyle kalkan zararla oturur" -> Genel bir kural koyar ve ders verir.',
            ],
            examTip: 'Cümle "öğüt" veriyorsa atasözüdür; sadece bir "durumu" betimliyorsa deyimdir.',
          ),
          // 3. SORU: Atasözü vs Deyim (ABCD)
          Question(
            id: 'q_tr_2_3',
            type: QuestionType.multipleChoice,
            prompt: 'Aşağıdakilerden hangisi bir "öğüt veya genel hayat dersi" içeren bir atasözüdür?',
            options: [
              'İki ayağı bir pabuca girmek',
              'Damlaya damlaya göl olur',
              'Göz boyamak',
              'Kulak misafiri olmak',
            ],
            correctIndex: 1,
            explanation: '"Damlaya damlaya göl olur" tasarrufu öğütleyen bir atasözüdür; diğerleri ise geçici durum bildiren deyimlerdir.',
          ),
          // 4. SORU: Deyim Boşluk Doldurma
          Question(
            id: 'q_tr_2_4',
            type: QuestionType.fillInTheBlank,
            prompt: 'Deyimler kalıplaşmış olduğu için "Başına çorap örmek" yerine "Başına _____ örmek" denilemez.',
            blankOptions: ['kazak', 'şapka', 'atkı', 'eldiven'],
            correctBlankAnswer: 'kazak',
            explanation: 'Deyimlerin kelimeleri değiştirilemez, eş ya da yakın anlamlıları dahi konulamaz.',
          ),
          // 5. SORU: Deyim Eşleştirme
          Question(
            id: 'q_tr_2_5',
            type: QuestionType.matching,
            prompt: 'Deyimleri doğru anlamlarıyla eşleştirin:',
            explanation: 'Deyimler Türkçede duygu ve durumları en veciz anlatan kalıplardır.',
            matchingPairs: [
              MatchingPair(left: 'Ağzı kulaklarına varmak', right: 'Aşırı mutlu olmak'),
              MatchingPair(left: 'Can kulağıyla dinlemek', right: 'Büyük dikkatle dinlemek'),
              MatchingPair(left: 'Çam devirmek', right: 'İstemeden pot kırmak'),
              MatchingPair(left: 'İçi içine sığmamak', right: 'Büyük sabırsızlık duymak'),
            ],
          ),
        ],
      ),

      Lesson(
        id: 'lesson_tr_3',
        title: 'Cümlede Anlam İlişkileri',
        description: 'Amaç, Neden ve Koşul cümlelerinin gizli şifreleri',
        xpReward: 45,
        gemReward: 15,
        questions: [
          // 1. KAVRAM KARTI: Neden-Sonuç vs Amaç-Sonuç
          Question(
            id: 'concept_tr_3_1',
            type: QuestionType.conceptCard,
            conceptTitle: 'Neden-Sonuç vs Amaç-Sonuç Formülü',
            iconEmoji: '⚖️',
            rule: 'Bu iki cümleyi ayırt etmenin garantili YKS formülü şudur:\n• Cümleye "-mek/mak AMACIYLA" koyabiliyorsan AMAÇ-SONUÇTUR.\n• Cümleye "-dığı için / gerekçesiyle" koyabiliyorsan NEDEN-SONUÇTUR.',
            examples: [
              '"Sınavı kazanmak için gece gündüz çalıştı." -> "Kazanmak amacıyla çalıştı" (AMAÇ-SONUÇ)',
              '"Kar yağdığı için yollar kapandı." -> "Kar yağması gerekçesiyle kapandı" (NEDEN-SONUÇ)',
            ],
            examTip: 'Amaç-sonuç cümlelerinde hedeflenen eylem henüz gerçekleşmemiştir (kazandı mı bilmiyoruz). Neden-sonuçta ise sebep eylemi zaten gerçekleşmiştir (kar yağmış bitmiş).',
          ),
          // 1. SORU: Boşluk Doldurma
          Question(
            id: 'q_tr_3_1',
            type: QuestionType.fillInTheBlank,
            prompt: 'Bir cümlede eylemin hangi hedef doğrultusunda yapıldığını anlamak için cümleye _____ ifadesi getirilir.',
            blankOptions: ['amacıyla', 'sebebiyle', 'koşuluyla', 'rağmen'],
            correctBlankAnswer: 'amacıyla',
            explanation: 'Amaç-sonuç cümlelerinin sağlaması "-mek/mak amacıyla" ifadesi eklenerek yapılır.',
          ),
          // 2. SORU: Amaç-Sonuç (ABCD)
          Question(
            id: 'q_tr_3_2',
            type: QuestionType.multipleChoice,
            prompt: 'Aşağıdaki cümlelerin hangisinde "amaç-sonuç" ilişkisi vardır?',
            options: [
              'Geç uyandığından dolayı ilk derse yetişemedi.',
              'Yeni çıkan kitabı satın almak üzere kitapçıya gitti.',
              'Hava aniden soğuyunca kalın montunu giydi.',
              'Çok yorulduğu için koltukta uyuyakalmış.',
            ],
            correctIndex: 1,
            explanation: '"Satın almak üzere" yerine "satın almak amacıyla" getirilebildiği için amaç-sonuç ilişkisidir.',
          ),

          // 2. KAVRAM KARTI: Koşul (Şart)-Sonuç
          Question(
            id: 'concept_tr_3_2',
            type: QuestionType.conceptCard,
            conceptTitle: 'Koşul (Şart)-Sonuç Cümleleri',
            iconEmoji: '🔒',
            rule: 'Bir olayın veya eylemin gerçekleşmesinin başka bir olayın gerçekleşmesine bağlı kılındığı cümlelerdir. En yaygın ek "-se / -sa" ve edat "üzere"dir.',
            examples: [
              '"Akşama geri vermek üzere bu kitabı alabilirsin." (Alma şartı: geri vermek)',
              '"Planlı çalışırsan hedefine rahatça ulaşırsın." (Ulaşma şartı: planlı çalışmak)',
            ],
            examTip: '"-mek üzere" ifadesi hem AMAÇ hem de KOŞUL bildirebilir! "Geri vermek üzere aldı" (koşul), "Konuşmak üzere kürsüye çıktı" (amaç).',
          ),
          // 3. SORU: Koşul-Sonuç (ABCD)
          Question(
            id: 'q_tr_3_3',
            type: QuestionType.multipleChoice,
            prompt: 'Aşağıdaki cümlelerin hangisinde eylemin gerçekleşmesi bir "şarta (koşula)" bağlanmıştır?',
            options: [
              'Yaz gelince yaylaya göç etmeye başladılar.',
              'Gürültü yapmamak kaydıyla kütüphanede kalabilirsiniz.',
              'Hava kararmadan eve dönmek için acele etti.',
              'Kardeşi doğduğu gün dünyalar onun olmuştu.',
            ],
            correctIndex: 1,
            explanation: '"Gürültü yapmamak kaydıyla" ifadesi kütüphanede kalmanın açık bir koşuludur.',
          ),

          // 3. KAVRAM KARTI: Örtülü Anlam
          Question(
            id: 'concept_tr_3_3',
            type: QuestionType.conceptCard,
            conceptTitle: 'Örtülü Anlam Çıkarımı',
            iconEmoji: '🕵️',
            rule: 'Cümlede doğrudan söylenmeyen ancak bazı ek ve bağlaçlarla ("de/da", "artık", "bile", "en") sezdirilen gizli anlama "Örtülü Anlam" denir.',
            examples: [
              '"Bu yılki sınava Ali de girdi." -> Demek ki Ali dışında başkaları da sınava girdi.',
              '"Artık yalanlarına kimse inanmıyor." -> Demek ki eskiden inanıyorlardı.',
            ],
            examTip: 'ÖSYM Türkçe sorularında "Bu cümleden kesin olarak çıkarılabilecek yargı hangisidir?" tarzında örtülü anlamı doğrudan sorgular.',
          ),
          // 4. SORU: Örtülü Anlam (ABCD)
          Question(
            id: 'q_tr_3_4',
            type: QuestionType.multipleChoice,
            prompt: '"Bu yaz tatilinde de memleketime gidemedim." cümlesinden çıkarılabilecek KESİN yargı hangisidir?',
            options: [
              'Kişi bundan önceki en az bir yaz tatilinde daha memleketine gidememiştir.',
              'Kişi tatil yapmaktan hiç hoşlanmamaktadır.',
              'Kişi ailesiyle tartışmalı olduğu için gidememiştir.',
              'Kişi kış tatillerinde her zaman memleketine gitmektedir.',
            ],
            correctIndex: 0,
            explanation: '"Bu yaz tatilinde de" ifadesindeki "-de" bağlacı, daha önceki yaz tatillerinde de gidemediği örtülü anlamını kesinleştirir.',
          ),
          // 5. SORU: Cümle İlişkileri Eşleştirme
          Question(
            id: 'q_tr_3_5',
            type: QuestionType.matching,
            prompt: 'Cümleleri ifade ettikleri anlam ilişkileriyle eşleştirin:',
            explanation: 'Cümlede anlam ilişkileri her yıl TYT Türkçede en az 3-4 sorunun temelidir.',
            matchingPairs: [
              MatchingPair(left: 'Ders çalışmak için odasına çekildi', right: 'Amaç-Sonuç'),
              MatchingPair(left: 'Yağmur dindiğinden yürüyüşe çıktı', right: 'Neden-Sonuç'),
              MatchingPair(left: 'Not tutarsan konuyu unutmazsın', right: 'Koşul-Sonuç'),
              MatchingPair(left: 'Bu roman diğerinden daha akıcı', right: 'Karşılaştırma'),
            ],
          ),
        ],
      ),

      Lesson(
        id: 'lesson_tr_4',
        title: 'Paragrafta Ana Düşünce',
        description: 'Taktiklerle ana fikir yakalama ve paragraf çözümü',
        xpReward: 50,
        gemReward: 20,
        questions: [
          // 1. KAVRAM KARTI: Ana Düşünce Taktiği
          Question(
            id: 'concept_tr_4_1',
            type: QuestionType.conceptCard,
            conceptTitle: 'Paragrafta Ana Fikir Taktiği',
            iconEmoji: '🎯',
            rule: 'Ana düşünce; "Yazar bu parçayı ne amaçla yazdı? Bana ne mesaj vermek istiyor?" sorusunun tek cümlelik yanıtıdır.',
            examples: [
              'Taktik İfadeler: "Kısacası...", "Özetle...", "Asıl önemli olan...", "Oysa...", "Bence..."',
              'Bu ifadelerden sonra gelen cümle %85 ihtimalle parçanın ana fikridir!',
            ],
            examTip: 'Şıklarda paragrafta geçen kelimeler geçebilir ama bu onların ana fikir olduğu anlamına gelmez. Yardımcı düşünce ile ana fikri birbirine karıştırma!',
          ),
          // 1. SORU: Paragraf Sorusu (ABCD)
          Question(
            id: 'q_tr_4_1',
            type: QuestionType.multipleChoice,
            passage: 'Gerçek bir yazar, yalnızca kendi yaşadıklarını değil; başkalarının acılarını, sevinçlerini ve iç dünyasını da kendi ruhunda hissedebilen kişidir. Empati kurma yeteneği zayıf bir yazarın ürettiği karakterler solgun ve yapay kalmaya mahkûmdur.',
            prompt: 'Bu parçanın ana düşüncesi aşağıdakilerden hangisidir?',
            options: [
              'Yazarlık sadece çok kitap okumakla geliştirilebilir.',
              'Başarılı ve inandırıcı karakterler ancak güçlü bir empati yeteneğiyle doğar.',
              'Her yazar yalnızca kendi anılarını yazmalıdır.',
              'Roman yazmak en zor edebiyat türüdür.',
            ],
            correctIndex: 1,
            explanation: 'Parçada yazarın başkalarının iç dünyasını hissetmesi (empati) sayesinde inandırıcı ve güçlü karakterler üretebileceği açıkça vurgulanmıştır.',
          ),

          // 2. KAVRAM KARTI: Konu vs Ana Fikir
          Question(
            id: 'concept_tr_4_2',
            type: QuestionType.conceptCard,
            conceptTitle: 'Paragrafta Konu vs Ana Düşünce',
            iconEmoji: '💡',
            rule: 'Konu: "Bu metinde ne anlatılıyor?" sorusuna verilecek genel başlıktır.\nAna Düşünce ise: "Yazar bu konu üzerinden bana ne öğütlüyor, neyi savunuyor?" sorusunun yanıtıdır.',
            examples: [
              'Konu: Kitap okuma alışkanlığı',
              'Ana Fikir: Erken yaşta kitap okumak bireyin eleştirel düşünme gücünü artırır.',
            ],
            examTip: 'Konu birkaç sözcükle özetlenir, ana fikir ise mutlaka yargı bildiren tam bir cümledir.',
          ),
          // 2. SORU: Paragrafta Konu (ABCD)
          Question(
            id: 'q_tr_4_2',
            type: QuestionType.multipleChoice,
            passage: 'Zamanımızın büyük bir kısmını ekrana bakarak geçiriyoruz. Bildirimlerin ardı arkası kesilmiyor ve her uyarı dikkatimizi bölüyor. Derinlemesine odaklanma yerini saniyelik yüzeysel bakışlara bıraktı.',
            prompt: 'Bu parçanın "konusu" aşağıdakilerden hangisidir?',
            options: [
              'Dijital teknolojinin dikkat ve odaklanma üzerindeki olumsuz etkisi',
              'İnternet ortamında yapılan alışverişlerin güvenlik riskleri',
              'Sosyal medyanın gençler arasında yaygınlaşma hızı',
              'Televizyon dizilerinin dil üzerindeki zararları',
            ],
            correctIndex: 0,
            explanation: 'Metin dijital bildirimlerin ve ekranların dikkati dağıtması ve derin odaklanmayı yok etmesi konusunu ele almaktadır.',
          ),

          // 3. KAVRAM KARTI: Akışı Bozan Cümle
          Question(
            id: 'concept_tr_4_3',
            type: QuestionType.conceptCard,
            conceptTitle: 'Düşüncenin Akışını Bozan Cümle',
            iconEmoji: '✂️',
            rule: 'Bir paragrafta her cümle bir önceki cümlenin devamı niteliğindedir. Paragrafın genel konusundan sapan, konunun farklı ve ilgisiz bir yönüne geçen cümle "akışı bozar".',
            examples: [
              '1. Kahve dünyada en çok tüketilen içeceklerden biridir.',
              '2. Farklı demleme yöntemleriyle eşsiz lezzetler ortaya çıkar.',
              '3. Çay tiryakileri ince belli bardaktan asla vazgeçmez. (AKIŞI BOZDU!)',
              '4. Özellikle espresso bazlı içecekler günümüzde çok popülerdir.',
            ],
            examTip: 'Akışı bozan cümleyi metinden çıkardığınızda paragrafın anlam bütünlüğünde hiçbir bozulma veya kopukluk olmaz.',
          ),
          // 3. SORU: Akışı Bozan Cümle (ABCD)
          Question(
            id: 'q_tr_4_3',
            type: QuestionType.multipleChoice,
            passage: '(I) Şiir, sözcüklerin musikiyle buluştuğu en zarif sanat dalıdır. (II) Şair, sıradan sözcüklere yepyeni titreşimler kazandırır. (III) Roman yazarları ise olay örgüsünü kurabilmek için aylarca kurgu üzerine çalışırlar. (IV) Bu yüzden bir dize, bazen sayfalarca anlatılabilecek bir duyguyu tek nefeste fısıldar.',
            prompt: 'Bu parçadaki numaralanmış cümlelerden hangisi "düşüncenin akışını bozmaktadır"?',
            options: ['I', 'II', 'III', 'IV'],
            correctIndex: 2,
            explanation: 'Parça boyunca şiir ve dizeler anlatılırken III. cümlede aniden araya roman yazarlarının girmesi konunun akışını bozmuştur.',
          ),
          // 4. SORU: Paragraf Boşluk Doldurma
          Question(
            id: 'q_tr_4_4',
            type: QuestionType.fillInTheBlank,
            prompt: 'Bir paragrafın ana fikri bulunurken genellikle özetleyici nitelikteki _____ gibi bağlayıcı sözcüklerden sonra gelen cümleye odaklanılır.',
            blankOptions: ['kısacası', 'halbuki', 'örneğin', 'zira'],
            correctBlankAnswer: 'kısacası',
            explanation: '"Kısacası", "özetle", "sonuç olarak" ifadeleri ana fikrin sunulduğu en güçlü sinyallerdir.',
          ),
          // 5. SORU: Paragrafı İkiye Bölme (ABCD)
          Question(
            id: 'q_tr_4_5',
            type: QuestionType.multipleChoice,
            passage: '(I) Anadolu toprakları tarih boyunca onlarca medeniyete ev sahipliği yapmıştır. (II) Hititler, Frigler ve Urartular bu coğrafyada derin izler bırakmıştır. (III) Müzelerimiz bu köklü uygarlıkların paha biçilmez eserleriyle doludur. (IV) Son yıllarda müze işletmeciliğinde dijital teknolojiler öne çıkmaya başladı. (V) Ziyaretçiler artık sanal gözlüklerle tarihi mekânları birebir deneyimleyebiliyor.',
            prompt: 'Bu parça iki paragrafa ayrılmak istense ikinci paragraf numaralanmış cümlelerin hangisiyle başlar?',
            options: ['II', 'III', 'IV', 'V'],
            correctIndex: 2, // 'IV' is at index 2 of options ['II', 'III', 'IV', 'V']
            explanation: 'IV. cümleden itibaren Anadolu medeniyetlerinden çıkılıp "müzelerde dijital teknolojilerin kullanımı" konusuna geçilmiştir.',
          ),
        ],
      ),

      // ==========================================
      // ÜNİTE 1 SONU KUPA SINAVI (BOSS LEVEL)
      // ==========================================
      Lesson(
        id: 'exam_unit_tr_1',
        title: 'Ünite 1 Kupa Sınavı 🏆',
        description: 'Tüm üniteyi kapsayan karma A, B, C, D, eşleştirme ve boşluk doldurma final testi!',
        xpReward: 100,
        gemReward: 30,
        isUnitExam: true,
        questions: [
          Question(
            id: 'exam_tr1_q1',
            type: QuestionType.multipleChoice,
            prompt: 'Aşağıdaki cümlelerin hangisinde altı çizili sözcük "mecaz anlamıyla" kullanılmıştır?',
            options: [
              'Sıcak çorbayı içerken "dili" hafifçe yandı.',
              'Söylediği bu ağır sözler hepimizin "ağrına" gitti.',
              'Yol boyunca dizilmiş fidanları tek tek "suladılar".',
              'Kapının "kolu" gevşeyince usta çağırmak zorunda kaldık.',
            ],
            correctIndex: 1,
            explanation: '"Ağrına gitmek" sözcüğü gücenmek ve incinmek anlamında mecazlaşmıştır.',
          ),
          Question(
            id: 'exam_tr1_q2',
            type: QuestionType.fillInTheBlank,
            prompt: 'Deyimler kalıplaşmış söz öbekleri olduğu için sözcüklerinin yerine _____ konulamaz.',
            blankOptions: ['eş anlamlıları', 'zıt anlamlıları', 'ekler', 'noktalama'],
            correctBlankAnswer: 'eş anlamlıları',
            explanation: 'Deyimlerdeki sözcüklerin yerine eş anlamlıları dahi konulamaz; konulursa anlatım bozukluğu meydana gelir.',
          ),
          Question(
            id: 'exam_tr1_q3',
            type: QuestionType.matching,
            prompt: 'Kelimeleri kazandıkları anlam türleriyle eşleştirin:',
            explanation: 'Anlam bilgisi YKS Türkçe sınavının yaklaşık üçte birini oluşturur.',
            matchingPairs: [
              MatchingPair(left: 'Ağacın dalı', right: 'Gerçek Anlam'),
              MatchingPair(left: 'Dağın eteği', right: 'Yan Anlam'),
              MatchingPair(left: 'Soğuk bakışlar', right: 'Mecaz Anlam'),
              MatchingPair(left: 'Kafiye şeması', right: 'Terim Anlam'),
            ],
          ),
          Question(
            id: 'exam_tr1_q4',
            type: QuestionType.multipleChoice,
            prompt: 'Aşağıdaki cümlelerin hangisinde "neden-sonuç" ilişkisi vardır?',
            options: [
              'Kendini geliştirmek amacıyla yabancı dil kursuna yazıldı.',
              'Elektrikler kesildiği için akşamki canlı ders iptal edildi.',
              'Erken kalkarsan sabah yürüyüşüne birlikte çıkabiliriz.',
              'Güneş gözlüğünü arabada unuttuğunu fark etti.',
            ],
            correctIndex: 1,
            explanation: '"Elektriklerin kesilmesi gerekçesiyle/nedeniyle" ders iptal edilmiş, sebep-sonuç ilişkisidir.',
          ),
          Question(
            id: 'exam_tr1_q5',
            type: QuestionType.multipleChoice,
            prompt: '"Çoğu gitti azı kaldı" deyiminin dikkat çeken en belirgin özelliği nedir?',
            options: [
              'Tamamen gerçek anlamını koruyan bir deyim olması',
              'Sadece atasözü olarak kullanılabilmesi',
              'İçinde terim anlamlı sözcük barındırması',
              'Yalnızca mecaz anlam taşıması',
            ],
            correctIndex: 0,
            explanation: '"Çoğu gitti azı kaldı" deyimi nadir rastlanan tamamen gerçek anlamlı deyimlerden biridir.',
          ),
          Question(
            id: 'exam_tr1_q6',
            type: QuestionType.multipleChoice,
            prompt: 'Aşağıdaki cümlelerin hangisinde "öznel (kişisel)" bir yargı bildirilmektedir?',
            options: [
              'Türkiye\'nin başkenti Ankara\'dır.',
              'Romandaki tasvirler okuyucunun ruhunu adeta büyülüyor.',
              'Kitap toplam 320 sayfadan ve 12 bölümden oluşmaktadır.',
              'Yazar son kitabını 2023 yılında yayımladı.',
            ],
            correctIndex: 1,
            explanation: '"Ruhunu büyülüyor" ifadesi kişisel beğeni ve duygu içerdiği için kanıtlanamaz, öznel bir yargıdır.',
          ),
          Question(
            id: 'exam_tr1_q7',
            type: QuestionType.fillInTheBlank,
            prompt: 'Bir kişinin sözünü hiç değiştirmeden tırnak içinde veya virgülle aktarmaya _____ anlatım denir.',
            blankOptions: ['doğrudan', 'dolaylı', 'öznel', 'nesnel'],
            correctBlankAnswer: 'doğrudan',
            explanation: 'Başkasına ait bir sözün ağızdan çıktığı gibi aktarılmasına "doğrudan anlatım" denir.',
          ),
          Question(
            id: 'exam_tr1_q8',
            type: QuestionType.multipleChoice,
            prompt: 'Aşağıdakilerin hangisinde "somutlama" yapılmıştır?',
            options: [
              'Sınav stresi sanki omzunda ağır bir yük gibi duruyordu.',
              'Kütüphanedeki tüm ansiklopedileri raflara dizdi.',
              'Sabah erken saatlerde yoğun bir sis oluştu.',
              'Otobüs durakta yaklaşık on dakika bekledi.',
            ],
            correctIndex: 0,
            explanation: 'Soyut bir his olan "stres", omuza binen somut bir yüke benzetilerek somutlaştırılmıştır.',
          ),
          Question(
            id: 'exam_tr1_q9',
            type: QuestionType.matching,
            prompt: 'Cümle türlerini doğru tanımlarıyla eşleştirin:',
            explanation: 'TYT Türkçe sınavında bu kavramlar paragraf sorularında da sıklıkla karşımıza çıkar.',
            matchingPairs: [
              MatchingPair(left: 'Öznel Yargı', right: 'Kişisel görüş ve beğeni'),
              MatchingPair(left: 'Nesnel Yargı', right: 'Kanıtlanabilir bilimsel bilgi'),
              MatchingPair(left: 'Doğrudan Anlatım', right: 'Sözü değiştirmeden aktarma'),
              MatchingPair(left: 'Dolaylı Anlatım', right: 'Sözü kendi ifadesiyle aktarma'),
            ],
          ),
        ],
      ),
    ],
  ),

  // ===========================================================================
  // ÜNİTE 2: TYT TÜRKÇE - SES BİLGİSİ & YAZIM KURALLARI
  // ===========================================================================
  LearningUnit(
    id: 'unit_turkce_2',
    unitNumber: 2,
    title: 'Ses Bilgisi & Yazım Kuralları',
    subject: 'TYT Türkçe',
    colorHex: 0xFFFF9600, // Duolingo Turuncu
    lessons: [
      // ==========================================
      // DERS 1: ÜNSÜZ YUMUŞAMASI (DEĞİŞİMİ)
      // ==========================================
      Lesson(
        id: 'lesson_tr_ses_yumusama',
        title: 'Ünsüz Yumuşaması',
        description: 'p, ç, t, k seslerinin yumuşaması ve istisnaları',
        xpReward: 40,
        gemReward: 15,
        questions: [
          Question(
            id: 'q_tr_yum_1',
            type: QuestionType.multipleChoice,
            prompt: 'Aşağıdaki altı çizili sözcüklerin hangisinde "ünsüz yumuşaması" (değişimi) vardır?',
            options: [
              'Bahçedeki sararmış "yaprağı" eline aldı.',
              'Güneşli havada parkta "koştu".',
              'Sınav sonuçlarını "sabırla" bekledi.',
              'Sınıftaki arkadaşlarına "selam" verdi.',
            ],
            correctIndex: 0,
            explanation: '"Yaprak" sözcüğü ünlüyle başlayan "-ı" ekini alınca sonundaki "k" sesi "ğ"ye yumuşamıştır: yaprak-ı -> yaprağı.',
          ),
          Question(
            id: 'q_tr_yum_2',
            type: QuestionType.trueFalse,
            prompt: 'Özel isimlerde ünsüz yumuşaması yazıda gösterilmez (Örn: "Ahmet\'e" yazılır), sadece okurken yumuşatılır.',
            isTrue: true,
            explanation: 'Doğru! Özel isimlerin sonundaki sert ünsüzler yazıda korunur ve kesme işaretiyle ayrılır, sadece telaffuzda yumuşatılır.',
          ),
          Question(
            id: 'q_tr_yum_3',
            type: QuestionType.fillInTheBlank,
            prompt: '"Kitap" sözcüğüne "-ı" belirtme eki getirildiğinde sonundaki "p" sesi yumuşayarak _____ olur.',
            blankOptions: ['b', 'c', 'd', 'ğ'],
            correctBlankAnswer: 'b',
            explanation: 'p sert ünsüzü iki ünlü arasında kalarak "b" yumuşak sesine dönüşür: kitap-ı -> kitabı.',
          ),
          // 💡 KÜÇÜK TAKTİK KARTI (3 Sorudan Sonra!)
          Question(
            id: 'tactic_tr_yum_1',
            type: QuestionType.conceptCard,
            conceptTitle: '💡 Küçük Taktik: Yumuşamayan İstisnalar!',
            iconEmoji: '🎯',
            rule: '• Tek heceli sözcüklerin çoğunda yumuşama OLMAZ: süt-ü (sütü), ip-i (ipi), suç-u (suçu), top-u (topu).\n• Yabancı kökenli sözcüklerde yumuşama OLMAZ: hukuk-u (hukuku), millet-i (milleti), tabiat-ı (tabiatı).\n• Özel adlarda yazıda asla yumuşama yapılmaz: Sinop\'a, Zonguldak\'a.',
            examples: [
              'Doğru: "Hukukun üstünlüğü" (Hukuğun ❌)',
              'Doğru: "Devletin milleti" (Milledi ❌)',
              'Doğru: "Mehmet\'in kalemi" (Mehmed\'in ❌)',
            ],
            examTip: 'ÖSYM "Hangisinde yumuşamaya aykırı bir sözcük kullanılmıştır?" diye sorarsa hemen "hukuku, milleti, sanatı, saati veya tek heceli (sütü, ipi)" gibi sözcükleri ara!',
          ),
          Question(
            id: 'q_tr_yum_4',
            type: QuestionType.multipleChoice,
            prompt: 'Aşağıdaki altı çizili sözcüklerin hangisi "ünsüz yumuşaması kuralına aykırıdır"?',
            options: [
              'Toplantıda "hukukun" üstünlüğüne vurgu yapıldı.',
              'Ağacın "dalını" rüzgar kırmıştı.',
              'Gözlüğünün "camını" mendille temizledi.',
              'Evin "kapısını" kilitlemeyi unutmuş.',
            ],
            correctIndex: 0,
            explanation: '"Hukuk" yabancı kökenli bir sözcüktür; ünlüyle başlayan ek almasına rağmen "k" sesi yumuşamamış, "hukukun" şeklinde sert kalmıştır.',
          ),
          Question(
            id: 'q_tr_yum_5',
            type: QuestionType.matching,
            prompt: 'Sert ünsüzle biten kökleri ünlüyle ek almış yumuşamış halleriyle eşleştirin:',
            explanation: 'p->b, ç->c, t->d, k->ğ dönüşümlerine dikkat edin.',
            matchingPairs: [
              MatchingPair(left: 'Ağaç', right: 'Ağacı'),
              MatchingPair(left: 'Dert', right: 'Derdi'),
              MatchingPair(left: 'Renk', right: 'Rengi'),
              MatchingPair(left: 'Kanat', right: 'Kanadı'),
            ],
          ),
          Question(
            id: 'q_tr_yum_6',
            type: QuestionType.multipleChoice,
            prompt: 'Aşağıdaki cümlelerin hangisinde gözden kaçabilecek bir ünsüz yumuşaması vardır?',
            options: [
              'Yol boyunca yürüyünce karnı çok "acıktı".',
              'Sabah erkenden yola çıktık.',
              'Güneş dağların ardından doğdu.',
              'Kitapları masanın üstüne bıraktı.',
            ],
            correctIndex: 0,
            explanation: '"Acıktı" sözcüğünün kökü "aç" (tok zıttı) ismidir. -ık yapım eki aldığında "ç" sesi "c"ye dönüşerek yumuşamıştır: aç-ık-tı -> acıktı.',
          ),
          Question(
            id: 'q_tr_yum_7',
            type: QuestionType.trueFalse,
            prompt: '"Evrak" sözcüğüne ünlüyle başlayan ek geldiğinde "evrağı" şeklinde yazılması bir yazım yanlışıdır.',
            isTrue: true,
            explanation: 'Doğru! "Evrak" yabancı kökenlidir ve yumuşamaz; "evrakı" şeklinde yazılmalıdır. "Evrağı" yazımı yazım yanlışıdır.',
          ),
        ],
      ),

      // ==========================================
      // DERS 2: ÜNSÜZ BENZEŞMESİ (SERTLEŞME)
      // ==========================================
      Lesson(
        id: 'lesson_tr_ses_benszleme',
        title: 'Ünsüz Benzeşmesi (Sertleşme)',
        description: 'Fıstıkçı Şahap formülü ve sayıların yazımı',
        xpReward: 40,
        gemReward: 15,
        questions: [
          Question(
            id: 'q_tr_benz_1',
            type: QuestionType.multipleChoice,
            prompt: 'Aşağıdaki altı çizili sözcüklerin hangisinde "ünsüz benzeşmesi" (sertleşmesi) vardır?',
            options: [
              'Bütün gün kütüphanede "çalıştı".',
              'Ağacın dalına kuşlar kondu.',
              'Denizin maviliği insanı büyülüyor.',
              'Okuldan eve doğru yürüyordu.',
            ],
            correctIndex: 0,
            explanation: '"Çalış-" fiili "ş" sert ünsüzüyle biter. Gelen "-di" görülen geçmiş zaman eki sertleşerek "-ti" olmuştur: çalış-tı.',
          ),
          Question(
            id: 'q_tr_benz_2',
            type: QuestionType.trueFalse,
            prompt: 'F, S, T, K, Ç, Ş, H, P ünsüzleriyle biten bir kelimeye c, d, g ile başlayan ek gelirse bunlar ç, t, k seslerine dönüşür.',
            isTrue: true,
            explanation: 'Doğru! Bu kural Türkçe ses uyumunun temelidir ve "ünsüz sertleşmesi/benzeşmesi" olarak adlandırılır.',
          ),
          Question(
            id: 'q_tr_benz_3',
            type: QuestionType.fillInTheBlank,
            prompt: '"Sınıf" sözcüğüne bulunma durumu eki "-da" getirildiğinde sertleşerek "sınıf____" olur.',
            blankOptions: ['ta', 'da', 'te', 'de'],
            correctBlankAnswer: 'ta',
            explanation: 'Sınıf sözcüğü f sert ünsüzü ile bittiğinden -da eki sertleşerek "-ta" olur.',
          ),
          // 💡 KÜÇÜK TAKTİK KARTI (3 Sorudan Sonra!)
          Question(
            id: 'tactic_tr_benz_1',
            type: QuestionType.conceptCard,
            conceptTitle: '💡 Küçük Taktik: Sayıların Sertleşmesi!',
            iconEmoji: '🛡️',
            rule: '• Sayılara ve saatlere ek getirirken RAKAMIN OKUNUŞUNA bakılır!\n• 1923 (üç ile biter) -> 1923\'te\n• 1975 (beş ile biter) -> 1975\'te\n• 40 (kırk ile biter) -> 40\'tan\n• Saat 14:00 (sıfır-da DEĞİL! ondört-te yazılır!)',
            examples: [
              'Doğru: 1923\'te | Yanlış: 1923\'de ❌',
              'Doğru: Saat 15:00\'te | Yanlış: 15:00\'da ❌',
              'Doğru: Saat 17:03\'te (üç-te)',
            ],
            examTip: 'ÖSYM yazım kuralları sorularında mutlaka 1923\'de, 1975\'de veya 14:00\'da gibi tuzaklar kurar. Son harfe bak: Fıstıkçı Şahap ise kesinlikle -te/-ta gelmelidir!',
          ),
          Question(
            id: 'q_tr_benz_4',
            type: QuestionType.multipleChoice,
            prompt: 'Aşağıdaki cümlelerin hangisinde ünsüz benzeşmesine uyulmadığı için bir YAZIM YANLIŞI yapılmıştır?',
            options: [
              'Cumhuriyet 1923\'de ilan edildi.',
              'Sınav saat 10:00\'da başlayacak.',
              'Kitapçıdan yeni bir roman aldı.',
              'Sabah erkenden sokaktan sesler geldi.',
            ],
            correctIndex: 0,
            explanation: '1923 "üç" (ç) sert ünsüzüyle biter. Bu nedenle gelen ek "-te" olmalıdır: 1923\'te. "1923\'de" yazımı bariz bir yazım yanlışıdır.',
          ),
          Question(
            id: 'q_tr_benz_5',
            type: QuestionType.matching,
            prompt: 'Sözcük köklerini sertleşmiş ekleriyle doğru eşleştirin:',
            explanation: 'c->ç, d->t, g->k dönüşümlerini bulun.',
            matchingPairs: [
              MatchingPair(left: 'Fıstık + cı', right: 'Fıstıkçı'),
              MatchingPair(left: 'Sokak + dan', right: 'Sokaktan'),
              MatchingPair(left: 'Bit + gi', right: 'Bitki'),
              MatchingPair(left: 'Git + di', right: 'Gitti'),
            ],
          ),
          Question(
            id: 'q_tr_benz_6',
            type: QuestionType.multipleChoice,
            prompt: 'Aşağıdaki sözcüklerin hangisinde türetilirken meydana gelen bir ünsüz benzeşmesi vardır?',
            options: [
              'Bitki',
              'Sevgi',
              'Bilgi',
              'Görgü',
            ],
            correctIndex: 0,
            explanation: '"Bitki" sözcüğü "bit-" fiiline "-gi" yapım eki getirilerek türetilmiştir: bit-gi -> bitki (g sertleşerek k olmuştur). Diğerlerinde sertleşme yoktur.',
          ),
          Question(
            id: 'q_tr_benz_7',
            type: QuestionType.trueFalse,
            prompt: '"Seçkin" sözcüğünün kökü "seç-" fiilidir ve yapım eki alırken benzeşme (sertleşme) gerçekleşmiştir.',
            isTrue: true,
            explanation: 'Doğru! seç- fiiline "-gin" yapım eki gelmiş ve "seçkin" olmuştur (g -> k sertleşmesi).',
          ),
        ],
      ),

      // ==========================================
      // DERS 3: ÜNLÜ DÜŞMESİ & AŞINMA
      // ==========================================
      Lesson(
        id: 'lesson_tr_ses_unludusme',
        title: 'Ünlü Düşmesi & Aşınma',
        description: 'İkinci hecedeki dar ünlü düşmesi ve türetilirken kayıp',
        xpReward: 40,
        gemReward: 15,
        questions: [
          Question(
            id: 'q_tr_dus_1',
            type: QuestionType.multipleChoice,
            prompt: 'Aşağıdaki altı çizili sözcüklerin hangisinde "çekim eki alırken" ünlü düşmesi gerçekleşmiştir?',
            options: [
              'Duydukları karşısında "aklı" karıştı.',
              'Güller sıcaktan "sarardı".',
              'Çocuklar bahçede "oynuyor".',
              'Yaralı askerin yarası "sızladı".',
            ],
            correctIndex: 0,
            explanation: '"Akıl" sözcüğü iyelik/çekim eki "-ı" alınca ikinci hecedeki dar ünlü düşmüştür: akıl-ı -> aklı. Diğerleri ise yapım ekiyle (türetilirken) düşmüştür.',
          ),
          Question(
            id: 'q_tr_dus_2',
            type: QuestionType.trueFalse,
            prompt: 'İkilemelerde ses düşmesi kuralı UYGULANMAZ (Örn: "omuz omuza", "burun buruna" yazılır, "omuz omza" yazılırsa yazım yanlışıdır).',
            isTrue: true,
            explanation: 'Doğru! Türk Dil Kurumu kuralına göre ikilemelerde ünlü düşmesi kesinlikle gösterilmez.',
          ),
          Question(
            id: 'q_tr_dus_3',
            type: QuestionType.fillInTheBlank,
            prompt: '"Karın" sözcüğüne "-ı" iyelik eki getirildiğinde ikinci hecedeki "ı" düşerek "_____ı" olur.',
            blankOptions: ['karn', 'karın', 'karan', 'korun'],
            correctBlankAnswer: 'karn',
            explanation: 'İki heceli ve son hecesinde dar ünlü bulunan organ isimlerinde ünlü düşmesi kuraldır: karın-ı -> karnı.',
          ),
          // 💡 KÜÇÜK TAKTİK KARTI (3 Sorudan Sonra!)
          Question(
            id: 'tactic_tr_dus_1',
            type: QuestionType.conceptCard,
            conceptTitle: '💡 Küçük Taktik: Türetilirken Düşenler!',
            iconEmoji: '🔥',
            rule: 'ÖSYM sınavlarında en çok "türetilirken" ünlü kaybına uğrayanları sorar:\n• Oyun + a -> Oyna-\n• Sarı + ar -> Sarar-\n• Koku + la -> Kokla-\n• Sızı + la -> Sızla-\n• İleri + le -> İlerle-\n• Çevir + e -> Çevre\n• Buyur + uk -> Buyruk\n• Besi + le -> Besle-',
            examples: [
              'Oyun-a -> Oyna- (u düştü, yapım eki)',
              'Çevir-e -> Çevre (i düştü, yapım eki)',
              'Besi-le -> Besle- (i düştü, yapım eki)',
            ],
            examTip: 'Soru kökünde "türetilirken" ifadesi varsa akıl-aklı, burun-burnu gibi çekim ekli kelimeleri HEMEN ELE! Yapım eki almış olanları (sarar-, oyna-, çevre) ara!',
          ),
          Question(
            id: 'q_tr_dus_4',
            type: QuestionType.multipleChoice,
            prompt: 'Aşağıdaki cümlelerin hangisinde "türetilirken ünlü kaybına uğramış" bir sözcük kullanılmıştır?',
            options: [
              'Köyün "çevresinde" verimli meyve bahçeleri vardı.',
              'Haberi duyunca onun da "göğsü" kabardı.',
              'Soğuktan çocuğun "boynu" tutulmuştu.',
              'Odanın "şehrin" gürültüsünden uzak bir havası vardı.',
            ],
            correctIndex: 0,
            explanation: '"Çevre" sözcüğü "çevir-" fiilinden "-e" yapım ekiyle türetilirken "i" ünlüsü düşmüştür: çevir-e -> çevre.',
          ),
          Question(
            id: 'q_tr_dus_5',
            type: QuestionType.matching,
            prompt: 'Aşınma (birleşirken ünlü düşmesi) sonucu oluşan sözcükleri kökenleriyle eşleştirin:',
            explanation: 'İki kelime birleşirken yan yana gelen ünlülerin birinin kaybolmasına aşınma denir.',
            matchingPairs: [
              MatchingPair(left: 'Kahve + altı', right: 'Kahvaltı'),
              MatchingPair(left: 'Cuma + ertesi', right: 'Cumartesi'),
              MatchingPair(left: 'Ne + asıl', right: 'Nasıl'),
              MatchingPair(left: 'Ne + için', right: 'Niçin'),
            ],
          ),
          Question(
            id: 'q_tr_dus_6',
            type: QuestionType.multipleChoice,
            prompt: '"Pazartesi" sözcüğünde gerçekleşen ses olayı aşağıdakilerden hangisidir?',
            options: [
              'Aşınma (Birleşik sözcükte ünlü düşmesi)',
              'Ünsüz türemesi',
              'Ünlü daralması',
              'Ünsüz benzeşmesi',
            ],
            correctIndex: 0,
            explanation: '"Pazar + ertesi" sözcükleri birleşirken "e" ünlüsü düşmüştür; iki sözcük birleşirken olan bu olaya aşınma denir.',
          ),
          Question(
            id: 'q_tr_dus_7',
            type: QuestionType.multipleChoice,
            prompt: '"Şu gurbet ellerde yalnız kaldım." dizesindeki "yalnız" sözcüğünde hangi ses olayı vardır?',
            options: [
              'Türetilirken ünlü düşmesi (yalın-ız)',
              'Ünsüz yumuşaması',
              'Ünlü daralması',
              'Kaynaştırma ünsüzü',
            ],
            correctIndex: 0,
            explanation: '"Yalnız" sözcüğü "yalın" (tek, sade) kökünden "-ız" eki alıp türetilirken "ı" sesi düşmüştür: yalın-ız -> yalnız.',
          ),
        ],
      ),

      // ==========================================
      // DERS 4: ULUMA & ÜNLÜ DARALMASI
      // ==========================================
      Lesson(
        id: 'lesson_tr_ses_uluma_daralma',
        title: 'Uluma & Ünlü Daralması',
        description: 'Sözcükler arası uluma ve -yor ekinin daraltma sırrı',
        xpReward: 40,
        gemReward: 15,
        questions: [
          Question(
            id: 'q_tr_ulu_1',
            type: QuestionType.multipleChoice,
            prompt: 'Aşağıdaki dizelerin hangisinde "uluma" vardır?',
            options: [
              'Dönülmez akşamın ufkundayız, vakit çok geç.',
              'Gözlerin gözlerime değince felaketim olurdu.',
              'Hava soğuktu, elleri titriyordu.',
              'Bir gemi kalkar bu limandan.',
            ],
            correctIndex: 0,
            explanation: '"Dönülmez akşamın" (z -> a) ve "akşamın ufkundayız" (n -> u) sözcükleri arasında ünsüzle bitip ünlüyle başladığı için uluma vardır.',
          ),
          Question(
            id: 'q_tr_ulu_2',
            type: QuestionType.trueFalse,
            prompt: 'İki sözcük arasında virgül (,) veya herhangi bir noktalama işareti varsa, kural gereği uluma bozulur.',
            isTrue: true,
            explanation: 'Doğru! Noktalama işaretleri nefes durağı olduğu için araya noktalama girerse uluma gerçekleşmez.',
          ),
          Question(
            id: 'q_tr_ulu_3',
            type: QuestionType.fillInTheBlank,
            prompt: '"Başla-" fiiline "-yor" eki getirildiğinde sonundaki "a" geniş ünlüsü daralarak "başl____yor" olur.',
            blankOptions: ['ı', 'a', 'u', 'i'],
            correctBlankAnswer: 'ı',
            explanation: 'Son sesi a olan fiile -yor gelince daralarak "başlıyor" biçimini alır.',
          ),
          // 💡 KÜÇÜK TAKTİK KARTI (3 Sorudan Sonra!)
          Question(
            id: 'tactic_tr_ulu_1',
            type: QuestionType.conceptCard,
            conceptTitle: '💡 Küçük Taktik: Daralma Tuzağına Düşme!',
            iconEmoji: '⚠️',
            rule: '• Daralma Kuralı: Fiil "a, e" geniş ünlüsüyle bitmelidir: anla-yor -> anlıyor, bekle-yor -> bekliyor.\n• TUZAK 1: "Seviyor", "Gülüyor", "Biliyor" kelimelerinde daralma YOKTUR! Çünkü fiil kökleri ünsüzle biter (sev-, gül-, bil-). Aradaki ses daralma değil yardımcı ünlüdür!\n• TUZAK 2: "-yor" eki dışında sadece "de-" ve "ye-" fiillerinde daralma olur: de-y-en -> diyen, ye-y-ecek -> yiyecek!',
            examples: [
              'Daralma Var: Dinliyor (dinle-yor), Gözlüyor (gözle-yor)',
              'Daralma Var: Diyen (de-y-en), Yiyecek (ye-y-ecek)',
              'Daralma YOK: Seviyor (sev-i-yor), Bakıyor (bak-ı-yor)',
            ],
            examTip: 'Daralmayı bulmak için hemen -yor ekini kapat ve mastar (-mak/-mek) getir: sev-mek (daralma yok), bekle-mek (daralma var)!',
          ),
          Question(
            id: 'q_tr_ulu_4',
            type: QuestionType.multipleChoice,
            prompt: 'Aşağıdaki cümlelerin hangisinde "ünlü daralması" vardır?',
            options: [
              'Sabahtan beri durmadan ders "çalışıyor".',
              'Pencereden dışarıdaki yağmura "bakıyor".',
              'Arkadaşının gelmesini sabırsızlıkla "bekliyor".',
              'Bütün gün odasında kitap "okuyor".',
            ],
            correctIndex: 2,
            explanation: '"Bekliyor" sözcüğünün kökü "bekle-"dir. -yor eki kökteki geniş "e" ünlüsünü daraltarak "i" yapmıştır. Diğer fiiller (çalış-, bak-, oku-) daralmamıştır.',
          ),
          Question(
            id: 'q_tr_ulu_5',
            type: QuestionType.matching,
            prompt: 'Geniş ünlüyle biten fiilleri daralmış halleriyle eşleştirin:',
            explanation: '-yor ekinin geniş ünlüleri daraltma etkisini eşleştirin.',
            matchingPairs: [
              MatchingPair(left: 'Başla + yor', right: 'Başlıyor'),
              MatchingPair(left: 'Söyle + yor', right: 'Söylüyor'),
              MatchingPair(left: 'Kutla + yor', right: 'Kutluyor'),
              MatchingPair(left: 'Özle + yor', right: 'Özlüyor'),
            ],
          ),
          Question(
            id: 'q_tr_ulu_6',
            type: QuestionType.trueFalse,
            prompt: '"Beni hiç dinlemiyor." cümlesinde olumsuzluk eki "-me/-ma" daralarak "-mi" olmuştur.',
            isTrue: true,
            explanation: 'Doğru! Olumsuzluk eki "-me/-ma"ya -yor geldiğinde her zaman daralır: dinle-me-yor -> dinlemiyor.',
          ),
          Question(
            id: 'q_tr_ulu_7',
            type: QuestionType.multipleChoice,
            prompt: 'Aşağıdaki altı çizili sözcüklerin hangisinde "-yor eki OLMADAN" kaynaştırma harfiyle daralma gerçekleşmiştir?',
            options: [
              'Bize doğru "diyen" insanların sözünü dinlemeliyiz.',
              'Bunu sana "anlatan" kimdi?',
              'Evden hızla "çıkan" çocuğu gördü.',
              'Konuyu baştan sona "okuyan" öğrenci anladı.',
            ],
            correctIndex: 0,
            explanation: '"De-" fiili "-en" sıfat-fiil eki alırken "y" kaynaştırma harfi etkisiyle kökteki "e" daralarak "i" olmuştur: de-y-en -> diyen. Bu istisna sadece de- ve ye- fiillerinde görülür.',
          ),
        ],
      ),

      // ==========================================
      // DERS 5: YAZIM KURALLARI & SOMBAHÇEMİ
      // ==========================================
      Lesson(
        id: 'lesson_tr_ses_yazim',
        title: 'Yazım Kuralları & SOMBAHÇEMİ',
        description: 'de, ki bağlaçları ve birleşik sözcüklerin yazımı',
        xpReward: 45,
        gemReward: 15,
        questions: [
          Question(
            id: 'q_tr_yaz_1',
            type: QuestionType.multipleChoice,
            prompt: 'Aşağıdaki cümlelerin hangisinde bir yazım yanlışı yapılmıştır?',
            options: [
              'Oysaki biz bu konuda ona çok güvenmiştik.',
              'Sen de sınavın bu kadar zor olacağını tahmin etmemiştin.',
              'Çantasını evde unuttuğu için geri dönüp te aldı.',
              'Akşamki maçta takımımız çok üstün bir performans gösterdi.',
            ],
            correctIndex: 2,
            explanation: 'Bağlaç olan "de/da" asla sertleşerek "te/ta" olamaz. Doğrusu: "dönüp de" şeklinde ayrı ve d ile yazılmasıdır.',
          ),
          Question(
            id: 'q_tr_yaz_2',
            type: QuestionType.trueFalse,
            prompt: '"ki" bağlacının yazımını anlamak için kelimeye "-ler" eki eklenir; anlamlıysa bitişik (evdekiler), anlamsızsa ayrı (duydumkiler❌) yazılır.',
            isTrue: true,
            explanation: 'Doğru! "-ler" taktiği sıfat ve zamir yapan "ki" ile bağlaç olan "ki"yi ayırt etmenin en pratik yoludur.',
          ),
          Question(
            id: 'q_tr_yaz_3',
            type: QuestionType.fillInTheBlank,
            prompt: 'Kalıplaşmış olarak her zaman bitişik yazılan "ki" bağlaçları _____ formülüyle kodlanır.',
            blankOptions: ['SOMBAHÇEMİ', 'FISTIKÇIŞAHAP', 'KAYNAŞTIRMA', 'SESBİLGİSİ'],
            correctBlankAnswer: 'SOMBAHÇEMİ',
            explanation: 'Sanki, Oysaki, Mademki, Belki, Halbuki, Çünkü, Meğerki, İllaki kelimeleri SOMBAHÇEMİ akrostişiyle ezberlenir.',
          ),
          // 💡 KÜÇÜK TAKTİK KARTI (3 Sorudan Sonra!)
          Question(
            id: 'tactic_tr_yaz_1',
            type: QuestionType.conceptCard,
            conceptTitle: '💡 Küçük Taktik: Birleşik Fiiller Nasıl Yazılır?',
            iconEmoji: '🧩',
            rule: 'İsim + etmek/olmak fiillerinde:\n• Ses düşmesi veya ses türemesi VARSA -> BİTİŞİK yazılır:\n  His + etmek -> Hissetmek (s türedi)\n  Kayıp + olmak -> Kaybolmak (ı düştü)\n  Af + etmek -> Affetmek (f türedi)\n• Ses olayı YOKSA -> AYRI yazılır:\n  Terk etmek, fark etmek, arz etmek, rica etmek, yok olmak.',
            examples: [
              'Doğru: Fark etmek | Yanlış: Farketmek ❌',
              'Doğru: Terk etmek | Yanlış: Terketmek ❌',
              'Doğru: Hissetmek | Yanlış: His etmek ❌',
            ],
            examTip: 'ÖSYM yazım sorularında en çok "terketmek" ve "farketmek" tuzağını kullanır. İkisinde de ses düşmesi veya türemesi yoktur, daima AYRI yazılırlar!',
          ),
          Question(
            id: 'q_tr_yaz_4',
            type: QuestionType.multipleChoice,
            prompt: 'Aşağıdaki cümlelerin hangisinde birleşik fiillerin yazımı ile ilgili bir YANLIŞLIK yapılmıştır?',
            options: [
              'Tüm uyarılara rağmen köyü terketti.',
              'Olayın ciddiyetini çok geç fark etti.',
              'Kendisine yapılan iyilikleri asla unutmazdı.',
              'Durumu okul yönetimine arz etti.',
            ],
            correctIndex: 0,
            explanation: '"Terk etmek" sözcüğünde herhangi bir ses olayı (düşme veya türeme) olmadığı için mutlaka AYRI yazılmalıdır.',
          ),
          Question(
            id: 'q_tr_yaz_5',
            type: QuestionType.matching,
            prompt: 'Sözcükleri doğru ve yanlış yazım durumlarıyla eşleştirin:',
            explanation: 'Ses olayı kuralını hatırlayın: ses olayı yoksa ayrı, varsa bitişik.',
            matchingPairs: [
              MatchingPair(left: 'Fark etmek', right: 'Doğru Yazım'),
              MatchingPair(left: 'Farketmek', right: 'Yanlış Yazım'),
              MatchingPair(left: 'Hissetmek', right: 'Doğru Yazım'),
              MatchingPair(left: 'Terketmek', right: 'Yanlış Yazım'),
            ],
          ),
          Question(
            id: 'q_tr_yaz_6',
            type: QuestionType.multipleChoice,
            prompt: 'Aşağıdaki cümlelerin hangisinde tarih ve gün adlarının yazımı ile ilgili bir yanlışlık vardır?',
            options: [
              'Okullar bu yıl eylül ayında açılacak.',
              'Sınav 15 haziran pazar günü yapılacak.',
              '29 Ekim 1923\'te cumhuriyet ilan edildi.',
              'Haftaya salı günü toplantı var.',
            ],
            correctIndex: 1,
            explanation: 'Belirli bir tarihi (15) bildiren gün ve ay adları BÜYÜK harfle başlamalıdır: "15 Haziran Pazar" şeklinde yazılmalıydı.',
          ),
          Question(
            id: 'q_tr_yaz_7',
            type: QuestionType.fillInTheBlank,
            prompt: 'Ses düşmesi veya ses türemesi olmayan birleşik fiiller her zaman _____ yazılır.',
            blankOptions: ['ayrı', 'bitişik', 'tire ile', 'büyük'],
            correctBlankAnswer: 'ayrı',
            explanation: 'Ses olayı olmayan birleşik fiiller daima ayrı yazılır (örneğin: terk etmek, fark etmek).',
          ),
        ],
      ),

      // ==========================================
      // ÜNİTE 2 SONU KUPA SINAVI (BOSS LEVEL)
      // ==========================================
      Lesson(
        id: 'exam_unit_tr_2',
        title: 'Ünite 2 Kupa Sınavı 🏆',
        description: 'Ses olayları ve yazım kurallarında ustalığını kanıtla!',
        xpReward: 100,
        gemReward: 30,
        isUnitExam: true,
        questions: [
          Question(
            id: 'exam_tr2_q1',
            type: QuestionType.multipleChoice,
            prompt: '"Ayrılığın acısını yüreğinde hissediyordu." cümlesinde aşağıdaki ses olaylarından hangileri vardır?',
            options: [
              'Ünlü Düşmesi ve Ünsüz Yumuşaması',
              'Ünlü Daralması ve Benzeşme',
              'Ünsüz Türemesi ve Kaynaşma',
              'Yalnızca Ünlü Düşmesi',
            ],
            correctIndex: 0,
            explanation: 'Ayır-ılık -> Ayrılık (Ünlü düşmesi); Yürek-i -> Yüreği (Ünsüz yumuşaması) gerçekleşmiştir.',
          ),
          Question(
            id: 'exam_tr2_q2',
            type: QuestionType.matching,
            prompt: 'Sözcükleri gerçekleşen ses olaylarıyla eşleştirin:',
            explanation: 'Ses bilgisi sorularında kök ve ek tahlili çok önemlidir.',
            matchingPairs: [
              MatchingPair(left: 'Sabır-ı -> Sabrı', right: 'Ünlü Düşmesi'),
              MatchingPair(left: 'Ağaç-da -> Ağaçta', right: 'Ünsüz Benzeşmesi'),
              MatchingPair(left: 'Kanat-ı -> Kanadı', right: 'Ünsüz Yumuşaması'),
              MatchingPair(left: 'Söyle-yor -> Söylüyor', right: 'Ünlü Daralması'),
            ],
          ),
          Question(
            id: 'exam_tr2_q3',
            type: QuestionType.fillInTheBlank,
            prompt: 'Türkçede bağlaç olan "de/da" her zaman kelimeden _____ yazılır.',
            blankOptions: ['ayrı', 'bitişik', 'kesme ile', 'büyük harfle'],
            correctBlankAnswer: 'ayrı',
            explanation: 'Bağlaç olan "de/da" bağımsız bir sözcüktür ve her zaman ayrı yazılır.',
          ),
          Question(
            id: 'exam_tr2_q4',
            type: QuestionType.multipleChoice,
            prompt: 'Aşağıdaki cümlelerin hangisinde büyük harflerin yazımıyla ilgili bir yanlışlık yapılmıştır?',
            options: [
              'Türkiye\'nin doğusunda Van Gölü yer almaktadır.',
              'Gelecek hafta Salı günü sınav yapılacağı duyuruldu.',
              'Türk Dil Kurumu binası Ankara\'dadır.',
              'Güneydoğu Anadolu Bölgesi kurak bir iklime sahiptir.',
            ],
            correctIndex: 1,
            explanation: 'Belirli bir tarih (gün, ay, yıl) bildirmeyen gün ve ay adları küçük harfle yazılır: "Gelecek hafta salı günü".',
          ),
          Question(
            id: 'exam_tr2_q5',
            type: QuestionType.multipleChoice,
            prompt: 'Aşağıdaki cümlelerin hangisinde "ki"nin yazımı ile ilgili bir yanlışlık yapılmıştır?',
            options: [
              'Demekki söylediklerimin hiçbirini dinlememişsin.',
              'Masadaki kitapları çantasına güzelce yerleştirdi.',
              'Öyle bir hata yaptı ki affetmek imkânsızdı.',
              'Mademki gelecektin, neden haber vermedin?',
            ],
            correctIndex: 0,
            explanation: '"Demek ki" kelimesindeki ki ayrı yazılır; çünkü SOMBAHÇEMİ istisnaları arasında yer almaz.',
          ),
          Question(
            id: 'exam_tr2_q6',
            type: QuestionType.fillInTheBlank,
            prompt: 'F, S, T, K, Ç, Ş, H, P ünsüzleriyle biten kelimelere gelen eklerin sertleşmesine _____ kuralı denir.',
            blankOptions: ['ünsüz benzeşmesi', 'ünlü daralması', 'ünsüz türemesi', 'ulama'],
            correctBlankAnswer: 'ünsüz benzeşmesi',
            explanation: 'Sert ünsüzlerin ekteki yumuşak ünsüzü sertleştirmesi ünsüz benzeşmesidir.',
          ),
          Question(
            id: 'exam_tr2_q7',
            type: QuestionType.trueFalse,
            prompt: '"Terketmek" sözcüğü Türk Dil Kurumu kurallarına göre bitişik yazılmalıdır.',
            isTrue: false,
            explanation: 'Yanlış! Ses olayı bulunmayan "terk etmek" fiili daima ayrı yazılır.',
          ),
          Question(
            id: 'exam_tr2_q8',
            type: QuestionType.matching,
            prompt: 'Kelimeleri doğru ve yanlış yazılışlarıyla eşleştirin:',
            explanation: 'ÖSYM her yıl ses ve yazım kurallarından garanti sorular sormaktadır.',
            matchingPairs: [
              MatchingPair(left: 'Oysaki', right: 'Doğru (Bitişik)'),
              MatchingPair(left: 'Demekki', right: 'Yanlış (Ayrı olmalı)'),
              MatchingPair(left: 'Terk etmek', right: 'Doğru (Ayrı)'),
              MatchingPair(left: 'Herşey', right: 'Yanlış (Her şey olmalı)'),
            ],
          ),
        ],
      ),
    ],
  ),

  // ===========================================================================
  // ÜNİTE 3: TYT MATEMATİK - TEMEL KAVRAMLAR & SAYILAR
  // ===========================================================================
  LearningUnit(
    id: 'unit_matematik_1',
    unitNumber: 1,
    title: 'Temel Kavramlar & Sayılar',
    subject: 'TYT Matematik',
    colorHex: 0xFF9C27B0, // Duolingo Mor
    lessons: [
      Lesson(
        id: 'lesson_mat_1',
        title: 'Tek ve Çift Sayılar',
        description: 'ÖSYM\'nin her yıl banko sorduğu tek-çift sayı taktikleri',
        xpReward: 40,
        gemReward: 15,
        questions: [
          // 1. KAVRAM KARTI: Tek ve Çift Sayıların Altın Kuralları
          Question(
            id: 'concept_mat_1_1',
            type: QuestionType.conceptCard,
            conceptTitle: 'Tek - Çift Sayıların Çarpım Sırrı',
            iconEmoji: '🔢',
            rule: '• Çarpma kuralı: Çarpımın sonucu TEK ise, çarpanların HEPSİ TEKTİR!\n  (a · b = Tek ise hem a = Tek hem b = Tek olmak zorundadır).\n• Çarpımda tek bir tane bile ÇİFT sayı varsa, sonuç kesinlikle ÇİFTTİR.\n• Kesirli ifadelerde (örneğin (a·b + 1)/2 = c) İÇLER DIŞLAR ÇARPIMI yap:\n  a·b + 1 = 2c\n  2c kesinlikle ÇİFT olduğundan: a·b + 1 = Çift -> a·b = Tek -> a ve b tektir!',
            examples: [
              'Tek ± Tek = Çift (3 + 5 = 8)',
              'Çift ± Tek = Tek (4 + 3 = 7)',
              'Tek · Tek = Tek (3 · 5 = 15)',
              'Çift · Tek = Çift (4 · 3 = 12)',
            ],
            examTip: 'ÖSYM TUZAĞI: Yukarıdaki örnekte 2c ifadesi çifttir ama "c"nin kendisi hakkında TEK veya ÇİFT diye YORUM YAPILAMAZ! Şıklarda "c çifttir" diyen öncülü hemen ele!',
          ),
          // 1. SORU: Tek-Çift (ABCD)
          Question(
            id: 'q_mat_1_1',
            type: QuestionType.multipleChoice,
            prompt: 'a, b ve c tam sayılar olmak üzere,\n(a · b + 3) / 2 = c\neşitliği veriliyor. Buna göre aşağıdakilerden hangisi KESİNLİKLE doğrudur?',
            options: [
              'c tek sayıdır.',
              'c çift sayıdır.',
              'a ve b tek sayılardır.',
              'a çift, b tek sayıdır.',
            ],
            correctIndex: 2,
            explanation: 'İçler dışlar yaparsak: a·b + 3 = 2c olur. 2c her zaman çift bir sayıdır. a·b + Tek = Çift ise a·b = Tek olmalıdır. Çarpım tek ise hem a hem de b kesinlikle TEKTİR. c hakkında kesin yorum yapılamaz.',
          ),

          // 2. KAVRAM KARTI: Asal Sayıların Sırrı
          Question(
            id: 'concept_mat_1_2',
            type: QuestionType.conceptCard,
            conceptTitle: 'Asal Sayılar ve "2" İstisnası',
            iconEmoji: '⭐',
            rule: 'Sadece 1\'e ve kendisine bölünebilen 1\'den büyük doğal sayılara asal sayı denir.\n• 2 HARİÇ BÜTÜN ASAL SAYILAR TEKTİR!\n• İki asal sayının farkı 1 ise, bu sayılar KESİNLİKLE 3 ve 2\'dir (3 - 2 = 1).\n• İki asal sayının toplamı tek ise, bu sayılardan BİRİ MUTLAKA 2\'DİR!',
            examples: [
              'Asal sayılar: 2, 3, 5, 7, 11, 13, 17, 19, 23...',
              'En küçük asal sayı 2\'dir (Negatif asal sayı yoktur).',
            ],
            examTip: 'ÖSYM, toplamı veya farkı verilen asal sayı sorularında 2 sayısını test etmeyi çok sever. Sayılardan birinin çift asal sayı (2) olma ihtimalini asla unutma!',
          ),
          // 2. SORU: Boşluk Doldurma
          Question(
            id: 'q_mat_1_2',
            type: QuestionType.fillInTheBlank,
            prompt: 'Çift olan yegane asal sayı _____ sayısıdır.',
            blankOptions: ['2', '0', '1', '4'],
            correctBlankAnswer: '2',
            explanation: '2 sayısı hem en küçük asal sayıdır hem de çift olan tek asal sayıdır.',
          ),
          // 3. SORU: Asal Sayılar Testi (ABCD)
          Question(
            id: 'q_mat_1_3',
            type: QuestionType.multipleChoice,
            prompt: 'x ve y birer asal sayı olmak üzere,\nx - y = 1\nolduğuna göre, x + y toplamı kaçtır?',
            options: [
              '4',
              '5',
              '7',
              '9',
            ],
            correctIndex: 1,
            explanation: 'Ardışık olan ve farkı 1 olan tek asal sayı çifti 3 ve 2\'dir. Dolayısıyla x = 3 ve y = 2 olur. Buradan x + y = 3 + 2 = 5 bulunur.',
          ),

          // 3. KAVRAM KARTI: Ardışık Sayılar ve Terim Sayısı
          Question(
            id: 'concept_mat_1_3',
            type: QuestionType.conceptCard,
            conceptTitle: 'Terim Sayısı ve Ortanca Formülü',
            iconEmoji: '📊',
            rule: 'Düzenli artan sayı dizilerinde:\n• Terim Sayısı = [(Son Terim - İlk Terim) / Artış Miktarı] + 1\n• Toplam = Terim Sayısı · [(İlk Terim + Son Terim) / 2]\n• Ardışık tek sayıların toplamı ortadaki sayı ile terim sayısının çarpımına eşittir.',
            examples: [
              '1, 3, 5, ..., 19 dizisinde:\nTerim Sayısı = [(19 - 1) / 2] + 1 = 10 terim.',
              'Toplam = 10 · [(1 + 19) / 2] = 10 · 10 = 100.',
            ],
            examTip: 'Ardışık 5 tam sayının toplamı verildiyse toplamı 5\'e bölerek doğrudan ortadaki (3.) sayıyı bulabilirsin!',
          ),
          // 4. SORU: Ardışık Sayılar (ABCD)
          Question(
            id: 'q_mat_1_4',
            type: QuestionType.multipleChoice,
            prompt: 'Ardışık 5 tek tam sayının toplamı 85 olduğuna göre, bu sayıların en büyüğü kaçtır?',
            options: [
              '17',
              '19',
              '21',
              '23',
            ],
            correctIndex: 2,
            explanation: 'Toplamı terim sayısına bölersek ortanca sayıyı buluruz: 85 / 5 = 17 (3. sayı). Sayılar: 13, 15, 17, 19, 21. En büyüğü 21\'dir.',
          ),
          // 5. SORU: Boşluk Doldurma
          Question(
            id: 'q_mat_1_5',
            type: QuestionType.fillInTheBlank,
            prompt: 'İki tam sayının çarpımı tek sayı ise bu sayıların her ikisi de mutlaka _____ olmalıdır.',
            blankOptions: ['tek sayı', 'çift sayı', 'asal sayı', 'pozitif'],
            correctBlankAnswer: 'tek sayı',
            explanation: 'Tek · Tek = Tek kuralı gereğince çarpımın tek olması için çarpanların tümü tek olmak zorundadır.',
          ),
        ],
      ),

      Lesson(
        id: 'lesson_mat_2',
        title: 'Mutlak Değer & Uzaklık Mantığı',
        description: 'Uzaklık formülü ve mutlak değerli eşitsizlikler',
        xpReward: 45,
        gemReward: 15,
        questions: [
          // 1. KAVRAM KARTI: Mutlak Değerin Geometrik Anlamı
          Question(
            id: 'concept_mat_2_1',
            type: QuestionType.conceptCard,
            conceptTitle: 'Mutlak Değer Bir UZAKLIKTIR!',
            iconEmoji: '📏',
            rule: '|x - a| ifadesi sayı doğrusunda x noktasının a noktasına olan UZAKLIĞIDIR.\n• Uzaklık asla negatif olamaz (|x| >= 0).\n• |x| <= a (a > 0) ise: -a <= x <= a şeklinde açılır.\n• |x| >= a ise: x >= a veya x <= -a şeklinde açılır.',
            examples: [
              '|x| = 5 -> x = 5 veya x = -5',
              '|x - 2| <= 3 -> -3 <= x - 2 <= 3 -> Her tarafa +2 ekle: -1 <= x <= 5',
            ],
            examTip: 'Mutlak değerin içi pozitifse aynen çıkar: |x| = x. İçi negatifse işaret değiştirerek çıkar: |-5| = -(-5) = 5.',
          ),
          // 1. SORU: Mutlak Değer Eşitsizlik (ABCD)
          Question(
            id: 'q_mat_2_1',
            type: QuestionType.multipleChoice,
            prompt: '|2x - 4| <= 6\neşitsizliğini sağlayan x tam sayı değerlerinin toplamı kaçtır?',
            options: [
              '8',
              '10',
              '12',
              '14',
            ],
            correctIndex: 3,
            explanation: '-6 <= 2x - 4 <= 6\nHer tarafa +4 ekle:\n-2 <= 2x <= 10\nHer tarafı 2\'ye böl:\n-1 <= x <= 5\nx değerleri: -1, 0, 1, 2, 3, 4, 5.\nToplam: (-1) + 0 + 1 + 2 + 3 + 4 + 5 = 14.',
          ),

          // 2. KAVRAM KARTI: En Küçük Değer Mantığı
          Question(
            id: 'concept_mat_2_2',
            type: QuestionType.conceptCard,
            conceptTitle: 'Mutlak Değerin En Küçük Değeri',
            iconEmoji: '📉',
            rule: 'Mutlak değerli bir ifadenin alabileceği en küçük değer SIFIRDIR (|x| >= 0).\n|x - a| + |x - b| ifadesinin en küçük değerini bulmak için:\nİçleri sıfır yapan kritik noktalar (x = a ve x = b) yerine yazılır ve en küçük çıkan sonuç alınır.',
            examples: [
              '|x - 3| ifadesinin en küçük değeri x = 3 için 0\'dır.',
              '|x - 2| + |x - 8| için:\nx = 2 koyarsak: |0| + |-6| = 6.\nx = 8 koyarsak: |6| + |0| = 6.\nEn küçük değer 6\'dır.',
            ],
            examTip: 'İki mutlak değerin toplamının en küçük değeri, aralarındaki uzaklıktır: |a - b|.',
          ),
          // 2. SORU: En Küçük Değer (ABCD)
          Question(
            id: 'q_mat_2_2',
            type: QuestionType.multipleChoice,
            prompt: 'A = |x - 4| + |x + 6|\nifadesinin alabileceği EN KÜÇÜK değer kaçtır?',
            options: [
              '6',
              '8',
              '10',
              '12',
            ],
            correctIndex: 2,
            explanation: 'x = 4 için: A = |0| + |10| = 10.\nx = -6 için: A = |-10| + |0| = 10.\nAlabileceği en küçük değer 10\'dur (aralarındaki uzaklık: 4 - (-6) = 10).',
          ),

          // 3. KAVRAM KARTI: |A| + |B| = 0 Durumu
          Question(
            id: 'concept_mat_2_3',
            type: QuestionType.conceptCard,
            conceptTitle: '|A| + |B| = 0 İse Tek Çözüm',
            iconEmoji: '🎯',
            rule: 'Mutlak değerli iki ifadenin toplamı sıfır ise her iki ifadenin içi de AYNI ANDA SIFIR olmak zorundadır! Çünkü mutlak değer negatif olamaz, birbirini nötrleyemez.',
            examples: [
              '|x - 3| + |y + 5| = 0 ise:\nx - 3 = 0 -> x = 3\ny + 5 = 0 -> y = -5',
            ],
            examTip: 'Tam kareler ve çift dereceli kökler de mutlak değer gibi negatif olamaz; toplamları 0 ise içleri ayrı ayrı 0\'dır.',
          ),
          // 3. SORU: |A| + |B| = 0 (ABCD)
          Question(
            id: 'q_mat_2_3',
            type: QuestionType.multipleChoice,
            prompt: '|2x - 6| + |y + 4| = 0\nolduğuna göre, x · y çarpımı kaçtır?',
            options: [
              '-12',
              '-6',
              '12',
              '24',
            ],
            correctIndex: 0,
            explanation: 'İki mutlak değer toplamı 0 ise içleri sıfırdır:\n2x - 6 = 0 => x = 3\ny + 4 = 0 => y = -4\nx · y = 3 · (-4) = -12.',
          ),
          // 4. SORU: Boşluk Doldurma
          Question(
            id: 'q_mat_2_4',
            type: QuestionType.fillInTheBlank,
            prompt: 'Bir reel sayının mutlak değeri sayı doğrusunda o noktanın başlangıç noktasına (sıfıra) olan _____ belirtir.',
            blankOptions: ['uzaklığını', 'yönünü', 'işaretini', 'katını'],
            correctBlankAnswer: 'uzaklığını',
            explanation: 'Mutlak değer geometrik olarak sıfıra veya referans noktasına olan uzaklığı ifade eder ve asla negatif olamaz.',
          ),
          // 5. SORU: Mutlak Değer Eşleştirme
          Question(
            id: 'q_mat_2_5',
            type: QuestionType.matching,
            prompt: 'Mutlak değerli denklemleri çözüm değerleriyle eşleştirin:',
            explanation: 'Mutlak değer denklemlerinde hem pozitif hem negatif durum düşünülür.',
            matchingPairs: [
              MatchingPair(left: '|x| = 7', right: 'x = 7 veya -7'),
              MatchingPair(left: '|x - 1| = 0', right: 'x = 1'),
              MatchingPair(left: '|x| = -3', right: 'Boş Küme (Çözüm yok)'),
              MatchingPair(left: '|2x| = 8', right: 'x = 4 veya -4'),
            ],
          ),
        ],
      ),

      Lesson(
        id: 'lesson_mat_3',
        title: 'Yaş Problemleri Şifresi',
        description: 'Yaş farkı sabittir taktiğiyle problem çözümü',
        xpReward: 50,
        gemReward: 20,
        questions: [
          // 1. KAVRAM KARTI: Yaş Problemlerinin Değişmez Kuralı
          Question(
            id: 'concept_mat_3_1',
            type: QuestionType.conceptCard,
            conceptTitle: 'Yaş Problemlerinin 1 Numaralı Sırrı',
            iconEmoji: '🎂',
            rule: '• İKİ KİŞİ ARASINDAKİ YAŞ FARKI ZAMANLA ASLA DEĞİŞMEZ!\n• n yıl sonra herkesin yaşı n kadar artar.\n• n kişinin bugünkü yaşları toplamı T ise, x yıl sonra yaşları toplamı: T + (n · x) olur.',
            examples: [
              'Bugün anne 30, çocuğu 5 yaşında olsun. Yaş farkı 25\'tir.\n10 yıl sonra anne 40, çocuk 15 olur; yaş farkı HÂLÂ 25\'tir!',
            ],
            examTip: 'Denklem kurarken kişilerin yaşları farkının sabitliğini kullanmak sana en az 1 dakika kazandırır.',
          ),
          // 1. SORU: Yaş Problemi (ABCD)
          Question(
            id: 'q_mat_3_1',
            type: QuestionType.multipleChoice,
            prompt: 'Bir babanın yaşı, oğlunun yaşının 4 katıdır. 6 yıl sonra babanın yaşı oğlunun yaşının 3 katından 2 eksik olacağına göre, oğlunun bugünkü yaşı kaçtır?',
            options: [
              '8',
              '10',
              '12',
              '14',
            ],
            correctIndex: 1,
            explanation: 'Oğul = x, Baba = 4x olsun.\n6 yıl sonra: Oğul = x + 6, Baba = 4x + 6.\nDenklem: 4x + 6 = 3(x + 6) - 2\n4x + 6 = 3x + 18 - 2\n4x + 6 = 3x + 16\nx = 10.\nOğlunun bugünkü yaşı 10\'dur.',
          ),

          // 2. KAVRAM KARTI: Yaş Ortalaması
          Question(
            id: 'concept_mat_3_2',
            type: QuestionType.conceptCard,
            conceptTitle: 'Grupta Yaş Ortalamasının Değişimi',
            iconEmoji: '👥',
            rule: 'Bir grupta hiç kimse ayrılmaz veya yeni biri katılmazsa, geçen her 1 yılda grubun yaş ortalaması da TAM 1 ARTAR.\n• t yıl sonraki yaş ortalaması = Şimdiki Ortalama + t.',
            examples: [
              '4 kişilik bir ailenin bugünkü yaş ortalaması 22 ise, 5 yıl sonra yaş ortalaması 22 + 5 = 27 olur.',
            ],
            examTip: 'Kişi sayısı değişmediği sürece tek tek kişilerin yaşlarını hesaplamana gerek yoktur!',
          ),
          // 2. SORU: Yaş Ortalaması (ABCD)
          Question(
            id: 'q_mat_3_2',
            type: QuestionType.multipleChoice,
            prompt: '5 kişilik bir arkadaş grubunun bugünkü yaş ortalaması 19\'dur. Buna göre, bu grubun 4 yıl sonraki yaşları toplamı kaç olur?',
            options: [
              '95',
              '105',
              '115',
              '120',
            ],
            correctIndex: 2,
            explanation: '4 yıl sonra yaş ortalaması 19 + 4 = 23 olur. Yaşları toplamı = Kişi sayısı · Ortalama = 5 · 23 = 115 bulunur.',
          ),

          // 3. KAVRAM KARTI: Geçen Zaman Mantığı
          Question(
            id: 'concept_mat_3_3',
            type: QuestionType.conceptCard,
            conceptTitle: '"Senin Yaşına Geldiğimde..." Kalıbı',
            iconEmoji: '⏳',
            rule: '"Ben senin yaşındayken..." veya "Sen benim yaşıma geldiğinde..." cümlelerinde geçen süre iki kişi için de eşittir.\nGeçen süre = Hedef Yaş - Şimdiki Yaş.',
            examples: [
              'A = 30, B = 20 olsun. B, A\'nın yaşına geldiğinde aradan 30 - 20 = 10 yıl geçer. A da 10 yıl büyüyüp 40 olur.',
            ],
            examTip: 'Yaş farkı daima sabittir kuralıyla bu soruları tek bilinmeyenli denklemle çözebilirsin.',
          ),
          // 3. SORU: Geçen Zaman (ABCD)
          Question(
            id: 'q_mat_3_3',
            type: QuestionType.multipleChoice,
            prompt: 'Ali 24, Can 16 yaşındadır. Can, Ali\'nin bugünkü yaşına geldiğinde Ali kaç yaşında olur?',
            options: [
              '28',
              '30',
              '32',
              '34',
            ],
            correctIndex: 2,
            explanation: 'Can\'ın 24 yaşına gelmesi için 24 - 16 = 8 yıl geçmelidir. 8 yıl sonra Ali: 24 + 8 = 32 yaşında olur.',
          ),
          // 4. SORU: Boşluk Doldurma
          Question(
            id: 'q_mat_3_4',
            type: QuestionType.fillInTheBlank,
            prompt: '3 kişilik bir grubun 5 yıl sonraki yaşları toplamı bugünkünden _____ fazla olur.',
            blankOptions: ['15', '5', '10', '8'],
            correctBlankAnswer: '15',
            explanation: '3 kişinin her biri 5 yıl büyüyeceği için yaşları toplamı 3 · 5 = 15 artar.',
          ),
          // 5. SORU: Eşleştirme
          Question(
            id: 'q_mat_3_5',
            type: QuestionType.matching,
            prompt: 'Yaş ifadelerini cebirsel gösterimleriyle eşleştirin (Şimdiki yaş = x):',
            explanation: 'Problem çözümlerinde doğru cebirsel ifadeyi kurmak çok önemlidir.',
            matchingPairs: [
              MatchingPair(left: '5 yıl önceki yaşı', right: 'x - 5'),
              MatchingPair(left: '3 yıl sonraki yaşının 2 katı', right: '2(x + 3)'),
              MatchingPair(left: 'Yaşının yarısının 4 fazlası', right: '(x / 2) + 4'),
              MatchingPair(left: 'Bugünkü yaşının karesi', right: 'x²'),
            ],
          ),
        ],
      ),

      // ==========================================
      // ÜNİTE 1 SONU KUPA SINAVI (BOSS LEVEL)
      // ==========================================
      Lesson(
        id: 'exam_unit_mat_1',
        title: 'Ünite 1 Kupa Sınavı 🏆',
        description: 'Temel kavramlar ve matematik problemlerinde final meydan okuması!',
        xpReward: 100,
        gemReward: 30,
        isUnitExam: true,
        questions: [
          Question(
            id: 'exam_mat1_q1',
            type: QuestionType.multipleChoice,
            prompt: 'x, y, z pozitif tam sayılar ve x · y · z tek sayıdır. Buna göre;\nI. x + y + z tektir.\nII. x · y + z çifttir.\nIII. x + y çifttir.\nifadelerinden hangileri DAİMA doğrudur?',
            options: [
              'Yalnız I',
              'I ve II',
              'I, II ve III',
              'II ve III',
            ],
            correctIndex: 2,
            explanation: 'Çarpım tek ise x, y, z sayılarının üçü de TEKTİR. T+T+T = Tek (I doğru). T·T + T = T+T = Çift (II doğru). T+T = Çift (III doğru).',
          ),
          Question(
            id: 'exam_mat1_q2',
            type: QuestionType.fillInTheBlank,
            prompt: 'İki kişi arasındaki yaş farkı geçen yıllara göre _____ .',
            blankOptions: ['değişmez', 'artar', 'azalır', 'ikiye katlanır'],
            correctBlankAnswer: 'değişmez',
            explanation: 'Zaman herkes için aynı aktığından yaş farkı daima sabittir.',
          ),
          Question(
            id: 'exam_mat1_q3',
            type: QuestionType.matching,
            prompt: 'Sayı kümelerini sembolleriyle eşleştirin:',
            explanation: 'Temel matematikte küme gösterimleri:',
            matchingPairs: [
              MatchingPair(left: 'Doğal Sayılar', right: 'N'),
              MatchingPair(left: 'Tam Sayılar', right: 'Z'),
              MatchingPair(left: 'Rasyonel Sayılar', right: 'Q'),
              MatchingPair(left: 'Gerçek (Reel) Sayılar', right: 'R'),
            ],
          ),
          Question(
            id: 'exam_mat1_q4',
            type: QuestionType.multipleChoice,
            prompt: '|x - 5| = 5 - x\neşitliğini sağlayan x değerleri için hangisi doğrudur?',
            options: [
              'x >= 5',
              'x <= 5',
              'x > 0',
              'x = 5',
            ],
            correctIndex: 1,
            explanation: '|A| = -A olarak çıkmışsa A <= 0 olmalıdır. Yani x - 5 <= 0 => x <= 5.',
          ),
          Question(
            id: 'exam_mat1_q5',
            type: QuestionType.multipleChoice,
            prompt: 'a ve b pozitif tam sayılar olmak üzere,\na · b = 36\nolduğuna göre, a + b toplamının alabileceği EN KÜÇÜK değer kaçtır?',
            options: [
              '12',
              '13',
              '15',
              '37',
            ],
            correctIndex: 0,
            explanation: 'Çarpımları sabit pozitif sayıların toplamının en küçük olması için sayılar birbirine en yakın seçilir: a = 6, b = 6 => a + b = 12.',
          ),
          Question(
            id: 'exam_mat1_q6',
            type: QuestionType.fillInTheBlank,
            prompt: 'Tek sayıların tüm pozitif tam sayı kuvvetleri daima _____ sayıdır.',
            blankOptions: ['tek', 'çift', 'asal', 'negatif'],
            correctBlankAnswer: 'tek',
            explanation: 'Tek bir sayının kendisiyle kaç kez çarpılırsa çarpılsın sonucu daima tektir (Örn: 3³ = 27).',
          ),
          Question(
            id: 'exam_mat1_q7',
            type: QuestionType.trueFalse,
            prompt: 'En küçük asal sayı 1\'dir.',
            isTrue: false,
            explanation: 'Yanlış! En küçük asal sayı 2\'dir. 1 sayısı asal sayı değildir.',
          ),
          Question(
            id: 'exam_mat1_q8',
            type: QuestionType.matching,
            prompt: 'İşlemleri sonuçlarının tek veya çift olma durumuyla eşleştirin:',
            explanation: 'Tek-çift sayı kuralları ÖSYM TYT sınavında her yıl doğrudan test edilir.',
            matchingPairs: [
              MatchingPair(left: 'Tek + Tek', right: 'Çift'),
              MatchingPair(left: 'Tek · Tek', right: 'Tek'),
              MatchingPair(left: 'Çift + Tek', right: 'Tek'),
              MatchingPair(left: 'Çift · Çift', right: 'Çift'),
            ],
          ),
        ],
      ),
    ],
  ),

  // ===========================================================================
  // ÜNİTE 2: TYT MATEMATİK - RASYONEL SAYILAR, ASAL SAYILAR & EŞİTSİZLİKLER
  // ===========================================================================
  LearningUnit(
    id: 'unit_matematik_2',
    unitNumber: 2,
    title: 'Rasyonel Sayılar, Asal Sayılar & Eşitsizlikler',
    subject: 'TYT Matematik',
    colorHex: 0xFF2563EB,
    lessons: [
      Lesson(
        id: 'lesson_mat_asal',
        title: 'Asal Sayılar & Asal Çarpanlar',
        description: 'Asallık kuralları, aralarında asallık ve bölen sayıları',
        xpReward: 40,
        gemReward: 15,
        questions: [
          Question(
            id: 'q_mat_asal_1',
            type: QuestionType.multipleChoice,
            prompt: 'Aşağıdaki sayılardan hangisi "asal sayı" değildir?',
            options: ['2', '19', '51', '97'],
            correctIndex: 2,
            explanation: '51 sayısı 3 ile bölünebilir (5+1=6). 51 = 3 × 17 olduğu için asal değildir!',
          ),
          Question(
            id: 'q_mat_asal_2',
            type: QuestionType.fillInTheBlank,
            prompt: '1\'den başka ortak pozitif böleni olmayan iki pozitif sayıya _____ asal sayılar denir.',
            blankOptions: ['aralarında', 'ardışık', 'çift', 'tam'],
            correctBlankAnswer: 'aralarında',
            explanation: 'Örneğin 8 ve 9 asal olmasa bile aralarında asaldır çünkü 1 dışında ortak bölenleri yoktur.',
          ),
          Question(
            id: 'q_mat_asal_3',
            type: QuestionType.trueFalse,
            prompt: '2 sayısı, asal sayılar kümesindeki tek "çift" asal sayıdır.',
            isTrue: true,
            explanation: 'Doğru! 2 hariç tüm çift sayılar 2\'ye bölünebildiğinden asal olamaz.',
          ),
          Question(
            id: 'card_mat_asal_taktik',
            type: QuestionType.conceptCard,
            conceptTitle: 'Pozitif Bölen Sayısı Formülü',
            iconEmoji: '💡',
            rule: 'A = xᵃ · yᵇ · zᶜ (x, y, z asal olmak üzere)\nPozitif Bölen Sayısı (PBS) = (a + 1) · (b + 1) · (c + 1)\nAsal çarpanların kuvvetlerini birer artırıp çarp!',
            examples: [
              '72 = 2³ · 3²',
              'PBS = (3 + 1) · (2 + 1) = 4 · 3 = 12 pozitif böleni vardır.',
              'Tam bölen sayısı sorulursa PBS × 2 = 24 deriz!',
            ],
            examTip: 'ÖSYM, asal çarpanlara ayırmadan sonra formülü uygulatarak kaç farklı çarpan olduğunu sıkça sorar.',
          ),
          Question(
            id: 'q_mat_asal_4',
            type: QuestionType.multipleChoice,
            prompt: '72 sayısının kaç tane pozitif tam sayı böleni vardır?',
            options: ['8', '10', '12', '16'],
            correctIndex: 2,
            explanation: '72 = 2³ × 3² olduğuna göre PBS = (3+1) × (2+1) = 4 × 3 = 12 tanedir.',
          ),
          Question(
            id: 'q_mat_asal_5',
            type: QuestionType.matching,
            prompt: 'Sayıları asal çarpanlarıyla eşleştiriniz:',
            explanation: 'Asal çarpanlarına ayırma:',
            matchingPairs: [
              MatchingPair(left: '60', right: '{2, 3, 5}'),
              MatchingPair(left: '45', right: '{3, 5}'),
              MatchingPair(left: '28', right: '{2, 7}'),
              MatchingPair(left: '77', right: '{7, 11}'),
            ],
          ),
          Question(
            id: 'q_mat_asal_6',
            type: QuestionType.fillInTheBlank,
            prompt: 'a ve b aralarında asal iki sayı ise EBOB(a, b) daima _____ eşittir.',
            blankOptions: ['1\'e', '0\'a', 'a\'ya', 'a·b\'ye'],
            correctBlankAnswer: '1\'e',
            explanation: 'Aralarında asal sayıların en büyük ortak böleni her zaman 1\'dir.',
          ),
          Question(
            id: 'q_mat_asal_7',
            type: QuestionType.multipleChoice,
            prompt: 'a ve b aralarında asal sayılardır. a / b = 28 / 35 olduğuna göre a + b toplamı kaçtır?',
            options: ['9', '14', '21', '63'],
            correctIndex: 0,
            explanation: '28 ve 35 aralarında asal değildir. 7 ile sadeleştiririz: 28/35 = 4/5. a=4, b=5 olur. a + b = 9.',
          ),
        ],
      ),

      Lesson(
        id: 'lesson_mat_rasyonel',
        title: 'Rasyonel Sayılarda İşlemler & Ondalık Kesirler',
        description: 'Dört işlem, merdivenli kesirler ve devirli ondalık sayılar',
        xpReward: 40,
        gemReward: 15,
        questions: [
          Question(
            id: 'q_mat_ras_1',
            type: QuestionType.multipleChoice,
            prompt: '(1/2 + 1/3) ÷ (5/6) işleminin sonucu kaçtır?',
            options: ['1', '5/6', '6/5', '2/3'],
            correctIndex: 0,
            explanation: '1/2 + 1/3 = 3/6 + 2/6 = 5/6. (5/6) ÷ (5/6) = 1.',
          ),
          Question(
            id: 'q_mat_ras_2',
            type: QuestionType.fillInTheBlank,
            prompt: 'Rasyonel sayılarda bölme yapılırken birinci kesir aynen kalır, ikinci kesir ters çevrilip _____ yapılır.',
            blankOptions: ['çarpma', 'çıkarma', 'toplama', 'sadeleştirme'],
            correctBlankAnswer: 'çarpma',
            explanation: '(a/b) ÷ (c/d) = (a/b) × (d/c) kuralı uygulanır.',
          ),
          Question(
            id: 'q_mat_ras_3',
            type: QuestionType.trueFalse,
            prompt: 'Paydaları eşit olan pozitif kesirlerden payı büyük olan daha büyüktür.',
            isTrue: true,
            explanation: 'Doğru! Örneğin 5/7 sayısı 3/7 sayısından daha büyüktür.',
          ),
          Question(
            id: 'card_mat_ras_taktik',
            type: QuestionType.conceptCard,
            conceptTitle: 'Devirli Ondalık Sayı Çevirme Formülü',
            iconEmoji: '💡',
            rule: 'Kesir = (Sayının Tamamı - Devretmeyen Kısım) / (Devreden kadar 9, devretmeyen kadar 0)\nPaydaya sadece VİRGÜLDEN SONRAKİ basamaklar için 9 ve 0 yazılır!',
            examples: [
              '1,23̄ = (123 - 12) / 90 = 111 / 90',
              '0,4̄ = (4 - 0) / 9 = 4/9',
              '2,9̄ = (29 - 2) / 9 = 27/9 = 3 (Devreden 9 ise önceki basamak 1 artar!)',
            ],
            examTip: 'Virgülden sonra sadece 9 devrediyorsa, 9\'un solundaki basamağı doğrudan 1 artırabilirsin! Örn: 0,9̄ = 1, 3,49̄ = 3,5',
          ),
          Question(
            id: 'q_mat_ras_4',
            type: QuestionType.multipleChoice,
            prompt: '1,4̄ devirli ondalık sayısının rasyonel kesir karşılığı hangisidir?',
            options: ['13/9', '14/9', '4/9', '7/5'],
            correctIndex: 0,
            explanation: '(14 - 1) / 9 = 13/9.',
          ),
          Question(
            id: 'q_mat_ras_5',
            type: QuestionType.matching,
            prompt: 'Kesirleri ondalık gösterimleriyle eşleştirin:',
            explanation: 'Rasyonel kesirlerin ondalık açılımları:',
            matchingPairs: [
              MatchingPair(left: '1/2', right: '0,5'),
              MatchingPair(left: '3/4', right: '0,75'),
              MatchingPair(left: '1/5', right: '0,2'),
              MatchingPair(left: '3/8', right: '0,375'),
            ],
          ),
          Question(
            id: 'q_mat_ras_6',
            type: QuestionType.fillInTheBlank,
            prompt: '1 + 1/(1 + 1/2) merdivenli kesir işleminin sonucu _____ olur.',
            blankOptions: ['5/3', '4/3', '3/2', '7/4'],
            correctBlankAnswer: '5/3',
            explanation: '1 + 1/2 = 3/2. 1/(3/2) = 2/3. 1 + 2/3 = 5/3.',
          ),
          Question(
            id: 'q_mat_ras_7',
            type: QuestionType.multipleChoice,
            prompt: 'a = 10/11, b = 100/101, c = 1000/1001 olduğuna göre doğru sıralama hangisidir?',
            options: ['a < b < c', 'c < b < a', 'b < a < c', 'a = b = c'],
            correctIndex: 0,
            explanation: 'Pay ve payda arasındaki fark eşit (1) ve basit kesir ise payı büyük olan daha büyüktür (1\'e daha yakındır). Dolayısıyla a < b < c.',
          ),
        ],
      ),

      Lesson(
        id: 'lesson_mat_bolunebilme',
        title: 'Bölme & Bölünebilme Kuralları',
        description: '3, 4, 5, 8, 9, 11 ve aralarında asal çarpan kuralları',
        xpReward: 40,
        gemReward: 15,
        questions: [
          Question(
            id: 'q_mat_bol_1',
            type: QuestionType.multipleChoice,
            prompt: 'Dört basamaklı 4a2b sayısı 10 ile kalansız bölünebiliyor. Bu sayı 3 ile de bölünebildiğine göre a\'nın alabileceği en büyük değer kaçtır?',
            options: ['6', '7', '8', '9'],
            correctIndex: 3,
            explanation: '10 ile bölünüyorsa b = 0. 4 + a + 2 + 0 = 6 + a. 3\'ün katı olması için a ∈ {0, 3, 6, 9}. En büyük 9.',
          ),
          Question(
            id: 'q_mat_bol_2',
            type: QuestionType.fillInTheBlank,
            prompt: 'Bir sayının 4 ile tam bölünebilmesi için son _____ basamağının 4\'ün katı veya 00 olması gerekir.',
            blankOptions: ['iki', 'üç', 'bir', 'dört'],
            correctBlankAnswer: 'iki',
            explanation: '4 ile bölünebilmede sadece son iki basamağa bakılır.',
          ),
          Question(
            id: 'q_mat_bol_3',
            type: QuestionType.trueFalse,
            prompt: '9 ile tam bölünebilen her sayı, 3 ile de kesinlikle tam bölünür.',
            isTrue: true,
            explanation: 'Doğru! 9 sayısı 3\'ün katı olduğu için rakamları toplamı 9\'un katı olan sayı aynı zamanda 3\'ün de katıdır.',
          ),
          Question(
            id: 'card_mat_bol_taktik',
            type: QuestionType.conceptCard,
            conceptTitle: 'Bileşik Bölünebilme Kuralları Taktiği',
            iconEmoji: '💡',
            rule: 'Aralarında asal iki çarpana bak!\n• 12 ile bölünebilme -> 3 ve 4\n• 15 ile bölünebilme -> 3 ve 5\n• 36 ile bölünebilme -> 4 ve 9\n• 45 ile bölünebilme -> 5 ve 9',
            examples: [
              'İpuçlu soru çözüm sırası:',
              '1. ÖNCE son basamağı ilgilendiren kurala bakılır (5 veya 4 kuralı).',
              '2. SONRA rakamları toplamını ilgilendiren kurala bakılır (3 veya 9 kuralı).',
            ],
            examTip: 'Soru "36 ile tam bölünüyor" diyorsa önce 4 kuralı ile birler/onlar basamağını netleştir, sonra 9 kuralını uygula!',
          ),
          Question(
            id: 'q_mat_bol_4',
            type: QuestionType.multipleChoice,
            prompt: 'Beş basamaklı 72a31 sayısının 9 ile bölümünden kalan 5 olduğuna göre a kaçtır?',
            options: ['1', '3', '6', '8'],
            correctIndex: 0,
            explanation: 'Rakamlar toplamı: 7 + 2 + a + 3 + 1 = 13 + a. 13 + a = 9k + 5 => 13 + a = 14 => a = 1.',
          ),
          Question(
            id: 'q_mat_bol_5',
            type: QuestionType.matching,
            prompt: 'Bölünebilme kurallarını incelenen basamaklarla eşleştirin:',
            explanation: 'Bölünebilme kuralları:',
            matchingPairs: [
              MatchingPair(left: '5 ile bölünebilme', right: 'Son basamak 0 veya 5'),
              MatchingPair(left: '4 ile bölünebilme', right: 'Son iki basamak'),
              MatchingPair(left: '8 ile bölünebilme', right: 'Son üç basamak'),
              MatchingPair(left: '3 ile bölünebilme', right: 'Tüm rakamlar toplamı'),
            ],
          ),
          Question(
            id: 'q_mat_bol_6',
            type: QuestionType.fillInTheBlank,
            prompt: 'Bir bölme işleminde bölen 14 ise, kalanın alabileceği en büyük değer _____ dir.',
            blankOptions: ['13', '14', '15', '7'],
            correctBlankAnswer: '13',
            explanation: 'Kalan daima bölenden küçük olmak zorundadır (Kalan < Bölen). Kalan en fazla 13 olabilir.',
          ),
          Question(
            id: 'q_mat_bol_7',
            type: QuestionType.multipleChoice,
            prompt: '3a5b sayısı 36 ile kalansız bölünebilmektedir. a\'nın alabileceği değerler toplamı kaçtır?',
            options: ['12', '10', '14', '16'],
            correctIndex: 0,
            explanation: '36 = 4 × 9. Son iki basamak 5b, 4\'ün katı olmalı: b = 2 veya b = 6. b=2 için 3a52: 10+a=9k => a=8. b=6 için 3a56: 14+a=9k => a=4. Toplam: 8 + 4 = 12.',
          ),
        ],
      ),

      Lesson(
        id: 'lesson_mat_esitsizlik',
        title: 'Basit Eşitsizlikler & Aralık Kavramı',
        description: 'Eşitsizliklerde yön değiştirme, karesi kendisinden küçük sayılar',
        xpReward: 40,
        gemReward: 15,
        questions: [
          Question(
            id: 'q_mat_esit_1',
            type: QuestionType.multipleChoice,
            prompt: '-2x + 4 < 10 eşitsizliğinin çözüm kümesi aşağıdakilerden hangisidir?',
            options: ['x > -3', 'x < -3', 'x > 3', 'x < 3'],
            correctIndex: 0,
            explanation: '-2x < 6 => Her iki tarafı -2\'ye bölerken eşitsizlik yön değiştirir: x > -3.',
          ),
          Question(
            id: 'q_mat_esit_2',
            type: QuestionType.fillInTheBlank,
            prompt: 'Bir eşitsizliğin her iki tarafı negatif bir sayıyla çarpılır veya bölünürse eşitsizlik _____ değiştirir.',
            blankOptions: ['yön', 'işaret', 'değer', 'kök'],
            correctBlankAnswer: 'yön',
            explanation: '< işareti > işaretine, > işareti < işaretine döner.',
          ),
          Question(
            id: 'q_mat_esit_3',
            type: QuestionType.trueFalse,
            prompt: 'a < b ve c < d ise taraf tarafa toplama yapılarak a + c < b + d yazılabilir.',
            isTrue: true,
            explanation: 'Doğru! Aynı yönlü eşitsizlikler taraf tarafa toplanabilir.',
          ),
          Question(
            id: 'card_mat_esit_taktik',
            type: QuestionType.conceptCard,
            conceptTitle: 'ÖSYM\'nin En Sevdiği Tuzak: x² < x',
            iconEmoji: '💡',
            rule: 'Bir sayının karesi kendisinden küçükse (x² < x), o sayı KESİNLİKLE 0 ile 1 arasındadır!\n0 < x < 1 (Pozitif basit kesir)',
            examples: [
              'x = 1/2 ise x² = 1/4 olur. Gerçekten de 1/4 < 1/2 dir.',
              'x < x² < |x| görüyorsan: -1 < x < 0 dır!',
            ],
            examTip: 'Sorunun başında "x² < x olmak üzere" kalıbını gördüğün anda hemen kenara 0 < x < 1 yaz!',
          ),
          Question(
            id: 'q_mat_esit_4',
            type: QuestionType.multipleChoice,
            prompt: 'x² < x olduğuna göre aşağıdakilerden hangisi daima doğrudur?',
            options: ['0 < x < 1', 'x > 1', 'x < -1', '-1 < x < 0'],
            correctIndex: 0,
            explanation: 'Karesi kendisinden küçük olan sayılar 0 ile 1 arasındaki pozitif basit kesirlerdir.',
          ),
          Question(
            id: 'q_mat_esit_5',
            type: QuestionType.matching,
            prompt: 'Aralık gösterimlerini eşitsizliklerle eşleştiriniz:',
            explanation: 'Aralık kavramı:',
            matchingPairs: [
              MatchingPair(left: '[2, 5]', right: '2 ≤ x ≤ 5'),
              MatchingPair(left: '(2, 5)', right: '2 < x < 5'),
              MatchingPair(left: '[2, 5)', right: '2 ≤ x < 5'),
              MatchingPair(left: '(2, 5]', right: '2 < x ≤ 5'),
            ],
          ),
          Question(
            id: 'q_mat_esit_6',
            type: QuestionType.fillInTheBlank,
            prompt: 'Eşitsizliklerde taraf tarafa çıkarma veya çarpma _____ yapılamaz.',
            blankOptions: ['kesinlikle', 'her zaman', 'kolayca', 'bazen'],
            correctBlankAnswer: 'kesinlikle',
            explanation: 'Eşitsizlikler yalnızca taraf tarafa toplanabilir; çıkarma için ikinci eşitsizlik (-) ile çarpılıp toplanır.',
          ),
          Question(
            id: 'q_mat_esit_7',
            type: QuestionType.multipleChoice,
            prompt: '-3 < x < 4 olduğuna göre x² ifadesinin alabileceği değer aralığı hangisidir?',
            options: ['[0, 16)', '(9, 16)', '[0, 9)', '(-9, 16)'],
            correctIndex: 0,
            explanation: 'Aralıkta 0 bulunduğu için x² en az 0 olabilir. Üst sınır ise max((-3)², 4²) = 16 dır. Dolayısıyla [0, 16).',
          ),
        ],
      ),

      Lesson(
        id: 'exam_unit_mat_2',
        title: 'Ünite 2 Kupa Sınavı 🏆',
        description: 'Rasyonel sayılar, asal sayılar ve eşitsizlikler karma final testi',
        xpReward: 60,
        gemReward: 25,
        isUnitExam: true,
        questions: [
          Question(
            id: 'exam_mat2_q1',
            type: QuestionType.multipleChoice,
            prompt: 'İki basamaklı en küçük asal sayı ile iki basamaklı en büyük asal sayının toplamı kaçtır?',
            options: ['108', '110', '106', '104'],
            correctIndex: 0,
            explanation: 'En küçük iki basamaklı asal 11, en büyük iki basamaklı asal 97 dir. 11 + 97 = 108.',
          ),
          Question(
            id: 'exam_mat2_q2',
            type: QuestionType.fillInTheBlank,
            prompt: '120 sayısının asal çarpanlarının sayısı _____ tanedir.',
            blankOptions: ['3', '2', '4', '5'],
            correctBlankAnswer: '3',
            explanation: '120 = 2³ × 3¹ × 5¹. Asal çarpanları 2, 3 ve 5 olmak üzere 3 tanedir.',
          ),
          Question(
            id: 'exam_mat2_q3',
            type: QuestionType.multipleChoice,
            prompt: '0,2̄ + 0,3̄ + 0,4̄ toplamının değeri kaçtır?',
            options: ['1', '9/10', '0,9', '10/9'],
            correctIndex: 0,
            explanation: '2/9 + 3/9 + 4/9 = 9/9 = 1.',
          ),
          Question(
            id: 'exam_mat2_q4',
            type: QuestionType.trueFalse,
            prompt: 'Pozitif bir basit kesrin pay ve paydasına aynı pozitif sayı eklenirse kesrin değeri artar.',
            isTrue: true,
            explanation: 'Doğru! Örneğin 1/2 = 0,5. Her ikisine 1 eklersek 2/3 ≈ 0,66 olur, değer artar (1\'e yaklaşır).',
          ),
          Question(
            id: 'exam_mat2_q5',
            type: QuestionType.multipleChoice,
            prompt: '3a4b sayısı 15 ile kalansız bölünebilen tek sayıdır. Buna göre a kaçtır?',
            options: ['0, 3, 6, 9', '1, 4, 7', '2, 5, 8', '4, 7'],
            correctIndex: 0,
            explanation: '15 için 3 ve 5. Tek sayı dendiği için b = 5. 3a45: 3 + a + 4 + 5 = 12 + a. 3\'ün katı olması için a ∈ {0, 3, 6, 9}.',
          ),
          Question(
            id: 'exam_mat2_q6',
            type: QuestionType.fillInTheBlank,
            prompt: 'x < y ve z < 0 ise x·z _____ y·z olur.',
            blankOptions: ['>', '<', '=', '≥'],
            correctBlankAnswer: '>',
            explanation: 'Negatif sayıyla çarpıldığında eşitsizlik yön değiştirir.',
          ),
          Question(
            id: 'exam_mat2_q7',
            type: QuestionType.matching,
            prompt: 'Sayıları özellikleriyle eşleştirin:',
            explanation: 'Sayı özellikleri:',
            matchingPairs: [
              MatchingPair(left: '2', right: 'En küçük çift asal'),
              MatchingPair(left: '1', right: 'Asal değildir'),
              MatchingPair(left: '0', right: 'Çift tam sayıdır'),
              MatchingPair(left: '97', right: 'İki basamaklı en büyük asal'),
            ],
          ),
          Question(
            id: 'exam_mat2_q8',
            type: QuestionType.multipleChoice,
            prompt: '-2 ≤ x < 3 olduğuna göre 3x - 1 ifadesinin değer aralığı nedir?',
            options: ['[-7, 8)', '(-7, 8]', '[-6, 8)', '[-7, 9)'],
            correctIndex: 0,
            explanation: '-6 ≤ 3x < 9 => Her taraftan 1 çıkarırsak: -7 ≤ 3x - 1 < 8 => [-7, 8).',
          ),
        ],
      ),
    ],
  ),

  // ===========================================================================
  // ÜNİTE 1: TYT TARİH - İLK TÜRK DEVLETLERİ & KURTULUŞ SAVAŞI
  // ===========================================================================
  LearningUnit(
    id: 'unit_tarih_1',
    unitNumber: 1,
    title: 'İlk Türk Devletleri & Kurtuluş Savaşı',
    subject: 'TYT Tarih',
    colorHex: 0xFF1CB0F6, // Duolingo Mavi
    lessons: [
      Lesson(
        id: 'lesson_tar_1',
        title: 'İlk Türk Devletleri Kavramları',
        description: 'Orta Asya kavramlarını öğren ve anında test et!',
        xpReward: 35,
        gemReward: 12,
        questions: [
          // 1. KAVRAM KARTI: Kut, Kurultay ve Töre
          Question(
            id: 'concept_tar_1_1',
            type: QuestionType.conceptCard,
            conceptTitle: 'Kut İnancı & Devlet Yönetimi',
            iconEmoji: '🏛️',
            rule: 'İlk Türk devletlerinde yönetme yetkisinin Gök Tanrı tarafından hükümdara ve sülalesine (hanedana) verildiğine inanılırdı. Buna "KUT" denir.',
            examples: [
              'KUT: Yönetme hakkının ilahi kaynağıdır. Kan yoluyla babadan oğula geçer.',
              'KURULTAY: Devlet işlerinin görüşülüp karara bağlandığı meclistir.',
              'TÖRE: Yazısız ama hükümdarın bile uymak zorunda olduğu geleneksel hukuk kurallarıdır.',
              'YUĞ: Ölen kişinin ardından düzenlenen cenaze törenidir.',
            ],
            examTip: 'ÖSYM KLASİĞİ: Kut inancının kan bağıyla hanedana geçmesi ("Ülke hanedanın ortak malıdır"), Türk devletlerinde TAHT KAVGALARINA ve devletlerin kısa sürede parçalanmasına yol açmıştır!',
          ),
          // 1. SORU: Eşleştirme Oyunu
          Question(
            id: 'q_tar_1_1',
            type: QuestionType.matching,
            prompt: 'Kavramları doğru açıklamaları ile eşleştirin:',
            explanation: 'İlk Türk devletlerinde siyasi ve sosyal yapıyı belirleyen temel terimler YKS Tarih sorularında sıkça karşımıza çıkar.',
            matchingPairs: [
              MatchingPair(left: 'Kurultay', right: 'Devlet işlerinin görüşüldüğü meclis'),
              MatchingPair(left: 'Kut', right: 'Yönetme yetkisinin Tanrıdan verildiği inanç'),
              MatchingPair(left: 'Töre', right: 'Yazısız geleneksel hukuk kuralları'),
              MatchingPair(left: 'Yuğ', right: 'Eski Türklerde cenaze töreni'),
            ],
          ),

          // 2. KAVRAM KARTI: Mete Han ve Ordu Teşkilatı
          Question(
            id: 'concept_tar_1_2',
            type: QuestionType.conceptCard,
            conceptTitle: 'Mete Han & Onlu Sistem',
            iconEmoji: '⚔️',
            rule: 'Asya Hun Hükümdarı Mete Han tarafından M.Ö. 209 yılında kurulan ordunun 10, 100, 1000 ve 10.000 kişilik birliklere ayrıldığı teşkilatlanma modelidir.',
            examples: [
              'Dünya ordularına model olmuştur (Roma ve modern ordular dahil).',
              'M.Ö. 209 yılı, bugün Türk Kara Kuvvetleri\'nin kuruluş tarihi olarak kutlanmaktadır.',
              'Ordu-millet anlayışı vardır; eli silah tutan herkes askerdir.',
            ],
            examTip: 'İlk Türk devletlerinde ordu-millet anlayışı nedeniyle ÜCRETLİ ASKERLİK YOKTUR (Ticaretle zenginleşen Musevi Hazarlar hariç!).',
          ),
          // 2. SORU: Boşluk Doldurma
          Question(
            id: 'q_tar_1_2',
            type: QuestionType.fillInTheBlank,
            prompt: 'Ordu-millet anlayışı nedeniyle eski Türk devletlerinde _____ askerlik anlayışı görülmez.',
            blankOptions: ['ücretli', 'atlı', 'gönüllü', 'düzenli'],
            correctBlankAnswer: 'ücretli',
            explanation: 'Hazarlar hariç hiçbir ilk Türk devletinde ücretli askerlik yoktur; ordu-millet anlayışı hakimdir.',
          ),
          // 3. SORU: Doğru / Yanlış
          Question(
            id: 'q_tar_1_3',
            type: QuestionType.trueFalse,
            prompt: 'Mete Han tarafından kurulan "Onlu Sistem", günümüz dünya ordularının birçoğunda hâlâ temel askeri teşkilatlanma esası olarak kullanılmaktadır.',
            isTrue: true,
            explanation: 'Doğru! M.Ö. 209\'da kurulan bu sistem evrensel askeri hiyerarşinin temelidir ve Kara Kuvvetleri kuruluş tarihi kabul edilir.',
          ),

          // 3. KAVRAM KARTI: Eski Türklerde Sosyal Yapı
          Question(
            id: 'concept_tar_1_3',
            type: QuestionType.conceptCard,
            conceptTitle: 'Sosyal Yapı Basamakları',
            iconEmoji: '👨‍👩‍👧‍👦',
            rule: 'İlk Türk toplumunda hiyerarşi küçükten büyüğe şu şekildedir:\n• Oguş: Aile\n• Urug: Sülale (Aileler birliği)\n• Boy (Ok): Kabile\n• Bodun: Millet\n• İl (El): Devlet',
            examples: [
              'Toplumsal sınıflaşma ve kölelik YOKTUR (Göçebe yaşam ve özel mülkiyetin olmaması nedeniyle).',
              'Kadınlar toplumda ve yönetimde (Hatun/Katun) son derece etkilidir.',
            ],
            examTip: 'ÖSYM, "Türklerde kölelik ve soyluluk neden gelişmemiştir?" diye sorar. Cevap: Toprak üzerinde özel mülkiyetin olmaması ve göçebe yaşamdır!',
          ),
          // 4. SORU: Sosyal Yapı (ABCD)
          Question(
            id: 'q_tar_1_4',
            type: QuestionType.multipleChoice,
            prompt: 'İlk Türk devletlerinde toplumun en küçük yapı taşı olan "aile"ye verilen ad aşağıdakilerden hangisidir?',
            options: [
              'Oguş',
              'Urug',
              'Boy',
              'Bodun',
            ],
            correctIndex: 0,
            explanation: 'Eski Türklerde aileye "Oguş", sülaleye "Urug", boya "Ok", millete "Bodun" denir.',
          ),
          // 5. SORU: Boşluk Doldurma
          Question(
            id: 'q_tar_1_5',
            type: QuestionType.fillInTheBlank,
            prompt: 'İlk Türk devletlerinde ölen kişilerin ardından yakılan ağıtlara ve düzenlenen cenaze törenine _____ denir.',
            blankOptions: ['yuğ', 'balbal', 'kurgan', 'töre'],
            correctBlankAnswer: 'yuğ',
            explanation: 'Eski Türklerde cenaze törenine "yuğ", mezara "kurgan", mezar taşı heykeline "balbal" denir.',
          ),
        ],
      ),

      Lesson(
        id: 'lesson_tar_2',
        title: 'Kurtuluş Savaşı Kongreleri',
        description: 'Genelge ve kongre şifrelerini çöz, soruları fethet!',
        xpReward: 45,
        gemReward: 15,
        questions: [
          // 1. KAVRAM KARTI: Amasya Genelgesi Şifresi
          Question(
            id: 'concept_tar_2_1',
            type: QuestionType.conceptCard,
            conceptTitle: 'Amasya Genelgesi\'nin Şifresi (22 Haziran 1919)',
            iconEmoji: '📜',
            rule: 'Milli Mücadele\'nin GEREKÇESİ, AMACI ve YÖNTEMİ ilk kez bu genelgede açıkça ilan edilmiştir.',
            examples: [
              '"Vatanın bütünlüğü milletin istiklali tehlikededir." -> GEREKÇE',
              '"İstanbul Hükümeti üzerine düşen görevi yerine getirememektedir." -> GEREKÇE',
              '"Milletin bağımsızlığını yine milletin azim ve kararı kurtaracaktır." -> AMAÇ VE YÖNTEM',
            ],
            examTip: '"Milletin azim ve kararı" ifadesi, ilk kez üstü kapalı olarak MİLLİ EGEMENLİK (Cumhuriyet) fikrini ima etmektedir!',
          ),
          // 1. SORU: Amasya Genelgesi (ABCD)
          Question(
            id: 'q_tar_2_1',
            type: QuestionType.multipleChoice,
            prompt: '"Milletin bağımsızlığını yine milletin azim ve kararı kurtaracaktır." maddesiyle Kurtuluş Savaşı\'nın AMACI ve YÖNTEMİ ilk kez nerede belirtilmiştir?',
            options: [
              'Havza Genelgesi',
              'Amasya Genelgesi',
              'Erzurum Kongresi',
              'Sivas Kongresi',
            ],
            correctIndex: 1,
            explanation: 'Amasya Genelgesi (22 Haziran 1919), Kurtuluş Savaşı\'nın gerekçesini, amacını ve yöntemini ilk kez belirten tarihi belgedir.',
          ),

          // 2. KAVRAM KARTI: Erzurum ve Sivas Karşılaştırması
          Question(
            id: 'concept_tar_2_2',
            type: QuestionType.conceptCard,
            conceptTitle: 'Erzurum vs Sivas: Manda ve Himaye',
            iconEmoji: '🇹🇷',
            rule: 'Manda ve himaye (başka bir devletin boyunduruğuna girme), Türk bağımsızlık ruhuna taban tabana zıttır.',
            examples: [
              'İLK KEZ RED: Erzurum Kongresi\'nde ilk kez reddedildi.',
              'KESİN VE SON KEZ RED: Sivas Kongresi\'nde bir daha gündeme gelmemek üzere tamamen reddedildi.',
              'Erzurum: Toplanış bölgesel, kararları ulusal.',
              'Sivas: Hem toplanış hem kararları ulusal.',
            ],
            examTip: 'ÖSYM "İlk kez nerede reddedildi?" derse cevap: Erzurum. "Kesin olarak nerede reddedildi?" derse cevap: Sivas!',
          ),
          // 2. SORU: Manda ve Himaye (ABCD)
          Question(
            id: 'q_tar_2_2',
            type: QuestionType.multipleChoice,
            prompt: '"Manda ve himaye kesin ve son olarak reddedilmiştir" kararı hangi kongrede alınmıştır?',
            options: [
              'Sivas Kongresi',
              'Amasya Görüşmeleri',
              'Alaşehir Kongresi',
              'Pozantı Kongresi',
            ],
            correctIndex: 0,
            explanation: 'Manda ve himaye fikri ilk kez Erzurum\'da, kesin ve son olarak ise Sivas Kongresi\'nde tam bağımsızlık ilkesi gereği reddedilmiştir.',
          ),

          // 3. KAVRAM KARTI: Havza Genelgesi
          Question(
            id: 'concept_tar_2_3',
            type: QuestionType.conceptCard,
            conceptTitle: 'Havza Genelgesi & Mitingler (28 Mayıs 1919)',
            iconEmoji: '📣',
            rule: 'Mustafa Kemal Paşa Samsun\'a çıktıktan sonra Havza\'ya geçerek ilk genelgesini yayımlamıştır.\n• İşgallerin mitinglerle protesto edilmesini istemiştir.\n• Ancak Hristiyan azınlığa taşkınlık YAPILMAMASI konusunda uyarmıştır (İtilaf Devletleri Mondros\'un 7. maddesini bahane etmesin diye!).',
            examples: [
              'Milli bilinci uyandırmak için atılan ilk adımdır.',
              'Karakol Cemiyeti ve halk mitinglerle ilk kez organize tepki vermiştir.',
            ],
            examTip: 'ÖSYM sorar: Mustafa Kemal mitinglerde azınlıklara kötü davranılmamasını neden istemiştir? -> Mondros 7. madde gereği yeni işgallere zemin hazırlamamak için.',
          ),
          // 3. SORU: Havza Genelgesi (ABCD)
          Question(
            id: 'q_tar_2_3',
            type: QuestionType.multipleChoice,
            prompt: 'Mustafa Kemal Havza Genelgesi\'nde halktan işgalleri protesto etmesini isterken azınlıklara zarar verilmemesini özellikle tembihlemiştir. Bunun TEMEL AMACI nedir?',
            options: [
              'İtilaf Devletlerinin Mondros 7. maddeyi öne sürerek yeni işgaller yapmasını engellemek',
              'Padişahın güvenini kazanmak',
              'Osmanlı borçlarını sildirmek',
              'Azınlıkların askerlik yapmasını sağlamak',
            ],
            correctIndex: 0,
            explanation: 'Mondros\'un 7. maddesi karışıklık çıkan yerlerin işgaline izin veriyordu; azınlıklara taşkınlık yapılmaması işgal gerekçesini yok etmek içindir.',
          ),
          // 4. SORU: Boşluk Doldurma
          Question(
            id: 'q_tar_2_4',
            type: QuestionType.fillInTheBlank,
            prompt: 'Temsil Heyeti ilk kez Erzurum Kongresi\'nde kurulmuş, yetkileri _____ Kongresi\'nde tüm yurdu temsil edecek şekilde genişletilmiştir.',
            blankOptions: ['Sivas', 'Amasya', 'Havza', 'Balıkesir'],
            correctBlankAnswer: 'Sivas',
            explanation: 'Erzurum\'da bölgesel olan Temsil Heyeti, Sivas Kongresi\'nde tüm vatanı temsil eden milli bir organ haline getirilmiştir.',
          ),
          // 5. SORU: Eşleştirme
          Question(
            id: 'q_tar_2_5',
            type: QuestionType.matching,
            prompt: 'Genelge ve kongreleri aldıkları tarihi kararlarla eşleştirin:',
            explanation: 'Milli Mücadele hazırlık dönemi adımları:',
            matchingPairs: [
              MatchingPair(left: 'Havza Genelgesi', right: 'İşgallere karşı ilk miting çağrısı'),
              MatchingPair(left: 'Amasya Genelgesi', right: 'Milli Mücadele\'nin amacı ve yöntemi'),
              MatchingPair(left: 'Erzurum Kongresi', right: 'Manda ve himayenin ilk kez reddi'),
              MatchingPair(left: 'Sivas Kongresi', right: 'Tüm cemiyetlerin birleştirilmesi'),
            ],
          ),
        ],
      ),

      Lesson(
        id: 'lesson_tar_3',
        title: 'Sevr ve Lozan Karşılaştırması',
        description: 'Milli Mücadele\'nin diplomatik zaferleri',
        xpReward: 50,
        gemReward: 20,
        questions: [
          // 1. KAVRAM KARTI: Sevr Neden Hukuken Geçersizdir?
          Question(
            id: 'concept_tar_3_1',
            type: QuestionType.conceptCard,
            conceptTitle: 'Sevr Antlaşması Hukuken Neden Ölü Doğmuştur?',
            iconEmoji: '⚖️',
            rule: 'Osmanlı Anayasası (Kanun-i Esasi) gereğince bir uluslararası antlaşmanın yürürlüğe girebilmesi için MEBUSAN MECLİSİ tarafından onaylanması zorunludur.\nİtilaf Devletleri Meclis-i Mebusan\'ı kapattığı için Sevr hiçbir zaman meclis onayından geçmemiştir!',
            examples: [
              'Sevr\'i padişahın kurduğu "Saltanat Şurası" imzalamıştır.',
              'TBMM, Sevr\'i imzalayanları vatan haini ilan etmiştir.',
            ],
            examTip: 'ÖSYM sorar: "Sevr Antlaşması\'nın hukuken geçersiz olmasının temel sebebi nedir?" -> Mebusan Meclisi onayından geçmemiş olmasıdır.',
          ),
          // 1. SORU: Sevr Sorusu (ABCD)
          Question(
            id: 'q_tar_3_1',
            type: QuestionType.multipleChoice,
            prompt: 'Sevr Barış Antlaşması\'nın hukuken geçersiz sayılmasının (ölü doğmuş antlaşma olmasının) temel gerekçesi aşağıdakilerden hangisidir?',
            options: [
              'Padişah tarafından imzalanmamış olması',
              'Osmanlı Mebusan Meclisi onayından geçmemiş olması',
              'İtilaf Devletleri arasında anlaşmazlık çıkması',
              'Antlaşmanın Türkçeye çevrilmemiş olması',
            ],
            correctIndex: 1,
            explanation: 'Kanun-i Esasi\'ye göre antlaşmalar Mebusan Meclisi onayından geçmelidir. Meclis kapalı olduğundan ve onaylamadığından Sevr hukuken geçersizdir.',
          ),

          // 2. KAVRAM KARTI: Lozan\'da Çözülemeyen Tek Konu
          Question(
            id: 'concept_tar_3_2',
            type: QuestionType.conceptCard,
            conceptTitle: 'Lozan Barış Antlaşması ve Musul Sorunu',
            iconEmoji: '🇹🇷',
            rule: '24 Temmuz 1923\'te imzalanan Lozan Antlaşması Türkiye\'nin bağımsızlık belgesidir. Kapitülasyonlar tamamen kaldırılmış, azınlıklar Türk vatandaşı sayılmıştır.',
            examples: [
              'ÇÖZÜLEBİLENLER: Kapitülasyonlar (kaldırıldı), Dış Borçlar (paylaşıldı), Azınlıklar (Türk vatandaşı oldu), Boğazlar (Komisyon kuruldu, 1936 Montrö ile çözüldü).',
              'LOZAN\'DA ÇÖZÜLEMEYEN TEK MESELE: Musul Sorunu (Türkiye - Irak Sınırı). İngiltere ile 9 ay içinde ikili görüşmelere bırakılmıştır.',
            ],
            examTip: 'ÖSYM\'nin en klasik sorusu: "Lozan Antlaşması\'nda çözüme kavuşturulamayan ve sonraya bırakılan tek sınır hangisidir?" -> IRAK SINIRI (Musul Meselesi).',
          ),
          // 2. SORU: Lozan Boşluk Doldurma
          Question(
            id: 'q_tar_3_2',
            type: QuestionType.fillInTheBlank,
            prompt: 'Lozan Barış Antlaşması\'nda çözüme kavuşturulamayan tek sınır _____ sınırıdır (Musul meselesi).',
            blankOptions: ['Irak', 'Suriye', 'Yunanistan', 'İran'],
            correctBlankAnswer: 'Irak',
            explanation: 'Musul meselesi nedeniyle Türkiye-Irak sınırı Lozan\'da çözülememiş, 1926 Ankara Antlaşması\'na kalmıştır.',
          ),

          // 3. KAVRAM KARTI: Mudanya Ateşkesi (Savaşsız Zafer)
          Question(
            id: 'concept_tar_3_3',
            type: QuestionType.conceptCard,
            conceptTitle: 'Mudanya Ateşkes Antlaşması (11 Ekim 1922)',
            iconEmoji: '🤝',
            rule: 'Büyük Taarruz\'un askeri zaferle bitmesi üzerine imzalanmıştır.\n• Doğu Trakya, İstanbul ve Boğazlar TEK BİR KURŞUN ATILMADAN (diplomatik yolla) TBMM yönetimine bırakılmıştır.\n• Osmanlı Devleti hukuken sona ermiştir.',
            examples: [
              'İsmet Paşa başarılı diplomasisiyle Lozan baş delegeliğini kazanmıştır.',
              'Refet Bele İstanbul\'a girerek yönetimi teslim almıştır.',
            ],
            examTip: 'ÖSYM sorar: "Kurtuluş Savaşı\'nda savaş yapılmadan diplomatik başarıyla kurtarılan yer neresidir?" -> Doğu Trakya ve İstanbul!',
          ),
          // 3. SORU: Mudanya Ateşkesi (ABCD)
          Question(
            id: 'q_tar_3_3',
            type: QuestionType.multipleChoice,
            prompt: 'Aşağıdaki bölgelerden hangisi Kurtuluş Savaşı\'nda askeri bir çatışma yaşanmadan, Mudanya Ateşkesi ile diplomatik yolla kurtarılmıştır?',
            options: [
              'İzmir',
              'Doğu Trakya',
              'Antep',
              'Maraş',
            ],
            correctIndex: 1,
            explanation: 'Doğu Trakya (Edirne, Kırklareli, Tekirdağ) ve İstanbul, Mudanya Ateşkes Antlaşması ile savaş yapılmadan kurtarılmıştır.',
          ),
          // 4. SORU: Doğru / Yanlış
          Question(
            id: 'q_tar_3_4',
            type: QuestionType.trueFalse,
            prompt: 'Lozan Barış Antlaşması ile yabancı devletlere tanınan adli ve mali ayrıcalıklar olan "kapitülasyonlar" tamamen kaldırılmıştır.',
            isTrue: true,
            explanation: 'Doğru! Kapitülasyonlar Lozan\'da taviz verilmeksizin bütünüyle kaldırılmış ve Türkiye tam ekonomik bağımsızlığını kazanmıştır.',
          ),
          // 5. SORU: Eşleştirme
          Question(
            id: 'q_tar_3_5',
            type: QuestionType.matching,
            prompt: 'Lozan Barış Antlaşması konularını varılan sonuçlarla eşleştirin:',
            explanation: 'Lozan Antlaşması maddeleri ve kararları:',
            matchingPairs: [
              MatchingPair(left: 'Kapitülasyonlar', right: 'Tamamen kaldırıldı'),
              MatchingPair(left: 'Azınlıklar', right: 'Türk vatandaşı sayıldı'),
              MatchingPair(left: 'Musul Sorunu', right: 'Çözümü sonraya bırakıldı'),
              MatchingPair(left: 'Dış Borçlar', right: 'Osmanlıdan ayrılanlara paylaştırıldı'),
            ],
          ),
        ],
      ),

      // ==========================================
      // ÜNİTE 1 SONU KUPA SINAVI (BOSS LEVEL)
      // ==========================================
      Lesson(
        id: 'exam_unit_tar_1',
        title: 'Ünite 1 Kupa Sınavı 🏆',
        description: 'Tarih kavramları ve Milli Mücadele zaferlerini taçlandır!',
        xpReward: 100,
        gemReward: 30,
        isUnitExam: true,
        questions: [
          Question(
            id: 'exam_tar1_q1',
            type: QuestionType.multipleChoice,
            prompt: 'Eski Türklerde devlet işlerinin görüşülüp karara bağlandığı meclise ne ad verilir?',
            options: [
              'Toygun',
              'Kurultay',
              'Tigin',
              'Şad',
            ],
            correctIndex: 1,
            explanation: 'Devlet işlerinin danışıldığı ve görüşüldüğü meclise Kurultay (Toy ya da Kengeş) denir.',
          ),
          Question(
            id: 'exam_tar1_q2',
            type: QuestionType.fillInTheBlank,
            prompt: 'Manda ve himaye fikri ilk kez Erzurum\'da, kesin ve son olarak _____ Kongresi\'nde reddedilmiştir.',
            blankOptions: ['Sivas', 'Amasya', 'Havza', 'Balıkesir'],
            correctBlankAnswer: 'Sivas',
            explanation: 'Sivas Kongresi tam bağımsızlık ilkesi doğrultusunda manda ve himayeyi kesin olarak reddetmiştir.',
          ),
          Question(
            id: 'exam_tar1_q3',
            type: QuestionType.matching,
            prompt: 'Tarihi belgeleri temel özellikleriyle eşleştirin:',
            explanation: 'Milli Mücadele dönemi kronolojisi ve belgeleri:',
            matchingPairs: [
              MatchingPair(left: 'Amasya Genelgesi', right: 'Amaç ve yöntem ilk kez açıklandı'),
              MatchingPair(left: 'Erzurum Kongresi', right: 'Toplanış bölgesel, kararları ulusal'),
              MatchingPair(left: 'Sivas Kongresi', right: 'Tüm cemiyetler tek çatı altında toplandı'),
              MatchingPair(left: 'Lozan Antlaşması', right: 'Kapitülasyonlar tamamen kaldırıldı'),
            ],
          ),
          Question(
            id: 'exam_tar1_q4',
            type: QuestionType.multipleChoice,
            prompt: 'İlk Türk devletlerinde hükümdara devleti yönetme yetkisinin Tanrı tarafından verildiği inancına ne ad verilir?',
            options: [
              'Oksızlık',
              'Kut',
              'Yarlıg',
              'Töre',
            ],
            correctIndex: 1,
            explanation: 'Gök Tanrı\'nın hükümdara ve ailesine bağışladığına inanılan yönetme yetkisine "Kut" denir.',
          ),
          Question(
            id: 'exam_tar1_q5',
            type: QuestionType.multipleChoice,
            prompt: 'Aşağıdakilerden hangisi Sevr Antlaşması\'nın hukuken geçersiz sayılmasının temel nedenidir?',
            options: [
              'Osmanlı Mebusan Meclisi tarafından onaylanmamış olması',
              'Müttefik devletlerin çekilmesi',
              'İstanbul Hükümetinin istifa etmesi',
              'Savaşın bitmemiş olması',
            ],
            correctIndex: 0,
            explanation: 'Kanun-i Esasi\'ye göre meclis onayından geçmeyen uluslararası antlaşmalar hukuken hükümsüzdür.',
          ),
          Question(
            id: 'exam_tar1_q6',
            type: QuestionType.fillInTheBlank,
            prompt: 'Mete Han\'ın kurduğu ve günümüz dünya ordularında hâlâ kullanılan askeri sistem _____ sistemdir.',
            blankOptions: ['onlu', 'ikili', 'tımarlı', 'kapıkulu'],
            correctBlankAnswer: 'onlu',
            explanation: 'Mete Han M.Ö. 209\'da orduyu 10, 100, 1000 ve 10.000\'lik birliklere bölerek Onlu Sistemi kurmuştur.',
          ),
          Question(
            id: 'exam_tar1_q7',
            type: QuestionType.trueFalse,
            prompt: 'Lozan Barış Antlaşması\'nda Türkiye-Irak sınırı (Musul meselesi) çözüme kavuşturulamamıştır.',
            isTrue: true,
            explanation: 'Doğru! Musul meselesi İngiltere ile ikili görüşmelere bırakılmış ve 1926 Ankara Antlaşması ile çözülmüştür.',
          ),
          Question(
            id: 'exam_tar1_q8',
            type: QuestionType.matching,
            prompt: 'Kavramları doğru açıklamalarıyla eşleştirin:',
            explanation: 'İlk Türk Devletleri ve Kurtuluş Savaşı temel kavramları:',
            matchingPairs: [
              MatchingPair(left: 'Oguş', right: 'Aile'),
              MatchingPair(left: 'Bodun', right: 'Millet'),
              MatchingPair(left: 'Kut', right: 'İlahi yönetme yetkisi'),
              MatchingPair(left: 'Töre', right: 'Yazısız hukuk kuralları'),
            ],
          ),
        ],
      ),
    ],
  ),

  // ===========================================================================
  // ÜNİTE 1: TYT COĞRAFYA - HARİTA BİLGİSİ, İKLİM & AFETLER
  // ===========================================================================
  LearningUnit(
    id: 'unit_cografya_1',
    unitNumber: 1,
    title: 'Harita Bilgisi, İklim & Afetler',
    subject: 'TYT Coğrafya',
    colorHex: 0xFF00B4D8, // Duolingo Turkuaz / Mavi
    lessons: [
      Lesson(
        id: 'lesson_cog_1',
        title: 'İzohipsler (Eş Yükselti Eğrileri)',
        description: 'Eğim, vadi, sırt ve delta ovası tespit taktikleri',
        xpReward: 40,
        gemReward: 15,
        questions: [
          // 1. KAVRAM KARTI: İzohips Sıklaşması ve Eğim
          Question(
            id: 'concept_cog_1_1',
            type: QuestionType.conceptCard,
            conceptTitle: 'İzohips Eğrilerinin Sırrı: EĞİM!',
            iconEmoji: '🗺️',
            rule: '• İzohips çizgilerinin BİRBİRİNE ÇOK YAKLAŞTIĞI (sıklaştığı) yerlerde EĞİM ÇOK FAZLADIR!\n  -> Akarsuyun akış hızı fazladır.\n  -> Aşındırma gücü fazladır.\n  -> Hidroelektrik enerji potansiyeli yüksektir.\n  -> Kıyıdaysa falez (yalıyar) oluşur, kıta sahanlığı dardır.\n• Eğrilerin seyrekleştiği yerlerde ise eğim azdır, biriktirme ve delta ovaları oluşur.',
            examples: [
              'Doğu Karadeniz ve Toroslar: Eğriler çok sık, eğim fazla.',
              'Ege kıyıları ve Çukurova: Eğriler seyrek, eğim az, delta ovaları var.',
            ],
            examTip: 'İzohips haritasında bir akarsu denizle buluştuğu yerde karayı denize doğru üçgen şeklinde itmişse orası DELTA OVASIDIR. Delta ovasının olduğu yerde kıta sahanlığı GENİŞTİR.',
          ),
          // 1. SORU: Boşluk Doldurma
          Question(
            id: 'q_cog_1_1',
            type: QuestionType.fillInTheBlank,
            prompt: 'Bir topoğrafya haritasında izohips eğrileri birbirine yaklaştıkça o bölgede yer şekillerinin _____ artar.',
            blankOptions: ['eğimi', 'sıcaklığı', 'yağışı', 'yüz ölçümü'],
            correctBlankAnswer: 'eğimi',
            explanation: 'İzohipslerin sıklaşması eğimin arttığını gösteren en temel kuraldır.',
          ),
          // 2. SORU: İzohips Sorusu (ABCD)
          Question(
            id: 'q_cog_1_2',
            type: QuestionType.multipleChoice,
            prompt: 'Bir topoğrafya haritasında izohips eğrilerinin birbirine çok yaklaştığı (sıklaştığı) bir bölge için aşağıdakilerden hangisi KESİNLİKLE söylenemez?',
            options: [
              'Yer şekillerinin eğimi fazladır.',
              'Bölgeden geçen akarsuyun hidroelektrik enerji potansiyeli yüksektir.',
              'Kıyıdaysa kıta sahanlığı çok geniştir ve delta ovası oluşmuştur.',
              'Akarsuyun akış hızı ve aşındırma gücü fazladır.',
            ],
            correctIndex: 2,
            explanation: 'Eğrilerin sıklaştığı yerde eğim fazladır, kıyıda falez oluşur ve kıta sahanlığı dardır. Delta ovaları eğimin az olduğu ve eğrilerin seyrekleştiği kıyılarda oluşur.',
          ),

          // 2. KAVRAM KARTI: Vadi vs Sırt
          Question(
            id: 'concept_cog_1_2',
            type: QuestionType.conceptCard,
            conceptTitle: 'Vadi ve Sırt Ayrımı (V Kuralı)',
            iconEmoji: '⛰️',
            rule: 'İzohips haritalarında "V" şekli iki temel yer şeklini gösterir:\n• V\'nin sivri ucu YÜKSEKTEKİ (zirveye doğru) değeri gösteriyorsa: VADİDİR (Akarsu vadisi).\n• V\'nin sivri ucu ALÇAKTAKİ değeri gösteriyorsa: SIRT (Dağ sırtı)tır.',
            examples: [
              'Akarsuların aktığı yerler daima vadidir.',
              'İki tepe arasında kalan düzlüğe BOYUN denir.',
            ],
            examTip: 'İzohipsler üzerinde ok işareti olan çizgiler akarsu akış yönünü gösterir. Akarsu daima yüksekten alçağa doğru akar!',
          ),
          // 3. SORU: Vadi vs Sırt (ABCD)
          Question(
            id: 'q_cog_1_3',
            type: QuestionType.multipleChoice,
            prompt: 'Bir izohips haritasında eş yükselti eğrilerinin "V" harfi şeklinde büküldüğü ve V\'nin sivri ucunun yükseltinin arttığı yöne baktığı yer şekli nedir?',
            options: [
              'Vadi',
              'Sırt',
              'Falez',
              'Plato',
            ],
            correctIndex: 0,
            explanation: 'V\'nin sivri ucu yüksek kesimleri gösteriyorsa o yer şekli akarsu aşındırmasıyla oluşan bir vadidir.',
          ),

          // 3. KAVRAM KARTI: Kapalı Çukur (Çanak)
          Question(
            id: 'concept_cog_1_3',
            type: QuestionType.conceptCard,
            conceptTitle: 'Kapalı Çukur & Krater Şeması',
            iconEmoji: '🕳️',
            rule: 'İzohips çizgileri üzerinde içeriye (merkeze) doğru bakan küçük OKLAR varsa o alan KAPALI ÇUKUR (çanak/krater) dur.\n• Okların başladığı çizgiden bittiği çizgiye kadar yükselti İZOHİPS ARALIĞI KADAR DÜŞER.',
            examples: [
              'Volkan kraterleri (Nemrut Dağı krateri).',
              'Karstik dolin ve obruk çukurları.',
            ],
            examTip: 'Ok işaretini gördüğünde yükseltiyi artırma, her izohips çizgisi için aralık değeri kadar eksilt!',
          ),
          // 4. SORU: Boşluk Doldurma
          Question(
            id: 'q_cog_1_4',
            type: QuestionType.fillInTheBlank,
            prompt: 'İzohips haritasında merkeze doğru içe dönük ok işaretleri _____ olduğunu gösterir.',
            blankOptions: ['kapalı çukur', 'dağ zirvesi', 'falez', 'delta ovası'],
            correctBlankAnswer: 'kapalı çukur',
            explanation: 'İçe doğru yönelmiş ok işaretleri yükseltinin azaldığı kapalı çukur (çanak) alanlarını gösterir.',
          ),
          // 5. SORU: Eşleştirme
          Question(
            id: 'q_cog_1_5',
            type: QuestionType.matching,
            prompt: 'İzohips terimlerini doğru anlamlarıyla eşleştirin:',
            explanation: 'Topoğrafya haritalarında yer şekli okuma kuralları:',
            matchingPairs: [
              MatchingPair(left: 'Falez (Yalıyar)', right: 'Kıyıda izohipslerin üst üste binmesi'),
              MatchingPair(left: 'Boyun', right: 'İki tepe arasındaki alçak düzlük'),
              MatchingPair(left: 'Delta Ovası', right: 'Akarsuyun denize yaptığı çıkıntı'),
              MatchingPair(left: 'Zirve (Doruk)', right: 'İzohipslerin merkezindeki nokta/üçgen'),
            ],
          ),
        ],
      ),

      Lesson(
        id: 'lesson_cog_2',
        title: 'Türkiye\'de Doğal Afetler: Heyelan vs Erozyon',
        description: 'ÖSYM\'nin en çok düşürdüğü afet çeldiricisi',
        xpReward: 45,
        gemReward: 15,
        questions: [
          // 1. KAVRAM KARTI: Heyelan ve Erozyon Farkı
          Question(
            id: 'concept_cog_2_1',
            type: QuestionType.conceptCard,
            conceptTitle: 'Heyelan mı, Erozyon mu? (Büyük Tuzak!)',
            iconEmoji: '⛰️',
            rule: '• HEYELAN (Kütle Hareketi):\n  -> Şartları: Fazla yağış + Dik eğim + KİLLİ TOPRAK tabakası + Kar erimeleri.\n  -> Türkiye\'de en çok: DOĞU VE BATI KARADENİZ\'de (Özellikle ilkbaharda).\n• EROZYON:\n  -> Şartları: Kuraklık + Bitki örtüsünün cılızlığı + Rüzgar ve yağmur süpürmesi.\n  -> Türkiye\'de en çok: İÇ ANADOLU ve GÜNEYDOĞU ANADOLU.',
            examples: [
              'Heyelan hızlı ve anlık bir afettir; koca bir dağ yamacı kayar.',
              'Erozyon çok yavaş ilerler; verimli üst toprağın taşınmasıdır.',
            ],
            examTip: 'ÖSYM TUZAĞI: "Ağaçlandırma yapmak" erozyonu önlemede 1 numaralı çözümdür. AMA ağaçlandırma tek başına killi ve aşırı suya doymuş toprağın heyelanla kaymasını ENGELLEYEMEZ!',
          ),
          // 1. SORU: Doğal Afetler Sorusu (ABCD)
          Question(
            id: 'q_cog_2_1',
            type: QuestionType.multipleChoice,
            prompt: 'Türkiye\'de heyelan olaylarının en fazla Karadeniz Bölgesi\'nde ve özellikle ilkbahar aylarında görülmesinin temel sebebi aşağıdakilerden hangisidir?',
            options: [
              'İlkbaharda şiddetli fırtınaların ve rüzgarların etkili olması',
              'Kar erimeleri ve aşırı yağışlar sonucu killi toprak tabakasının suya doyup kayganlaşması',
              'Bölgedeki ağaçların yaprak dökmesi',
              'Tektonik depremlerin ilkbahar aylarında artış göstermesi',
            ],
            correctIndex: 1,
            explanation: 'Heyelanın en temel tetikleyicisi karların erimesi, bol yağış ve killi toprağın suyu emerek adeta sabun gibi kayganlaşmasıdır.',
          ),

          // 2. KAVRAM KARTI: Orman Yangınları ve Çığ
          Question(
            id: 'concept_cog_2_2',
            type: QuestionType.conceptCard,
            conceptTitle: 'Orman Yangını & Çığ Koşulları',
            iconEmoji: '🔥',
            rule: '• Orman Yangınları: Akdeniz ve Ege kıyılarında, yaz kuraklığı, yüksek sıcaklık ve reçineli kızılçam ormanları nedeniyle riski en fazladır.\n• Çığ: Doğu Anadolu\'da (Hakkari, Van, Bitlis) dik eğimli yamaçlar ve yoğun kar yağışı nedeniyle kış/ilkbahar aylarında görülür.',
            examples: [
              'Antalya, Muğla, İzmir: Orman yangını riski çok yüksek.',
              'Karadeniz kıyılarında yazın her mevsim yağış olduğundan yangın riski düşüktür.',
            ],
            examTip: 'ÖSYM sorar: "Karadeniz kıyılarında orman çok olmasına rağmen yangın riski neden düşüktür?" -> Her mevsim yağışlı ve nemli olması sebebiyle!',
          ),
          // 2. SORU: Orman Yangınları (ABCD)
          Question(
            id: 'q_cog_2_2',
            type: QuestionType.multipleChoice,
            prompt: 'Karadeniz Bölgesi zengin orman varlığına sahip olmasına rağmen Akdeniz Bölgesi\'ne göre orman yangını riskinin ÇOK DAHA DÜŞÜK olmasının temel nedeni nedir?',
            options: [
              'Bölgede hiç insan yerleşimi olmaması',
              'Yaz kuraklığının belirgin olmaması ve her mevsimin yağışlı/nemli geçmesi',
              'Ağaç türlerinin yanmayan maddeler içermesi',
              'Bölgede rüzgarların hiç esmemesi',
            ],
            correctIndex: 1,
            explanation: 'Karadeniz ikliminde yaz kuraklığı yaşanmaz, bağıl nem ve yağış yıl boyu yüksektir; bu da yangın riskini ciddi oranda düşürür.',
          ),

          // 3. KAVRAM KARTI: Deprem Kuşakları ve Güvenli Masifler
          Question(
            id: 'concept_cog_2_3',
            type: QuestionType.conceptCard,
            conceptTitle: 'Türkiye\'de Deprem Riskinin Az Olduğu Yerler',
            iconEmoji: '🛡️',
            rule: 'Türkiye genç oluşumlu (3. ve 4. jeolojik zaman) bir ülke olduğu için %90\'ı deprem bölgesidir. Ancak yaşlı ve sert kütleler (Masif araziler) fay hatlarından uzaktır ve deprem riski azdır.',
            examples: [
              'Deprem Riski En Az Olan Alanlar: Konya - Karaman (Tuz Gölü güneyi), Taşeli Platosu, Mardin Eşiği, Ergene Havzası, Sinop çevresi.',
            ],
            examTip: 'ÖSYM Türkiye haritasında numaralı noktalar verip "Hangisinde tektonik deprem riski en azdır?" diye sıkça sorar. Konya-Karaman veya Mardin\'i işaretle!',
          ),
          // 3. SORU: Deprem Riski (ABCD)
          Question(
            id: 'q_cog_2_3',
            type: QuestionType.multipleChoice,
            prompt: 'Aşağıdaki alanların hangisinde tektonik deprem riski DİĞERLERİNE GÖRE DAHA AZDIR?',
            options: [
              'Marmara Denizi ve çevresi',
              'Hatay - Maraş fayı',
              'Konya - Karaman ve Tuz Gölü çevresi',
              'Ege çöküntü ovaları (Gediz, Menderes)',
            ],
            correctIndex: 2,
            explanation: 'Konya-Karaman ve çevresi Türkiye\'de masif karakterli olup ana aktif fay hatlarından uzaktır; deprem tehlikesi düşüktür.',
          ),
          // 4. SORU: Boşluk Doldurma
          Question(
            id: 'q_cog_2_4',
            type: QuestionType.fillInTheBlank,
            prompt: 'Toprağın rüzgâr ve yağmur sularıyla süpürülüp taşınması olayına _____ denir.',
            blankOptions: ['erozyon', 'heyelan', 'çığ', 'tsunami'],
            correctBlankAnswer: 'erozyon',
            explanation: 'Verimli üst toprağın rüzgâr ve akarsularla deniz veya göllere taşınmasına erozyon denir.',
          ),
          // 5. SORU: Eşleştirme
          Question(
            id: 'q_cog_2_5',
            type: QuestionType.matching,
            prompt: 'Doğal afetleri kökenlerine göre eşleştirin:',
            explanation: 'Doğal afetler oluşturan faktörlere göre sınıflandırılır:',
            matchingPairs: [
              MatchingPair(left: 'Deprem ve Tsunami', right: 'Jeolojik / Jeomorfolojik'),
              MatchingPair(left: 'Kuraklık ve Fırtına', right: 'Klimatik / Meteorolojik'),
              MatchingPair(left: 'Heyelan', right: 'Eğim + Yağış + Killi Yapı'),
              MatchingPair(left: 'Erozyon', right: 'Bitki Örtüsü Cılızlığı'),
            ],
          ),
        ],
      ),

      // ==========================================
      // ÜNİTE 1 SONU KUPA SINAVI (BOSS LEVEL)
      // ==========================================
      Lesson(
        id: 'exam_unit_cog_1',
        title: 'Ünite 1 Kupa Sınavı 🏆',
        description: 'Coğrafya harita ve doğal afetler final kupa sınavı!',
        xpReward: 100,
        gemReward: 30,
        isUnitExam: true,
        questions: [
          Question(
            id: 'exam_cog1_q1',
            type: QuestionType.multipleChoice,
            prompt: 'Aşağıdaki doğal afetlerden hangisinin oluşumunda jeolojik (yer yapısı / fay hattı) faktörler doğrudan etkilidir?',
            options: [
              'Erozyon',
              'Deprem',
              'Çığ',
              'Kuraklık',
            ],
            correctIndex: 1,
            explanation: 'Deprem yer kabuğundaki kırılmalar ve levha hareketleri sonucu meydana gelen jeolojik bir afettir.',
          ),
          Question(
            id: 'exam_cog1_q2',
            type: QuestionType.fillInTheBlank,
            prompt: 'İzohips haritasında bir akarsuyun denize döküldüğü yerde denize doğru üçgen şeklinde karasal çıkıntı varsa orada _____ ovası oluşmuştur.',
            blankOptions: ['delta', 'karstik', 'tektonik', 'taban seviyesi'],
            correctBlankAnswer: 'delta',
            explanation: 'Akarsuların taşıdığı alüvyonları denizde biriktirmesiyle üçgen şeklinde delta ovaları meydana gelir.',
          ),
          Question(
            id: 'exam_cog1_q3',
            type: QuestionType.matching,
            prompt: 'Doğal afetleri en çok etkili oldukları bölgelerle eşleştirin:',
            explanation: 'Türkiye\'nin afet coğrafyası:',
            matchingPairs: [
              MatchingPair(left: 'Heyelan', right: 'Karadeniz Bölgesi'),
              MatchingPair(left: 'Rüzgar Erozyonu', right: 'İç Anadolu & Güneydoğu'),
              MatchingPair(left: 'Orman Yangınları', right: 'Akdeniz & Ege Kıyıları'),
              MatchingPair(left: 'Çığ Düşmesi', right: 'Doğu Anadolu Dağları'),
            ],
          ),
          Question(
            id: 'exam_cog1_q4',
            type: QuestionType.multipleChoice,
            prompt: 'Aşağıdakilerden hangisi erozyonu önlemek için alınabilecek en etkili önlemlerden biridir?',
            options: [
              'Meraları aşırı otlatmaya açmak',
              'Eğimli arazileri eğim yönünde sürmek',
              'Ağaçlandırma yapmak ve taraçalama (teraslama) uygulamak',
              'Tarlalarda anız yakılmasını teşvik etmek',
            ],
            correctIndex: 2,
            explanation: 'Ağaçlandırma, bitki örtüsünü koruma ve eğimli yamaçları teraslama erozyonun en güçlü ilacıdır.',
          ),
          Question(
            id: 'exam_cog1_q5',
            type: QuestionType.multipleChoice,
            prompt: 'Kıyıda izohips eğrilerinin birbirine çok yaklaşıp üst üste binmesi hangi yer şeklini gösterir?',
            options: [
              'Falez (Yalıyar)',
              'Delta ovası',
              'Kıyı oku',
              'Tombolo',
            ],
            correctIndex: 0,
            explanation: 'Kıyıda eğimin çok dik olduğunu ve dalga aşındırmasıyla oluşan dik uçurumu (falez/yalıyar) gösterir.',
          ),
          Question(
            id: 'exam_cog1_q6',
            type: QuestionType.fillInTheBlank,
            prompt: 'Türkiye\'de heyelan olayları kar erimeleri ve killi toprağın suya doyması nedeniyle en çok _____ mevsiminde yaşanır.',
            blankOptions: ['ilkbahar', 'yaz', 'sonbahar', 'kış'],
            correctBlankAnswer: 'ilkbahar',
            explanation: 'İlkbaharda artan yağışlar ve eriyen kar suları killi toprağı kayganlaştırarak heyelanları tetikler.',
          ),
          Question(
            id: 'exam_cog1_q7',
            type: QuestionType.trueFalse,
            prompt: 'Konya ve Karaman çevresi Türkiye\'nin aktif fay hatları üzerinde yer almadığından deprem tehlikesi düşüktür.',
            isTrue: true,
            explanation: 'Doğru! Konya-Karaman ve Tuz Gölü güneyi masif karakterlidir ve sismik riski en az olan alanlardandır.',
          ),
          Question(
            id: 'exam_cog1_q8',
            type: QuestionType.matching,
            prompt: 'Doğal afetleri ve en etkili önlemlerini eşleştirin:',
            explanation: 'Doğal afet yönetimi ve korunma yöntemleri:',
            matchingPairs: [
              MatchingPair(left: 'Erozyon', right: 'Ağaçlandırma & Teraslama'),
              MatchingPair(left: 'Deprem', right: 'Fay hatlarına dayanıklı yapı'),
              MatchingPair(left: 'Çığ', right: 'Kar siperleri & Yamaç ağaçlandırma'),
              MatchingPair(left: 'Heyelan', right: 'İstinat duvarı & Drenaj kanalları'),
            ],
          ),
        ],
      ),
    ],
  ),

  // ===========================================================================
  // ÜNİTE 1: TYT BİYOLOJİ - HÜCRE, CANLILAR & EKOLOJİ
  // ===========================================================================
  LearningUnit(
    id: 'unit_biyoloji_1',
    unitNumber: 1,
    title: 'Hücre, Canlılar & Ekoloji',
    subject: 'TYT Biyoloji',
    colorHex: 0xFF10B981, // Canlı Zümrüt Yeşili
    lessons: [
      Lesson(
        id: 'lesson_bio_1',
        title: 'Canlıların Temel Bileşenleri & Enzimler',
        description: 'Organik moleküller ve enzimlerin anahtar-kilit modeli',
        xpReward: 40,
        gemReward: 15,
        questions: [
          // 1. KAVRAM KARTI: Organik vs İnorganik Bileşikler
          Question(
            id: 'concept_bio_1_1',
            type: QuestionType.conceptCard,
            conceptTitle: 'İnorganik vs Organik Bileşikler',
            iconEmoji: '🧪',
            rule: '• İnorganik Bileşikler (Su, Mineraller, Asit-Baz-Tuz): Canlılar tarafından SENTEZLENEMEZ, doğadan hazır alınır! Sindirilmeden zardan geçerler ve enerji vermezler.\n• Organik Bileşikler (Karbonhidrat, Yağ, Protein, Vitamin, Enzim): Canlılar tarafından sentezlenir. Karbon (C) ve Hidrojen (H) atomlarını bir arada içerir.',
            examples: [
              'Enerji Vericiler: Karbonhidrat > Yağ > Protein (Açlıkta kullanım sırası)',
              'Vitaminler organik olmasına rağmen enerji VERMEZ!',
            ],
            examTip: 'ÖSYM TUZAĞI: "Vitaminler ve mineraller enerji verir" ifadesi KESİNLİKLE YANLIŞTIR! Her ikisi de sadece düzenleyicidir.',
          ),
          // 1. SORU: İnorganik/Organik (ABCD)
          Question(
            id: 'q_bio_1_1',
            type: QuestionType.multipleChoice,
            prompt: 'Aşağıdaki moleküllerden hangisi hücrede solunumda parçalanarak "hücresel enerji (ATP)" üretiminde doğrudan KULLANILMAZ?',
            options: [
              'Glikoz',
              'Aminoasit',
              'Vitamin',
              'Yağ asidi',
            ],
            correctIndex: 2,
            explanation: 'Vitaminler organik olmalarına ve enzimlerin yapısına (koenzim) katılmalarına rağmen asla enerji verici olarak kullanılmazlar.',
          ),

          // 2. KAVRAM KARTI: Enzimler ve Anahtar-Kilit
          Question(
            id: 'concept_bio_1_2',
            type: QuestionType.conceptCard,
            conceptTitle: 'Enzimlerin Çalışma Mantığı',
            iconEmoji: '🔑',
            rule: '• Enzimler biyolojik katalizörlerdir; aktivasyon enerjisini düşürerek reaksiyonu milyonlarca kat hızlandırırlar.\n• Enzim ile substrat arasında ANAHTAR-KİLİT uyumu vardır.\n• Enzimler reaksiyona girer ve HİÇBİR DEĞİŞİKLİĞE UĞRAMADAN tekrar tekrar çıkarlar!',
            examples: [
              'Substrat: Enzimin etki ettiği maddedir.',
              'Aktif Bölge: Enzimin substrata bağlandığı özel kısımdır.',
            ],
            examTip: 'Enzim miktarı reaksiyon sonunda DEĞİŞMEZ. Substrat miktarı azalırken, ürün miktarı artar.',
          ),
          // 2. SORU: Enzim Diagramlı Soru (Şekilli)
          Question(
            id: 'q_bio_1_2',
            type: QuestionType.multipleChoice,
            diagramType: 'enzyme_lock',
            prompt: 'Yukarıdaki şemada gösterilen enzim-substrat etkileşimi incelendiğinde aşağıdaki yargılardan hangisine ULAŞILAMAZ?',
            options: [
              'Enzim substratına aktif bölgesinden anahtar-kilit modeliyle bağlanır.',
              'Tepkime sonunda enzim parçalanarak tükenir ve yeni bir enzime dönüşür.',
              'Tepkime sonucunda substrat kimyasal değişime uğrayarak ürünlere dönüşmüştür.',
              'Oluşan serbest enzim başka bir substratla tekrar aynı tepkimeyi gerçekleştirebilir.',
            ],
            correctIndex: 1,
            explanation: 'Şemada da açıkça görüldüğü gibi enzim reaksiyondan hiçbir değişikliğe uğramadan "serbest enzim" olarak çıkar; tükenmez veya parçalanmaz.',
          ),

          // 3. KAVRAM KARTI: Enzim Hızını Etkileyen Faktörler
          Question(
            id: 'concept_bio_1_3',
            type: QuestionType.conceptCard,
            conceptTitle: 'Substrat Yüzeyi & Enzim Hızı',
            iconEmoji: '🥩',
            rule: 'Enzimler substrata DIŞ YÜZEYİNDEN etki eder. Bu nedenle substrat yüzeyi arttıkça birim zamanda bağlanan enzim sayısı artar ve reaksiyon hızı fırlar!',
            examples: [
              'Kıyılmış et, parça ete göre çok daha hızlı sindirilir.',
              'Besinleri iyi çiğnemek sindirim enzimlerinin işini kolaylaştırır.',
            ],
            examTip: 'Karaciğer-H₂O₂ deneyine dikkat et: Kıyılmış karaciğerde parçalanan substrat değil ENZİMDİR (Katalaz enzimi hücreden açığa çıkar)!',
          ),
          // 3. SORU: Boşluk Doldurma
          Question(
            id: 'q_bio_1_3',
            type: QuestionType.fillInTheBlank,
            prompt: 'Substrat yüzeyi genişledikçe enzimlerin etki alanı arttığı için reaksiyon hızı _____ .',
            blankOptions: ['artar', 'azalır', 'durur', 'değişmez'],
            correctBlankAnswer: 'artar',
            explanation: 'Enzimler substratın dış yüzeyinden bağlandığı için yüzey arttıkça tepkime belirgin şekilde hızlanır.',
          ),
          // 4. SORU: Doğru / Yanlış
          Question(
            id: 'q_bio_1_4',
            type: QuestionType.trueFalse,
            prompt: 'Bütün enzimler protein yapılı olup tepkimelerden hiçbir değişikliğe uğramadan çıkarlar.',
            isTrue: true,
            explanation: 'Doğru! Enzimler protein yapılı biyolojik katalizörlerdir ve reaksiyonda harcanmazlar.',
          ),
          // 5. SORU: Eşleştirme
          Question(
            id: 'q_bio_1_5',
            type: QuestionType.matching,
            prompt: 'Polimer besinleri yapı taşları (monomerleri) ile eşleştirin:',
            explanation: 'Organik besinlerin hidroliz monomerleri:',
            matchingPairs: [
              MatchingPair(left: 'Protein', right: 'Aminoasit'),
              MatchingPair(left: 'Nişasta', right: 'Glikoz'),
              MatchingPair(left: 'Nötral Yağ (Trigliserit)', right: 'Yağ Asidi ve Gliserol'),
              MatchingPair(left: 'Nükleik Asit (DNA/RNA)', right: 'Nükleotit'),
            ],
          ),
        ],
      ),

      Lesson(
        id: 'lesson_bio_2',
        title: 'Hücre ve Organeller',
        description: 'Ökaryot hücre şeması, mitokondri ve organel görevleri',
        xpReward: 45,
        gemReward: 15,
        questions: [
          // 1. KAVRAM KARTI: Hücre Organellerinin Görevleri
          Question(
            id: 'concept_bio_2_1',
            type: QuestionType.conceptCard,
            conceptTitle: 'Ökaryot Hücre ve Organel Şeması',
            iconEmoji: '🔬',
            rule: '• Mitokondri: Oksijenli solunum ile hücrenin ATP (enerji) santralidir.\n• Ribozom: Protein sentezi yapar (Tüm canlılarda ortaktır, zarsızdır).\n• Kloroplast: Fotosentez ile besin ve oksijen üretir (Bitkilerde bulunur).\n• Çekirdek: Hücrenin yönetim ve genetik merkezidir (DNA taşır).',
            examples: [
              'Enerji ihtiyacı yüksek olan kas ve karaciğer hücrelerinde mitokondri sayısı çok fazladır.',
              'Olgun alyuvar hücrelerinde çekirdek ve mitokondri bulunmaz.',
            ],
            examTip: 'Hücre zarı seçici geçirgendir; hücre çeperi (bitkilerde selüloz) ise tam geçirgendir.',
          ),
          // 1. SORU: Hücre Şemalı Soru (Resimli)
          Question(
            id: 'q_bio_2_1',
            type: QuestionType.multipleChoice,
            diagramType: 'cell_organelles',
            prompt: 'Yukarıdaki hücre şemasında "X" harfi ile gösterilen ve hücrenin oksijenli solunumla ATP (enerji) üretimini sağlayan organel aşağıdakilerden hangisidir?',
            options: [
              'Mitokondri',
              'Ribozom',
              'Golgi Aygıtı',
              'Lizozom',
            ],
            correctIndex: 0,
            explanation: 'Şemada "X" ile gösterilen çift zarlı organel mitokondridir ve hücrenin enerji (ATP) santralidir.',
          ),

          // 2. KAVRAM KARTI: Mitokondri Yapısı
          Question(
            id: 'concept_bio_2_2',
            type: QuestionType.conceptCard,
            conceptTitle: 'Mitokondri: Krista & Matriks',
            iconEmoji: '⚡',
            rule: '• Çift zarlıdır. Dış zar düz, iç zar ise yüzeyi genişletmek için kıvrımlıdır (KRİSTA).\n• Krista üzerinde Elektron Taşıma Sistemi (ETS) enzimleri bulunur.\n• Sıvı kısmına MATRİKS denir. Kendi DNA, RNA ve ribozomuna sahiptir; çekirdek kontrolünde kendini eşleyebilir.',
            examples: [
              'Reaksiyon: Besin (Glikoz) + O₂ ➔ CO₂ + H₂O + ATP Enerji',
            ],
            examTip: 'Mitokondri ve kloroplast kendi DNA\'sına sahip olduğu için hücre bölünmesini beklemeden çoğalabilirler.',
          ),
          // 2. SORU: Mitokondri Şemalı Soru (Resimli)
          Question(
            id: 'q_bio_2_2',
            type: QuestionType.multipleChoice,
            diagramType: 'mitochondria',
            prompt: 'Yukarıdaki mitokondri yapısı ve denklem incelendiğinde hangisi YANLIŞTIR?',
            options: [
              'Mitokondrinin iç zarı krista adı verilen kıvrımlardan oluşur.',
              'Matriks adı verilen sıvı kısımda solunum enzimleri yer alır.',
              'Oksijenli solunum sonucunda ortamdaki oksijen miktarı artar.',
              'Glikoz ve oksijen harcanarak hücreye gerekli ATP enerjisi üretilir.',
            ],
            correctIndex: 2,
            explanation: 'Oksijenli solunumda oksijen tüketilir (harcanır), dolayısıyla ortamdaki oksijen miktarı artmaz, azalır.',
          ),

          // 3. KAVRAM KARTI: Zarsız, Tek Zarlı ve Çift Zarlı Organeller
          Question(
            id: 'concept_bio_2_3',
            type: QuestionType.conceptCard,
            conceptTitle: 'Organellerin Zarlı Yapı Sınıflandırması',
            iconEmoji: '📦',
            rule: '• Zarsız Organeller: Ribozom, Sentrozom\n• Tek Zarlı Organeller: Endoplazmik Retikulum, Golgi, Lizozom, Koful, Peroksizom\n• Çift Zarlı Organeller: Mitokondri, Kloroplast, Kromoplast, Lökoplast',
            examples: [
              'Ribozom prokaryot ve ökaryot tüm hücrelerde ortaktır.',
            ],
            examTip: 'ÖSYM prokaryot hücre sorarsa hemen aklına gelsin: Zarlı organel ve çekirdek YOKTUR, sadece ribozom vardır!',
          ),
          // 3. SORU: Boşluk Doldurma
          Question(
            id: 'q_bio_2_3',
            type: QuestionType.fillInTheBlank,
            prompt: 'Hem prokaryot hem de ökaryot tüm canlı hücrelerde ortak olarak bulunan zarsız organel _____ dur.',
            blankOptions: ['ribozom', 'mitokondri', 'sentrozom', 'kloroplast'],
            correctBlankAnswer: 'ribozom',
            explanation: 'Ribozom tüm canlılarda protein sentezini gerçekleştiren evrensel zarsız organeldir.',
          ),
          // 4. SORU: Doğru / Yanlış
          Question(
            id: 'q_bio_2_4',
            type: QuestionType.trueFalse,
            prompt: 'Lizozom organeli hücre içi sindirim enzimlerini taşır ve yaşlanmış yıpranmış organelleri parçalar (otofaji).',
            isTrue: true,
            explanation: 'Doğru! Lizozom asidik enzimleriyle hücre içi sindirim ve savunmada görev alır.',
          ),
          // 5. SORU: Eşleştirme
          Question(
            id: 'q_bio_2_5',
            type: QuestionType.matching,
            prompt: 'Organelleri hücredeki temel işlevleriyle eşleştirin:',
            explanation: 'Hücre organelleri ve biyolojik görevleri:',
            matchingPairs: [
              MatchingPair(left: 'Ribozom', right: 'Protein Sentezi'),
              MatchingPair(left: 'Golgi Aygıtı', right: 'Salgı ve Paketleme'),
              MatchingPair(left: 'Mitokondri', right: 'ATP Enerji Üretimi'),
              MatchingPair(left: 'Kloroplast', right: 'Fotosentezle Besin Üretimi'),
            ],
          ),
        ],
      ),

      Lesson(
        id: 'lesson_bio_3',
        title: 'Ekoloji ve Besin Piramidi',
        description: 'Trofik basamaklar, %10 enerji aktarımı ve biyolojik birikim',
        xpReward: 50,
        gemReward: 20,
        questions: [
          // 1. KAVRAM KARTI: Besin Piramidinde Değişenler
          Question(
            id: 'concept_bio_3_1',
            type: QuestionType.conceptCard,
            conceptTitle: 'Besin Piramidinin Altın Kuralları',
            iconEmoji: '🔺',
            rule: 'Besin piramidinde üreticilerden (taban) en üst tüketicilere (zirve) doğru çıkıldıkça:\n• Aktarılan enerji AZALIR (%10 Kuralı: Enerjinin sadece yaklaşık %10\'u üst basamağa geçer).\n• Biyokütle (Toplam canlı ağırlığı) AZALIR.\n• Biyolojik birikim (DDT, zehir, ağır metal) ARTAR!\n• Genellikle birey sayısı AZALIR, canlı vücut büyüklüğü ARTAR.',
            examples: [
              '10.000 J (Bitki) -> 1.000 J (Otçul) -> 100 J (Etçil) -> 10 J (Kartal/Aslan)',
            ],
            examTip: 'EN KRİTİK KURAL: Biyolojik birikim (zehir) sadece YUKARI ÇIKILDIKÇA ARTAR! Diğer parametrelerin çoğu (enerji, biyokütle, birey sayısı) azalır.',
          ),
          // 1. SORU: Besin Piramidi Diagramlı Soru (Resimli)
          Question(
            id: 'q_bio_3_1',
            type: QuestionType.multipleChoice,
            diagramType: 'food_pyramid',
            prompt: 'Yukarıda verilen ekolojik besin piramidi incelendiğinde, üreticilerden son tüketicilere (tabandan tepeye) doğru gidildikçe aşağıdakilerden hangisi GERÇEKLEŞMEZ?',
            options: [
              'Aktarılan kullanılabilir enerji miktarı azalır.',
              'Dokularda biriken zehirli madde miktarı (biyolojik birikim) artar.',
              'Basamaklar arasındaki enerji %100 kayıpsız aktarılır.',
              'Toplam biyokütle belirgin şekilde azalır.',
            ],
            correctIndex: 2,
            explanation: 'Termodinamik yasaları ve %10 kuralı gereğince enerjinin yaklaşık %90\'ı ısı ve metabolizma ile kaybolur; kayıpsız (%100) aktarım imkânsızdır.',
          ),

          // 2. KAVRAM KARTI: Ayrıştırıcılar (Saprofitler)
          Question(
            id: 'concept_bio_3_2',
            type: QuestionType.conceptCard,
            conceptTitle: 'Ayrıştırıcıların (Saprofit) Özel Konumu',
            iconEmoji: '🍄',
            rule: 'Ayrıştırıcılar (bakteri ve mantarlar), besin piramidinin belirli tek bir basamağında değil, HER BASAMAĞINDA yer alır!\n• Organik atıkları parçalayarak inorganik maddelere dönüştürürler.',
            examples: [
              'Ayrıştırıcılar olmasaydı yeryüzü organik atıklarla kaplanır ve madde döngüleri dururdu.',
            ],
            examTip: 'Besin zinciri şemasında tüm basamaklardan tek bir canlı grubuna ok gidiyorsa o canlı grubu KESİNLİKLE AYRIŞTIRICIDIR (Saprofit).',
          ),
          // 2. SORU: Ayrıştırıcılar (ABCD)
          Question(
            id: 'q_bio_3_2',
            type: QuestionType.multipleChoice,
            prompt: 'Bir ekosistemde ayrıştırıcı (saprofit) organizmaların sayısının kritik şekilde azalması durumunda aşağıdakilerden hangisinin gerçekleşmesi BEKLENİR?',
            options: [
              'Topraktaki inorganik mineral miktarının azalması ve organik atıkların birikmesi',
              'Üretici bitki sayısının hızla artması',
              'Besin piramidinde aktarılan enerjinin %100\'e çıkması',
              'Ekosistemde otçul hayvanların sayısının iki katına çıkması',
            ],
            correctIndex: 0,
            explanation: 'Saprofitler organik atıkları inorganik minerallere çevirir. Onlar azalırsa ölü atıklar birikir ve toprağın mineral döngüsü durma noktasına gelir.',
          ),

          // 3. KAVRAM KARTI: Biyolojik Terimler
          Question(
            id: 'concept_bio_3_3',
            type: QuestionType.conceptCard,
            conceptTitle: 'Popülasyon, Komünite & Ekosistem',
            iconEmoji: '🌍',
            rule: '• Popülasyon: Belirli bir alanda yaşayan AYNI TÜRE ait canlılar topluluğu (Örn: Karadeniz\'deki hamsiler).\n• Komünite: Belirli bir alandaki TÜM POPÜLASYONLAR (Örn: Karadeniz\'deki tüm balıklar ve deniz canlıları).\n• Ekosistem: Komünite + Cansız Çevre (Hava, su, toprak).',
            examples: [
              'Van Gölü\'ndeki inci kefalleri -> Popülasyondur.',
              'Belgrad Ormanı\'ndaki tüm canlılar -> Komünitedir.',
            ],
            examTip: 'Popülasyon TEK bir türdür; komünite BİRDEN FAZLA türün birlikteliğidir.',
          ),
          // 3. SORU: Boşluk Doldurma
          Question(
            id: 'q_bio_3_3',
            type: QuestionType.fillInTheBlank,
            prompt: 'Belirli bir alanda yaşayan aynı türe ait bireylerin oluşturduğu topluluğa _____ denir.',
            blankOptions: ['popülasyon', 'komünite', 'ekosistem', 'biyosfer'],
            correctBlankAnswer: 'popülasyon',
            explanation: 'Aynı türe ait canlıların oluşturduğu topluluğa popülasyon denir (Örn: Toros Dağları\'ndaki ala geyikler).',
          ),
          // 4. SORU: Doğru / Yanlış
          Question(
            id: 'q_bio_3_4',
            type: QuestionType.trueFalse,
            prompt: 'Ekolojik besin piramidinde tabandan tavana doğru çıkıldıkça dokularda biriken zehirli madde oranı (biyolojik birikim) azalır.',
            isTrue: false,
            explanation: 'Yanlış! Biyolojik birikim (ağır metaller, tarım ilaçları) üst basamaklara doğru katlanarak ARTAR.',
          ),
          // 5. SORU: Eşleştirme
          Question(
            id: 'q_bio_3_5',
            type: QuestionType.matching,
            prompt: 'Ekoloji kavramlarını doğru örnekleriyle eşleştirin:',
            explanation: 'Ekolojik organizasyon basamakları:',
            matchingPairs: [
              MatchingPair(left: 'Popülasyon', right: 'Marmara Denizi\'ndeki istavritler'),
              MatchingPair(left: 'Komünite', right: 'Marmara Denizi\'ndeki tüm canlı türleri'),
              MatchingPair(left: 'Ekosistem', right: 'Canlılar + Cansız Çevre (Su, Tuz, Işık)'),
              MatchingPair(left: 'Habitat', right: 'Canlının doğal yaşam ve üreme adresi'),
            ],
          ),
        ],
      ),

      // ==========================================
      // ÜNİTE 1 SONU KUPA SINAVI (BOSS LEVEL)
      // ==========================================
      Lesson(
        id: 'exam_unit_bio_1',
        title: 'Ünite 1 Kupa Sınavı 🏆',
        description: 'Tüm biyoloji ünitelerini kapsayan şekilli ve şıklı final sınavı!',
        xpReward: 100,
        gemReward: 30,
        isUnitExam: true,
        questions: [
          Question(
            id: 'exam_bio1_q1',
            type: QuestionType.multipleChoice,
            diagramType: 'dna_helix',
            prompt: 'Yukarıdaki DNA şeması incelendiğinde nükleotitler arasındaki hidrojen bağı ve baz eşleşmeleriyle ilgili hangisi DOĞRUDUR?',
            options: [
              'Adenin ile Timin arasında 3\'lü, Guanin ile Sitozin arasında 2\'li hidrojen bağı kurulur.',
              'Adenin karşısına Timin, Guanin karşısına Sitozin gelir (A=T, G≡C).',
              'DNA tek zincirli bir yapıya sahiptir.',
              'Pürin bazlarının sayısı pirimidin bazlarından daima farklıdır.',
            ],
            correctIndex: 1,
            explanation: 'Şemada da gösterildiği üzere Adenin-Timin ikili (A=T), Guanin-Sitozin ise üçlü (G≡C) hidrojen bağlarıyla eşleşir.',
          ),
          Question(
            id: 'exam_bio1_q2',
            type: QuestionType.multipleChoice,
            diagramType: 'mitochondria',
            prompt: 'Hücrede oksijenli solunum yaparak ATP enerjisi üreten ve kıvrımlı iç zarına "krista" adı verilen organel hangisidir?',
            options: [
              'Mitokondri',
              'Lizozom',
              'Kloroplast',
              'Koful',
            ],
            correctIndex: 0,
            explanation: 'Mitokondri çift zarlı olup kıvrımlı iç zarına krista denir ve hücresel solunum merkezidir.',
          ),
          Question(
            id: 'exam_bio1_q3',
            type: QuestionType.fillInTheBlank,
            prompt: 'Bileşik enzimlerin protein olan ana kısmına _____ denir.',
            blankOptions: ['apoenzim', 'koenzim', 'kofaktör', 'substrat'],
            correctBlankAnswer: 'apoenzim',
            explanation: 'Bileşik enzimin (holoenzim) protein kısmına apoenzim, yardımcı organik kısmına ise koenzim denir.',
          ),
          Question(
            id: 'exam_bio1_q4',
            type: QuestionType.multipleChoice,
            prompt: 'Aşağıdakilerden hangisi hücre zarının özelliklerinden biri DEĞİLDİR?',
            options: [
              'Seçici geçirgen (yarı geçirgen) olması',
              'Çift katlı fosfolipit tabakasından oluşması',
              'Tam geçirgen ve ölü bir yapıda olması',
              'Akıcı mozaik zar modeline uygun olması',
            ],
            correctIndex: 2,
            explanation: 'Hücre zarı canlı ve seçici geçirgendir; tam geçirgen ve ölü olan bitkilerdeki hücre çeperidir (duvarıdır).',
          ),
          Question(
            id: 'exam_bio1_q5',
            type: QuestionType.matching,
            prompt: 'Organelleri hücredeki temel işlevleriyle eşleştirin:',
            explanation: 'Biyoloji organel fonksiyonları:',
            matchingPairs: [
              MatchingPair(left: 'Ribozom', right: 'Protein sentezi'),
              MatchingPair(left: 'Mitokondri', right: 'Oksijenli solunum (ATP)'),
              MatchingPair(left: 'Kloroplast', right: 'Fotosentez'),
              MatchingPair(left: 'Lizozom', right: 'Hücre içi sindirim'),
            ],
          ),
          Question(
            id: 'exam_bio1_q6',
            type: QuestionType.trueFalse,
            prompt: 'Ribozom organeli tek katlı zarla çevrili bir organeldir.',
            isTrue: false,
            explanation: 'Yanlış! Ribozom zarsız bir organeldir ve tüm canlı hücrelerde bulunur.',
          ),
          Question(
            id: 'exam_bio1_q7',
            type: QuestionType.fillInTheBlank,
            prompt: 'Besin piramidinin en alt tabanında yer alarak güneş enerjisini kimyasal bağ enerjisine çeviren canlılar _____ dir.',
            blankOptions: ['üreticiler', 'otçullar', 'etçiller', 'ayrıştırıcılar'],
            correctBlankAnswer: 'üreticiler',
            explanation: 'Fotosentez yapan üretici bitkiler ve algler besin piramidinin temelini oluşturur.',
          ),
          Question(
            id: 'exam_bio1_q8',
            type: QuestionType.matching,
            prompt: 'Biyomolekülleri temel yapı birimleriyle eşleştirin:',
            explanation: 'Temel bileşenler ve yapı taşları:',
            matchingPairs: [
              MatchingPair(left: 'Protein', right: 'Aminoasit'),
              MatchingPair(left: 'DNA', right: 'Deoksiribonükleotit'),
              MatchingPair(left: 'Trigliserit (Yağ)', right: '3 Yağ Asidi + 1 Gliserol'),
              MatchingPair(left: 'Glikojen', right: 'Glikoz'),
            ],
          ),
        ],
      ),
    ],
  ),

  // ===========================================================================
  // ÜNİTE 2: TYT BİYOLOJİ - CANLILAR DÜNYASI & KALITIM
  // ===========================================================================
  LearningUnit(
    id: 'unit_biyoloji_2',
    unitNumber: 2,
    title: 'Canlılar Dünyası, Sınıflandırma & Kalıtım',
    subject: 'TYT Biyoloji',
    colorHex: 0xFF10B981,
    lessons: [
      Lesson(
        id: 'lesson_bio_siniflandirma',
        title: 'Canlıların Sınıflandırılması & Bakteriler/Arkeler',
        description: 'Sınıflandırma basamakları, ikili adlandırma ve prokaryot alemleri',
        xpReward: 40,
        gemReward: 15,
        questions: [
          Question(
            id: 'q_bio_sin_1',
            type: QuestionType.multipleChoice,
            prompt: 'Doğal (filogenetik) sınıflandırmada aşağıdakilerden hangisi temel "alınmaz"?',
            options: [
              'Analog organlar (Görevdeş)',
              'Homolog organlar (Köken benzerliği)',
              'DNA ve protein benzerliği',
              'Embriyonik gelişim benzerliği',
            ],
            correctIndex: 0,
            explanation: 'Analog organlar yapay (ampirik) sınıflandırmada kullanılmıştır; modern filogenetik sınıflandırmada temel alınmaz!',
          ),
          Question(
            id: 'q_bio_sin_2',
            type: QuestionType.fillInTheBlank,
            prompt: 'Ortak bir atadan gelen ve çiftleştiklerinde verimli (kısır olmayan) döller veren canlılar topluluğuna _____ denir.',
            blankOptions: ['tür', 'cins', 'familya', 'popülasyon'],
            correctBlankAnswer: 'tür',
            explanation: 'Biyolojik tür tanımının en kritik şartı verimli (kısır olmayan) döller verebilmektir.',
          ),
          Question(
            id: 'q_bio_sin_3',
            type: QuestionType.trueFalse,
            prompt: 'Bakterilerde bulunan plazmit DNA, antibiyotik direnci gibi avantaj sağlayan genleri taşır.',
            isTrue: true,
            explanation: 'Doğru! Plazmitler konjugasyonla diğer bakterilere aktarılabilen küçük halkasal DNA parçalarıdır.',
          ),
          Question(
            id: 'card_bio_sin_taktik',
            type: QuestionType.conceptCard,
            conceptTitle: 'Sınıflandırma Basamakları Şifresi',
            iconEmoji: '💡',
            rule: 'Türkiye Cumhuriyeti Futbol Takımı Sahada Şut Attı\nTür -> Cins -> Familya -> Takım -> Sınıf -> Şube -> Alem\n\nTürden Aleme doğru gidildikçe:\n• Birey sayısı ve çeşitlilik ARTAR.\n• Ortak gen ve protein benzerliği AZALIR.',
            examples: [
              'Aynı cins içindeki iki canlı (örn: Pinus nigra ve Pinus brutia) kesinlikle aynı familya, takım, sınıf, şube ve alemde yer alır!',
              'İkili adlandırmada (Felis leo): İlk kelime cinsi, ikinci kelime tanımlayıcı sıfatı belirtir.',
            ],
            examTip: 'ÖSYM akrabalık sorarken ilk kelimeye (Cinse) bakmanı ister! İkinci kelimelerin aynı olması akrabalık göstermez!',
          ),
          Question(
            id: 'q_bio_sin_4',
            type: QuestionType.multipleChoice,
            prompt: 'Canis lupus ve Canis familiaris canlıları için hangisi kesinlikle "aynıdır"?',
            options: ['Cinsleri', 'Türleri', 'Kromozom sayıları', 'Habitatları'],
            correctIndex: 0,
            explanation: 'İkili adlandırmada ilk kelime Cins adıdır. İkisi de "Canis" cinsine aittir.',
          ),
          Question(
            id: 'q_bio_sin_5',
            type: QuestionType.matching,
            prompt: 'Sınıflandırma basamaklarını doğru açıklamalarıyla eşleştirin:',
            explanation: 'Basamaklar: Tür en küçük birimdir, Alem en kapsamlı birimdir.',
            matchingPairs: [
              MatchingPair(left: 'Tür', right: 'En küçük birim'),
              MatchingPair(left: 'Cins', right: 'Türden sonraki basamak'),
              MatchingPair(left: 'Familya', right: 'Aile basamağı'),
              MatchingPair(left: 'Alem', right: 'En kapsamlı birim'),
            ],
          ),
          Question(
            id: 'q_bio_sin_6',
            type: QuestionType.fillInTheBlank,
            prompt: 'Aşırı sıcak, tuzlu veya asidik ekstrem koşullarda yaşayabilen prokaryot canlılar _____ aleminde incelenir.',
            blankOptions: ['arkeler', 'bakteriler', 'protistler', 'mantarlar'],
            correctBlankAnswer: 'arkeler',
            explanation: 'Metanojenler, termofiller ve halofiller gibi ekstrem canlılar Arkea alemini oluşturur.',
          ),
          Question(
            id: 'q_bio_sin_7',
            type: QuestionType.multipleChoice,
            prompt: 'Bakterilerde endospor oluşumu hakkında hangisi doğrudur?',
            options: [
              'Olumsuz çevre koşullarına karşı bir hayatta kalma adaptasyonudur',
              'Bir üreme çeşididir ve birey sayısını artırır',
              'Aktif hareket etmeyi sağlar',
              'Sadece oksijenli solunum yapanlarda görülür',
            ],
            correctIndex: 0,
            explanation: 'Endospor bir üreme şekli DEĞİLDİR; olumsuz çevre koşullarında metabolizmayı minimuma indirip hayatta kalma biçimidir.',
          ),
        ],
      ),

      Lesson(
        id: 'lesson_bio_bitki_hayvan',
        title: 'Bitkiler ve Hayvanlar Alemi',
        description: 'Tohumlu/tohumsuz bitkiler, omurgalı ve omurgasız hayvanlar',
        xpReward: 40,
        gemReward: 15,
        questions: [
          Question(
            id: 'q_bio_bit_1',
            type: QuestionType.multipleChoice,
            prompt: 'Aşağıdaki özelliklerden hangisi "sadece Memeliler" sınıfına özgüdür?',
            options: [
              'Alveollü akciğerlere sahip olmak',
              'Dört odacıklı kalbe sahip olmak',
              'Sabit vücut sıcaklığına (sıcakkanlı) sahip olmak',
              'İç döllenme yapmak',
            ],
            correctIndex: 0,
            explanation: 'Alveollü akciğer, çizgili kaslı diyafram ve süt bezleri sadece memelilere özgüdür! Kuşlarda da 4 odacıklı kalp ve sıcakkanlılık vardır.',
          ),
          Question(
            id: 'q_bio_bit_2',
            type: QuestionType.fillInTheBlank,
            prompt: 'Bitkilerde fotosentez sonucu üretilen glikozun fazlası lökoplastlarda _____ olarak depolanır.',
            blankOptions: ['nişasta', 'glikojen', 'selüloz', 'kitin'],
            correctBlankAnswer: 'nişasta',
            explanation: 'Bitkisel depo polisakkariti nişastadır (hayvanlarda ve bakterilerde glikojendir).',
          ),
          Question(
            id: 'q_bio_bit_3',
            type: QuestionType.trueFalse,
            prompt: 'Kuşların akciğerlerine bağlı hava keseleri kemiklerin içine kadar uzanarak uçmayı kolaylaştırır.',
            isTrue: true,
            explanation: 'Doğru! Kuşlarda hava keseleri hafiflik sağlar ve çift yönlü solunuma imkan tanır.',
          ),
          Question(
            id: 'card_bio_bit_taktik',
            type: QuestionType.conceptCard,
            conceptTitle: 'Sadece Memelilere Özgü 4 Kutsal Kural',
            iconEmoji: '💡',
            rule: 'ÖSYM\'nin her 2 yılda bir sorduğu memeli özellikleri:\n1. Akciğerlerinde ALVEOL bulunması\n2. Göğüs ve karın boşluğunu ayıran ÇİZGİLİ KASLI DİYAFRAM\n3. Yavrusunu SÜTLE besleme ve süt bezleri\n4. Olgun alyuvarlarının ÇEKİRDEKSİZ olması',
            examples: [
              'Yunus ve Balina balık değil, doğuran ve süt veren birer MEMELİDİR!',
              'Yarasa kuş değil, uçabilen bir MEMELİDİR!',
            ],
            examTip: 'Soru kökünde "Sadece memelilerde görülür" deniyorsa şıklarda alveol, kaslı diyafram veya süt bezini ara!',
          ),
          Question(
            id: 'q_bio_bit_4',
            type: QuestionType.multipleChoice,
            prompt: 'Yunus ve balina ile ilgili aşağıdaki ifadelerden hangisi doğrudur?',
            options: [
              'Akciğer solunumu yapan memeli canlılardır',
              'Solungaç solunumu yapan balıklardır',
              'Dış döllenme ile çoğalırlar',
              'Soğukkanlı (değişken ısılı) canlılardır',
            ],
            correctIndex: 0,
            explanation: 'Yunus ve balina memelidir; akciğer solunumu yapar, doğurur ve yavrularını sütle besler.',
          ),
          Question(
            id: 'q_bio_bit_5',
            type: QuestionType.matching,
            prompt: 'Omurgalı sınıflarını tipik özellikleriyle eşleştirin:',
            explanation: 'Omurgalılar alemi:',
            matchingPairs: [
              MatchingPair(left: 'Balıklar', right: 'İki odacıklı kalp & solungaç'),
              MatchingPair(left: 'İki Yaşamlılar (Kurbağa)', right: 'Metamorfoz (Başkalaşım)'),
              MatchingPair(left: 'Sürüngenler', right: 'Keratin pul ve kuru deri'),
              MatchingPair(left: 'Kuşlar', right: 'Vücudu tüylerle kaplı olma'),
            ],
          ),
          Question(
            id: 'q_bio_bit_6',
            type: QuestionType.fillInTheBlank,
            prompt: 'Böceklerin dış iskeletinde bulunan azotlu yapısal polisakkarit _____ dir.',
            blankOptions: ['kitin', 'selüloz', 'keratin', 'peptit'],
            correctBlankAnswer: 'kitin',
            explanation: 'Eklem bacaklıların dış iskeleti ve mantarların hücre çeperi kitinden oluşur.',
          ),
          Question(
            id: 'q_bio_bit_7',
            type: QuestionType.multipleChoice,
            prompt: 'Açık tohumlu bitkiler (Çam, Ladin, Göknar) için hangisi doğrudur?',
            options: [
              'Her dem yeşil, kozalaklı ve iğne yapraklıdırlar',
              'Meyve ve gerçek çiçek oluştururlar',
              'Otsu gövdeye sahiptirler',
              'İletim demetleri bulunmaz',
            ],
            correctIndex: 0,
            explanation: 'Açık tohumlular daima odunsu, çoğunlukla iğne yapraklı ve kozalaklı bitkilerdir; meyve oluşturmazlar.',
          ),
        ],
      ),

      Lesson(
        id: 'lesson_bio_kalitim',
        title: 'Mendel Genetiği & Kalıtım',
        description: 'Genotip, fenotip, monohibrit çaprazlama ve kan grupları',
        xpReward: 40,
        gemReward: 15,
        questions: [
          Question(
            id: 'q_bio_kal_1',
            type: QuestionType.multipleChoice,
            prompt: 'Heterozigot kahverengi gözlü (Aa) iki bireyin evliliğinden mavi gözlü (aa) çocuk doğma olasılığı kaçtır?',
            options: ['%25 (1/4)', '%50 (1/2)', '%75 (3/4)', '%0'],
            correctIndex: 0,
            explanation: 'Aa × Aa çaprazlamasında: AA, Aa, Aa, aa oluşur. aa oranı 1/4 yani %25\'tir.',
          ),
          Question(
            id: 'q_bio_kal_2',
            type: QuestionType.fillInTheBlank,
            prompt: 'Bir canlının sahip olduğu genlerin tamamına genotip, genlerin dışa yansıyan görüntüsüne _____ denir.',
            blankOptions: ['fenotip', 'karyotip', 'genom', 'alel'],
            correctBlankAnswer: 'fenotip',
            explanation: 'Genotip canlının genetik şifresi, fenotip ise gözlemlenebilir dış özellikleridir.',
          ),
          Question(
            id: 'q_bio_kal_3',
            type: QuestionType.trueFalse,
            prompt: 'A ve B kan grubu alelleri birbirine eş baskındır (AB kan grubu).',
            isTrue: true,
            explanation: 'Doğru! A ve B genleri birbirine baskınlık kuramaz ve eş baskın (kodominant) olarak AB kan grubunu oluşturur.',
          ),
          Question(
            id: 'card_bio_kal_taktik',
            type: QuestionType.conceptCard,
            conceptTitle: 'Kan Grupları ve Rh Faktörü Şifresi',
            iconEmoji: '💡',
            rule: 'A ve B baskın, 0 çekiniktir.\nRh(+) baskın, Rh(-) çekiniktir.\n\nEğer bir çocuk 0 kan grubundaysa (00), anne ve babanın her ikisinde de MUTLAKA en az bir tane "0" geni vardır!',
            examples: [
              'A kan grubu: AA veya A0 olabilir.',
              'B kan grubu: BB veya B0 olabilir.',
              '0 kan grubu: Sadece 00 olabilir.',
              'AB kan grubu: Sadece AB olabilir (0 geni taşıyamaz!).',
            ],
            examTip: 'Soyağacında 0 kan gruplu bir çocuk gördüğün an anne ve babanın genotiplerine hemen birer "0" yapıştır!',
          ),
          Question(
            id: 'q_bio_kal_4',
            type: QuestionType.multipleChoice,
            prompt: 'Anne A0, baba B0 genotipinde olduğuna göre bu ailenin çocuklarında kaç farklı fenotip görülebilir?',
            options: ['4 (A, B, AB, 0)', '2 (AB, 0)', '3 (A, B, AB)', '1 (AB)'],
            correctIndex: 0,
            explanation: 'A0 × B0 çaprazlaması: AB, A0, B0, 00 oluşur. Yani 4 farklı fenotipin dördü de görülebilir!',
          ),
          Question(
            id: 'q_bio_kal_5',
            type: QuestionType.matching,
            prompt: 'Genetik kavramlarını tanımlarıyla eşleştirin:',
            explanation: 'Mendel genetiği temel kavramları:',
            matchingPairs: [
              MatchingPair(left: 'Homozigot', right: 'Aynı alellere sahip olma (AA veya aa)'),
              MatchingPair(left: 'Heterozigot', right: 'Farklı alellere sahip olma (Aa)'),
              MatchingPair(left: 'Dominant', right: 'Etkisini her durumda gösteren baskın gen'),
              MatchingPair(left: 'Resesif', right: 'Sadece homozigotken etkisini gösteren çekinik gen'),
            ],
          ),
          Question(
            id: 'q_bio_kal_6',
            type: QuestionType.fillInTheBlank,
            prompt: 'Kırmızı-yeşil renk körlüğü _____ kromozomu üzerinde çekinik bir genle kalıtılır.',
            blankOptions: ['X', 'Y', 'otozom', 'mitokondri'],
            correctBlankAnswer: 'X',
            explanation: 'Renk körlüğü ve hemofili X kromozomunun Y ile homolog olmayan bölgesinde çekinik aktarılır.',
          ),
          Question(
            id: 'q_bio_kal_7',
            type: QuestionType.multipleChoice,
            prompt: 'Renk körü bir kız çocuğunun (XʳXʳ) babasıyla ilgili hangisi kesinlikle doğrudur?',
            options: [
              'Babası da kesinlikle renk körüdür (XʳY)',
              'Babası sağlıklı taşıyıcıdır',
              'Babasının genotipi belirlenemez',
              'Hastalık genini sadece annesinden almıştır',
            ],
            correctIndex: 0,
            explanation: 'Kız çocuğu X kromozomunun birini babasından almak zorundadır. Babada tek X olduğu için babası mutlaka renk körüdür (XʳY).',
          ),
        ],
      ),

      Lesson(
        id: 'exam_unit_bio_2',
        title: 'Ünite 2 Kupa Sınavı 🏆',
        description: 'Sınıflandırma, canlılar alemi ve kalıtım final testi',
        xpReward: 60,
        gemReward: 25,
        isUnitExam: true,
        questions: [
          Question(
            id: 'exam_bio2_q1',
            type: QuestionType.multipleChoice,
            prompt: 'Aşağıdaki canlılardan hangisinde zarlı organel ve çekirdek bulunmaz (Prokaryottur)?',
            options: ['Bakteri', 'Amip', 'Öglena', 'Mantar'],
            correctIndex: 0,
            explanation: 'Bakteriler ve arkeler prokaryottur; amip, öglena ve mantarlar ise ökaryottur.',
          ),
          Question(
            id: 'exam_bio2_q2',
            type: QuestionType.fillInTheBlank,
            prompt: 'Türden aleme doğru gidildikçe canlılar arasındaki benzerlik _____ .',
            blankOptions: ['azalır', 'artar', 'değişmez', 'sıfırlanır'],
            correctBlankAnswer: 'azalır',
            explanation: 'Alem en genel gruptur, bu yüzden canlılar arası ortak gen ve protein benzerliği azalır.',
          ),
          Question(
            id: 'exam_bio2_q3',
            type: QuestionType.trueFalse,
            prompt: 'Olgun alyuvarlarında çekirdek bulunmayan bir omurgalı kesinlikle memelidir.',
            isTrue: true,
            explanation: 'Doğru! Sadece memelilerin olgun alyuvarları daha fazla oksijen taşımak için çekirdek ve organellerini kaybeder.',
          ),
          Question(
            id: 'exam_bio2_q4',
            type: QuestionType.multipleChoice,
            prompt: 'Kuşlar ve memelilerin ortak özelliği aşağıdakilerden hangisidir?',
            options: [
              'Vücut sıcaklığının çevreye bağlı olmaması (Sıcakkanlılık)',
              'Akciğerlerinde alveol bulunması',
              'Vücutlarının kıllarla kaplı olması',
              'Yavrularını sütle beslemeleri',
            ],
            correctIndex: 0,
            explanation: 'Hem kuşlar hem memeliler 4 odacıklı kalbe ve sabit vücut ısısına (endotermi / sıcakkanlılık) sahiptir.',
          ),
          Question(
            id: 'exam_bio2_q5',
            type: QuestionType.fillInTheBlank,
            prompt: '0 grubu bir anne ile AB grubu bir babanın çocukları kesinlikle _____ kan grubuna sahip olamaz.',
            blankOptions: ['0 veya AB', 'A veya B', 'sadece A', 'sadece B'],
            correctBlankAnswer: '0 veya AB',
            explanation: 'Anne (00) ve Baba (AB) evliliğinden sadece A0 ve B0 doğabilir; çocuk asla 00 veya AB olamaz!',
          ),
          Question(
            id: 'exam_bio2_q6',
            type: QuestionType.multipleChoice,
            prompt: 'Aşağıdakilerden hangisi bir bitki hücresinde kesinlikle "bulunmaz"?',
            options: ['Sentrozom', 'Kloroplast', 'Hücre çeperi', 'Mitokondri'],
            correctIndex: 0,
            explanation: 'Gelişmiş bitki hücrelerinde iğ iplikleri sitoplazmik mikrotübüllerle organize edilir, sentrozom bulunmaz.',
          ),
          Question(
            id: 'exam_bio2_q7',
            type: QuestionType.matching,
            prompt: 'Canlıları hücre duvarı bileşenleriyle eşleştirin:',
            explanation: 'Hücre duvarı yapıları:',
            matchingPairs: [
              MatchingPair(left: 'Bitkiler', right: 'Selüloz'),
              MatchingPair(left: 'Mantarlar', right: 'Kitin'),
              MatchingPair(left: 'Bakteriler', right: 'Peptidoglikan'),
              MatchingPair(left: 'Hayvanlar', right: 'Hücre duvarı yoktur'),
            ],
          ),
          Question(
            id: 'exam_bio2_q8',
            type: QuestionType.multipleChoice,
            prompt: 'Hemofili taşıyıcısı bir anne (XᴴXʰ) ile sağlıklı bir babanın (XᴴY) erkek çocuklarının hemofili olma olasılığı kaçtır?',
            options: ['%50 (1/2)', '%25 (1/4)', '%100', '%0'],
            correctIndex: 0,
            explanation: 'Erkek çocuklar anneden X alır. Erkek çocuklara bakıldığında: XᴴY (sağlıklı) ve XʰY (hemofili) olur. Erkekler içindeki oran %50\'dir.',
          ),
        ],
      ),
    ],
  ),
];
