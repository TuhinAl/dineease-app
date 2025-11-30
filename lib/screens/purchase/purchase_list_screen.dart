import 'package:flutter/material.dart';
import '../../config/app_theme.dart';
import '../../widgets/empty_state.dart';
import '../../widgets/loading_indicator.dart';

class PurchaseListScreen extends StatefulWidget {
  const PurchaseListScreen({super.key});

  @override
  State<PurchaseListScreen> createState() => _PurchaseListScreenState();
}

class _PurchaseListScreenState extends State<PurchaseListScreen> {
  bool _isLoading = true;
  final List<Map<String, dynamic>> _purchases = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() => _isLoading = true);

    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));

    if (mounted) {
      setState(() {
        _isLoading = false;
        // Mock data would go here
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
                  ? const LoadingIndicator(message: 'Loading purchases...')
                  : _purchases.isEmpty
                  ? const EmptyState(
                      icon: Icons.shopping_cart_outlined,
                      message: 'No purchases yet',
                    )
                  : _buildPurchaseList(),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Navigate to purchase entry
        },
        icon: const Icon(Icons.add),
        label: const Text('Add Purchase'),
        backgroundColor: AppTheme.primaryColor,
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
      child: Row(
        children: [
          const Icon(Icons.shopping_cart, color: Colors.white, size: 32),
          const SizedBox(width: 12),
          const Text(
            'Purchase History',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPurchaseList() {
    return ListView.builder(
      padding: const EdgeInsets.all(AppSpacing.spacingMedium),
      itemCount: _purchases.length,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: ListTile(
            title: Text('Purchase ${index + 1}'),
            subtitle: const Text('Details'),
          ),
        );
      },
    );
  }
}
