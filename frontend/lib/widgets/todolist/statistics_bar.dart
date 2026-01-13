import 'package:flutter/material.dart';

class StatisticsBar extends StatelessWidget {
  final int totalCount;
  final int activeCount;
  final int completedCount;

  const StatisticsBar({
    super.key, // StatelessWidget 에 기본으로 존재하는 변수들 포함해서 사용!
    required this.totalCount,
    required this.activeCount,
    required this.completedCount,

  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,

        children: [
          StatCard(
            label: 'Total',
            count: totalCount.toString(),
            color: Colors.blue,
          ),
          StatCard(
            label: 'Active',
            count: activeCount.toString(),
            color: Colors.orange,
          ),
          StatCard(
            label: 'Done',
            count: completedCount.toString(),
            color: Colors.green,
          ),
        ],
      ),
    );
  }

// TODO: 구현
}

class StatCard extends StatelessWidget {
  final String label;
  final String count;
  final Color color;

  const StatCard({
    super.key, // StatelessWidget 에 기본으로 존재하는 변수들 포함해서 사용!
    required this.label,
    required this.count,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          count,
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[700],
          ),
        ),
      ],
    );
  }
}