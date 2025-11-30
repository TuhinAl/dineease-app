import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../config/app_theme.dart';
import '../../models/overview_dto.dart';
import '../../widgets/custom_card.dart';
import '../../widgets/loading_indicator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TodayOverview? _overview;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() => _isLoading = true);

    // Simulate API call with mock data
    await Future.delayed(const Duration(seconds: 1));

    if (mounted) {
      setState(() {
        _overview = TodayOverview.mock();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: _isLoading
                  ? const LoadingIndicator(
                      message: 'Loading today\'s overview...',
                    )
                  : RefreshIndicator(
                      onRefresh: _loadData,
                      child: SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        padding: const EdgeInsets.all(AppSpacing.spacingMedium),
                        child: Column(
                          children: [
                            _buildUserMealCard(),
                            const SizedBox(height: 16),
                            _buildMessTotalCard(),
                          ],
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.spacingLarge),
      decoration: const BoxDecoration(
        color: AppTheme.appBarColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(AppSpacing.radiusXLarge),
          bottomRight: Radius.circular(AppSpacing.radiusXLarge),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.restaurant, color: Colors.white, size: 32),
              const SizedBox(width: 12),
              const Expanded(
                child: Text(
                  'Today Mess Overview',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.refresh, color: Colors.white),
                onPressed: _loadData,
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            DateFormat('EEEE, dd MMMM yyyy').format(DateTime.now()),
            style: AppTextStyles.bodyMedium.copyWith(color: Colors.white70),
          ),
        ],
      ),
    );
  }

  Widget _buildUserMealCard() {
    if (_overview == null) return const SizedBox.shrink();

    final breakfast = _overview!.breakfast ?? 0;
    final lunch = _overview!.lunch ?? 0;
    final dinner = _overview!.dinner ?? 0;
    final total = breakfast + lunch + dinner;

    return CustomCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: AppTheme.primaryColor.withOpacity(0.1),
                child: const Icon(
                  Icons.restaurant,
                  color: AppTheme.primaryColor,
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Your Food', style: AppTextStyles.headingSmall),
                    Text(
                      'consumption for today',
                      style: AppTextStyles.bodySmall,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildMealItem(
            'Breakfast',
            breakfast,
            Icons.wb_sunny,
            AppTheme.breakfastColor,
          ),
          const SizedBox(height: 16),
          _buildMealItem(
            'Lunch',
            lunch,
            Icons.wb_sunny_outlined,
            AppTheme.lunchColor,
          ),
          const SizedBox(height: 16),
          _buildMealItem(
            'Dinner',
            dinner,
            Icons.nights_stay,
            AppTheme.dinnerColor,
          ),
          const Divider(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Your Total Food for Today:',
                style: AppTextStyles.bodyLarge,
              ),
              Text(
                '$total',
                style: AppTextStyles.headingMedium.copyWith(
                  color: AppTheme.primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMealItem(String label, int count, IconData icon, Color color) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
          ),
          child: Icon(icon, color: color, size: 24),
        ),
        const SizedBox(width: 16),
        Expanded(child: Text(label, style: AppTextStyles.bodyLarge)),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(AppSpacing.radiusSmall),
          ),
          child: Text(
            '$count',
            style: AppTextStyles.headingSmall.copyWith(
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMessTotalCard() {
    if (_overview == null) return const SizedBox.shrink();

    final totalBreakfast = _overview!.totalBreakfast ?? 0;
    final totalLunch = _overview!.totalLunch ?? 0;
    final totalDinner = _overview!.totalDinner ?? 0;

    return CustomCard(
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppTheme.accentColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
                ),
                child: const Icon(Icons.analytics, color: AppTheme.accentColor),
              ),
              const SizedBox(width: 12),
              const Text('Mess Total Food', style: AppTextStyles.headingSmall),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildTotalCard(
                'Breakfast',
                totalBreakfast,
                Icons.wb_sunny,
                AppTheme.breakfastColor,
              ),
              _buildTotalCard(
                'Lunch',
                totalLunch,
                Icons.wb_sunny_outlined,
                AppTheme.lunchColor,
              ),
              _buildTotalCard(
                'Dinner',
                totalDinner,
                Icons.nights_stay,
                AppTheme.dinnerColor,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTotalCard(String label, int count, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(height: 8),
          Text(
            '$count',
            style: AppTextStyles.headingMedium.copyWith(
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(label, style: AppTextStyles.bodySmall.copyWith(color: color)),
        ],
      ),
    );
  }
}
