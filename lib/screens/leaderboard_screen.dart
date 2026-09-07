import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/game_provider.dart';

class LeaderboardPlayer {
  final String name;
  final int xp;
  final String avatar;
  final bool isUser;

  const LeaderboardPlayer({
    required this.name,
    required this.xp,
    required this.avatar,
    this.isUser = false,
  });
}

class LeaderboardScreen extends ConsumerWidget {
  const LeaderboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(userProfileProvider);

    // Mock rakipler + Kullanıcı
    final List<LeaderboardPlayer> players = [
      const LeaderboardPlayer(name: 'Ayşe K. (Hacettepe Hedef)', xp: 320, avatar: '👩‍🎓'),
      const LeaderboardPlayer(name: 'Mehmet T. (Boğaziçi Hedef)', xp: 260, avatar: '👨‍💻'),
      const LeaderboardPlayer(name: 'Zeynep D.', xp: 210, avatar: '📚'),
      const LeaderboardPlayer(name: 'Burak S.', xp: 140, avatar: '🎯'),
      const LeaderboardPlayer(name: 'Elif Y.', xp: 90, avatar: '🚀'),
      const LeaderboardPlayer(name: 'Kaan B.', xp: 40, avatar: '⚡'),
    ];

    // Kullanıcıyı ekle
    players.add(
      LeaderboardPlayer(
        name: 'Sen (YKS Savaşçısı)',
        xp: profile.xp,
        avatar: '👑',
        isUser: true,
      ),
    );

    // XP'ye göre büyükten küçüğe sırala
    players.sort((a, b) => b.xp.compareTo(a.xp));

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Lig Başlık Kartı
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              decoration: const BoxDecoration(
                color: Color(0xFFF7F7F7),
                border: Border(
                  bottom: BorderSide(color: Color(0xFFE5E5E5), width: 2),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE5E5E5),
                      shape: BoxShape.circle,
                      border: Border.all(color: const Color(0xFFCECECE), width: 3),
                    ),
                    child: const Center(
                      child: Text('🥈', style: TextStyle(fontSize: 30)),
                    ),
                  ),
                  const SizedBox(width: 14),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'GÜMÜŞ LİG',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                            color: Color(0xFF4B4B4B),
                            letterSpacing: 0.8,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'Kalan Süre: 2 Gün • İlk 3 Altın Lige Çıkar',
                          style: TextStyle(
                            fontSize: 13,
                            color: Color(0xFF777777),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Liderlik Sıralaması
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                itemCount: players.length,
                separatorBuilder: (context, index) {
                  if (index == 2) {
                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      decoration: BoxDecoration(
                        color: const Color(0xFFD7FFB8),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      alignment: Alignment.center,
                      child: const Text(
                        '🔼 YÜKSELME BÖLGESİ (ALTIN LİG)',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF58A700),
                        ),
                      ),
                    );
                  }
                  return const Divider(height: 1, color: Color(0xFFF0F0F0));
                },
                itemBuilder: (context, index) {
                  final player = players[index];
                  final rank = index + 1;

                  Color rankColor = const Color(0xFF777777);
                  Widget rankWidget = Text(
                    '$rank',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                      color: rankColor,
                    ),
                  );

                  if (rank == 1) {
                    rankWidget = const Text('🥇', style: TextStyle(fontSize: 22));
                  } else if (rank == 2) {
                    rankWidget = const Text('🥈', style: TextStyle(fontSize: 22));
                  } else if (rank == 3) {
                    rankWidget = const Text('🥉', style: TextStyle(fontSize: 22));
                  }

                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                    decoration: BoxDecoration(
                      color: player.isUser
                          ? const Color(0xFFDDF4FF)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(16),
                      border: player.isUser
                          ? Border.all(color: const Color(0xFF84D8FF), width: 2)
                          : null,
                    ),
                    child: Row(
                      children: [
                        SizedBox(width: 32, child: Center(child: rankWidget)),
                        const SizedBox(width: 12),
                        Text(player.avatar, style: const TextStyle(fontSize: 26)),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Text(
                            player.name,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: player.isUser
                                  ? FontWeight.w900
                                  : FontWeight.w700,
                              color: player.isUser
                                  ? const Color(0xFF1899D6)
                                  : const Color(0xFF4B4B4B),
                            ),
                          ),
                        ),
                        Text(
                          '${player.xp} XP',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w800,
                            color: player.isUser
                                ? const Color(0xFF1899D6)
                                : const Color(0xFF777777),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
