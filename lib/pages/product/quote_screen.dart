import 'package:flutter/material.dart';
import 'package:flutter_visualizador_de_precos/components/constants/app_colors.dart';
import 'package:flutter_visualizador_de_precos/components/constants/app_text_styles.dart';
import 'package:flutter_visualizador_de_precos/components/widgets/molecules/app_bar_widget.dart';
import 'package:flutter_visualizador_de_precos/models/keanu_quotes_model.dart';

class QuoteScreen extends StatelessWidget {
  final Quote quote;

  const QuoteScreen({super.key, required this.quote});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      appBar: AppBarWidget(
        title: quote.movie,
        actions: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Pôster do filme
            if (quote.poster.isNotEmpty)
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    quote.poster,
                    height: 300,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      height: 300,
                      decoration: BoxDecoration(
                        color: AppColors.veryLightGrey,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Icon(
                        Icons.broken_image,
                        size: 80,
                        color: AppColors.grey,
                      ),
                    ),
                  ),
                ),
              ),

            const SizedBox(height: 24),

            // Fala completa
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.veryLightGrey,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                quote.fullLine,
                style: TextStyles.label.copyWith(
                  color: AppColors.borderColor,
                  fontSize: 18,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Informações do filme
            _buildInfoCard(
              icon: Icons.movie,
              label: 'Filme',
              value: quote.movie,
            ),

            const SizedBox(height: 12),

            _buildInfoCard(
              icon: Icons.person,
              label: 'Personagem',
              value: quote.character,
            ),

            const SizedBox(height: 12),

            _buildInfoCard(
              icon: Icons.calendar_today,
              label: 'Ano',
              value: quote.year.toString(),
            ),

            const SizedBox(height: 12),

            _buildInfoCard(
              icon: Icons.person_outline,
              label: 'Diretor',
              value: quote.director,
            ),

            const SizedBox(height: 12),

            _buildInfoCard(
              icon: Icons.access_time,
              label: 'Duração do Filme',
              value: quote.movieDuration,
            ),

            const SizedBox(height: 12),

            _buildInfoCard(
              icon: Icons.timelapse,
              label: 'Timestamp',
              value: quote.timestamp,
            ),

            const SizedBox(height: 12),

            _buildInfoCard(
              icon: Icons.numbers,
              label: 'Whoa #',
              value:
                  '${quote.currentWhoaInMovie} de ${quote.totalWhoasInMovie}',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.veryLightGrey,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.backgroundLight, size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyles.label.copyWith(
                    color: AppColors.grey,
                    fontSize: 11,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: TextStyles.label.copyWith(
                    color: AppColors.borderColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
