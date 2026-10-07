import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RewardsScreen extends StatelessWidget {
  const RewardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Rewards & Vouchers', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: colorScheme.onSurface),
          onPressed: () => context.pop(),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: colorScheme.secondaryContainer.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: colorScheme.secondaryContainer.withOpacity(0.5)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Available Points', style: theme.textTheme.titleMedium?.copyWith(color: colorScheme.onSurfaceVariant)),
                Text('2,450', style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold, color: colorScheme.secondaryContainer)),
              ],
            ),
          ),
          const SizedBox(height: 32),
          Text('Partner Offers', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          _buildVoucherCard('Hard Rock Cafe Melaka', '15% Off Total Bill', '500 Points', theme, colorScheme),
          const SizedBox(height: 16),
          _buildVoucherCard('Baba Nyonya Heritage Museum', 'Free Entry for 1', '800 Points', theme, colorScheme),
          const SizedBox(height: 16),
          _buildVoucherCard('Jonker Walk Night Market', 'Free Coconut Shake', '200 Points', theme, colorScheme),
        ],
      ),
    );
  }

  Widget _buildVoucherCard(String partner, String offer, String cost, ThemeData theme, ColorScheme colorScheme) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: colorScheme.outlineVariant.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.storefront, color: colorScheme.primary),
              const SizedBox(width: 8),
              Expanded(child: Text(partner, style: theme.textTheme.titleMedium?.copyWith(color: colorScheme.onSurfaceVariant))),
            ],
          ),
          const SizedBox(height: 12),
          Text(offer, style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, color: colorScheme.onSurface)),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(cost, style: theme.textTheme.titleMedium?.copyWith(color: colorScheme.secondaryContainer, fontWeight: FontWeight.bold)),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: colorScheme.primaryContainer,
                  foregroundColor: colorScheme.primary,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text('Redeem'),
              ),
            ],
          )
        ],
      ),
    );
  }
}
