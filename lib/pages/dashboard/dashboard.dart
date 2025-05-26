// Tambahkan import ini di bagian atas file
import 'package:medilist/pages/stock/stock-in.dart';
import 'package:medilist/pages/stock/stock-out.dart';
import 'package:medilist/pages/produk/produk-page.dart';
import 'package:medilist/pages/supplier/supplier-page.dart';
import 'package:medilist/pages/report/report-page.dart';
import 'package:medilist/pages/history/history-page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SalesSummaryPage extends StatefulWidget {
  const SalesSummaryPage({Key? key}) : super(key: key);

  @override
  State<SalesSummaryPage> createState() => _SalesSummaryPageState();
}

class _SalesSummaryPageState extends State<SalesSummaryPage> {
  final List<Map<String, dynamic>> stockData = [
    {'medicine': "Paracetamol", 'stock': 20, 'expDate': "14/02/25"},
    {'medicine': "Dexametason", 'stock': 15, 'expDate': "20/02/25"},
  ];

  void _navigateTo(Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => page));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Changed from Colors.grey[200] to white
      appBar: AppBar(
        title: Image.asset(
          "assets/medilist2.png",
          width: 130,
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        actions: [
          Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () => Scaffold.of(context).openEndDrawer(),
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            ),
          ),
        ],
        automaticallyImplyLeading: false,
      ),
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
                                'Dashboard',
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
                      isActive: true,
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
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Bagian Sales Summary di atas container putih
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Sales Summary",
                    style: GoogleFonts.poppins(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 10, // Jarak horizontal antar card
                    runSpacing: 10, // Jarak vertikal antar baris
                    alignment: WrapAlignment.spaceBetween,
                    children: [
                      _summaryCard(
                        Icons.trending_up, // Icon grafik untuk Today's Sale
                        "Rp.2.577.500",
                        "Today's Sale",
                        const Color(0xFF2E7D32), // Hijau gelap
                        const Color(0xFFE8F5E9), // Hijau terang
                      ),
                      _summaryCard(
                        Icons
                            .calendar_month, // Icon kalender untuk Yearly Total
                        "Rp.30.460.600",
                        "Yearly Total Sales",
                        const Color(0xFF4527A0), // Ungu gelap
                        const Color(0xFFEDE7F6), // Ungu terang
                      ),
                      _summaryCard(
                        Icons.monetization_on, // Icon dollar untuk Net Income
                        "Rp.1.261.790",
                        "Net Income",
                        const Color(0xFFE65100), // Orange gelap
                        const Color(0xFFFFF3E0), // Orange terang
                      ),
                      _summaryCard(
                        Icons.shopping_basket, // Icon keranjang untuk Products
                        "343",
                        "Products",
                        const Color(0xFFC2185B), // Merah-pink gelap
                        const Color(0xFFFCE4EC), // Merah-pink terang
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            // Container putih dengan sudut melengkung untuk menu ke bawah
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20), // More rounded corners
                  topRight: Radius.circular(20),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.08),
                    blurRadius: 12,
                    spreadRadius: 1,
                    offset: const Offset(0, -4),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Menu Section
                  const SizedBox(height: 10),
                  Text(
                    "Menu",
                    style: GoogleFonts.poppins(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 15),
                  GridView.count(
                    shrinkWrap: true,
                    crossAxisCount: 3,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      _menuCard(
                          Icons.add_box_outlined,
                          'STOCK IN',
                          const Color(0xFF4AC7FF),
                          () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const StockInPage()))),
                      _menuCard(
                          Icons.outbox_outlined,
                          'STOCK OUT',
                          const Color(0xFF4CAF50),
                          () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const StockOutPage()))),
                      _menuCard(
                          Icons.inventory_2_outlined,
                          'PRODUCT',
                          const Color(0xFFFF9800),
                          () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const ProductPage()))),
                      _menuCard(
                          Icons.person_outline,
                          'SUPPLIER',
                          const Color(0xFF9C27B0),
                          () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const SupplierPage()))),
                      _menuCard(
                          Icons.receipt_long_outlined,
                          'REPORT',
                          const Color(0xFFE91E63),
                          () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const ReportPage()))),
                      _menuCard(
                          Icons.history_outlined,
                          'HISTORY',
                          const Color(0xFF607D8B),
                          () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const HistoryPage()))),
                    ],
                  ),

                  // Stock Report Section
                  const SizedBox(height: 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Stock Report",
                        style: GoogleFonts.poppins(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      TextButton.icon(
                        onPressed: () {
                          // Link to Report Page instead of dummy page
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const ReportPage()));
                        },
                        icon: const Icon(Icons.arrow_forward_ios,
                            size: 14, color: Color(0xFF4AC7FF)),
                        label: Text(
                          "View All",
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF4AC7FF),
                          ),
                        ),
                        style: TextButton.styleFrom(
                          backgroundColor:
                              const Color(0xFF4AC7FF).withOpacity(0.05),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  // Table Header
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 6.0),
                    child: Row(
                      children: [
                        // Medicine header
                        Expanded(
                          flex: 4,
                          child: Text(
                            "Medicine",
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[600],
                            ),
                          ),
                        ),

                        // Stock header - sama dengan posisi container stock di item
                        Expanded(
                          flex: 2,
                          child: Text(
                            "Stock",
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[600],
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),

                        // Expiration header
                        Expanded(
                          flex: 2,
                          child: Text(
                            "Expiration",
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[600],
                            ),
                            textAlign: TextAlign.end,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Stock Items
                  Column(
                    children: stockData.map((item) {
                      // Determine stock color based on quantity
                      Color statusColor = (item['stock'] > 10)
                          ? const Color(0xFF4CAF50) // Green if stock > 10
                          : (item['stock'] > 5)
                              ? const Color(
                                  0xFFFFA000) // Orange if 5 < stock <= 10
                              : const Color(0xFFE53935); // Red if stock <= 5

                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey.shade100),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.05),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 15),
                          child: Row(
                            children: [
                              // Medicine Icon & Name group
                              Expanded(
                                flex: 4,
                                child: Row(
                                  children: [
                                    // Medicine Icon
                                    Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF4AC7FF)
                                            .withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                          color: const Color(0xFF4AC7FF)
                                              .withOpacity(0.3),
                                          width: 1.5,
                                        ),
                                      ),
                                      child: const Center(
                                        child: Icon(
                                          Icons.medication,
                                          color: Color(0xFF4AC7FF),
                                          size: 20,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 12),

                                    // Medicine Name
                                    Expanded(
                                      child: Text(
                                        item['medicine'],
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              // Stock with colored indicator - align center in its space
                              Expanded(
                                flex: 2,
                                child: Center(
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: statusColor.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      "${item['stock']}",
                                      style: GoogleFonts.poppins(
                                        color: statusColor,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              // Expiration Date - align right
                              Expanded(
                                flex: 2,
                                child: Text(
                                  item['expDate'],
                                  style: GoogleFonts.poppins(
                                    color: Colors.grey[700],
                                    fontSize: 13,
                                  ),
                                  textAlign: TextAlign.right,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),

                  // Add More button
                  const SizedBox(height: 10),
                  Center(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        // Link to Report Page instead of dummy page
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const ReportPage()));
                      },
                      icon: const Icon(Icons.add, size: 16),
                      label: Text(
                        "View More Items",
                        style: GoogleFonts.poppins(
                            fontSize: 12, fontWeight: FontWeight.w500),
                      ),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: const Color(0xFF4AC7FF),
                        backgroundColor:
                            const Color(0xFF4AC7FF).withOpacity(0.05),
                        side: BorderSide(
                            color: const Color(0xFF4AC7FF).withOpacity(0.3)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                      ),
                    ),
                  ),

                  // Extra padding at bottom for better scrolling
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _summaryCard(IconData icon, String amount, String label,
      Color iconColor, Color bgColor) {
    // Tetapkan ukuran tetap untuk semua card
    final double cardWidth = (MediaQuery.of(context).size.width - 42) / 2;
    final double cardHeight = 90; // Tinggi tetap untuk semua card

    return Container(
      width: cardWidth,
      height: cardHeight, // Tetapkan tinggi tetap
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.white, bgColor.withOpacity(0.05)],
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Icon di dalam container lingkaran dengan warna
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: bgColor,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Icon(icon, color: iconColor, size: 20),
            ),
          ),
          const SizedBox(width: 10),
          // Jumlah dan label
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  amount,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  label,
                  style: GoogleFonts.poppins(
                    color: Colors.grey[600],
                    fontSize: 11,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _menuCard(
      IconData icon, String label, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.15),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
          border: Border.all(color: Colors.grey.shade100),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
                border: Border.all(color: color.withOpacity(0.2), width: 2),
              ),
              child:
                  Icon(icon, color: color, size: 28), // Slightly smaller icon
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: 11, // Slightly smaller text
                fontWeight: FontWeight.w600,
                color: Colors.black87,
                letterSpacing: 0.3, // Add letter spacing for better readability
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

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

class DummyPage extends StatelessWidget {
  final String title;

  const DummyPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Center(
        child: Text(
          '$title Page',
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
