import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/lesson_models.dart';
import '../providers/game_provider.dart';
import '../services/sound_service.dart';
import '../widgets/duo_button.dart';
import '../widgets/parrot_mascot_widget.dart';

final List<Flashcard> defaultFlashcards = [
  // ==========================================
  // TYT BİYOLOJİ KARTLARI (10 Kart)
  // ==========================================
  const Flashcard(
    id: 'fc_bio_1',
    subject: 'TYT Biyoloji',
    category: 'Organeller & Hücre',
    term: 'Mitokondri',
    meaning: 'Çift katlı zarlı organeldir. Oksijenli solunumla hücrenin ATP (enerji) santralidir. Kıvrımlı iç zarına "krista", sıvı kısmına "matriks" denir.',
    example: 'Enerji ihtiyacı yüksek olan kas, karaciğer ve sinir hücrelerinde sayısı çok fazladır.',
    examTip: 'Kendi DNA, RNA ve ribozomu vardır; çekirdek kontrolünde hücre bölünmesini beklemeden çoğalabilir!',
  ),
  const Flashcard(
    id: 'fc_bio_2',
    subject: 'TYT Biyoloji',
    category: 'Enzimler',
    term: 'Anahtar-Kilit Modeli',
    meaning: 'Enzim ile substrat arasındaki kusursuz biçimsel uyumu ifade eder. Enzim substratına aktif bölgesinden bağlanır ve reaksiyondan değişmeden çıkar.',
    example: 'Substrat parçalanıp ürüne dönüşürken, enzim miktarı ve yapısı reaksiyon sonunda sabit kalır.',
    examTip: 'Enzimler substrata dış yüzeyinden etki eder; substrat yüzeyi genişledikçe (kıyılmış et) tepkime hızı artar!',
  ),
  const Flashcard(
    id: 'fc_bio_3',
    subject: 'TYT Biyoloji',
    category: 'Sınıflandırma',
    term: 'Analog Organ vs Homolog Organ',
    meaning: 'Analog: Kökenleri farklı, görevleri aynı organlar (Kuş kanadı - Sinek kanadı). Homolog: Kökenleri aynı, görevleri farklı veya aynı olabilen organlar (İnsan kolu - Balina yüzgeci).',
    example: 'Doğal (Filogenetik) sınıflandırmada sadece HOMOLOG organlar ve DNA benzerliği temel alınır.',
    examTip: 'ÖSYM TUZAĞI: Analog organlar yapay (ampirik) sınıflandırmada kullanılmıştır; modern biyolojide akrabalık göstermez!',
  ),
  const Flashcard(
    id: 'fc_bio_4',
    subject: 'TYT Biyoloji',
    category: 'Canlılar Alemi',
    term: 'Memelilere Özgü 4 Altın Özellik',
    meaning: 'Yalnızca memeliler sınıfında görülen ve başka hiçbir omurgalıda bulunmayan özelliklerdir.',
    example: '1. Akciğerlerinde alveol bulunması\n2. Kaslı diyaframa sahip olması\n3. Olgun alyuvarlarının çekirdeksiz olması\n4. Yavrularını süt bezleriyle beslemesi ve vücudun kıllarla kaplı olması.',
    examTip: 'ÖSYM omurgalı sorusu sorarsa olgun alyuvarda çekirdeksizlik veya alveol gördüğün an tereddütsüz MEMELİ de!',
  ),
  const Flashcard(
    id: 'fc_bio_5',
    subject: 'TYT Biyoloji',
    category: 'Kalıtım',
    term: 'X\'e Bağlı Çekinik Kalıtım',
    meaning: 'Renk körlüğü ve Hemofili gibi hastalıklar X kromozomunun Y ile homolog olmayan bölgesinde çekinik (r) taşınır.',
    example: 'Erkek çocuk tek X kromozomunu kesinlikle ANNESİNDEN alır. Anne renk körüyse (XʳXʳ), tüm erkek çocukları kesinlikle hastadır!',
    examTip: 'Hasta bir kız çocuğunun (XʳXʳ) babası (XʳY) KESİNLİKLE hastadır!',
  ),
  const Flashcard(
    id: 'fc_bio_6',
    subject: 'TYT Biyoloji',
    category: 'Hücre Zarı',
    term: 'Akıcı Mozaik Zar Modeli',
    meaning: 'Hücre zarı çift katlı fosfolipit tabakasından ve içine gömülü proteinlerden oluşur. Proteinlere bağlı glikoprotein ve glikolipitler hücreye kimlik ve seçici geçirgenlik kazandırır.',
    example: 'Hücrelerin birbirini tanıması ve hormonların hedef hücreye bağlanması glikoprotein reseptörleriyle sağlanır.',
    examTip: 'Küçük moleküller büyüklere göre, nötr moleküller iyonlara göre, yağda çözünenler (A, D, E, K) suda çözünenlere göre zardan DAHA HIZLI geçer!',
  ),
  const Flashcard(
    id: 'fc_bio_7',
    subject: 'TYT Biyoloji',
    category: 'Metabolizma',
    term: 'Fotosentez vs Kemosentez',
    meaning: 'Fotosentezde ışık enerjisi ve klorofil kullanılır (Bitki, alg, siyanobakteri). Kemosentezde inorganik maddelerin oksitlenmesiyle açığa çıkan kimyasal enerji kullanılır; ışık ve klorofil gerekmez (Sadece bazı prokaryotlar!).',
    example: 'Kemosentez gece-gündüz kesintisiz gerçekleşebilir; fotosentez ise sadece ışık varlığında gerçekleşir.',
    examTip: 'Kemosentezi SADECE VE SADECE bazı BAKTERİ ve ARKE türleri yapabilir! Hiçbir ökaryot canlı kemosentez yapamaz.',
  ),
  const Flashcard(
    id: 'fc_bio_8',
    subject: 'TYT Biyoloji',
    category: 'Hücre Bölünmesi',
    term: 'Krossing-Over (Parça Değişimi)',
    meaning: 'Mayoz-1 Profaz-1 evresinde homolog kromozomların kardeş olmayan kromatitleri arasındaki gen alışverişidir.',
    example: 'Yeni genetik kombinasyonlar (varyasyon) oluşturarak tür içi çeşitliliği artırır.',
    examTip: 'Krossing-over genlerin yapısını veya nükleotit dizilimini DEĞİŞTİRMEZ; sadece kromozom üzerindeki gen kombinasyonunu değiştirir!',
  ),
  const Flashcard(
    id: 'fc_bio_9',
    subject: 'TYT Biyoloji',
    category: 'Madde Geçişleri',
    term: 'Plazmoliz vs Deplazmoliz vs Turgor',
    meaning: 'Plazmoliz: Hücrenin hipertonik (çok yoğun) ortama konulup su kaybederek büzülmesidir. Deplazmoliz: Büzülmüş hücrenin saf suya konulup su alarak eski haline dönmesidir. Turgor: Hücrenin su alıp şişerek zarına yaptığı basınçtır.',
    example: 'Tuzlanan etin veya reçel yapılan meyvenin su kaybedip büzülmesi plazmolizdir (bakteriler yaşayamaz).',
    examTip: 'Bitki hücreleri aşırı su aldığında çeper sayesinde patlamaz (turgor olur); hayvan hücreleri ise çeperi olmadığı için patlar (Hemoliz)!',
  ),
  const Flashcard(
    id: 'fc_bio_10',
    subject: 'TYT Biyoloji',
    category: 'Ekosistem',
    term: 'Biyolojik Birikim',
    meaning: 'DDT, cıva, kurşun gibi zehirli maddelerin besin zincirinde üreticiden son tüketiciye doğru gidildikçe dokularda artarak birikmesidir.',
    example: 'Besin piramidinin en üstündeki yırtıcı kuş ve insanda zehirli madde yoğunluğu en yüksek seviyededir.',
    examTip: 'Piramitte yukarı çıkıldıkça: Biyokütle azalır, aktarılan enerji azalır, birey sayısı azalır, BİYOLOJİK BİRİKİM ARTAR!',
  ),

  // ==========================================
  // TYT TÜRKÇE KARTLARI (10 Kart)
  // ==========================================
  const Flashcard(
    id: 'fc_tr_1',
    subject: 'TYT Türkçe',
    category: 'Sözcükte Anlam',
    term: 'Mecaz Anlam',
    meaning: 'Bir sözcüğün gerçek (ilk) anlamından tamamen uzaklaşarak kazandığı yeni, soyut ve mecazi anlama denir.',
    example: '"Bu soğuk tavırlarıyla herkesin kalbini kırdı." (İncitmek/üzmek anlamında mecaz)',
    examTip: 'Mecaz anlamda genellikle somut bir eylem soyutlaştırılarak duygu dünyasına aktarılır.',
  ),
  const Flashcard(
    id: 'fc_tr_2',
    subject: 'TYT Türkçe',
    category: 'Ses Bilgisi',
    term: 'Ünlü Daralması',
    meaning: 'Sonu "a" veya "e" geniş ünlüleriyle biten bir fiile "-yor" şimdiki zaman eki geldiğinde bu ünlüler daralarak "ı, i, u, ü"ye dönüşür.',
    example: 'başla-yor ➔ başlıyor, bekle-yor ➔ bekliyor, anla-yor ➔ anlıyor.',
    examTip: 'İstisnalar: "de-" ve "ye-" fiillerinde "y" kaynaştırma harfi de daralma yapar (diye, yiyecek)!',
  ),
  const Flashcard(
    id: 'fc_tr_3',
    subject: 'TYT Türkçe',
    category: 'Ses Bilgisi',
    term: 'Ünsüz Benzeşmesi (Sertleşme)',
    meaning: 'Sert ünsüzlerden (FıSTıKÇı ŞaHaP) biriyle biten bir kelimeye "c, d, g" yumuşak ünsüzleriyle başlayan ek geldiğinde ek "ç, t, k"ye dönüşür.',
    example: 'kitap-cı ➔ kitapçı, sokak-da ➔ sokakta, git-di ➔ gitti, 1923\'de ➔ 1923\'te.',
    examTip: 'Sayılara gelen eklerde de kural geçerlidir: Saat 15:00\'te yazılmalıdır, 15:00\'da yazımı yazım hatasıdır!',
  ),
  const Flashcard(
    id: 'fc_tr_4',
    subject: 'TYT Türkçe',
    category: 'Noktalama',
    term: 'Noktalı Virgül (;) Şartı',
    meaning: 'Cümlede daha önce virgül (,) kullanılmamışsa asla noktalı virgül (;) gelemez! Virgülle ayrılmış türleri ayırmak veya sıralı cümleleri bağlamak için kullanılır.',
    example: '"Kel ölür, sırma saçlı olur; kör ölür, badem gözlü olur."',
    examTip: 'Cümlede hiç virgül yoksa noktalı virgül şıkkını anında eleyebilirsin!',
  ),
  const Flashcard(
    id: 'fc_tr_5',
    subject: 'TYT Türkçe',
    category: 'Sözcükte Yapı',
    term: 'İyelik Eki vs Belirtme Hâl Eki',
    meaning: 'Sözcüğün başına "ONUN" getirildiğinde anlamlı oluyorsa İyelik Ekidir; getirilemiyor ve "Neyi/Kimi?" sorusuna cevap veriyorsa Belirtme Hâl Ekidir.',
    example: '"(Onun) Kitabı masada kalmış." ➔ İyelik | "Kitabı çantama koydum." ➔ Hâl eki.',
    examTip: 'İkisi üst üste gelirse birincisi daima iyelik, ikincisi hal ekidir: Ev-i-n-i (onun evini).',
  ),
  const Flashcard(
    id: 'fc_tr_6',
    subject: 'TYT Türkçe',
    category: 'Sözcük Türleri',
    term: 'Edat vs Bağlaç: İle / Yalnız Testi',
    meaning: '"İle" yerine "ve" koyabiliyorsan BAĞLAÇ, koyamıyorsan EDAT\'tır. "Yalnız" yerine "sadece" koyabiliyorsan EDAT, "ama/fakat" koyabiliyorsan BAĞLAÇ\'tır.',
    example: '"Kalemle (ve) defter aldım." (Bağlaç) | "Okula otobüsle (ve X) gitti." (Edat)',
    examTip: 'ÖSYM her yıl "yalnız", "ancak" veya "ile" sözcüklerinin edat/bağlaç ayrımını test eder!',
  ),
  const Flashcard(
    id: 'fc_tr_7',
    subject: 'TYT Türkçe',
    category: 'Fiilimsiler',
    term: '3 Fiilimsi Formülü',
    meaning: '1. İsim-Fiil: -ma, -ış, -mak (Ma-y-ış-mak)\n2. Sıfat-Fiil: -an, -ası, -mez, -ar, -dik, -ecek, -miş (Anası mezar dikecekmiş)\n3. Zarf-Fiil: -ken, -alı, -esiye, -meden, -ince, -ip, -erek, -dikçe.',
    example: '"Gelecek yıl sınavı kazanıp hayallerine kavuşacak."',
    examTip: 'Kalıcı isimlere dikkat: Dolmuş, sarma, çakmak, dondurma artık bir varlığın adı olduğu için fiilimsi DEĞİLDİR!',
  ),
  const Flashcard(
    id: 'fc_tr_8',
    subject: 'TYT Türkçe',
    category: 'Cümle Türleri',
    term: 'Girişik Birleşik Cümle',
    meaning: 'Tek bir temel yüklemi olan ve içinde en az bir tane FİİLİMSİ (yan cümlecik) barındıran cümlelerdir.',
    example: '"Hava kararınca sokaktaki çocuklar evlerine dağıldı." (-ınca zarf-fiili vardır)',
    examTip: 'Cümlede kaç tane fiilimsi varsa o kadar "yan cümlecik" vardır!',
  ),
  const Flashcard(
    id: 'fc_tr_9',
    subject: 'TYT Türkçe',
    category: 'Yazım Kuralları',
    term: 'Kurum ve Kuruluş Adlarına Gelen Ekler',
    meaning: 'Kurum, kuruluş, kurul ve iş yeri adlarına gelen ekler KESME İŞARETİYLE AYRILMAZ.',
    example: 'Türk Dil Kurumuna, Türkiye Büyük Millet Meclisinde, Boğaziçi Üniversitesinden.',
    examTip: 'İstisna: "Avrupa Birliği\'ne" ifadesi kesme işaretiyle ayrılır!',
  ),
  const Flashcard(
    id: 'fc_tr_10',
    subject: 'TYT Türkçe',
    category: 'Cümlede Anlam',
    term: 'Öznel vs Nesnel Yargı',
    meaning: 'Öznel: Kişiden kişiye değişen, kanıtlanamayan beğeni ve duygulardır. Nesnel: Kişiden bağımsız, doğruluğu veya yanlışlığı bilimsel olarak kanıtlanabilen yargılardır.',
    example: 'Öznel: "İstanbul dünyanın en büyüleyici şehridir." | Nesnel: "İstanbul Türkiye\'nin en kalabalık ilidir."',
    examTip: 'Bir yargının nesnel olması onun doğru olduğu anlamına gelmez; yanlış da olsa kanıtlanabiliyorsa nesneldir ("Türkiye\'nin başkenti İzmir\'dir" nesneldir).',
  ),

  // ==========================================
  // TYT MATEMATİK KARTLARI (10 Kart)
  // ==========================================
  const Flashcard(
    id: 'fc_mat_1',
    subject: 'TYT Matematik',
    category: 'Temel Kavramlar',
    term: 'Pozitif Bölen Sayısı (PBS)',
    meaning: 'Bir doğal sayı asal çarpanlarına ayrıldığında [A = aˣ · bʸ · cᶻ], tüm asal üslerin 1\'er fazlasının çarpımıdır: (x+1)·(y+1)·(z+1).',
    example: '72 = 2³ · 3² ➔ PBS = (3+1)·(2+1) = 4·3 = 12 pozitif böleni vardır.',
    examTip: 'Tam bölen sayısı sorulursa PBS\'nin 2 katı alınır (negatif bölenler de dahil edilir)!',
  ),
  const Flashcard(
    id: 'fc_mat_2',
    subject: 'TYT Matematik',
    category: 'Basit Eşitsizlikler',
    term: 'x² < x Kuralı',
    meaning: 'Karesi kendisinden küçük olan sayılar daima 0 ile 1 arasındaki pozitif basit kesirlerdir: 0 < x < 1.',
    example: 'x = 1/2 ise x² = 1/4 olur. 1/4 < 1/2 olduğu için x² < x kuralını sağlar.',
    examTip: 'Soruda "a² < a" ifadesini gördüğün anda hemen "0 < a < 1" eşitsizliğini yazmalısın!',
  ),
  const Flashcard(
    id: 'fc_mat_3',
    subject: 'TYT Matematik',
    category: 'Bölünebilme & EBOB',
    term: 'EBOB vs EKOK Problem Ayrımı',
    meaning: 'Bütünden parçaya gidiliyorsa (çuvalları poşetlere bölme, tarla etrafına ağaç dikme) EBOB; parçadan bütüne gidiliyorsa (küçük kutulardan küp yapma, nöbet saatleri) EKOK kullanılır.',
    example: 'EBOB(a, b) · EKOK(a, b) = a · b formülü iki pozitif sayı için daima geçerlidir.',
    examTip: 'Aralarında asal iki sayının EBOB\'u 1, EKOK\'u ise bu sayıların çarpımıdır!',
  ),
  const Flashcard(
    id: 'fc_mat_4',
    subject: 'TYT Matematik',
    category: 'Özdeşlikler',
    term: 'İki Kare Farkı Özdeşliği',
    meaning: 'a² - b² = (a - b) · (a + b). Matematikte en çok kullanılan ve çarpanlara ayırmanın temelini oluşturan özdeşliktir.',
    example: '101² - 99² = (101 - 99) · (101 + 99) = 2 · 200 = 400.',
    examTip: 'ÖSYM yeni nesil sadeleştirme ve alan sorularında mutlaka iki kare farkını gizler!',
  ),
  const Flashcard(
    id: 'fc_mat_5',
    subject: 'TYT Matematik',
    category: 'Özdeşlikler',
    term: 'Tam Kare Açılımı',
    meaning: '(a + b)² = a² + 2ab + b² | (a - b)² = a² - 2ab + b². Birincinin karesi, birinciyle ikincinin çarpımının iki katı, ikincinin karesi.',
    example: 'x + 1/x = 5 ise her iki tarafın karesi alınarak x² + 1/x² = 23 bulunur.',
    examTip: '(a - b)² ile (b - a)² birbirine eşittir çünkü çift kuvvet eksiyi yutar!',
  ),
  const Flashcard(
    id: 'fc_mat_6',
    subject: 'TYT Matematik',
    category: 'Eşitsizlikler',
    term: 'Negatif Sayıyla Çarpma ve Yön Değişimi',
    meaning: 'Bir eşitsizliğin her iki tarafı negatif bir sayıyla çarpılır veya bölünürse eşitsizlik MUTLAKA yön değiştirir (< ise > olur).',
    example: '-3x < 12 ➔ her iki tarafı -3\'e bölünce: x > -4.',
    examTip: 'Eşitsizlikler taraf tarafa çıkarılamaz veya bölünemez; yalnızca taraf tarafa TOPLANABİLİR!',
  ),
  const Flashcard(
    id: 'fc_mat_7',
    subject: 'TYT Matematik',
    category: 'Mutlak Değer',
    term: 'Mutlak Değerin Sıfırlanma Kuralı',
    meaning: '|A| + |B| = 0 veya A² + B² = 0 ise her iki ifade de AYRI AYRI sıfıra eşit olmak zorundadır (A = 0 ve B = 0).',
    example: '|2x - 6| + |y + 4| = 0 ise x = 3 ve y = -4 olmak zorundadır.',
    examTip: 'Mutlak değer asla negatif olamaz (|x| ≥ 0); uzaklık kavramıdır.',
  ),
  const Flashcard(
    id: 'fc_mat_8',
    subject: 'TYT Matematik',
    category: 'Üslü Sayılar',
    term: 'Üslü Sayılarda Sıfır ve Negatif Üs',
    meaning: 'Sıfır hariç her sayının sıfırıncı kuvveti 1\'dir (a⁰ = 1). Negatif üs sayıyı ters çevirir: a⁻ⁿ = 1 / aⁿ.',
    example: '5⁻² = 1 / 25 | (-3)² = +9 iken -3² = -9\'dur (parantez yoksa kare eksiyi kapsamaz!).',
    examTip: '0⁰ matematikte TANIMSIZDIR!',
  ),
  const Flashcard(
    id: 'fc_mat_9',
    subject: 'TYT Matematik',
    category: 'Problemler',
    term: 'Yüzde Problemlerinde 100x Kuralı',
    meaning: 'Maliyeti veya başlangıç miktarını bilmediğin sorularda bilinmeyene x yerine 100x de! Kesirlerle ve virgüllerle uğraşmadan çözersin.',
    example: '100x maliyetli ürüne %30 kâr eklenirse 130x, sonra %20 indirim yapılırsa: 130x - 26x = 104x (%4 kâr).',
    examTip: 'Eşit oranda zam yapılıp ardından indirim yapılırsa sonuç başlangıçtan DAİMA daha düşük olur!',
  ),
  const Flashcard(
    id: 'fc_mat_10',
    subject: 'TYT Matematik',
    category: 'Olasılık',
    term: 'Basit Olasılık Formülü',
    meaning: 'P(A) = (İstenen Durum Sayısı) / (Tüm Olası Durumların Sayısı). İmkansız olay 0, kesin olay 1\'dir.',
    example: 'Bir zar atıldığında asal sayı (2, 3, 5) gelme olasılığı = 3 / 6 = 1/2.',
    examTip: 'Bir olayın gerçekleşme olasılığı ile gerçekleşmeme olasılığının toplamı DAİMA 1\'dir: P(A) + P(A\') = 1.',
  ),

  // ==========================================
  // TYT FİZİK KARTLARI (10 Kart)
  // ==========================================
  const Flashcard(
    id: 'fc_fiz_1',
    subject: 'TYT Fizik',
    category: 'Fizik Bilimine Giriş',
    term: 'Temel Büyüklükler (KISA MUZ)',
    meaning: 'Tek başına tanımlanabilen 7 temel fiziksel büyüklük: Kütle (kg), Işık şiddeti (cd), Sıcaklık (Kelvin), Akım şiddeti (Amper), Madde miktarı (mol), Uzunluk (metre), Zaman (saniye).',
    example: 'Hız, kuvvet, enerji, ivme gibi büyüklükler temel büyüklüklerden türetilmiştir.',
    examTip: 'Sıcaklığın SI birimi Celsius (°C) DEĞİL, KELVİN (K)\'dir!',
  ),
  const Flashcard(
    id: 'fc_fiz_2',
    subject: 'TYT Fizik',
    category: 'Madde & Özkütle',
    term: 'Özkütle (d = m / V) & Dayanıklılık',
    meaning: 'Özkütle birim hacimdeki kütledir. Dayanıklılık = Kesit Alanı / Hacim ∝ 1 / h. Cisimler büyüdükçe kendi ağırlığına karşı dayanıklılığı azalır.',
    example: 'Bir karınca kendi ağırlığının 50 katını kaldırabilirken, fil kendi ağırlığını zor taşır.',
    examTip: 'Boyutları 2 katına çıkan küpün hacmi ve kütlesi 8 katına çıkar, dayanıklılığı ise yarıya iner!',
  ),
  const Flashcard(
    id: 'fc_fiz_3',
    subject: 'TYT Fizik',
    category: 'Sıvıların Özellikleri',
    term: 'Adezyon vs Kohezyon',
    meaning: 'Adezyon: Farklı cins moleküller arasındaki yapışma çekimidir (Su-cam). Kohezyon: Aynı cins moleküller arasındaki tutunma çekimidir (Su-su, cıva küresi).',
    example: 'Adezyon > Kohezyon ise sıvı yüzeyi ıslatır (su); Kohezyon > Adezyon ise sıvı ıslatmaz (cıva).',
    examTip: 'Yağmur damlasının cama yapışması ADEZYON, damlanın küre şeklinde dağılmadan durması KOHEZYON\'dur.',
  ),
  const Flashcard(
    id: 'fc_fiz_4',
    subject: 'TYT Fizik',
    category: 'Sıvıların Özellikleri',
    term: 'Yüzey Gerilimi Etkenleri',
    meaning: 'Kohezyon etkisiyle sıvı yüzeyinin esnek bir zar gibi davranmasıdır (Böceklerin batmadan yürümesi). Sıcaklık ve deterjan yüzey gerilimini AZALTIR; tuz eklemek ARTIRIR.',
    example: 'Çamaşırların sıcak ve deterjanlı suyla yıkanması suyun yüzey gerilimini düşürerek liflere nüfuz etmesini sağlar.',
    examTip: 'Kılcallıkta boru inceldikçe sıvının yükselme veya alçalma miktarı ARTAR!',
  ),
  const Flashcard(
    id: 'fc_fiz_5',
    subject: 'TYT Fizik',
    category: 'Hareket',
    term: 'Sürat (Skaler) vs Hız (Vektörel)',
    meaning: 'Sürat = Alınan Yol / Zaman (Skaler, yönsüzdür). Hız = Yer Değiştirme / Zaman (Vektörel, yönlüdür).',
    example: 'Dairesel pistte bir tur atıp başladığı yere dönen koşucunun yer değiştirmesi 0 olduğu için ortalama HIZI SIFIRDIR!',
    examTip: 'Araçların hız kadranı yön göstermediği için anlık SÜRATİ ölçer.',
  ),
  const Flashcard(
    id: 'fc_fiz_6',
    subject: 'TYT Fizik',
    category: 'Kuvvet ve Hareket',
    term: 'Newton 3. Yasa: Etki - Tepki',
    meaning: 'Her etkiye karşı eşit büyüklükte ve zıt yönde bir tepki kuvveti vardır (F_etki = -F_tepki).',
    example: 'Masaya bastırdığınızda masanın elinize uyguladığı kuvvet elinizin masaya uyguladığı kuvvete eşittir.',
    examTip: 'Etki ve tepki kuvvetleri FARKLI CİSİMLER üzerinde oluştukları için birbirlerini dengeleyip yok edemezler!',
  ),
  const Flashcard(
    id: 'fc_fiz_7',
    subject: 'TYT Fizik',
    category: 'İş ve Enerji',
    term: 'Fiziksel Anlamda İş Şartı (W = F · Δx)',
    meaning: 'Fiziksel anlamda iş yapılabilmesi için cisme kuvvet uygulanmalı ve cisim KUVVET DOĞRULTUSUNDA yer değiştirmelidir.',
    example: 'Sırtında çantayla düz yolda sabit hızla yürüyen çocuk fiziksel anlamda iş yapmaz (kuvvet ile hareket birbirine diktir).',
    examTip: 'Kuvvet harekete dik ise kesinlikle iş yapmaz (W = 0)!',
  ),
  const Flashcard(
    id: 'fc_fiz_8',
    subject: 'TYT Fizik',
    category: 'İş ve Enerji',
    term: 'Mekanik Enerjinin Korunumu',
    meaning: 'Sürtünmesiz bir sistemde Mekanik Enerji = Kinetik Enerji + Potansiyel Enerji toplamı daima sabittir (Em = Ek + Ep).',
    example: 'Yüksekten düşen topun potansiyel enerjisi azalırken kinetik enerjisi aynı miktarda artar.',
    examTip: 'Sürtünme varsa mekanik enerji azalır ancak kaybolan mekanik enerji ısı enerjisine dönüşür; evrende toplam enerji asla kaybolmaz!',
  ),
  const Flashcard(
    id: 'fc_fiz_9',
    subject: 'TYT Fizik',
    category: 'Termodinamik',
    term: 'Isı vs Sıcaklık Kavram Farkı',
    meaning: 'Sıcaklık: Taneciklerin ortalama kinetik enerjisinin ölçüsüdür, enerji değildir, termometreyle ölçülür. Isı: Sıcaklık farkından dolayı aktarılan enerjidir, kalorimetreyle ölçülür (Joule).',
    example: '"Suyun ısısı 50°C" demek yanlıştır; doğrusu "suyun sıcaklığı 50°C"dir.',
    examTip: 'Bir maddenin ısısı ölçülemez; madde ısı ALIR veya VERİR!',
  ),
  const Flashcard(
    id: 'fc_fiz_10',
    subject: 'TYT Fizik',
    category: 'Optik',
    term: 'Işığın Kırılması ve Hız İlişkisi',
    meaning: 'Işık az yoğundan çok yoğun ortama geçerken normale YAKLAŞARAK kırılır ve yoğun ortamda hızı AZALIR.',
    example: 'Havadan suya geçen ışık ışını normale yaklaşır ve yavaşlar.',
    examTip: 'Işık ortam değiştirirken FREKANSI VE PERİYODU DEĞİŞMEZ (kaynağa bağlıdır); sadece hızı ve dalga boyu değişir!',
  ),

  // ==========================================
  // TYT KİMYA KARTLARI (10 Kart)
  // ==========================================
  const Flashcard(
    id: 'fc_kim_1',
    subject: 'TYT Kimya',
    category: 'Kimya Bilimi',
    term: 'Simya Neden Bilim Değildir?',
    meaning: 'Simya teorik temellere dayanmaz, sistematik bilgi birikimi içermez ve deneme-yanılmaya dayalıdır. Kimya ise deney, gözlem ve nicel ölçüme dayalı pozitif bir bilimdir.',
    example: 'Terazinin yaygın ve hassas kullanımıyla (Lavoisier) modern kimya çağı başlamıştır.',
    examTip: 'Simyacılar kral suyunu, kezzabı, zaç yağını ve imbiği bulmuşlardır; ancak simya bir bilim dalı değildir.',
  ),
  const Flashcard(
    id: 'fc_kim_2',
    subject: 'TYT Kimya',
    category: 'Kimya Bilimi',
    term: 'Yaygın Asit ve Baz Formülleri',
    meaning: 'HCl: Tuz ruhu | HNO₃: Kezzap | H₂SO₄: Zaç yağı | CH₃COOH: Sirke asidi | NaOH: Sudkostik | KOH: Potaskostik | Ca(OH)₂: Sönmüş kireç.',
    example: 'CaCO₃ kireç taşıdır, ısıtılırsa sönmemiş kireç (CaO) ve CO₂ gazı oluşur.',
    examTip: 'Tuz ruhu (HCl) ile Çamaşır suyu (NaClO) karıştırılırsa ölümcül zehirli Klor gazı (Cl₂) açığa çıkar!',
  ),
  const Flashcard(
    id: 'fc_kim_3',
    subject: 'TYT Kimya',
    category: 'Güvenlik İşaretleri',
    term: 'Yanıcı vs Yakıcı Piktogramı',
    meaning: 'Yalnızca alev simgesi varsa YANICI maddedir (alkol, benzin). Alevin ortasında bir çember / "O" harfi varsa OKSİTLEYİCİ (YAKICI) maddedir (oksijen tüpü, peroksit).',
    example: 'Yanıcı maddeler kıvılcımdan uzak tutulmalı; yakıcı maddeler yanıcılarla yan yana konulmamalıdır.',
    examTip: 'Alevin ortasındaki "O" harfi oksijeni simgeler, yani YAKICI maddedir!',
  ),
  const Flashcard(
    id: 'fc_kim_4',
    subject: 'TYT Kimya',
    category: 'Atom Modelleri',
    term: 'Çekirdek ve Yörünge Keşifleri',
    meaning: 'Rutherford altın levha saçılma deneyi ile atomun merkezinde pozitif yüklü ÇEKİRDEK olduğunu kanıtlamıştır. Bohr ise elektronların belirli enerjili YÖRÜNGELERDE dolandığını bulmuştur.',
    example: 'Thomson üzümlü kek modeliyle elektronun varlığını ilk açıklayan modeldir.',
    examTip: 'Nötronu keşfeden James Chadwick\'tir (1932); Bohr ve Rutherford modellerinde nötron ismi yer almaz.',
  ),
  const Flashcard(
    id: 'fc_kim_5',
    subject: 'TYT Kimya',
    category: 'Periyodik Tablo',
    term: 'Kardan Adam Kuralı (Atom Yarıçapı)',
    meaning: 'Periyodik cetvelde yukarıdan aşağıya inildikçe katman sayısı arttığı için çap ARTAR. Soldan sağa gidildikçe çekirdeğin çekim gücü arttığı için çap KÜÇÜLÜR (kardan adamın burnu).',
    example: 'Çapı en büyük element tablonun sol altındaki Fransiyum (Fr); en küçük element sağ üstteki Helyum (He)\'dur.',
    examTip: 'Çap küçüldükçe elektron koparmak zorlaşır ve iyonlaşma enerjisi artar!',
  ),
  const Flashcard(
    id: 'fc_kim_6',
    subject: 'TYT Kimya',
    category: 'Periyodik Tablo',
    term: 'İyonlaşma Enerjisinde 3 Aşağı 5 Yukarı',
    meaning: 'Aynı periyotta soldan sağa gidildikçe iyonlaşma enerjisi sıralaması küresel simetri sebebiyle: 1A < 3A < 2A < 4A < 6A < 5A < 7A < 8A şeklindedir.',
    example: '2A grubu (Mg) 3A grubundan (Al), 5A grubu (N) 6A grubundan (O) daha yüksek iyonlaşma enerjisine sahiptir.',
    examTip: 'ÖSYM grafik sorularında 2A-3A ve 5A-6A zikzaklarını her yıl sorar!',
  ),
  const Flashcard(
    id: 'fc_kim_7',
    subject: 'TYT Kimya',
    category: 'Kimyasal Bağlar',
    term: 'İyonik vs Kovalent Bağ',
    meaning: 'İyonik Bağ: Metal ile ametal arası elektron ALIŞVERİŞİ (NaCl). Kristal örgülüdür, katısı elektriği iletmez, sıvısı ve sulu çözeltisi iletir. Kovalent Bağ: Ametaller arası elektron ORTAKLAŞMASI (H₂O, CO₂).',
    example: 'Apolar Kovalent: Aynı ametaller (O₂). Polar Kovalent: Farklı ametaller (HCl).',
    examTip: 'Ametal şifresi: H, C, N, O, F, P, S, Cl, Br, I (Hacı Sinoplu Celal\'in Burnunu Isırdı).',
  ),
  const Flashcard(
    id: 'fc_kim_8',
    subject: 'TYT Kimya',
    category: 'Zayıf Etkileşimler',
    term: 'Hidrojen Bağı (FON Grubu)',
    meaning: 'Hidrojen atomunun elektronegatifliği çok yüksek F, O, N (Flor, Oksijen, Azot) atomlarına bağlı olduğu moleküller arasında görülen en güçlü zayıf etkileşimdir.',
    example: 'H₂O, HF, NH₃ ve alkol molekülleri arasında hidrojen bağı bulunur.',
    examTip: 'Suyun beklenenden çok daha yüksek sıcaklıkta (100°C) kaynaması molekülleri arasındaki güçlü hidrojen bağları sayesindedir.',
  ),
  const Flashcard(
    id: 'fc_kim_9',
    subject: 'TYT Kimya',
    category: 'Maddenin Halleri',
    term: 'Sıvıların Buhar Basıncına Etki Edenler',
    meaning: 'Buhar basıncı SADECE 3 şeye bağlıdır: Sıvının Cinsi, Sıcaklık ve Saflık Derecesi (tuz çözme). Kabın hacmine, şekline, sıvı miktarına ASLA BAĞLI DEĞİLDİR.',
    example: 'Bir bardak su ile bir sürahi suyun aynı sıcaklıkta buhar basınçları eşittir.',
    examTip: 'Aynı ortamda kaynayan TÜM sıvıların buhar basınçları birbirine eşittir çünkü hepsi açık hava basıncına eşittir!',
  ),
  const Flashcard(
    id: 'fc_kim_10',
    subject: 'TYT Kimya',
    category: 'Kimya Her Yerde',
    term: 'Sabun vs Deterjan Temizleme Mantığı',
    meaning: 'Sabun doğaldır (bitkisel/hayvansal yağ + NaOH/KOH); deterjan petrol türevidir. İkisinin de apolar (hidrofob) kuyruğu kire tutunur, polar (hidrofil) başı ise suya tutunarak kiri söker.',
    example: 'Deterjanlar sert ve soğuk sularda bile köpürür; ancak doğada parçalanmadığı için çevre kirliliği yapar.',
    examTip: 'Arap sabununda potasyum hidroksit (KOH), beyaz katı sabunda sodyum hidroksit (NaOH) kullanılır!',
  ),

  // ==========================================
  // TYT TARİH KARTLARI (10 Kart)
  // ==========================================
  const Flashcard(
    id: 'fc_tar_1',
    subject: 'TYT Tarih',
    category: 'Türk-İslam Tarihi',
    term: 'Miryokefalon Savaşı (1176)',
    meaning: 'Anadolu Selçuklu Devleti (2. Kılıç Arslan) ile Bizans arasında yapılan savaştır. Bizans ordusu ağır bir yenilgiye uğratılmıştır.',
    example: 'Bu zaferle Türklerin Anadolu\'dan atılamayacağı kesinleşmiş ve Anadolu kesin olarak Türk yurdu olmuştur.',
    examTip: 'Şifre: Pasinler = Keşif, Malazgirt = Kapıyı açan, Miryokefalon = Anadolu\'nun Tapu Senedi!',
  ),
  const Flashcard(
    id: 'fc_tar_2',
    subject: 'TYT Tarih',
    category: 'Türk-İslam Medeniyeti',
    term: 'İkta / Tımar Sistemi',
    meaning: 'Devlete ait mülk arazilerin gelirlerinin maaş karşılığı asker ve devlet memurlarına bırakılması sistemidir. Hazineden para çıkmadan savaşa hazır atlı ordu (Cebelü) yetiştirilir.',
    example: 'Tarımsal üretimde süreklilik sağlanmış, taşrada asayiş ve güvenlik korunmuştur.',
    examTip: 'Toprak mülkiyeti şahıslara değil devlete (Miri) aittir; bu sayede Avrupa\'daki gibi feodal beylerin türemesi engellenmiştir.',
  ),
  const Flashcard(
    id: 'fc_tar_3',
    subject: 'TYT Tarih',
    category: 'Osmanlı Kuruluş',
    term: 'İskân Politikası',
    meaning: 'Osmanlı\'nın Balkanlarda fethettiği Hristiyan topraklara Anadolu\'daki konargöçer Türkmen aileleri yerleştirme siyasetidir.',
    example: 'Balkanların hızla Türkleşmesini, İslamlaşmasını ve fetihlerin kalıcı olmasını sağlamıştır.',
    examTip: 'İskân edilen ailelere toprak verilmiş ve belirli bir süre vergi muafiyeti tanınarak geri dönmeleri engellenmiştir.',
  ),
  const Flashcard(
    id: 'fc_tar_4',
    subject: 'TYT Tarih',
    category: 'İlk Türk Devletleri',
    term: 'Kut Anlayışı ve İkili Teşkilat',
    meaning: 'Kut: Yönetme yetkisinin Gök Tengri tarafından hükümdara verildiği inancıdır. Kan bağıyla tüm hanedan üyelerine geçtiği için sık sık taht kavgalarına ve devletlerin kısa sürede yıkılmasına neden olmuştur.',
    example: 'İkili Teşkilat: Devletin Doğu (asıl kağan) ve Batı (yabgu/kardeş) olarak ikiye bölünerek yönetilmesidir.',
    examTip: 'Kut anlayışı veraset sisteminin belirsiz olmasına ("tahta kimin geçeceği belli değil") ve taht kavgalarına yol açmıştır!',
  ),
  const Flashcard(
    id: 'fc_tar_5',
    subject: 'TYT Tarih',
    category: 'Osmanlı Islahatları',
    term: 'Lale Devri (1718 - 1730)',
    meaning: 'Pasarofça Antlaşması ile başlayan ve Patrona Halil İsyanı ile biten barış ve yenileşme dönemidir. İlk kez Avrupa\'nın üstünlüğü kabul edilmiş ve Batı örnek alınmıştır.',
    example: 'İlk geçici elçilikler Paris ve Viyana\'da açılmış, ilk sivil Türk matbaası İbrahim Müteferrika tarafından kurulmuştur.',
    examTip: 'ÖSYM: Lale Devri\'nde askeri alanda ıslahat YAPILMAMIŞTIR; kültürel, teknik ve diplomatik alanda yenilikler yapılmıştır!',
  ),
  const Flashcard(
    id: 'fc_tar_6',
    subject: 'TYT Tarih',
    category: 'Demokratikleşme',
    term: 'Tanzimat Fermanı (1839)',
    meaning: 'Padişah Abdülmecit döneminde Mustafa Reşit Paşa tarafından ilan edilmiştir. Padişah ilk kez kendi gücünün üstünde KANUN GÜCÜNÜ kabul etmiştir.',
    example: 'Tüm Osmanlı tebaasına din, dil, ırk ayrımı yapılmaksızın can, mal, namus güvencesi ve eşit vergi getirilmiştir.',
    examTip: 'Tanzimat Fermanı ile anayasal düzene geçilmemiştir; anayasalı rejime 1. Meşrutiyet (Kanun-i Esasi - 1876) ile geçilmiştir!',
  ),
  const Flashcard(
    id: 'fc_tar_7',
    subject: 'TYT Tarih',
    category: 'Milli Mücadele',
    term: 'Amasya Genelgesi (22 Haziran 1919)',
    meaning: 'Kurtuluş Savaşı\'nın AMACI, GEREKÇESİ ve YÖNTEMİNİN ilk kez belirtildiği ihtilal bildirisi niteliğindeki belgedir.',
    example: '"Milletin bağımsızlığını yine milletin azim ve kararı kurtaracaktır" maddesiyle ilk kez millet egemenliğine dayalı yeni bir devlet mesajı verilmiştir.',
    examTip: 'Amasya Genelgesi üstü kapalı olarak ilk kez MİLLİ EGEMENLİK ilkesini ortaya koymuştur!',
  ),
  const Flashcard(
    id: 'fc_tar_8',
    subject: 'TYT Tarih',
    category: 'Milli Mücadele',
    term: 'Erzurum vs Sivas Kongresi',
    meaning: 'Erzurum Kongresi: Toplanış bakımından bölgesel, aldığı kararlar bakımından MİLLİDİR. Manda ve himaye ilk kez reddedildi.\nSivas Kongresi: Hem toplanış hem kararlar bakımından MİLLİDİR. Tüm cemiyetler tek çatı altında birleştirildi.',
    example: 'Sivas Kongresi\'nde manda ve himaye fikri KESİN olarak tarihe gömülmüştür.',
    examTip: 'Temsil Heyeti\'nin ilk siyasi başarısı Damat Ferit Paşa hükümetinin istifa ettirilmesidir!',
  ),
  const Flashcard(
    id: 'fc_tar_9',
    subject: 'TYT Tarih',
    category: 'Kurtuluş Savaşı',
    term: 'Sakarya Meydan Muharebesi (1921)',
    meaning: 'Mustafa Kemal\'in "Hattı müdafaa yoktur, sathı müdafaa vardır; o satıh bütün vatandır" emrini verdiği ölüm kalım savaşıdır.',
    example: '1683 2. Viyana Kuşatması\'ndan beri süren 238 yıllık Türk geri çekilmesi bu zaferle son bulmuş, taarruz sırası Türk ordusuna geçmiştir.',
    examTip: 'Mustafa Kemal\'e bu zafer sonrası TBMM tarafından "Gazi" unvanı ve "Mareşal" rütbesi verilmiştir.',
  ),
  const Flashcard(
    id: 'fc_tar_10',
    subject: 'TYT Tarih',
    category: 'Atatürk İlkeleri',
    term: 'Kabotaj Kanunu (1 Temmuz 1926)',
    meaning: 'Osmanlı döneminde yabancılara verilen deniz taşımacılığı ve liman işletme ayrıcalıklarını kaldırarak Türk karasularında ticaret hakkını Türk denizcilerine veren kanundur.',
    example: 'Denizlerimizdeki yabancı tekeline son vererek ekonomik bağımsızlığı sağlamıştır.',
    examTip: 'Kabotaj Kanunu doğrudan MİLLİYETÇİLİK ilkesiyle ilgilidir!',
  ),

  // ==========================================
  // TYT COĞRAFYA KARTLARI (10 Kart)
  // ==========================================
  const Flashcard(
    id: 'fc_cog_1',
    subject: 'TYT Coğrafya',
    category: 'Dünya\'nın Şekli',
    term: 'Geoit Şekil',
    meaning: 'Dünya\'nın kutuplardan hafif basık, ekvatordan ise şişkin olan kendine has özel küresel şeklidir.',
    example: 'Ekvator yarıçapı (6378 km), kutuplar yarıçapından (6357 km) yaklaşık 21 km daha uzundur.',
    examTip: 'Kutuplara gidildikçe yerçekiminin artması ve Ekvator çevresinin kutuplardan uzun olması geoit şeklin kanıtıdır!',
  ),
  const Flashcard(
    id: 'fc_cog_2',
    subject: 'TYT Coğrafya',
    category: 'Dünya\'nın Hareketleri',
    term: 'Ekinoks Tarihleri (21 Mart - 23 Eylül)',
    meaning: 'Güneş ışınlarının Ekvator\'a 90° dik açıyla düştüğü tarihlerdir. Aydınlanma çemberi kutup noktalarından teğet geçer.',
    example: 'Dünyanın her yerinde gece ve gündüz süreleri birbirine eşittir (12 saat gece, 12 saat gündüz).',
    examTip: 'Ekinokslarda aynı boylam üzerindeki tüm noktalarda güneş aynı anda doğar ve aynı anda batar!',
  ),
  const Flashcard(
    id: 'fc_cog_3',
    subject: 'TYT Coğrafya',
    category: 'Atmosfer',
    term: 'Troposfer Katmanı',
    meaning: 'Atmosferin yere en yakın ve en yoğun katmanıdır. Su buharının (nemin) TAMAMI bu katmanda bulunur; bu yüzden tüm hava olayları (yağmur, kar, rüzgar) sadece troposferde gerçekleşir.',
    example: 'Yerden yükseldikçe sıcaklık her 200 metrede yaklaşık 1°C azalır (yerden yansıyan ışınlarla ısındığı için).',
    examTip: 'Hava olaylarının sadece troposferde görülmesinin tek sebebi SU BUHARININ tamamının burada olmasıdır!',
  ),
  const Flashcard(
    id: 'fc_cog_4',
    subject: 'TYT Coğrafya',
    category: 'Rüzgarlar',
    term: 'Föhn Rüzgarı',
    meaning: 'Bir dağ yamacını aşarak diğer yamaçtan aşağı doğru alçalan havanın sürtünme nedeniyle her 100 metrede 1°C ısınmasıyla oluşan sıcak ve kurutucu yerel rüzgardır.',
    example: 'Doğu Karadeniz (Rize) kıyılarında kışın turunçgil ve çay yetişmesine (mikroklima) olanak sağlar.',
    examTip: 'Normalde hava yükselirken 200m\'de 1°C soğur; ancak Föhn rüzgarında inerken sürtünmeyle her 100m\'de 1°C ısınır!',
  ),
  const Flashcard(
    id: 'fc_cog_5',
    subject: 'TYT Coğrafya',
    category: 'İklim & Yağış',
    term: 'Cephe (Frontal) Yağışları',
    meaning: 'Kutuplardan gelen soğuk hava kütlesi ile Ekvator yönünden gelen sıcak hava kütlesinin karşılaşma alanında sıcak havanın yükselip soğumasıyla oluşan yağışlardır.',
    example: 'Akdeniz iklim bölgesinde kış aylarında görülen yağışların tamamı cephesel kökenlidir.',
    examTip: 'Türkiye\'de cephe yağışlarının görülmesi Türkiye\'nin ORTA KUŞAKTA (Mutlak Konum) yer almasının kesin kanıtıdır!',
  ),
  const Flashcard(
    id: 'fc_cog_6',
    subject: 'TYT Coğrafya',
    category: 'Toprak Tipleri',
    term: 'Çernozyom (Kara Toprak)',
    meaning: 'Sert karasal iklim bölgelerinde gür dağ çayırları altında oluşan dünyanın en verimli yerli (zonal) toprağıdır.',
    example: 'Türkiye\'de Erzurum-Kars ve Ardahan platolarında yaygın olarak bulunur.',
    examTip: 'Çok verimli olmasına rağmen bölgede iklim çok soğuk ve yazlar kısa olduğu için tarımdan ziyade büyükbaş hayvancılık yapılır!',
  ),
  const Flashcard(
    id: 'fc_cog_7',
    subject: 'TYT Coğrafya',
    category: 'Dış Kuvvetler',
    term: 'Karstik Şekiller',
    meaning: 'Kalker (kireçtaşı), jips ve kaya tuzu gibi suda kolay eriyebilen kayaçların bulunduğu arazilerde kimyasal çözünme ve çökelmeyle oluşan şekillerdir.',
    example: 'Aşınım: Lapya, dolin, uvala, polye, mağara, obruk. Birikim: Sarkıt, dikit, sütun, traverten (Pamukkale).',
    examTip: 'Türkiye\'de karstik şekiller en fazla Akdeniz Bölgesi\'nde (Teke ve Taşeli platoları) yaygındır!',
  ),
  const Flashcard(
    id: 'fc_cog_8',
    subject: 'TYT Coğrafya',
    category: 'Yer Şekilleri',
    term: 'Peri Bacaları: Ortak Kuvvet Ürünü',
    meaning: 'Volkanik tüf ve bazalt tabakalarının akarsu ve sel suları ile rüzgar tarafından aşındırılmasıyla oluşan piramit biçimli doğal yapılardır.',
    example: 'Kapadokya (Nevşehir, Ürgüp, Göreme) yöresinde yaygındır.',
    examTip: 'Peri bacalarında iç kuvvet VOLKANİZMA, asıl dış kuvvet AKARSU ve SEL SULARI, dolaylı dış kuvvet RÜZGARDIR!',
  ),
  const Flashcard(
    id: 'fc_cog_9',
    subject: 'TYT Coğrafya',
    category: 'Nüfus Coğrafyası',
    term: 'Nüfus Piramitleri Okuma',
    meaning: 'Tabanı geniş üçgen piramit: Doğum ve ölüm oranı yüksek, genç bağımlı nüfus fazla, ortalama ömür kısa gelişmemiş ülke (Nijerya). Tabanı daralan çan piramidi: Doğum oranı azalmış, ortalama ömür uzun gelişmiş ülke (Almanya, Japonya).',
    example: 'Nüfus piramidinden cinsiyet dağılımı, yaş grupları ve gelişmişlik düzeyi okunabilir.',
    examTip: 'Nüfus piramidinden o ülkenin yüzölçümü ve nüfus yoğunluğu ASLA bulunamaz!',
  ),
  const Flashcard(
    id: 'fc_cog_10',
    subject: 'TYT Coğrafya',
    category: 'Doğal Afetler',
    term: 'Heyelan (Kütle Hareketi)',
    meaning: 'Eğimli yamaçlarda toprak ve ana kayanın yerçekimi etkisiyle aşağı doğru kaymasıdır. Eğim, aşırı yağış, killi toprak yapısı ve kar erimeleri tetikler.',
    example: 'Türkiye\'de heyelan olaylarının %65\'inden fazlası Doğu ve Batı Karadeniz\'de, özellikle ilkbahar aylarında görülür.',
    examTip: 'Ağaçlandırma yapmak erozyonu önler ancak derin tabakalı HEYELANI ÖNLEYEMEZ çünkü heyelan ana kayayla birlikte kayar!',
  ),

  // ==========================================
  // TYT FELSEFE KARTLARI (6 Kart)
  // ==========================================
  const Flashcard(
    id: 'fc_fel_1',
    subject: 'TYT Felsefe',
    category: 'Felsefeye Giriş',
    term: 'Philo-Sophia & Refleksif Düşünce',
    meaning: 'Philo (sevgi) ve Sophia (bilgelik) kelimelerinden oluşur; bilgelik sevgisidir. Refleksiflik ise düşüncenin kendi üzerine dönerek kendini eleştirmesi ve sorgulamasıdır.',
    example: 'Felsefe kümülatiftir (yığılır), rasyoneldir (akılcıdır), evrenseldir ancak sonuçları özneldir (subjektif).',
    examTip: 'Felsefede kesinleşmiş hazır cevaplardan ziyade sorular ve hakikati arama çabası esastır.',
  ),
  const Flashcard(
    id: 'fc_fel_2',
    subject: 'TYT Felsefe',
    category: 'Akıl Yürütme',
    term: 'Analoji (Benzeşim)',
    meaning: 'İki farklı durum veya nesne arasındaki ortak bir benzerlikten yola çıkarak birindeki özelliği diğerine de yükleme akıl yürütmesidir.',
    example: 'Dünya bir gezegendir ve atmosferi vardır. Mars da bir gezegendir, o halde Mars\'ın da atmosferi vardır.',
    examTip: 'Tümdengelim genelden özele, tümevarım özelden genele, analoji ise özelden özele benzerlik aktarımıdır!',
  ),
  const Flashcard(
    id: 'fc_fel_3',
    subject: 'TYT Felsefe',
    category: 'Bilgi Felsefesi',
    term: 'Tabula Rasa (Boş Levha - John Locke)',
    meaning: 'Empirizmin (deneycilik) temel savıdır. İnsan zihni doğuştan boş bir levha gibidir ve tüm bilgiler sonradan duyu organları ve deneyimlerle kazanılır.',
    example: '"İnsan zihninde daha önce duyularda bulunmamış hiçbir şey olamaz."',
    examTip: 'Rasyonalistler (Platon, Descartes) bilginin doğuştan geldiğini savunurken, Empiristler (Locke, Hume) sonradan deneyle kazanıldığını savunur.',
  ),
  const Flashcard(
    id: 'fc_fel_4',
    subject: 'TYT Felsefe',
    category: 'Varlık Felsefesi',
    term: 'Düalizm (İkicilik - Descartes)',
    meaning: 'Varlığın temelinde birbirinden bağımsız iki ayrı töz olduğunu savunur: Madde (yer kaplayan beden) ve Ruh (düşünen akıl).',
    example: 'Descartes: "Düşünüyorum, o halde varım" (Cogito ergo sum).',
    examTip: 'Varlık sadece maddedir diyen Materyalizm; sadece ruhtur diyen İdealizm; ikisidir diyen Düalizmdir!',
  ),
  const Flashcard(
    id: 'fc_fel_5',
    subject: 'TYT Felsefe',
    category: 'Ahlak Felsefesi',
    term: 'Kant\'ın Ödev Ahlakı (Kategorik İmperatif)',
    meaning: 'Ahlaki bir eylemin değeri sonucunda getirdiği menfaate veya mutluluğa değil, tamamen İYİ NİYETE ve hiçbir çıkar gözetmeksizin ödev bilinciyle yapılmasına bağlıdır.',
    example: 'Müşteriyi kandırmayan bakkal, bunu cennete gitmek veya müşteri kaybetmemek için değil, sırf dürüst olmak ödevi olduğu için yapmalıdır.',
    examTip: 'Kant ahlakta pragmatizmi (faydacılık) ve hedonizmi (hazcılık) kesinlikle reddeder!',
  ),
  const Flashcard(
    id: 'fc_fel_6',
    subject: 'TYT Felsefe',
    category: 'Din Felsefesi',
    term: 'Deizm vs Panteizm vs Panenteizm',
    meaning: 'Deizm: Tanrı evreni yaratmış ve doğa yasalarını kurup köşesine çekilmiştir; vahiy ve mucizeyi reddeder. Panteizm: Tanrı ile doğa özdeştir (Evren = Tanrı - Spinoza). Panenteizm: Her şey Tanrı\'dadır ancak Tanrı evrenden büyüktür.',
    example: 'Deizmde Tanrı evreni kusursuz işleyen bir saat gibi kuran yüce mimardır.',
    examTip: 'Agnostisizm (bilinemezcilik) Tanrı\'nın bilinemeyeceğini savunurken, Ateizm Tanrı\'nın varlığını doğrudan inkar eder.',
  ),
  // ==========================================
  // TYT DİN KÜLTÜRÜ KARTLARI (5 Kart)
  // ==========================================
  const Flashcard(
    id: "fc_din_1",
    subject: "TYT Din Kültürü",
    category: "Bilgi ve İnanç",
    term: "İslam'da Kesin Bilgi Kaynakları",
    meaning: "İslam epistemolojisinde bağlayıcı ve kesin bilgi kaynakları 3 tanedir: Selim Akıl, Sadık Haber (Vahiy ve Mütevatir Sünnet), Salim Duyular.",
    example: "Rüya, ilham ve keşif kişisel tecrübelerdir; tüm toplumu bağlayıcı genel dini delil sayılamaz.",
    examTip: "ÖSYM rüya ve keşfin kesin dini delil olmadığını sıklıkla sorar!",
  ),
  const Flashcard(
    id: "fc_din_2",
    subject: "TYT Din Kültürü",
    category: "Ahlak ve İbadet",
    term: "İhlas vs Takva vs İhsan",
    meaning: "İhlas: Amelleri sırf Allah rızası için riyadan (gösterişten) uzak yapmak. Takva: Allah'ın emir ve yasaklarına titizlikle uyup günahtan sakınmak. İhsan: Allah'ı görüyormuşçasına ibadet etmektir.",
    example: "Cibril Hadisi: 'İhsan; Allah'ı görüyormuş gibi kulluk etmendir. Sen O'nu görmesen de O seni görmektedir.'",
    examTip: "İhlas samimiyet, ihsan Allah'ın huzurunda olma bilinci ve iyilik, takva ise Allah korkusu ve sorumluluk bilincidir.",
  ),
  const Flashcard(
    id: "fc_din_3",
    subject: "TYT Din Kültürü",
    category: "İslam ve İbadet",
    term: "Zekat, Nisap Miktarı ve Öşür",
    meaning: "Nisap: Dinen zenginlik sınırı olup 80.18 gr altın veya değeridir. Üzerinden 1 yıl (havelân-ı havl) geçmelidir. Zekat yılda 1 kez verilir (altın/nakitte 1/40 yani %2.5). Toprak ürünlerinin zekatına Öşür denir (yağmurla sulananda 1/10, emekle sulananda 1/20).",
    example: "Zekat anne, baba, dede, nine, çocuk ve torunlara (usul ve füru) VERİLEMEZ!",
    examTip: "ÖSYM zekat verilemeyecek yakın akrabaları (bakmakla yükümlü olunan usul ve füru) defalarca sormuştur!",
  ),
  const Flashcard(
    id: "fc_din_4",
    subject: "TYT Din Kültürü",
    category: "İnanç Esasları",
    term: "Tevhid vs Şirk",
    meaning: "Tevhid: Allah'ın zatında, sıfatlarında ve fiillerinde bir ve tek olduğunu kabul etmek, eşi ve benzeri olmadığını onaylamaktır. Şirk ise Allah'a ortak koşmaktır.",
    example: "İhlas Suresi (De ki: O Allah birdir...) tevhid inancının en özlü ifadesidir.",
    examTip: "İslam inanç sisteminin temeli Tevhid ilkesidir; şirk ise İslam'da affedilmeyen en büyük günahtır.",
  ),
  const Flashcard(
    id: "fc_din_5",
    subject: "TYT Din Kültürü",
    category: "Ahiret İnancı",
    term: "Ahiret Hayatının Aşamaları",
    meaning: "Berzah (Kabir hayatı) -> Kıyamet (İsrafil'in Sûr'a 1. üflemesi) -> Ba's (Yeniden diriliş - Sûr'a 2. üfleme) -> Haşr (Toplanma) -> Mahşer (Toplanma yeri) -> Mizan (Hassas terazi) -> Sırat ve Cennet/Cehennem.",
    example: "Ölüm ile kıyamet arasındaki bekleme alemine Berzah alemi denir.",
    examTip: "ÖSYM Ba's (yeniden dirilme) ve Berzah (kabir dönemi) kavramlarını doğrudan eşleştirme sorusu yapabilir.",
  ),

  // ==========================================
  // AYT MATEMATİK KARTLARI (5 Kart)
  // ==========================================
  const Flashcard(
    id: "fc_ayt_mat_1",
    subject: "AYT Matematik",
    category: "Polinomlar",
    term: "Polinomda Kalan Bulma Taktikleri",
    meaning: "P(x) polinomunun (ax - b) ile bölümünden kalanı bulmak için bölen sıfıra eşitlenir: ax - b = 0 => x = b/a bulunur ve polinomda x yerine yazılır: Kalan = P(b/a).",
    example: "P(2x - 1) polinomunun katsayılar toplamı için x = 1 yazılır: P(2·1 - 1) = P(1). Sabit terim için x = 0 yazılır: P(-1).",
    examTip: "Parantezin içini değil, dışarıdan verilen ana değişken x yerine 1 veya 0 yazmayı unutma!",
  ),
  const Flashcard(
    id: "fc_ayt_mat_2",
    subject: "AYT Matematik",
    category: "İkinci Dereceden Denklemler",
    term: "Kök-Katsayı Bağıntıları (Viète)",
    meaning: "ax² + bx + c = 0 denkleminin kökleri x1 ve x2 olmak üzere: Kökler Toplamı = -b / a, Kökler Çarpımı = c / a, Kökler Farkının Mutlak Değeri = √Δ / |a|.",
    example: "Δ = b² - 4ac > 0 ise 2 farklı reel kök, Δ = 0 ise çakışık (çift katlı) kök, Δ < 0 ise reel kök yoktur (karmaşık kökler vardır).",
    examTip: "Simetrik iki kök varsa kökler toplamı sıfırdır (-b/a = 0 => b = 0) ve kökler ters işaretlidir (c/a < 0).",
  ),
  const Flashcard(
    id: "fc_ayt_mat_3",
    subject: "AYT Matematik",
    category: "Logaritma",
    term: "Logaritmanın Altın Kuralları",
    meaning: "log_a(x · y) = log_a(x) + log_a(y), log_a(x / y) = log_a(x) - log_a(y), log_a(x^n) = n · log_a(x). Taban Değiştirme: log_a(b) = log_c(b) / log_c(a) = 1 / log_b(a).",
    example: "a^(log_a(b)) = b ve a^(log_c(b)) = b^(log_c(a)).",
    examTip: "Tanım kümesi tuzağı: log_a(f(x)) için taban a > 0 ve a ≠ 1 olmalı; fonksiyon f(x) > 0 olmalıdır!",
  ),
  const Flashcard(
    id: "fc_ayt_mat_4",
    subject: "AYT Matematik",
    category: "Trigonometri",
    term: "Yarım Açı & Toplam-Fark Formülleri",
    meaning: "sin(2x) = 2·sin(x)·cos(x). cos(2x) = cos²(x) - sin²(x) = 2cos²(x) - 1 = 1 - 2sin²(x). tan(2x) = 2tan(x) / (1 - tan²(x)).",
    example: "sin(a + b) = sin(a)cos(b) + cos(a)sin(b), cos(a + b) = cos(a)cos(b) - sin(a)sin(b).",
    examTip: "Sorularda (1 + cos(2x)) gördüğünde 1'i yok etmek için cos(2x) yerine (2cos²x - 1) yaz!",
  ),
  const Flashcard(
    id: "fc_ayt_mat_5",
    subject: "AYT Matematik",
    category: "Türev & İntegral",
    term: "Türevin Geometrik Yorumu",
    meaning: "f(x) fonksiyonuna x = a noktasından çizilen teğetin eğimi m_teğet = f'(a)'dır. Normal doğrusunun eğimi m_normal = -1 / f'(a)'dır (m_teğet · m_normal = -1).",
    example: "f'(x) > 0 ise fonksiyon artandır, f'(x) < 0 ise azalandır. f'(x) = 0 noktaları yerel ekstremum adaylarıdır.",
    examTip: "Teğet x eksenine paralelse eğim sıfırdır: f'(x) = 0.",
  ),

  // ==========================================
  // AYT EDEBİYAT KARTLARI (5 Kart)
  // ==========================================
  const Flashcard(
    id: "fc_ayt_edb_1",
    subject: "AYT Edebiyat",
    category: "Edebi Sanatlar",
    term: "Teşbih vs Açık İstiare vs Kapalı İstiare",
    meaning: "Teşbih: Benzetmedir (4 öğesi vardır). Açık İstiare: Sadece kendisine benzetilen (güçlü öğe) söylenir. Kapalı İstiare: Sadece benzeyen söylenir ve kendisine benzetilenin bir özelliği verilir.",
    example: "Açık: 'İki kapılı bir handa gidiyorum gündüz gece' (Han = Dünya). Kapalı: 'Tekerlekler yollara bir şeyler fısıldıyor' (Yollar insana benzetilmiş).",
    examTip: "Teşhis (kişileştirme) sanatının olduğu her dizede KESİNLİKLE kapalı istiare de vardır!",
  ),
  const Flashcard(
    id: "fc_ayt_edb_2",
    subject: "AYT Edebiyat",
    category: "Divan Edebiyatı",
    term: "Gazel vs Kaside vs Mesnevi",
    meaning: "Gazel: Aşk, şarap, kadın temalı (5-15 beyit, aa ba ca). Kaside: Din veya devlet büyüklerini övgü (33-99 beyit). Mesnevi: Olay anlatan Divan romanı gibidir; her beyit kendi arasında kafiyelidir (aa bb cc dd) ve beyit sınırı yoktur.",
    example: "Fuzuli'nin Leyla vü Mecnun'u mesnevi; Su Kasidesi peygamber övgüsünü anlatan bir kasidedir.",
    examTip: "Gazelin ilk beytine Matla, son beytine Makta, en güzel beytine Beytü'l-Gazel; şairin mahlası geçen beyte Taç beyit denir.",
  ),
  const Flashcard(
    id: "fc_ayt_edb_3",
    subject: "AYT Edebiyat",
    category: "Türk Edebiyatında İlkler",
    term: "Roman ve Tiyatroda İlk Eserler",
    meaning: "İlk Çeviri Roman: Telemak (Yusuf Kamil Paşa). İlk Yerli Roman: Taaşşuk-ı Talat ve Fitnat (Şemsettin Sami). İlk Edebi Roman: İntibah (Namık Kemal). İlk Tarihi Roman: Cezmi (Namık Kemal). İlk Köy Romanı: Karabibik (Nabizade Nazım). İlk Psikolojik Roman: Eylül (Mehmet Rauf).",
    example: "İlk Sahnelenen Tiyatro: Vatan yahut Silistre (Namık Kemal). İlk Yazılan Tiyatro: Şair Evlenmesi (Şinasi).",
    examTip: "ÖSYM ilkler tablosundan hemen her yıl 1 soru mutlaka sorar; Şinasi, Namık Kemal ve Nabizade Nazım ilklerini adın gibi bil!",
  ),
  const Flashcard(
    id: "fc_ayt_edb_4",
    subject: "AYT Edebiyat",
    category: "Tanzimat Edebiyatı",
    term: "Tanzimat 1. Dönem vs 2. Dönem",
    meaning: "1. Dönem (Şinasi, Namık Kemal, Ziya Paşa): 'Sanat toplum içindir', dilde sadeleşme savunulmuş, vatan/hürriyet/hak temaları işlenmiştir. 2. Dönem (Recaizade Mahmut Ekrem, Abdülhak Hamit Tarhan, Samipaşazade Sezai): 'Sanat sanat içindir', dil ağır ve süslü, bireysel ve melankolik temalar işlenmiştir.",
    example: "1. Dönemde tiyatro sahnelenmek için (halkı eğitmek), 2. Dönemde okunmak için yazılmıştır.",
    examTip: "Roman tekniği açısından 2. Dönem realizm ve natüralizme yaklaştığı için 1. Dönem romantizmine göre çok daha kusursuzdur.",
  ),
  const Flashcard(
    id: "fc_ayt_edb_5",
    subject: "AYT Edebiyat",
    category: "Milli Edebiyat",
    term: "Genç Kalemler ve Yeni Lisan Hareketi (1911)",
    meaning: "Ömer Seyfettin, Ali Canip Yöntem ve Ziya Gökalp'in Selanik'te çıkardığı dergi ile Milli Edebiyat başlamıştır. Yeni Lisan Makalesi ile İstanbul Türkçesi ortak edebiyat dili kabul edilmiş ve Arapça-Farsça dil bilgisi kuralları atılmıştır.",
    example: "Aruz ölçüsü bırakılmış, milli ölçümüz olan Hece ölçüsü ve dörtlük esası benimsenmiştir.",
    examTip: "Genç Kalemler'in başyazarı Ömer Seyfettin; Yeni Lisan manifestosunun kuramcısı ve fikir babası Ziya Gökalp'tir.",
  ),

  // ==========================================
  // AYT FİZİK KARTLARI (4 Kart)
  // ==========================================
  const Flashcard(
    id: "fc_ayt_fiz_1",
    subject: "AYT Fizik",
    category: "Bağıl Hareket",
    term: "Nehirde Karşı Kıyıya Geçiş Süresi",
    meaning: "Bir yüzücünün nehirde karşı kıyıya varış süresi (t = d / Vy) sadece nehrin genişliğine (d) ve suya göre hızının nehre dik bileşenine (Vy) bağlıdır.",
    example: "Akıntı hızı ne kadar büyük olursa olsun yüzücünün karşıya geçiş süresi DEĞİŞMEZ; sadece sürüklenme mesafesi (x = V_akıntı · t) artar.",
    examTip: "ÖSYM tuzağı: Akıntı hızı artarsa karşıya geçme süresi nasıl değişir? -> DEĞİŞMEZ!",
  ),
  const Flashcard(
    id: "fc_ayt_fiz_2",
    subject: "AYT Fizik",
    category: "Dinamik",
    term: "Eğik Düzlemde İvme ve Kütle İlişkisi",
    meaning: "Sürtünmesiz eğik düzlemde kayan cismin ivmesi a = g · sin(θ)'dır. Sürtünmeli eğik düzlemde ise a = g(sinθ - k·cosθ)'dır.",
    example: "Her iki durumda da m·a = m·g(...) eşitliğinden kütle (m) sadeleşir.",
    examTip: "Eğik düzlemde kayan cismin ivmesi KÜTLESİNDEN (m) tamamen bağımsızdır!",
  ),
  const Flashcard(
    id: "fc_ayt_fiz_3",
    subject: "AYT Fizik",
    category: "Elektromanyetizma",
    term: "Lenz Kanunu ve İndüksiyon Akımı",
    meaning: "Kapalı bir devrede indüksiyon akımı, kendisini oluşturan manyetik akı değişimine KARŞI KOYACAK (zıt yönde bir manyetik alan üretecek) yönde akar: ε = -ΔΦ / Δt.",
    example: "Mıknatıs bobine yaklaştırılırsa bobin mıknatısı itecek yönde, uzaklaştırılırsa çekecek yönde manyetik kutup oluşturur.",
    examTip: "Yaklaşanı iter, uzaklaşanı çeker!",
  ),
  const Flashcard(
    id: "fc_ayt_fiz_4",
    subject: "AYT Fizik",
    category: "Düzgün Çembersel Hareket",
    term: "Merkezcil İvme ve Kuvvet",
    meaning: "Hızın büyüklüğü sabit kalsa bile hız vektörünün yönü sürekli değiştiği için cisim ivmeli hareket yapar. Merkezcil ivme a = v² / r = ω² · r. Merkezcil kuvvet F = m · v² / r.",
    example: "Merkezcil kuvvet vektörü daima yörünge merkezine doğrudur ve hız vektörüne diktir; bu yüzden fiziksel olarak İŞ YAPMAZ (W = 0).",
    examTip: "Merkezcil kuvvet cisme etkiyen net kuvvettir. Serbest cisim diyagramında merkezcil kuvvet diye fazladan hayali bir kuvvet ÇİZİLMEZ!",
  ),

  // ==========================================
  // AYT KİMYA KARTLARI (4 Kart)
  // ==========================================
  const Flashcard(
    id: "fc_ayt_kim_1",
    subject: "AYT Kimya",
    category: "Modern Atom Teorisi",
    term: "24Cr ve 29Cu Küresel Simetri İstisnası",
    meaning: "24Cr atomunun temel hal elektron dizilimi [Ar] 4s¹ 3d⁵, 29Cu atomunun temel hal dizilimi ise [Ar] 4s¹ 3d¹⁰ şeklindedir.",
    example: "Bu durum bir uyarılma DEĞİLDİR! d orbitalinin yarı dolu (d⁵) ve tam dolu (d¹⁰) olması atoma daha kararlı bir yapı kazandırdığı için temel haldir.",
    examTip: "ÖSYM elektron dizilimi sorularında uyarılma tuzağı olarak Cr ve Cu'yu çok sık sorar; bunlar uyarılmış değil, temel haldedir!",
  ),
  const Flashcard(
    id: "fc_ayt_kim_2",
    subject: "AYT Kimya",
    category: "Gazlar",
    term: "Graham Difüzyon Yasası",
    meaning: "Gazların yayılma hızları, mutlak sıcaklıklarının karekökü ile doğru, mol kütlelerinin karekökü ile ters orantılıdır: v1 / v2 = √( (T1 · M2) / (T2 · M1) ).",
    example: "Aynı sıcaklıktaki CH4 (MA=16) ve SO2 (MA=64) için: v_CH4 / v_SO2 = √(64/16) = √4 = 2. CH4 iki kat hızlı yayılır.",
    examTip: "Gaz difüzyonunda sıcaklık Santigrat değil KELVİN olarak alınmalıdır!",
  ),
  const Flashcard(
    id: "fc_ayt_kim_3",
    subject: "AYT Kimya",
    category: "Kimyasal Denge",
    term: "Denge Sabitini (Kc) Değiştiren Tek Faktör",
    meaning: "Kimyasal bir dengede derişim, basınç, hacim veya katalizör denge yönünü kaydırabilir; ancak Kc'nin sayısal değerini YALNIZCA SICAKLIK değiştirir!",
    example: "Endotermik tepkimede sıcaklık artarsa Kc büyür; Ekzotermik tepkimede sıcaklık artarsa Kc küçülür.",
    examTip: "Katalizör ileri ve geri hızı eşit oranda artırır; Kc değerini ASLA değiştirmez, sadece dengeye daha hızlı ulaşılmasını sağlar!",
  ),
  const Flashcard(
    id: "fc_ayt_kim_4",
    subject: "AYT Kimya",
    category: "Çözünürlük Dengesi (Kçç)",
    term: "Ortak İyon Etkisi",
    meaning: "Az çözünen bir tuzun bulunduğu çözeltiye ortak iyon eklendiğinde, Le Chatelier ilkesi gereği denge çökelme (katı) yönüne kayar ve çözünürlük AZALIR.",
    example: "AgCl katısının 0.1 M NaCl çözeltisindeki çözünürlüğü, saf sudaki çözünürlüğünden çok daha düşüktür.",
    examTip: "Ortak iyon çözünürlüğü azaltır; ancak sıcaklık sabit kaldıkça Kçç sayısal değeri DEĞİŞMEZ!",
  ),

  // ==========================================
  // AYT BİYOLOJİ KARTLARI (4 Kart)
  // ==========================================
  const Flashcard(
    id: "fc_ayt_bio_1",
    subject: "AYT Biyoloji",
    category: "Sinir Sistemi",
    term: "İmpuls Hızı vs İmpuls Sayısı (Frekans)",
    meaning: "İmpuls iletim hızı akson çapına ve miyelin kılıfa bağlıdır (sabit hızla ilerler). Uyarı şiddetinin artması ise impulsun hızını DEĞİŞTİRMEZ; sadece birim zamanda geçen impuls sayısını (frekansını) ve tepki şiddetini artırır.",
    example: "Ilık suya dokunmakla kaynar suya dokunmak arasındaki fark impuls hızından değil, beyne giden impuls sayısından kaynaklanır.",
    examTip: "ÖSYM tuzağı: 'Uyarının şiddeti artarsa impuls hızı artar' ifadesi KESİNLİKLE YANLIŞTIR!",
  ),
  const Flashcard(
    id: "fc_ayt_bio_2",
    subject: "AYT Biyoloji",
    category: "Dolaşım Sistemi",
    term: "Starling Hipotezi ve Ödem Oluşumu",
    meaning: "Kılcal damarlarda kan basıncı süzülmeyi (kandan dokuya), protein osmotik basıncı geri emilimi (dokudan kana) sağlar. Dokular arası sıvının aşırı birikmesine ödem denir.",
    example: "Ödem Nedenleri: Kan basıncının artması, kanın protein osmotik basıncının düşmesi, lenf kılcallarının tıkanması, histamin etkisiyle kılcal geçirgenliğin artması.",
    examTip: "Kanın protein osmotik basıncının artması ödeme neden OLMAZ; tam tersine dokudan kana su çekilmesini artırır!",
  ),
  const Flashcard(
    id: "fc_ayt_bio_3",
    subject: "AYT Biyoloji",
    category: "Genden Proteine",
    term: "Stop Kodonları ve tRNA Sayısı",
    meaning: "Toplam 64 çeşit kodon vardır. AUG başlama kodonudur (Metiyonin). UAA, UAG ve UGA olmak üzere 3 tane durdurucu (stop) kodon bulunur.",
    example: "Stop kodonları hiçbir amino asit kodlamaz ve bu kodonlara karşılık gelen hiçbir tRNA molekülü yoktur.",
    examTip: "Bu yüzden 64 çeşit kodon olmasına rağmen en fazla 61 çeşit tRNA ve 20 çeşit amino asit kullanılabilir!",
  ),
  const Flashcard(
    id: "fc_ayt_bio_4",
    subject: "AYT Biyoloji",
    category: "Canlılarda Enerji Dönüşümleri",
    term: "Fotosentezde Atmosfere Verilen Oksijenin Kaynağı",
    meaning: "Fotosentezde açığa çıkan oksijen gazının (O2) kaynağı karbondioksit değil, ışığa bağımlı evrede suyun fotolize (H2O parçalanması) uğramasıdır.",
    example: "Ruben ve Kamen'in ağır oksijen izotopu (18O) deneyinde sadece suyun oksijeni işaretlendiğinde atmosfere verilen O2'nin işaretli olduğu kanıtlanmıştır.",
    examTip: "Karbondioksitteki (CO2) oksijen ise üretilen glikozun (C6H12O6) ve açığa çıkan metabolik suyun yapısına katılır!",
  ),
];

class FlashcardsScreen extends ConsumerStatefulWidget {
  final List<Flashcard>? customDeck;

  const FlashcardsScreen({super.key, this.customDeck});

  @override
  ConsumerState<FlashcardsScreen> createState() => _FlashcardsScreenState();
}

class _FlashcardsScreenState extends ConsumerState<FlashcardsScreen>
    with SingleTickerProviderStateMixin {
  late List<Flashcard> _deck;
  int _currentIndex = 0;
  bool _isFlipped = false;
  final Set<String> _learnedCardIds = {};
  final Set<String> _reviewCardIds = {};

  // Branş Filtresi
  String _selectedFilterSubject = 'Tümü';
  final List<String> _filterSubjects = const [
    'Tümü',
    'TYT Biyoloji',
    'TYT Türkçe',
    'TYT Matematik',
    'TYT Fizik',
    'TYT Kimya',
    'TYT Tarih',
    'TYT Coğrafya',
    'TYT Felsefe',
    'TYT Din Kültürü',
    'AYT Matematik',
    'AYT Edebiyat',
    'AYT Fizik',
    'AYT Kimya',
    'AYT Biyoloji',
  ];

  // 3D Flip Animasyonu
  late AnimationController _flipController;
  late Animation<double> _flipAnimation;

  // Drag & Swipe Durumu
  double _dragOffset = 0.0;
  bool _isFinished = false;

  void _onSelectFilterSubject(String subj) {
    setState(() {
      _selectedFilterSubject = subj;
      final base = (widget.customDeck ?? defaultFlashcards);
      if (subj == 'Tümü') {
        _deck = List.from(base)..shuffle();
      } else {
        _deck = base.where((c) => c.subject == subj).toList()..shuffle();
        if (_deck.isEmpty) {
          _deck = List.from(base)..shuffle();
        }
      }
      _currentIndex = 0;
      _isFlipped = false;
      _isFinished = false;
      _dragOffset = 0.0;
      _learnedCardIds.clear();
      _reviewCardIds.clear();
      _flipController.reset();
    });
  }

  @override
  void initState() {
    super.initState();
    _deck = List.from(widget.customDeck ?? defaultFlashcards)..shuffle();

    _flipController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 380),
    );

    _flipAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _flipController, curve: Curves.easeInOut),
    )..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _flipController.dispose();
    super.dispose();
  }

  void _toggleFlip() {
    HapticFeedback.lightImpact();
    SoundService.playFlip();
    if (_isFlipped) {
      _flipController.reverse();
    } else {
      _flipController.forward();
    }
    _isFlipped = !_isFlipped;
  }

  void _onSwipe(bool isLearned) {
    if (_currentIndex >= _deck.length) return;

    final currentCard = _deck[_currentIndex];
    HapticFeedback.mediumImpact();

    if (isLearned) {
      SoundService.playCorrect();
    } else {
      SoundService.playIncorrect();
    }

    setState(() {
      if (isLearned) {
        _learnedCardIds.add(currentCard.id);
        _reviewCardIds.remove(currentCard.id);
      } else {
        _reviewCardIds.add(currentCard.id);
        _learnedCardIds.remove(currentCard.id);
      }

      // Animasyonu sıfırla
      if (_isFlipped) {
        _flipController.reset();
        _isFlipped = false;
      }
      _dragOffset = 0.0;

      if (_currentIndex + 1 >= _deck.length) {
        _isFinished = true;
        SoundService.playComplete();
        // Tamamlandı, ödül ver
        ref.read(userProfileProvider.notifier).recordLessonAttempt(
              Lesson(
                id: 'flashcards_complete_${DateTime.now().millisecondsSinceEpoch}',
                title: 'Kartlarla Pekiştir',
                description: 'Flaş kart tamamlama',
                xpReward: 35,
                gemReward: 12,
                questions: const [],
              ),
              100.0,
            );
      } else {
        _currentIndex++;
      }
    });
  }

  void _restartDeck({bool onlyReview = false}) {
    setState(() {
      final base = (widget.customDeck ?? defaultFlashcards);
      final filteredBase = _selectedFilterSubject == 'Tümü'
          ? base
          : base.where((c) => c.subject == _selectedFilterSubject).toList();
      if (onlyReview && _reviewCardIds.isNotEmpty) {
        _deck = filteredBase
            .where((fc) => _reviewCardIds.contains(fc.id))
            .toList()
          ..shuffle();
      } else {
        _deck = List.from(filteredBase.isEmpty ? base : filteredBase)..shuffle();
      }
      _currentIndex = 0;
      _isFlipped = false;
      _isFinished = false;
      _dragOffset = 0.0;
      _learnedCardIds.clear();
      _reviewCardIds.clear();
      _flipController.reset();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isFinished) {
      return _buildFinishedScreen();
    }

    final currentCard = _deck[_currentIndex];
    final progress = (_currentIndex + 1) / _deck.length;

    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Kartlarla Pekiştir 🎴',
          style: TextStyle(fontWeight: FontWeight.w900, fontSize: 19),
        ),
        leading: IconButton(
          icon: const Icon(Icons.close_rounded, color: Color(0xFF4B4B4B), size: 26),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          // Öğrenilen / Tekrar sayaçları
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE8F5E9),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.check_circle_rounded, color: Color(0xFF2E7D32), size: 16),
                      const SizedBox(width: 4),
                      Text(
                        '${_learnedCardIds.length}',
                        style: const TextStyle(
                          color: Color(0xFF2E7D32),
                          fontWeight: FontWeight.w800,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 6),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFEBEE),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.replay_rounded, color: Color(0xFFC62828), size: 16),
                      const SizedBox(width: 4),
                      Text(
                        '${_reviewCardIds.length}',
                        style: const TextStyle(
                          color: Color(0xFFC62828),
                          fontWeight: FontWeight.w800,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Branş Filtreleme Çubuğu
            Container(
              height: 48,
              padding: const EdgeInsets.symmetric(vertical: 6),
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(bottom: BorderSide(color: Color(0xFFF1ECE4), width: 1)),
              ),
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: _filterSubjects.length,
                separatorBuilder: (context, index) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final subj = _filterSubjects[index];
                  final isSelected = _selectedFilterSubject == subj;
                  return InkWell(
                    onTap: () => _onSelectFilterSubject(subj),
                    borderRadius: BorderRadius.circular(16),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 180),
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: isSelected ? const Color(0xFF7C3AED) : const Color(0xFFF3F4F6),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: isSelected ? const Color(0xFF6D28D9) : const Color(0xFFE5E7EB),
                          width: 1,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          subj,
                          style: TextStyle(
                            color: isSelected ? Colors.white : const Color(0xFF4B5563),
                            fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            // İlerleme Barı
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: LinearProgressIndicator(
                        value: progress,
                        minHeight: 10,
                        backgroundColor: const Color(0xFFE5E7EB),
                        valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF7C3AED)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    '${_currentIndex + 1} / ${_deck.length}',
                    style: const TextStyle(
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF6B7280),
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 8),

            // Kart Alanı (Swipeable & 3D Flip)
            Expanded(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  child: GestureDetector(
                    onHorizontalDragUpdate: (details) {
                      setState(() {
                        _dragOffset += details.primaryDelta!;
                      });
                    },
                    onHorizontalDragEnd: (details) {
                      if (_dragOffset > 90) {
                        // Sağa atıldı ➔ Öğrendim
                        _onSwipe(true);
                      } else if (_dragOffset < -90) {
                        // Sola atıldı ➔ Tekrar Çalış
                        _onSwipe(false);
                      } else {
                        // Merkeze geri dön
                        setState(() {
                          _dragOffset = 0.0;
                        });
                      }
                    },
                    onTap: _toggleFlip,
                    child: Transform.translate(
                      offset: Offset(_dragOffset, 0),
                      child: Transform.rotate(
                        angle: (_dragOffset / 300) * 0.15,
                        child: _buildFlipCard(currentCard),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // Alt Butonlar (Sola At & Sağa At)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(top: BorderSide(color: Color(0xFFE5E7EB), width: 1.5)),
              ),
              child: Row(
                children: [
                  // Sola At Butonu (Tekrar Çalış)
                  Expanded(
                    child: DuoButton(
                      text: '👈 TEKRAR ÇALIŞ',
                      color: DuoButtonColor.red,
                      height: 52,
                      onPressed: () => _onSwipe(false),
                    ),
                  ),
                  const SizedBox(width: 14),
                  // Sağa At Butonu (Öğrendim)
                  Expanded(
                    child: DuoButton(
                      text: 'ÖĞRENDİM 👉',
                      color: DuoButtonColor.green,
                      height: 52,
                      onPressed: () => _onSwipe(true),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFlipCard(Flashcard card) {
    final angle = _flipAnimation.value * pi;
    final isBack = angle >= pi / 2;

    return Stack(
      children: [
        Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..rotateY(angle),
          child: isBack
              ? Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()..rotateY(pi),
                  child: _buildCardBack(card),
                )
              : _buildCardFront(card),
        ),

        // Sola kaydırırken çıkan kırmızı "TEKRAR ET" rozeti
        if (_dragOffset < -20)
          Positioned(
            top: 24,
            right: 24,
            child: Opacity(
              opacity: min(1.0, (-_dragOffset / 120)),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: const Color(0xFFEF4444),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.replay_rounded, color: Colors.white, size: 20),
                    SizedBox(width: 6),
                    Text(
                      'TEKRAR ÇALIŞ',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

        // Sağa kaydırırken çıkan yeşil "ÖĞRENDİM" rozeti
        if (_dragOffset > 20)
          Positioned(
            top: 24,
            left: 24,
            child: Opacity(
              opacity: min(1.0, (_dragOffset / 120)),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: const Color(0xFF10B981),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.check_circle_rounded, color: Colors.white, size: 20),
                    SizedBox(width: 6),
                    Text(
                      'ÖĞRENDİM',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }

  // Kart Ön Yüzü (Kelime / Kavram)
  Widget _buildCardFront(Flashcard card) {
    Color subjectColor;
    if (card.subject.contains('Biyoloji')) {
      subjectColor = const Color(0xFF10B981);
    } else if (card.subject.contains('Matematik')) {
      subjectColor = const Color(0xFF1CB0F6);
    } else if (card.subject.contains('Fizik')) {
      subjectColor = const Color(0xFF7C3AED);
    } else if (card.subject.contains('Kimya')) {
      subjectColor = const Color(0xFFEC4899);
    } else if (card.subject.contains('Türkçe')) {
      subjectColor = const Color(0xFFEA580C);
    } else if (card.subject.contains('Edebiyat')) {
      subjectColor = const Color(0xFFB91C1C);
    } else if (card.subject.contains('Tarih')) {
      subjectColor = const Color(0xFFFF9600);
    } else if (card.subject.contains('Coğrafya')) {
      subjectColor = const Color(0xFF14B8A6);
    } else if (card.subject.contains('Felsefe')) {
      subjectColor = const Color(0xFF6366F1);
    } else if (card.subject.contains('Din')) {
      subjectColor = const Color(0xFF047857);
    } else {
      subjectColor = const Color(0xFF58CC02);
    }

    return Container(
      width: double.infinity,
      height: double.infinity,
      constraints: const BoxConstraints(maxHeight: 460),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: const Color(0xFFE5E7EB), width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Ders ve Kategori Rozeti
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            decoration: BoxDecoration(
              color: subjectColor.withOpacity(0.12),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              '${card.subject} • ${card.category ?? "YKS Temel"}',
              style: TextStyle(
                color: subjectColor,
                fontWeight: FontWeight.w900,
                fontSize: 13,
                letterSpacing: 0.5,
              ),
            ),
          ),

          const Spacer(),

          // Kart İkonu
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: subjectColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.style_rounded,
              size: 42,
              color: subjectColor,
            ),
          ),

          const SizedBox(height: 20),

          // Kelime / Kavram
          Text(
            card.term,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w900,
              color: Color(0xFF1F2937),
              letterSpacing: -0.5,
            ),
          ),

          const Spacer(),

          // İpucu
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFFF3F4F6),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.touch_app_rounded, size: 18, color: Color(0xFF6B7280)),
                SizedBox(width: 6),
                Text(
                  'Kartı çevirmek için dokun',
                  style: TextStyle(
                    fontSize: 13,
                    color: Color(0xFF6B7280),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Kart Arka Yüzü (Anlam & Taktik)
  Widget _buildCardBack(Flashcard card) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      constraints: const BoxConstraints(maxHeight: 460),
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: const Color(0xFFFAF5FF), // Hafif Mor arka plan
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: const Color(0xFFD8B4FE), width: 2),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF7C3AED).withOpacity(0.08),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Üst Başlık & Çevir Simgesi
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  card.term,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF6B21A8),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEDE9FE),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.flip_camera_android_rounded,
                    size: 18,
                    color: Color(0xFF7C3AED),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),
            const Divider(color: Color(0xFFE9D5FF), height: 1),
            const SizedBox(height: 12),

            // Anlam & Tanım
            const Text(
              'AÇIKLAMA / TANIM:',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w900,
                color: Color(0xFF9333EA),
                letterSpacing: 0.8,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              card.meaning,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Color(0xFF374151),
                height: 1.45,
              ),
            ),

            if (card.example != null) ...[
              const SizedBox(height: 14),
              const Text(
                'ÖRNEK:',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF2563EB),
                  letterSpacing: 0.8,
                ),
              ),
              const SizedBox(height: 4),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xFFEFF6FF),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFBFDBFE)),
                ),
                child: Text(
                  card.example!,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF1E40AF),
                    fontWeight: FontWeight.w600,
                    height: 1.35,
                  ),
                ),
              ),
            ],

            if (card.examTip != null) ...[
              const SizedBox(height: 12),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFBEB),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFFDE68A)),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('💡 ', style: TextStyle(fontSize: 16)),
                    Expanded(
                      child: Text(
                        card.examTip!,
                        style: const TextStyle(
                          fontSize: 12.5,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF92400E),
                          height: 1.35,
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
    );
  }

  // Deste Bittiğinde Kutlama Ekranı
  Widget _buildFinishedScreen() {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),

              // Papağan Kutlama
              const ParrotMascotWidget(
                size: 130,
                mood: ParrotMood.happy,
                speechText: 'Harika iş çıkardın! Kartları pekiştirdin! 🎉',
              ),

              const SizedBox(height: 24),

              const Text(
                'Deste Tamamlandı!',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF10B981),
                ),
              ),

              const SizedBox(height: 8),

              Text(
                'Toplam ${_deck.length} kart üzerinden ${_learnedCardIds.length} tanesini öğrendin.',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 15,
                  color: Color(0xFF6B7280),
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 28),

              // Durum Kartları
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFECFDF5),
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(color: const Color(0xFFA7F3D0)),
                      ),
                      child: Column(
                        children: [
                          const Icon(Icons.check_circle_rounded, color: Color(0xFF059669), size: 28),
                          const SizedBox(height: 6),
                          Text(
                            '${_learnedCardIds.length}',
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w900,
                              color: Color(0xFF059669),
                            ),
                          ),
                          const Text(
                            'ÖĞRENİLDİ',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFF047857),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFEF2F2),
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(color: const Color(0xFFFECACA)),
                      ),
                      child: Column(
                        children: [
                          const Icon(Icons.replay_rounded, color: Color(0xFFDC2626), size: 28),
                          const SizedBox(height: 6),
                          Text(
                            '${_reviewCardIds.length}',
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w900,
                              color: Color(0xFFDC2626),
                            ),
                          ),
                          const Text(
                            'TEKRAR EDİLECEK',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFFB91C1C),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              const Spacer(),

              // Tekrar Çalış ve Çıkış Butonları
              if (_reviewCardIds.isNotEmpty) ...[
                DuoButton(
                  text: 'TEKRAR EDİLECEKLERİ ÇÖZ (${_reviewCardIds.length})',
                  color: DuoButtonColor.blue,
                  height: 52,
                  onPressed: () => _restartDeck(onlyReview: true),
                ),
                const SizedBox(height: 10),
              ],

              DuoButton(
                text: 'TÜMÜNÜ YENİDEN BAŞLAT',
                color: DuoButtonColor.green,
                height: 52,
                onPressed: () => _restartDeck(onlyReview: false),
              ),

              const SizedBox(height: 10),

              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text(
                  'Pratiğe Dön',
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF6B7280),
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
