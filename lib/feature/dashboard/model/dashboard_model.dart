// Dashboard model classes
class DashboardResponse {
  final bool success;
  final String message;
  final DashboardData data;

  DashboardResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory DashboardResponse.fromJson(Map<String, dynamic> json) {
    return DashboardResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: DashboardData.fromJson(json['data'] ?? {}),
    );
  }
}

class DashboardData {
  final DashboardItem totalDoctor;
  final DashboardItem totalPharmacy;
  final DashboardItem totalHospital;
  final DashboardItem totalTips;
  final DashboardItem totalUser;
  final DashboardItem activePlan;

  DashboardData({
    required this.totalDoctor,
    required this.totalPharmacy,
    required this.totalHospital,
    required this.totalTips,
    required this.totalUser,
    required this.activePlan,
  });

  factory DashboardData.fromJson(Map<String, dynamic> json) {
    return DashboardData(
      totalDoctor: DashboardItem.fromJson(json['totalDoctor'] ?? {}),
      totalPharmacy: DashboardItem.fromJson(json['totalPharmacy'] ?? {}),
      totalHospital: DashboardItem.fromJson(json['totalHospital'] ?? {}),
      totalTips: DashboardItem.fromJson(json['totalTips'] ?? {}),
      totalUser: DashboardItem.fromJson(json['totalUser'] ?? {}),
      activePlan: DashboardItem.fromJson(json['activePlan'] ?? {}),
    );
  }
}

class DashboardItem {
  final int count;
  final double change;

  DashboardItem({required this.count, required this.change});

  factory DashboardItem.fromJson(Map<String, dynamic> json) {
    return DashboardItem(
      count: json['count'] ?? 0,
      change: (json['change'] ?? 0).toDouble(),
    );
  }

  // Helper method to check if change is positive
  bool get isPositive => change >= 0;

  // Helper method to get formatted percentage
  String get formattedChange => "${change.toStringAsFixed(0)}%";

  // Helper method to get formatted count
  String get formattedCount {
    if (count >= 1000) {
      return "${(count / 1000).toStringAsFixed(count % 1000 == 0 ? 0 : 1)}k";
    }
    return count.toString();
  }
}
