import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../config/app_theme.dart';
import '../../utils/validators.dart';
import '../../utils/helpers.dart';
import '../../widgets/loading_indicator.dart';

class PaymentEntryScreen extends StatefulWidget {
  const PaymentEntryScreen({super.key});

  @override
  State<PaymentEntryScreen> createState() => _PaymentEntryScreenState();
}

class _PaymentEntryScreenState extends State<PaymentEntryScreen> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _dateController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  bool _isLoading = false;
  final String _currentUserName = 'John Doe'; // Mock user

  @override
  void initState() {
    super.initState();
    _dateController.text = DateFormat('dd/MM/yyyy').format(_selectedDate);
  }

  @override
  void dispose() {
    _amountController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now().subtract(const Duration(days: 30)),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _dateController.text = DateFormat('dd/MM/yyyy').format(picked);
      });
    }
  }

  Future<void> _handleSubmit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() => _isLoading = true);

    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));

    if (mounted) {
      setState(() => _isLoading = false);

      ToastHelper.showSuccess(context, "Payment added successfully!");

      _amountController.clear();
      setState(() {
        _selectedDate = DateTime.now();
        _dateController.text = DateFormat('dd/MM/yyyy').format(_selectedDate);
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
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(AppSpacing.spacingMedium),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Date Picker
                      TextFormField(
                        controller: _dateController,
                        readOnly: true,
                        decoration: InputDecoration(
                          labelText: 'Payment Date',
                          prefixIcon: const Icon(Icons.event),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                              AppSpacing.radiusMedium,
                            ),
                          ),
                        ),
                        onTap: () => _selectDate(context),
                      ),
                      const SizedBox(height: 16),

                      // Payment By (Read-only)
                      TextFormField(
                        readOnly: true,
                        initialValue: _currentUserName,
                        decoration: InputDecoration(
                          labelText: 'Payment By',
                          prefixIcon: const Icon(Icons.person),
                          suffixIcon: const Icon(Icons.lock, size: 16),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                              AppSpacing.radiusMedium,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Payment Amount
                      TextFormField(
                        controller: _amountController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Payment Amount',
                          prefixIcon: const Icon(Icons.attach_money),
                          suffixText: 'BDT',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                              AppSpacing.radiusMedium,
                            ),
                          ),
                          hintText: 'Enter amount',
                        ),
                        validator: (value) => Validators.validateAmount(value),
                      ),
                      const SizedBox(height: 24),

                      // Submit Button
                      ElevatedButton(
                        onPressed: _isLoading ? null : _handleSubmit,
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              AppSpacing.radiusMedium,
                            ),
                          ),
                        ),
                        child: _isLoading
                            ? const SmallLoadingIndicator(color: Colors.white)
                            : const Text(
                                'Submit Payment',
                                style: AppTextStyles.buttonText,
                              ),
                      ),
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
      child: Row(
        children: [
          const Icon(Icons.payment, color: Colors.white, size: 32),
          const SizedBox(width: 12),
          const Text(
            'Payment Entry',
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
}
