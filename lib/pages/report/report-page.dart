import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:medilist/pages/stock/stock-in.dart';
import 'package:medilist/pages/stock/stock-out.dart';
import 'package:medilist/pages/produk/produk-page.dart';
import 'package:medilist/pages/supplier/supplier-page.dart';
import 'package:medilist/pages/history/history-page.dart';
import 'dart:math' show pi;

// Define PieChartPainter at file level scope
class PieChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    // Define sections of the pie chart
    final sections = [
      {'color': Colors.blue, 'percent': 0.62},
      {'color': Colors.orange, 'percent': 0.28},
      {'color': Colors.green, 'percent': 0.10},
    ];

    var startAngle = -pi / 2; // Start from top (270 degrees)

    for (var section in sections) {
      final sweepAngle = 2 * pi * (section['percent'] as double);
      final paint = Paint()
        ..color = section['color'] as Color
        ..style = PaintingStyle.fill;

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepAngle,
        true,
        paint,
      );

      // Add border
      final borderPaint = Paint()
        ..color = Colors.white
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1;

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepAngle,
        true,
        borderPaint,
      );

      startAngle += sweepAngle;
    }

    // Draw a center white circle for donut effect
    final centerPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    canvas.drawCircle(center, radius * 0.4, centerPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class ReportPage extends StatefulWidget {
  const ReportPage({super.key});

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  // Current selected date range
  DateTimeRange _dateRange = DateTimeRange(
    start: DateTime.now().subtract(const Duration(days: 7)),
    end: DateTime.now(),
  );

  // Sample data for charts
  final List<Map<String, dynamic>> _weeklyStockData = [
    {'day': 'Mon', 'in': 32, 'out': 24},
    {'day': 'Tue', 'in': 45, 'out': 27},
    {'day': 'Wed', 'in': 30, 'out': 35},
    {'day': 'Thu', 'in': 55, 'out': 42},
    {'day': 'Fri', 'in': 25, 'out': 30},
    {'day': 'Sat', 'in': 10, 'out': 15},
    {'day': 'Sun', 'in': 5, 'out': 8},
  ];

  final List<Map<String, dynamic>> _weeklySalesData = [
    {'day': 'Mon', 'sales': 12, 'intensity': 0.3},
    {'day': 'Tue', 'sales': 28, 'intensity': 0.7},
    {'day': 'Wed', 'sales': 35, 'intensity': 0.9},
    {'day': 'Thu', 'sales': 25, 'intensity': 0.6},
    {'day': 'Fri', 'sales': 30, 'intensity': 0.8},
    {'day': 'Sat', 'sales': 15, 'intensity': 0.4},
    {'day': 'Sun', 'sales': 5, 'intensity': 0.1},
  ];

  final List<Map<String, dynamic>> _supplierPerformanceData = [
    {
      'name': 'PT Kimia Farma',
      'early': 15,
      'onTime': 75,
      'late': 10,
      'color': const Color(0xFF4AC7FF),
    },
    {
      'name': 'CV Medika Utama',
      'early': 20,
      'onTime': 65,
      'late': 15,
      'color': const Color(0xFF4CAF50),
    },
    {
      'name': 'PT Kalbe Farma',
      'early': 10,
      'onTime': 60,
      'late': 30,
      'color': const Color(0xFFFF9800),
    },
    {
      'name': 'PT Indofarma Global',
      'early': 5,
      'onTime': 55,
      'late': 40,
      'color': const Color(0xFF9C27B0),
    },
    {
      'name': 'CV Sehat Sejahtera',
      'early': 8,
      'onTime': 62,
      'late': 30,
      'color': const Color(0xFFF44336),
    },
  ];

  // Method to show date picker
  Future<void> _selectDateRange() async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      initialDateRange: _dateRange,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF4AC7FF),
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
            dialogBackgroundColor: Colors.white,
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _dateRange) {
      setState(() {
        _dateRange = picked;
      });
    }
  }

  // Mock method for report download
  void _downloadPdfReport() {
    // Display a snackbar to confirm download started
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.download, color: Colors.white),
            const SizedBox(width: 12),
            Flexible(
              child: Text(
                'Report download started...',
                style: GoogleFonts.poppins(),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        margin: const EdgeInsets.all(10),
      ),
    );

    // Here would be the actual PDF generation and download logic
  }

  // Method untuk menampilkan dialog report details yang lebih bagus
  void _viewReportDetails(String reportType) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        child:
            ContentBox(reportType: reportType, onDownload: _downloadPdfReport),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        // Ubah leading menjadi null agar tidak ada icon back
        automaticallyImplyLeading: false,
        title: Text(
          'Reports',
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        actions: [
          IconButton(
            icon: const Icon(Icons.print),
            onPressed: _downloadPdfReport,
            tooltip: 'Print Reports',
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              setState(() {
                // Refresh data
              });
            },
            tooltip: 'Refresh Data',
          ),
          // Tambahkan drawer toggle
          Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () => Scaffold.of(context).openEndDrawer(),
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Page Header with summary info
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 0,
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header dan description section
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Analytics Dashboard',
                                style: GoogleFonts.poppins(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Overview of your inventory and sales performance',
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  color: Colors.grey[700],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    // Date range row - pindahkan ke bawah header
                    Container(
                      margin: const EdgeInsets.only(top: 16, bottom: 16),
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEDF7FF),
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.15),
                            spreadRadius: 0,
                            blurRadius: 5,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Date Range:',
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey[700],
                            ),
                          ),
                          InkWell(
                            onTap: _selectDateRange,
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.date_range,
                                  size: 16,
                                  color: Color(0xFF4AC7FF),
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  '${DateFormat('MMM dd').format(_dateRange.start)} - ${DateFormat('MMM dd').format(_dateRange.end)}',
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xFF4AC7FF),
                                  ),
                                ),
                                const SizedBox(width: 4),
                                const Icon(
                                  Icons.arrow_drop_down,
                                  size: 16,
                                  color: Color(0xFF4AC7FF),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Summary cards row - sudah benar tetap pakai Row
                    LayoutBuilder(
                      builder: (context, constraints) {
                        final availableWidth = constraints.maxWidth;
                        final cardWidth =
                            (availableWidth - 32) / 3; // 3 cards dengan spacing

                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: cardWidth,
                              child: _buildSummaryCard(
                                title: 'Total Stock',
                                value: '1,250',
                                icon: Icons.inventory,
                                color: Colors.blue,
                              ),
                            ),
                            SizedBox(
                              width: cardWidth,
                              child: _buildSummaryCard(
                                title: 'Total Sales',
                                value: '₹ 28.5K',
                                icon: Icons.attach_money,
                                color: Colors.green,
                              ),
                            ),
                            SizedBox(
                              width: cardWidth,
                              child: _buildSummaryCard(
                                title: 'Returns',
                                value: '32',
                                icon: Icons.assignment_return,
                                color: Colors.amber,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Weekly Stock Report
              Text(
                'Weekly Stock Report',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 0,
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Stock In vs Stock Out',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                        Row(
                          children: [
                            _legendItem('Stock In', Colors.blue),
                            const SizedBox(width: 16),
                            _legendItem('Stock Out', Colors.orange),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      height: 200,
                      child: BarChart(
                        BarChartData(
                          alignment: BarChartAlignment.spaceAround,
                          maxY: 60,
                          barTouchData: BarTouchData(
                            enabled: true,
                            touchCallback: (FlTouchEvent event,
                                BarTouchResponse? response) {
                              // Optional callback jika diperlukan
                            },
                            touchTooltipData: BarTouchTooltipData(
                              fitInsideHorizontally: true,
                              fitInsideVertically: true,
                              tooltipPadding: const EdgeInsets.all(8),
                              tooltipMargin: 8,
                              getTooltipItem: (
                                BarChartGroupData group,
                                int groupIndex,
                                BarChartRodData rod,
                                int rodIndex,
                              ) {
                                return BarTooltipItem(
                                  '${rod.toY.round()}',
                                  GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                );
                              },
                            ),
                          ),
                          titlesData: FlTitlesData(
                            show: true,
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                getTitlesWidget: (value, meta) {
                                  return Text(
                                    _weeklyStockData[value.toInt()]['day'],
                                    style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey[600],
                                    ),
                                  );
                                },
                                reservedSize: 30,
                              ),
                            ),
                            leftTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                getTitlesWidget: (value, meta) {
                                  return Text(
                                    value.toInt().toString(),
                                    style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey[600],
                                    ),
                                  );
                                },
                                reservedSize: 40,
                              ),
                            ),
                            rightTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                            topTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                          ),
                          borderData: FlBorderData(show: false),
                          gridData: FlGridData(show: false),
                          barGroups:
                              _weeklyStockData.asMap().entries.map((entry) {
                            final index = entry.key;
                            final data = entry.value;
                            return BarChartGroupData(
                              x: index,
                              barRods: [
                                BarChartRodData(
                                  toY: data['in'].toDouble(),
                                  color: Colors.blue,
                                  width: 15,
                                  borderRadius: BorderRadius.circular(4),
                                  backDrawRodData: BackgroundBarChartRodData(
                                    show: true,
                                    toY: 60,
                                    color: Colors.grey[200],
                                  ),
                                ),
                                BarChartRodData(
                                  toY: data['out'].toDouble(),
                                  color: Colors.orange,
                                  width: 15,
                                  borderRadius: BorderRadius.circular(4),
                                  backDrawRodData: BackgroundBarChartRodData(
                                    show: true,
                                    toY: 60,
                                    color: Colors.grey[200],
                                  ),
                                ),
                              ],
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Weekly Sales with Heat Map style
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Weekly Sales',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  OutlinedButton.icon(
                    onPressed: _selectDateRange,
                    icon: const Icon(
                      Icons.date_range,
                      size: 20,
                      color: Color(0xFF4AC7FF),
                    ),
                    label: Text(
                      'Select Date',
                      style: GoogleFonts.poppins(
                        color: Colors.grey[800],
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(
                        color: Color(0xFF4AC7FF),
                        width: 1,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 0,
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Sales Activity Heatmap',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Implementation of github-style contribution chart
                    LayoutBuilder(
                      builder: (context, constraints) {
                        return Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: _weeklySalesData.map((day) {
                                return Container(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  height: 40,
                                  child: Text(
                                    day['day'],
                                    style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      color: Colors.grey[700],
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                            const SizedBox(
                                width: 8), // Kurangi dari 16px menjadi 8px
                            Expanded(
                              child: Column(
                                children: _weeklySalesData.map((day) {
                                  return Container(
                                    margin:
                                        const EdgeInsets.symmetric(vertical: 8),
                                    height: 24,
                                    child: Row(
                                      children: List.generate(
                                        constraints.maxWidth > 300
                                            ? 24
                                            : 12, // Kurangi jumlah cell pada layar kecil
                                        (hourIndex) {
                                          final double intensity =
                                              day['intensity'] *
                                                  (1 - hourIndex % 8 * 0.1);
                                          return Expanded(
                                            child: Container(
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      horizontal:
                                                          1), // Kurangi margin
                                              decoration: BoxDecoration(
                                                color:
                                                    _getHeatMapColor(intensity),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        2), // Kurangi radius
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    // Legend for heat map
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'Less',
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(width: 8),
                        ...List.generate(4, (index) {
                          return Container(
                            margin: const EdgeInsets.symmetric(horizontal: 2),
                            width: 16,
                            height: 16,
                            decoration: BoxDecoration(
                              color: _getHeatMapColor(index / 3),
                              borderRadius: BorderRadius.circular(4),
                            ),
                          );
                        }),
                        const SizedBox(width: 8),
                        Text(
                          'More',
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Supplier Performance Report
              Text(
                'Supplier Performance Report (Top 5 Suppliers)',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 0,
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Delivery Performance',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                        Row(
                          children: [
                            _legendItem('Early', Colors.blue),
                            const SizedBox(width: 12),
                            _legendItem('On Time', Colors.green),
                            const SizedBox(width: 12),
                            _legendItem('Late', Colors.red),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      height: 380,
                      child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _supplierPerformanceData.length,
                        itemBuilder: (context, index) {
                          final supplier = _supplierPerformanceData[index];
                          final total = supplier['early'] +
                              supplier['onTime'] +
                              supplier['late'];

                          return Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 10,
                                      height: 10,
                                      decoration: BoxDecoration(
                                        color: supplier['color'],
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      supplier['name'],
                                      style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const Spacer(),
                                    Text(
                                      'Total: $total orders',
                                      style: GoogleFonts.poppins(
                                        fontSize: 13,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    // Early deliveries
                                    Expanded(
                                      flex: supplier['early'],
                                      child: Container(
                                        height: 12,
                                        decoration: const BoxDecoration(
                                          color: Colors.blue,
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(6),
                                            bottomLeft: Radius.circular(6),
                                          ),
                                        ),
                                      ),
                                    ),
                                    // On-time deliveries
                                    Expanded(
                                      flex: supplier['onTime'],
                                      child: Container(
                                        height: 12,
                                        color: Colors.green,
                                      ),
                                    ),
                                    // Late deliveries
                                    Expanded(
                                      flex: supplier['late'],
                                      child: Container(
                                        height: 12,
                                        decoration: const BoxDecoration(
                                          color: Colors.red,
                                          borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(6),
                                            bottomRight: Radius.circular(6),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    Text(
                                      'Early: ${supplier['early']}%',
                                      style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        color: Colors.blue,
                                      ),
                                    ),
                                    const Spacer(),
                                    Text(
                                      'On Time: ${supplier['onTime']}%',
                                      style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        color: Colors.green,
                                      ),
                                    ),
                                    const Spacer(),
                                    Text(
                                      'Late: ${supplier['late']}%',
                                      style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Monthly Report Download Section
              Text(
                'Available Reports',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 16),
              _buildReportCard(
                title: 'Reports for Last Month',
                description: 'from 01 Jul - 31 Jul',
                onDownload: _downloadPdfReport,
                onView: () => _viewReportDetails('Monthly'),
              ),
              const SizedBox(height: 12),
              _buildReportCard(
                title: 'Defect Rate Report',
                description: 'Product Defects & Supplier Origin',
                onDownload: _downloadPdfReport,
                onView: () => _viewReportDetails('Defect Rate'),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
      // Using endDrawer for right-side navigation as requested
      endDrawer: Drawer(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              // Enhanced header with gradient background
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 40, horizontal: 16),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFF4AC7FF), Color(0xFF2196F3)],
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        // Profile avatar with border
                        Container(
                          width: 70,
                          height: 70,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 3),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                spreadRadius: 1,
                                blurRadius: 8,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: ClipOval(
                            child: Image.asset(
                              'assets/medilist3.jpg',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        // Username and status
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'MediList',
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Report Analytics',
                                style: GoogleFonts.poppins(
                                  color: Colors.white.withOpacity(0.9),
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // New "Main Menu" section header
              Padding(
                padding: const EdgeInsets.only(left: 16, top: 16, bottom: 8),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'MAIN MENU',
                    style: GoogleFonts.poppins(
                      color: Colors.grey[600],
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 8),

              // Enhanced menu items
              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    _buildDrawerItem(
                      icon: Icons.dashboard_outlined,
                      text: 'Dashboard',
                      onTap: () =>
                          Navigator.pushReplacementNamed(context, 'dashboard'),
                    ),
                    _buildDrawerItem(
                      icon: Icons.add_box_outlined,
                      text: 'Stock In',
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const StockInPage()),
                      ),
                    ),
                    _buildDrawerItem(
                      icon: Icons.outbox_outlined,
                      text: 'Stock Out',
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const StockOutPage()),
                      ),
                    ),
                    _buildDrawerItem(
                      icon: Icons.inventory_2_outlined,
                      text: 'Products',
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const ProductPage()),
                      ),
                    ),
                    _buildDrawerItem(
                      icon: Icons.person_outline,
                      text: 'Suppliers',
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const SupplierPage()),
                      ),
                    ),
                    _buildDrawerItem(
                      icon: Icons.receipt_long_outlined,
                      text: 'Reports',
                      isActive: true,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const ReportPage()),
                      ),
                    ),
                    _buildDrawerItem(
                      icon: Icons.history_outlined,
                      text: 'History',
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const HistoryPage()),
                      ),
                    ),

                    const Divider(height: 40),

                    // Logout at the bottom
                    _buildDrawerItem(
                      icon: Icons.logout,
                      text: 'Logout',
                      iconColor: const Color(0xFFE53935),
                      textColor: const Color(0xFFE53935),
                      onTap: () =>
                          Navigator.pushReplacementNamed(context, 'login'),
                    ),
                  ],
                ),
              ),

              // App version at bottom
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  'App Version 1.0.0',
                  style: GoogleFonts.poppins(
                    color: Colors.grey[500],
                    fontSize: 12,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper widgets
  Widget _buildSummaryCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
    double? width, // Tambahkan parameter width yang opsional
  }) {
    return Container(
      width: width, // Gunakan parameter width jika ada
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.2),
            spreadRadius: 0,
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: LayoutBuilder(builder: (context, constraints) {
        final isVerySmall = constraints.maxWidth < 80;

        if (isVerySmall) {
          // Layout sangat kecil - tampilkan sebagai kolom
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: color, size: 18),
              const SizedBox(height: 4),
              Text(
                title,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.poppins(
                  fontSize: 9,
                  color: Colors.grey[700],
                ),
              ),
              Text(
                value,
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          );
        } else {
          // Layout normal - tampilkan sebagai row
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: color, size: 20),
              const SizedBox(width: 6),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(
                        fontSize: 10,
                        color: Colors.grey[700],
                      ),
                    ),
                    Text(
                      value,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        }
      }),
    );
  }

  Widget _legendItem(String label, Color color) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 12,
            color: Colors.grey[700],
          ),
        ),
      ],
    );
  }

  Color _getHeatMapColor(double intensity) {
    // Color scale from light to dark blue
    if (intensity <= 0.1) return Colors.grey[200]!;
    if (intensity <= 0.3) return const Color(0xFFD0E8FF);
    if (intensity <= 0.6) return const Color(0xFF88C6FF);
    if (intensity <= 0.8) return const Color(0xFF4AC7FF);
    return const Color(0xFF0088E0);
  }

  Widget _buildReportCard({
    required String title,
    required String description,
    required VoidCallback onDownload,
    required VoidCallback onView,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 0,
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF4AC7FF).withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.description,
              color: Color(0xFF4AC7FF),
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  description,
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),

          // Gunakan Row untuk tombol dengan width tetap
          Container(
            width: 145, // Tetapkan width container untuk tombol
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // View button
                Container(
                  width: 70, // Width tetap untuk tombol View
                  child: TextButton.icon(
                    onPressed: onView,
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 6),
                      alignment: Alignment.center,
                    ),
                    icon: const Icon(
                      Icons.visibility,
                      size: 16,
                      color: Color(0xFF4AC7FF),
                    ),
                    label: Text(
                      'View',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: Color(0xFF4AC7FF),
                      ),
                    ),
                  ),
                ),

                // PDF button
                Container(
                  width: 70, // Width tetap untuk tombol PDF
                  child: ElevatedButton.icon(
                    onPressed: onDownload,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 6),
                      backgroundColor: const Color(0xFF4AC7FF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      alignment: Alignment.center,
                    ),
                    icon: const Icon(
                      Icons.download,
                      size: 16,
                      color: Colors.white,
                    ),
                    label: Text(
                      'PDF',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Add this method inside the _ReportPageState class
  Widget _buildDrawerItem({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
    bool isActive = false,
    Color iconColor = Colors.blue,
    Color textColor = Colors.black87,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: isActive
            ? const Color(0xFF4AC7FF).withOpacity(0.1)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: isActive ? const Color(0xFF4AC7FF) : iconColor,
          size: 22,
        ),
        title: Text(
          text,
          style: GoogleFonts.poppins(
            color: isActive ? const Color(0xFF4AC7FF) : textColor,
            fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
            fontSize: 14,
          ),
        ),
        onTap: onTap,
        dense: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}

// ContentBox widget moved outside of _ReportPageState to fix the error
class ContentBox extends StatelessWidget {
  final String reportType;
  final VoidCallback onDownload;

  const ContentBox({
    Key? key,
    required this.reportType,
    required this.onDownload,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 15,
            spreadRadius: 1,
            offset: const Offset(0.0, 10.0),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header dengan icon
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xFF4AC7FF).withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  reportType == 'Monthly'
                      ? Icons.calendar_month
                      : Icons.report_problem,
                  color: const Color(0xFF4AC7FF),
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$reportType Report Details',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      reportType == 'Monthly'
                          ? 'July 2023'
                          : 'Quality Control Report',
                      style: GoogleFonts.poppins(
                        color: Colors.grey[600],
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Divider
          Divider(color: Colors.grey[300], height: 1),
          const SizedBox(height: 20),

          // Report details section
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (reportType == 'Monthly')
                  _buildDetailItem(
                      'Period', '01 Jul - 31 Jul 2023', Icons.date_range),
                _buildDetailItem(
                    'Total Sales', '₹ 158,450', Icons.attach_money),
                _buildDetailItem(
                    'Orders Processed', '215', Icons.shopping_cart),
                _buildDetailItem(
                    'Top Product',
                    reportType == 'Monthly' ? 'Paracetamol 500mg' : 'N/A',
                    Icons.star),
                if (reportType == 'Defect Rate')
                  _buildDetailItem('Defect Rate', '3.2%', Icons.error_outline),
                if (reportType == 'Defect Rate')
                  _buildDetailItem(
                      'Top Issue', 'Packaging Damage', Icons.bug_report),
                if (reportType == 'Monthly')
                  _buildDetailItem(
                      'Growth', '+12.5% from last month', Icons.trending_up),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Chart visualization based on report type
          if (reportType == 'Monthly') _buildMiniChart(),
          if (reportType == 'Defect Rate') _buildDefectPieChart(),

          const SizedBox(height: 20),

          // Action buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                style: TextButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                ),
                child: Text(
                  'Close',
                  style: GoogleFonts.poppins(
                    color: Colors.grey[700],
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton.icon(
                onPressed: onDownload,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4AC7FF),
                  foregroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                icon: const Icon(Icons.download, size: 18),
                label: Text(
                  'Download PDF',
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Helper widget untuk item detail report
  Widget _buildDetailItem(String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFF4AC7FF).withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: const Color(0xFF4AC7FF),
              size: 16,
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: GoogleFonts.poppins(
                  color: Colors.grey[600],
                  fontSize: 12,
                ),
              ),
              Text(
                value,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Mini chart untuk monthly report
  Widget _buildMiniChart() {
    return Container(
      height: 120,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.15),
            spreadRadius: 0,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Bar chart column
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                // Sample data
                final data = [35.0, 42.0, 28.0, 15.0, 37.0, 43.0, 50.0];
                final maxData = data.reduce((a, b) => a > b ? a : b);
                final barWidth = constraints.maxWidth / data.length - 4;

                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: List.generate(
                    data.length,
                    (index) {
                      final height =
                          (data[index] / maxData) * constraints.maxHeight * 0.8;
                      return Container(
                        width: barWidth,
                        height: height,
                        decoration: BoxDecoration(
                          color: const Color(0xFF4AC7FF),
                          borderRadius: BorderRadius.circular(4),
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                              const Color(0xFF4AC7FF),
                              const Color(0xFF4AC7FF).withOpacity(0.6),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
          const SizedBox(width: 16),
          // Legend
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 10,
                    height: 10,
                    decoration: const BoxDecoration(
                      color: Color(0xFF4AC7FF),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    'Sales',
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                'Weekly Trend',
                style: GoogleFonts.poppins(
                  fontSize: 10,
                  color: Colors.grey[500],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Pie chart untuk defect rate report
  Widget _buildDefectPieChart() {
    return Container(
      height: 120,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.15),
            spreadRadius: 0,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Pie chart representation
          Container(
            width: 80,
            height: 80,
            child: CustomPaint(
              painter: PieChartPainter(), // Now this is accessible
            ),
          ),
          const SizedBox(width: 16),

          // Legend
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildPieLegendItem('Packaging', '62%', Colors.blue),
                const SizedBox(height: 8),
                _buildPieLegendItem('Expiry Date', '28%', Colors.orange),
                const SizedBox(height: 8),
                _buildPieLegendItem('Others', '10%', Colors.green),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPieLegendItem(String label, String value, Color color) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 12,
            color: Colors.grey[700],
          ),
        ),
        const Spacer(),
        Text(
          value,
          style: GoogleFonts.poppins(
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
