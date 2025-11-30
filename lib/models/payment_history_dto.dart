class DinePaymentHistoryDetailsDto {
  final String? id;
  final DateTime? paymentDateTime;
  final String? paidByName;
  final double? paymentAmount;

  DinePaymentHistoryDetailsDto({
    this.id,
    this.paymentDateTime,
    this.paidByName,
    this.paymentAmount,
  });

  factory DinePaymentHistoryDetailsDto.fromJson(Map<String, dynamic> json) {
    return DinePaymentHistoryDetailsDto(
      id: json['id'],
      paymentDateTime: json['paymentDateTime'] != null
          ? DateTime.parse(json['paymentDateTime'])
          : null,
      paidByName: json['paidByName'],
      paymentAmount: json['paymentAmount']?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'paymentDateTime': paymentDateTime?.toIso8601String(),
      'paidByName': paidByName,
      'paymentAmount': paymentAmount,
    };
  }
}
