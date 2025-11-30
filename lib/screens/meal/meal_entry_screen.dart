import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import '../../models/meal/meal_history_details_dto.dart';
import '../../models/meal/meal_history_details_search_dto.dart';
import '../../models/enums/meal_status_enum.dart';
import '../../services/meal_service.dart';
import '../../services/storage_service.dart';

class MealEntryScreen extends StatefulWidget {
  const MealEntryScreen({super.key});

  @override
  State<MealEntryScreen> createState() => _MealEntryScreenState();
}

class _MealEntryScreenState extends State<MealEntryScreen> {
  final _formKey = GlobalKey<FormState>();
  final _breakfastController = TextEditingController(text: '1');
  final _lunchController = TextEditingController(text: '1');
  final _dinnerController = TextEditingController(text: '1');

  final MealService _mealService = MealService();
  final StorageService _storageService = StorageService();

  DateTime _selectedDate = DateTime.now();
  late DateTime _minDate;
  late DateTime _maxDate;

  bool _isLoading = false;
  bool _isUpdateMode = false;
  String? _currentMealId;

  // User context
  String? _phoneNumber;
  String? _dineId;
  String? _memberId;

  // Table data
  List<MealHistoryDetailsDto> _mealHistory = [];
  int _currentPage = 1;
  final int _pageSize = 5;
  int _totalItems = 0;
  int _totalPages = 0;

  String? _validationError;

  @override
  void initState() {
    super.initState();
    _initializeDates();
    _loadUserContext();
    _searchMeals();
  }

  void _initializeDates() {
    final now = DateTime.now();
    _minDate = now;
    _maxDate = DateTime(
      now.year,
      now.month + 1,
      0,
    ); // Last day of current month
  }

  Future<void> _loadUserContext() async {
    _phoneNumber = _storageService.getPhoneNumber();
    _dineId = _storageService.getDineId();
    _memberId = _storageService.getUserId();
  }

  @override
  void dispose() {
    _breakfastController.dispose();
    _lunchController.dispose();
    _dinnerController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    if (_isUpdateMode) return;

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: _minDate,
      lastDate: _maxDate,
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  bool _validateForm() {
    setState(() => _validationError = null);

    final breakfast = int.tryParse(_breakfastController.text) ?? 0;
    final lunch = int.tryParse(_lunchController.text) ?? 0;
    final dinner = int.tryParse(_dinnerController.text) ?? 0;

    // Check if all are zero
    if (breakfast == 0 && lunch == 0 && dinner == 0) {
      setState(() => _validationError = 'Please enter at least one meal count');
      return false;
    }

    // Check range for each
    if (breakfast < 0 ||
        breakfast > 9 ||
        lunch < 0 ||
        lunch > 9 ||
        dinner < 0 ||
        dinner > 9) {
      setState(() => _validationError = 'Value between 0 and 9');
      return false;
    }

    return _formKey.currentState?.validate() ?? false;
  }

  Future<void> _handleSave() async {
    if (!_validateForm()) return;

    if (_phoneNumber == null || _dineId == null || _memberId == null) {
      _showErrorToast('User context not found. Please login again.');
      return;
    }

    setState(() => _isLoading = true);

    final breakfast = int.parse(_breakfastController.text);
    final lunch = int.parse(_lunchController.text);
    final dinner = int.parse(_dinnerController.text);
    final total = breakfast + lunch + dinner;

    // Format date as YYYY-MM-DD HH:mm:ss
    final formattedDate = DateFormat(
      'yyyy-MM-dd HH:mm:ss',
    ).format(_selectedDate);

    final mealDto = MealHistoryDetailsDto(
      mealDateTime: formattedDate,
      breakfastMealNumber: breakfast,
      lunchMealNumber: lunch,
      dinnerMealNumber: dinner,
      totalMealNumber: total,
      isApprovedByManager: false,
      enabled: true,
      dineInfoDto: {'id': _dineId},
      memberInfoDto: {'id': _memberId, 'phoneNumber': _phoneNumber},
    );

    final response = await _mealService.createMeal(mealDto);

    setState(() => _isLoading = false);

    if (response.isSuccess) {
      _showSuccessToast('Meal entry saved successfully!');
      _resetForm();
      _searchMeals();
    } else {
      _showErrorToast(response.message ?? 'Failed to save meal entry');
    }
  }

  Future<void> _handleUpdate() async {
    if (!_validateForm()) return;

    if (_phoneNumber == null ||
        _dineId == null ||
        _memberId == null ||
        _currentMealId == null) {
      _showErrorToast('User context not found. Please login again.');
      return;
    }

    setState(() => _isLoading = true);

    final breakfast = int.parse(_breakfastController.text);
    final lunch = int.parse(_lunchController.text);
    final dinner = int.parse(_dinnerController.text);
    final total = breakfast + lunch + dinner;

    final formattedDate = DateFormat(
      'yyyy-MM-dd HH:mm:ss',
    ).format(_selectedDate);

    final mealDto = MealHistoryDetailsDto(
      id: _currentMealId,
      mealDateTime: formattedDate,
      breakfastMealNumber: breakfast,
      lunchMealNumber: lunch,
      dinnerMealNumber: dinner,
      totalMealNumber: total,
      isApprovedByManager: false,
      enabled: true,
      dineInfoDto: {'id': _dineId},
      memberInfoDto: {'id': _memberId, 'phoneNumber': _phoneNumber},
    );

    final response = await _mealService.updateMeal(mealDto);

    setState(() => _isLoading = false);

    if (response.isSuccess) {
      _showSuccessToast('Meal entry updated successfully!');
      _resetForm();
      _searchMeals();
    } else {
      _showErrorToast(response.message ?? 'Failed to update meal entry');
    }
  }

  Future<void> _handleDelete(String mealId, String mealDate) async {
    final confirmed = await _showDeleteConfirmation(mealDate);
    if (!confirmed) return;

    if (_dineId == null || _memberId == null) {
      _showErrorToast('User context not found.');
      return;
    }

    setState(() => _isLoading = true);

    final response = await _mealService.deleteMeal(
      id: mealId,
      dineId: _dineId!,
      memberId: _memberId!,
    );

    setState(() => _isLoading = false);

    if (response.isSuccess) {
      _showSuccessToast('Meal entry deleted successfully!');
      _searchMeals();
    } else {
      _showErrorToast(response.message ?? 'Failed to delete meal entry');
    }
  }

  Future<bool> _showDeleteConfirmation(String date) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.delete_forever, color: Colors.red),
            SizedBox(width: 8),
            Text('Delete Meal Entry'),
          ],
        ),
        content: Text(
          'Are you sure you want to delete the meal entry for $date? This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Yes, Delete'),
          ),
        ],
      ),
    );
    return result ?? false;
  }

  void _editMeal(MealHistoryDetailsDto meal) {
    setState(() {
      _isUpdateMode = true;
      _currentMealId = meal.id;
      _breakfastController.text = meal.breakfastMealNumber?.toString() ?? '1';
      _lunchController.text = meal.lunchMealNumber?.toString() ?? '1';
      _dinnerController.text = meal.dinnerMealNumber?.toString() ?? '1';

      if (meal.mealDateTime != null) {
        try {
          _selectedDate = DateFormat(
            'yyyy-MM-dd HH:mm:ss',
          ).parse(meal.mealDateTime!);
        } catch (_) {
          _selectedDate = DateTime.now();
        }
      }
    });
  }

  void _resetForm() {
    setState(() {
      _breakfastController.text = '1';
      _lunchController.text = '1';
      _dinnerController.text = '1';
      _selectedDate = DateTime.now();
      _isUpdateMode = false;
      _currentMealId = null;
      _validationError = null;
    });
  }

  Future<void> _searchMeals({int? page}) async {
    if (_dineId == null) return;

    setState(() => _isLoading = true);

    final searchPage = page ?? 0; // Backend uses zero-based

    // Calculate date range: today + next 6 days
    final now = DateTime.now();
    final startDate = DateTime(now.year, now.month, now.day, 0, 0, 0);
    final endDate = startDate.add(
      const Duration(days: 6, hours: 23, minutes: 59, seconds: 59),
    );

    final searchDto = MealHistoryDetailsSearchDto(
      dineInfoId: _dineId,
      page: searchPage,
      size: _pageSize,
      mealStatusEnumKeyList: ['PENDING', 'APPROVED'],
      mealDateTimeFrom: DateFormat('yyyy-MM-dd HH:mm:ss').format(startDate),
      mealDateTimeTo: DateFormat('yyyy-MM-dd HH:mm:ss').format(endDate),
    );

    final response = await _mealService.searchPersonalMeals(searchDto);

    setState(() => _isLoading = false);

    if (response.isSuccess && response.data != null) {
      setState(() {
        _mealHistory = response.data!.content;
        _totalItems = response.data!.totalElements;
        _totalPages = response.data!.totalPages;
        _currentPage = searchPage + 1; // Display as one-based
      });
    } else if (!response.isSuccess) {
      _showErrorToast(response.message ?? 'Failed to load meal history');
    }
  }

  void _goToNextPage() {
    if (_currentPage < _totalPages) {
      _searchMeals(
        page: _currentPage,
      ); // currentPage is already one-based, backend needs zero-based
    }
  }

  void _goToPreviousPage() {
    if (_currentPage > 1) {
      _searchMeals(page: _currentPage - 2); // Convert to zero-based
    }
  }

  void _showSuccessToast(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.white),
            const SizedBox(width: 8),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  void _showErrorToast(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.error, color: Colors.white),
            const SizedBox(width: 8),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 4),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 1200;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF667eea), Color(0xFF764ba2)],
          ),
        ),
        child: SafeArea(
          child: isDesktop ? _buildDesktopLayout() : _buildMobileLayout(),
        ),
      ),
    );
  }

  Widget _buildDesktopLayout() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left Panel - Meal Entry Form
          SizedBox(width: 400, child: _buildMealEntryForm()),
          const SizedBox(width: 24),
          // Right Panel - Meal History Table
          Expanded(child: _buildMealHistoryTable()),
        ],
      ),
    );
  }

  Widget _buildMobileLayout() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          _buildMealEntryForm(),
          const SizedBox(height: 24),
          _buildMealHistoryTable(),
        ],
      ),
    );
  }

  Widget _buildMealEntryForm() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.95),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF667eea), Color(0xFF764ba2)],
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.restaurant,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'Meal Entry',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2d3748),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Validation Error Message
              if (_validationError != null)
                Container(
                  padding: const EdgeInsets.all(12),
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.red.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Colors.red.withValues(alpha: 0.3),
                    ),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.error_outline,
                        color: Colors.red,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          _validationError!,
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

              // Date Picker
              InkWell(
                onTap: _isUpdateMode ? null : () => _selectDate(context),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: _isUpdateMode ? Colors.grey.shade100 : Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.event,
                        color: _isUpdateMode
                            ? Colors.grey
                            : const Color(0xFF667eea),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Meal Date',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade600,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              DateFormat('MMM dd, yyyy').format(_selectedDate),
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        _isUpdateMode ? Icons.lock : Icons.calendar_today,
                        size: 20,
                        color: _isUpdateMode
                            ? Colors.grey
                            : Colors.grey.shade600,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Meal Input Fields
              _buildMealInput(
                'Breakfast',
                _breakfastController,
                Icons.wb_sunny,
                const Color(0xFF3b82f6),
              ),
              const SizedBox(height: 16),
              _buildMealInput(
                'Lunch',
                _lunchController,
                Icons.wb_sunny,
                const Color(0xFFf97316),
              ),
              const SizedBox(height: 16),
              _buildMealInput(
                'Dinner',
                _dinnerController,
                Icons.nights_stay,
                const Color(0xFF7c3aed),
              ),
              const SizedBox(height: 24),

              // Action Buttons
              if (_isUpdateMode)
                _buildGradientButton('Update Meal Entry', Icons.update, const [
                  Color(0xFFf59e0b),
                  Color(0xFFd97706),
                ], _isLoading ? null : _handleUpdate)
              else
                _buildGradientButton('Save Meal Entry', Icons.save, const [
                  Color(0xFF10b981),
                  Color(0xFF059669),
                ], _isLoading ? null : _handleSave),
              const SizedBox(height: 12),
              _buildOutlineButton(
                'Reset',
                Icons.restart_alt,
                _isLoading ? null : _resetForm,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMealInput(
    String label,
    TextEditingController controller,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade800,
              ),
            ),
          ),
          SizedBox(
            width: 80,
            child: TextFormField(
              controller: controller,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: color,
              ),
              decoration: InputDecoration(
                hintText: '0-9',
                hintStyle: TextStyle(color: Colors.grey.shade400),
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: color.withValues(alpha: 0.3)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: color, width: 2),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(1),
              ],
              validator: (value) {
                if (value == null || value.isEmpty) return null;
                final num = int.tryParse(value);
                if (num == null || num < 0 || num > 9) {
                  return 'Value between 0 and 9';
                }
                return null;
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGradientButton(
    String label,
    IconData icon,
    List<Color> colors,
    VoidCallback? onPressed,
  ) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 4,
        ),
        child: Ink(
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: colors),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Container(
            alignment: Alignment.center,
            child: _isLoading && onPressed != null
                ? const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      strokeWidth: 2,
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(icon, color: Colors.white),
                      const SizedBox(width: 8),
                      Text(
                        label,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  Widget _buildOutlineButton(
    String label,
    IconData icon,
    VoidCallback? onPressed,
  ) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: Color(0xFF667eea), width: 2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: const Color(0xFF667eea)),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFF667eea),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMealHistoryTable() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.95),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF667eea), Color(0xFF764ba2)],
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.history,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 12),
                const Text(
                  'Meal History',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2d3748),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Table
            if (_isLoading && _mealHistory.isEmpty)
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(60.0),
                  child: CircularProgressIndicator(),
                ),
              )
            else if (_mealHistory.isEmpty)
              _buildEmptyState()
            else
              _buildTable(),

            // Pagination
            if (_mealHistory.isNotEmpty) ...[
              const SizedBox(height: 16),
              _buildPagination(),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(60.0),
        child: Column(
          children: [
            Icon(Icons.restaurant_menu, size: 64, color: Colors.grey.shade400),
            const SizedBox(height: 16),
            Text(
              'No meal records found',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade700,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Start by adding your first meal entry',
              style: TextStyle(fontSize: 14, color: Colors.grey.shade500),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTable() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        headingRowColor: WidgetStateProperty.all(
          const Color(0xFF667eea).withValues(alpha: 0.1),
        ),
        columns: const [
          DataColumn(
            label: Row(
              children: [
                Icon(Icons.event, size: 16, color: Color(0xFF667eea)),
                SizedBox(width: 4),
                Text('Date', style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          DataColumn(
            label: Row(
              children: [
                Icon(Icons.person, size: 16, color: Color(0xFF667eea)),
                SizedBox(width: 4),
                Text('Member', style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          DataColumn(
            label: Row(
              children: [
                Icon(Icons.wb_sunny, size: 16, color: Color(0xFF3b82f6)),
                SizedBox(width: 4),
                Text(
                  'Breakfast',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          DataColumn(
            label: Row(
              children: [
                Icon(Icons.wb_sunny, size: 16, color: Color(0xFFf97316)),
                SizedBox(width: 4),
                Text('Lunch', style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          DataColumn(
            label: Row(
              children: [
                Icon(Icons.nights_stay, size: 16, color: Color(0xFF7c3aed)),
                SizedBox(width: 4),
                Text('Dinner', style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          DataColumn(
            label: Row(
              children: [
                Icon(Icons.functions, size: 16, color: Color(0xFF667eea)),
                SizedBox(width: 4),
                Text('Total', style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          DataColumn(
            label: Row(
              children: [
                Icon(
                  Icons.check_circle_outline,
                  size: 16,
                  color: Color(0xFF667eea),
                ),
                SizedBox(width: 4),
                Text('Status', style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          DataColumn(
            label: Text(
              'Actions',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
        rows: _mealHistory.map((meal) {
          final isPending = meal.mealStatusEnumKey == 'PENDING';
          final statusEnum = MealStatusEnum.fromKey(meal.mealStatusEnumKey);

          return DataRow(
            cells: [
              DataCell(
                Text(
                  meal.mealDateTime != null
                      ? DateFormat('MMM dd, yyyy').format(
                          DateFormat(
                            'yyyy-MM-dd HH:mm:ss',
                          ).parse(meal.mealDateTime!),
                        )
                      : '-',
                ),
              ),
              DataCell(Text(_getMemberName(meal))),
              DataCell(
                _buildMealBadge(
                  meal.breakfastMealNumber ?? 0,
                  const Color(0xFF3b82f6),
                ),
              ),
              DataCell(
                _buildMealBadge(
                  meal.lunchMealNumber ?? 0,
                  const Color(0xFFf97316),
                ),
              ),
              DataCell(
                _buildMealBadge(
                  meal.dinnerMealNumber ?? 0,
                  const Color(0xFF7c3aed),
                ),
              ),
              DataCell(_buildTotalBadge(meal.totalMealNumber ?? 0)),
              DataCell(_buildStatusBadge(statusEnum)),
              DataCell(
                isPending
                    ? Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.edit,
                              color: Color(0xFFf59e0b),
                              size: 20,
                            ),
                            onPressed: () => _editMeal(meal),
                            tooltip: 'Edit',
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                              size: 20,
                            ),
                            onPressed: () => _handleDelete(
                              meal.id!,
                              meal.mealDateTime ?? '',
                            ),
                            tooltip: 'Delete',
                          ),
                        ],
                      )
                    : const Icon(Icons.lock, color: Colors.grey, size: 20),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }

  String _getMemberName(MealHistoryDetailsDto meal) {
    if (meal.memberInfoDto != null && meal.memberInfoDto is Map) {
      final memberMap = meal.memberInfoDto as Map<String, dynamic>;
      return memberMap['fullName'] ??
          memberMap['name'] ??
          memberMap['phoneNumber'] ??
          '-';
    }
    return _storageService.getUserName() ?? _phoneNumber ?? '-';
  }

  Widget _buildMealBadge(int count, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Text(
        count.toString(),
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
    );
  }

  Widget _buildTotalBadge(int total) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF667eea), Color(0xFF764ba2)],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        total.toString(),
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
    );
  }

  Widget _buildStatusBadge(MealStatusEnum? status) {
    if (status == null) return const Text('-');

    Color color;
    switch (status) {
      case MealStatusEnum.PENDING:
        color = const Color(0xFFfbbf24);
        break;
      case MealStatusEnum.APPROVED:
        color = const Color(0xFF10b981);
        break;
      default:
        color = Colors.grey;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Text(
        status.value,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
      ),
    );
  }

  Widget _buildPagination() {
    final showingStart = _mealHistory.isEmpty
        ? 0
        : (_currentPage - 1) * _pageSize + 1;
    final showingEnd = _mealHistory.isEmpty
        ? 0
        : (_currentPage * _pageSize > _totalItems
              ? _totalItems
              : _currentPage * _pageSize);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Showing $showingStart - $showingEnd of $_totalItems entries',
          style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
        ),
        Row(
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back_ios, size: 16),
              onPressed: _currentPage > 1 ? _goToPreviousPage : null,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                '$_currentPage of $_totalPages',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.arrow_forward_ios, size: 16),
              onPressed: _currentPage < _totalPages ? _goToNextPage : null,
            ),
          ],
        ),
      ],
    );
  }
}
