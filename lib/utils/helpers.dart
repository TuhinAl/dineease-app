import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class DateTimeHelper {
  static String formatDate(DateTime? date) {
    if (date == null) return '';
    return DateFormat('dd/MM/yyyy').format(date);
  }

  static String formatDateTime(DateTime? date) {
    if (date == null) return '';
    return DateFormat('dd/MM/yyyy hh:mm a').format(date);
  }

  static String formatTime(DateTime? date) {
    if (date == null) return '';
    return DateFormat('hh:mm a').format(date);
  }

  static String formatMonthYear(DateTime? date) {
    if (date == null) return '';
    return DateFormat('MMMM yyyy').format(date);
  }

  static String formatDayMonth(DateTime? date) {
    if (date == null) return '';
    return DateFormat('dd MMM').format(date);
  }

  static String formatTimeDuration(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  static bool isToday(DateTime? date) {
    if (date == null) return false;
    final now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }

  static bool isSameDay(DateTime? date1, DateTime? date2) {
    if (date1 == null || date2 == null) return false;
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }
}

class CurrencyHelper {
  static String format(double? amount) {
    if (amount == null) return '৳ 0.00';
    return '৳ ${amount.toStringAsFixed(2)}';
  }

  static String formatCompact(double? amount) {
    if (amount == null) return '৳ 0';
    if (amount >= 1000) {
      return '৳ ${(amount / 1000).toStringAsFixed(1)}K';
    }
    return '৳ ${amount.toStringAsFixed(0)}';
  }
}

class ToastHelper {
  static void showToast(
    BuildContext context,
    String message, {
    Color? backgroundColor,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: backgroundColor,
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  static void showSuccess(BuildContext context, String message) {
    showToast(context, message, backgroundColor: Colors.green);
  }

  static void showError(BuildContext context, String message) {
    showToast(context, message, backgroundColor: Colors.red);
  }
}
