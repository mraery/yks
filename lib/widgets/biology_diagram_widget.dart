import 'package:flutter/material.dart';

class BiologyDiagramWidget extends StatelessWidget {
  final String diagramType;

  const BiologyDiagramWidget({
    super.key,
    required this.diagramType,
  });

  @override
  Widget build(BuildContext context) {
    Widget content;
    String caption;

    switch (diagramType) {
      case 'cell_organelles':
        content = _buildCellDiagram();
        caption = 'Şekil 1: Tipik bir ökaryot hücre ve organelleri';
        break;
      case 'mitochondria':
        content = _buildMitochondriaDiagram();
        caption = 'Şekil 2: Mitokondri organeli ve ATP sentez yapısı';
        break;
      case 'food_pyramid':
        content = _buildFoodPyramidDiagram();
        caption = 'Şekil 3: Ekolojik besin piramidi ve enerji akışı';
        break;
      case 'enzyme_lock':
        content = _buildEnzymeLockDiagram();
        caption = 'Şekil 4: Enzim-substrat anahtar-kilit uyumu';
        break;
      case 'dna_helix':
        content = _buildDnaHelixDiagram();
        caption = 'Şekil 5: DNA çift sarmalı ve nükleotit eşleşmeleri';
        break;
      default:
        content = const SizedBox.shrink();
        caption = '';
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE5E7EB), width: 2),
      ),
      padding: const EdgeInsets.all(14),
      child: Column(
        children: [
          content,
          const SizedBox(height: 10),
          Text(
            caption,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: Color(0xFF6B7280),
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }

  // 1. Hücre ve Organeller Şeması
  Widget _buildCellDiagram() {
    return Container(
      height: 180,
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFECFDF5),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF10B981), width: 2),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Çekirdek (Merkez)
          Container(
            width: 76,
            height: 76,
            decoration: BoxDecoration(
              color: const Color(0xFF8B5CF6).withOpacity(0.25),
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0xFF7C3AED), width: 2),
            ),
            child: const Center(
              child: Text(
                'ÇEKİRDEK\n(DNA)',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF5B21B6),
                ),
              ),
            ),
          ),

          // [X] ile gösterilen MİTOKONDRİ (Sol Alt)
          Positioned(
            left: 16,
            bottom: 20,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFFFF5722),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.deepOrange.withOpacity(0.3),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('⚡ ', style: TextStyle(fontSize: 14)),
                  Text(
                    'X: Mitokondri',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Ribozom (Sağ Üst)
          Positioned(
            right: 20,
            top: 18,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFF0284C7),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text(
                'Ribozom (Protein)',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 11,
                ),
              ),
            ),
          ),

          // Kloroplast (Sağ Alt)
          Positioned(
            right: 20,
            bottom: 20,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFF059669),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text(
                'Kloroplast (Fotosentez)',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 11,
                ),
              ),
            ),
          ),

          // Hücre Zarı Etiketi (Sol Üst)
          Positioned(
            left: 16,
            top: 14,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: const Color(0xFF10B981)),
              ),
              child: const Text(
                'Hücre Zarı',
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Color(0xFF047857)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 2. Mitokondri Şeması
  Widget _buildMitochondriaDiagram() {
    return Container(
      height: 160,
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF7ED),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFF97316), width: 2),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildBadge('Dış Zar', 'Koruyucu düz zar', const Color(0xFFEA580C)),
              _buildBadge('Krista', 'Kıvrımlı iç zar (ETS)', const Color(0xFFC2410C)),
              _buildBadge('Matriks', 'Sıvı kısım (Krebs)', const Color(0xFF9A3412)),
            ],
          ),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFFFED7AA),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Text(
              'Besin (Glikoz) + O₂ ➔ CO₂ + H₂O + [ 32 ATP Enerji ]',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 13,
                color: Color(0xFF7C2D12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 3. Besin Piramidi Şeması
  Widget _buildFoodPyramidDiagram() {
    return Container(
      height: 190,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF10B981), width: 2),
      ),
      child: Column(
        children: [
          // 4. Basamak (Tepedeki Avcılar)
          _buildPyramidTier('3. Tüketiciler (Kartal, Aslan)', '10 J', 140, const Color(0xFFEF4444)),
          const SizedBox(height: 4),
          // 3. Basamak
          _buildPyramidTier('2. Tüketiciler (Tilki, Yılan)', '100 J', 190, const Color(0xFFF59E0B)),
          const SizedBox(height: 4),
          // 2. Basamak
          _buildPyramidTier('1. Tüketiciler / Otçullar (Tavşan)', '1.000 J', 240, const Color(0xFF3B82F6)),
          const SizedBox(height: 4),
          // 1. Basamak (Üreticiler / Taban)
          _buildPyramidTier('Üreticiler (Yeşil Bitkiler)', '10.000 J', 300, const Color(0xFF10B981)),
          const SizedBox(height: 8),
          const Text(
            '⬆️ Yukarı çıkıldıkça: Enerji %10 kuralıyla azalır | Biyolojik birikim (Zehir) artar!',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 10.5,
              fontWeight: FontWeight.w800,
              color: Color(0xFF047857),
            ),
          ),
        ],
      ),
    );
  }

  // 4. Enzim-Substrat Şeması
  Widget _buildEnzymeLockDiagram() {
    return Container(
      height: 150,
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF6FF),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF3B82F6), width: 2),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildStep('SUBSTRAT\n+ ENZİM', 'Anahtar + Kilit', const Color(0xFF2563EB)),
          const Icon(Icons.arrow_forward_rounded, color: Color(0xFF93C5FD)),
          _buildStep('ENZİM-SUBSTRAT\nKOMPLEKSİ', 'Aktif Bölge Bağı', const Color(0xFF1D4ED8)),
          const Icon(Icons.arrow_forward_rounded, color: Color(0xFF93C5FD)),
          _buildStep('ÜRÜN +\nSERBEST ENZİM', 'Enzim değişmez!', const Color(0xFF1E40AF)),
        ],
      ),
    );
  }

  // 5. DNA Sarmalı Şeması
  Widget _buildDnaHelixDiagram() {
    return Container(
      height: 150,
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFFAF5FF),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFA855F7), width: 2),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildDnaBase('ADENİN (A)', 'TİMİN (T)', '2\'li Hidrojen Bağı', const Color(0xFF9333EA)),
              _buildDnaBase('GUANİN (G)', 'SİTOZİN (C)', '3\'lü Hidrojen Bağı', const Color(0xFF7E22CE)),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFFC084FC)),
            ),
            child: const Text(
              'A + G = T + C (Pürin = Pirimidin Kuralı)',
              style: TextStyle(fontSize: 11.5, fontWeight: FontWeight.w900, color: Color(0xFF581C87)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPyramidTier(String label, String energy, double width, Color color) {
    return Container(
      width: width,
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 10.5,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Text(
            energy,
            style: const TextStyle(
              color: Colors.white70,
              fontWeight: FontWeight.w900,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBadge(String title, String desc, Color color) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            title,
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 11),
          ),
        ),
        const SizedBox(height: 4),
        Text(desc, style: const TextStyle(fontSize: 9.5, color: Color(0xFF7C2D12), fontWeight: FontWeight.w600)),
      ],
    );
  }

  Widget _buildStep(String title, String sub, Color color) {
    return Container(
      width: 90,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withOpacity(0.5)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 9.5, fontWeight: FontWeight.w900, color: color),
          ),
          const SizedBox(height: 4),
          Text(
            sub,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 8.5, color: Color(0xFF6B7280)),
          ),
        ],
      ),
    );
  }

  Widget _buildDnaBase(String left, String right, String bond, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.4), width: 1.5),
      ),
      child: Column(
        children: [
          Text(
            '$left  ═  $right',
            style: TextStyle(fontWeight: FontWeight.w900, fontSize: 13, color: color),
          ),
          const SizedBox(height: 2),
          Text(
            bond,
            style: const TextStyle(fontSize: 10, color: Color(0xFF6B7280), fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
