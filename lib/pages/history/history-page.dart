import 'package:medilist/pages/stock/stock-in.dart';
import 'package:medilist/pages/stock/stock-out.dart';
import 'package:medilist/pages/produk/produk-page.dart';
import 'package:medilist/pages/supplier/supplier-page.dart';
import 'package:medilist/pages/report/report-page.dart';
import 'package:medilist/pages/dashboard/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String _selectedFilter = 'All';
  String _searchText = '';
  bool _showSearch = false;
  DateTime _selectedDate = DateTime.now();
  final TextEditingController _searchController = TextEditingController();

  // Add these declarations near the top of _HistoryPageState class
  DateTime? _startDate;
  DateTime? _endDate;
  String? _selectedStatus;

  // Sample transaction data
  final List<Map<String, dynamic>> _transactions = [
    {
      'id': 'TRX-001',
      'type': 'Stock In',
      'productName': 'Paracetamol 500mg',
      'quantity': 500,
      'date': DateTime.now().subtract(const Duration(hours: 2)),
      'supplier': 'PT Kimia Farma',
      'operator': 'John Doe',
      'status': 'Completed',
      'batchNo': 'BTC-2025-05',
      'expiry': DateTime.now().add(const Duration(days: 365)),
    },
    {
      'id': 'TRX-002',
      'type': 'Stock Out',
      'productName': 'Vitamin C 1000mg',
      'quantity': 200,
      'date': DateTime.now().subtract(const Duration(hours: 5)),
      'customer': 'Apotek Sehat',
      'operator': 'Jane Smith',
      'status': 'Completed',
      'batchNo': 'BTC-2025-04',
    },
    {
      'id': 'TRX-003',
      'type': 'Return',
      'productName': 'Amoxicillin 500mg',
      'quantity': 100,
      'date': DateTime.now().subtract(const Duration(days: 1)),
      'supplier': 'PT Indofarma',
      'reason': 'Expired Products',
      'operator': 'John Doe',
      'status': 'Processing',
    },
    {
      'id': 'TRX-004',
      'type': 'Stock In',
      'productName': 'Panadol Extra',
      'quantity': 300,
      'date': DateTime.now().subtract(const Duration(days: 2)),
      'supplier': 'CV Medika Utama',
      'operator': 'Jane Smith',
      'status': 'Completed',
      'batchNo': 'BTC-2025-03',
      'expiry': DateTime.now().add(const Duration(days: 730)),
    },
    {
      'id': 'TRX-005',
      'type': 'Stock Out',
      'productName': 'Simvastatin 10mg',
      'quantity': 150,
      'date': DateTime.now().subtract(const Duration(days: 2, hours: 4)),
      'customer': 'RS Medika',
      'operator': 'John Doe',
      'status': 'Completed',
      'batchNo': 'BTC-2025-02',
    },
    {
      'id': 'TRX-006',
      'type': 'Adjustment',
      'productName': 'Metformin 500mg',
      'quantity': -50,
      'date': DateTime.now().subtract(const Duration(days: 3)),
      'reason': 'Inventory Count',
      'operator': 'Jane Smith',
      'status': 'Completed',
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _showTransactionDetails(Map<String, dynamic> transaction) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: TransactionDetailCard(transaction: transaction),
      ),
    );
  }

  void _showDatePicker() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: const Color(0xFF4AC7FF),
            colorScheme: const ColorScheme.light(primary: Color(0xFF4AC7FF)),
            buttonTheme:
                const ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _selectStartDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _startDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: const Color(0xFF4AC7FF),
            colorScheme: const ColorScheme.light(primary: Color(0xFF4AC7FF)),
            buttonTheme:
                const ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        _startDate = picked;
        if (_endDate != null && _endDate!.isBefore(_startDate!)) {
          _endDate = _startDate!.add(const Duration(days: 1));
        }
      });
    }
  }

  void _selectEndDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _endDate ??
          (_startDate != null
              ? _startDate!.add(const Duration(days: 1))
              : DateTime.now()),
      firstDate: _startDate ?? DateTime(2020),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: const Color(0xFF4AC7FF),
            colorScheme: const ColorScheme.light(primary: Color(0xFF4AC7FF)),
            buttonTheme:
                const ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        _endDate = picked;
      });
    }
  }

  void _resetFilters() {
    setState(() {
      _selectedFilter = 'All';
      _searchController.clear();
      _startDate = null;
      _endDate = null;
      _selectedStatus = null;
    });
  }

  // Add this method to your _HistoryPageState class
  void _filterTransactions() {
    // This method is called when a status filter is selected
    // It triggers a state update to refresh the filtered transactions
    setState(() {
      // We don't need to do anything special here as the filtering logic
      // is already implemented in _buildListView() and _buildTimelineView()
      // This just forces those methods to rebuild with the new filter applied
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Image.asset(
          "assets/medilist2.png",
          width: 130,
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
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
      body: Column(
        children: [
          // Filter chips row
          Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(16),
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
                  'Filter Transactions',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 16),

                // Search field with enhanced shadow
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.15),
                        spreadRadius: 0,
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search by ID or product',
                      hintStyle: GoogleFonts.poppins(fontSize: 14),
                      prefixIcon: const Icon(Icons.search),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: EdgeInsets.zero,
                    ),
                    onChanged: (_) => setState(() {}),
                  ),
                ),

                const SizedBox(height: 16),

                // Status filters row
                Text(
                  'Status',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),

                // Add scrollable status filters with enhanced design
                SizedBox(
                  height: 40,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      _buildStatusFilterChip('All', const Color(0xFF4AC7FF)),
                      const SizedBox(width: 8),
                      _buildStatusFilterChip('In', Colors.green),
                      const SizedBox(width: 8),
                      _buildStatusFilterChip('Out', Colors.blue),
                      const SizedBox(width: 8),
                      _buildStatusFilterChip('Return', Colors.orange),
                      const SizedBox(width: 8),
                      _buildStatusFilterChip('Expired', Colors.red),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // Date range selection with enhanced design
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Start Date',
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 4),
                          InkWell(
                            onTap: _selectStartDate,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Colors.grey.shade300),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.1),
                                    spreadRadius: 0,
                                    blurRadius: 4,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    _startDate != null
                                        ? DateFormat('dd MMM yyyy')
                                            .format(_startDate!)
                                        : 'Select Date',
                                    style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      color: _startDate != null
                                          ? Colors.black
                                          : Colors.grey,
                                    ),
                                  ),
                                  Icon(
                                    Icons.calendar_today_outlined,
                                    size: 16,
                                    color: Colors.grey[600],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'End Date',
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 4),
                          InkWell(
                            onTap: _selectEndDate,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Colors.grey.shade300),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.1),
                                    spreadRadius: 0,
                                    blurRadius: 4,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    _endDate != null
                                        ? DateFormat('dd MMM yyyy')
                                            .format(_endDate!)
                                        : 'Select Date',
                                    style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      color: _endDate != null
                                          ? Colors.black
                                          : Colors.grey,
                                    ),
                                  ),
                                  Icon(
                                    Icons.calendar_today_outlined,
                                    size: 16,
                                    color: Colors.grey[600],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // Apply and Reset buttons with enhanced design
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          // Just update the state to apply filters without any navigation
                          setState(() {
                            // Filters are already captured in the state variables
                            // No need to do anything else
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF4AC7FF),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          elevation: 2,
                        ),
                        child: Text(
                          'Apply Filters',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    OutlinedButton(
                      onPressed: _resetFilters,
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Colors.grey.shade300),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'Reset',
                        style: GoogleFonts.poppins(
                          color: Colors.grey[700],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Transaction summary
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey.shade100),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Expanded(
                  child: _buildSummaryCard(
                    title: 'Today\'s In',
                    value: '500',
                    icon: Icons.add_circle,
                    iconColor: Colors.green,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildSummaryCard(
                    title: 'Today\'s Out',
                    value: '200',
                    icon: Icons.remove_circle,
                    iconColor: Colors.orangeAccent,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildSummaryCard(
                    title: 'Returns',
                    value: '100',
                    icon: Icons.replay,
                    iconColor: Colors.amber,
                  ),
                ),
              ],
            ),
          ),

          // Tab content
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // List View Tab
                _buildListView(),

                // Timeline Tab
                _buildTimelineView(),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showRecentActivityDialog,
        backgroundColor: const Color(0xFF4AC7FF),
        child: const Icon(Icons.insights_outlined, color: Colors.white),
        elevation: 4, // Increased elevation for better shadow
        tooltip: 'Activity Summary',
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
                                'Transaction History',
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
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const ReportPage()),
                      ),
                    ),
                    _buildDrawerItem(
                      icon: Icons.history_outlined,
                      text: 'History',
                      isActive: true,
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

  Widget _buildFilterChip(String label) {
    bool isSelected = _selectedFilter == label;
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: FilterChip(
        label: Text(
          label,
          style: GoogleFonts.poppins(
            color: isSelected ? Colors.white : Colors.grey[700],
            fontSize: 13,
          ),
        ),
        selected: isSelected,
        onSelected: (bool selected) {
          setState(() {
            _selectedFilter = selected ? label : 'All';
          });
        },
        backgroundColor: Colors.white,
        selectedColor: const Color(0xFF4AC7FF),
        checkmarkColor: Colors.white,
        elevation: 1,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      ),
    );
  }

  Widget _buildSummaryCard({
    required String title,
    required String value,
    required IconData icon,
    required Color iconColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: iconColor,
              size: 20,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  value,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListView() {
    // Filter transactions based on both type and status
    List<Map<String, dynamic>> filteredTransactions = _transactions
        .where((transaction) =>
            // Filter by transaction type
            (_selectedFilter == 'All' ||
                transaction['type'] == _selectedFilter) &&
            // Filter by status (if a status is selected)
            (_selectedStatus == null ||
                transaction['type'] ==
                    _selectedStatus) && // Changed from status to type
            // Filter by search text
            (transaction['productName']
                    .toString()
                    .toLowerCase()
                    .contains(_searchController.text.toLowerCase()) ||
                transaction['id']
                    .toString()
                    .toLowerCase()
                    .contains(_searchController.text.toLowerCase())))
        .toList();

    // Show empty state if no transactions found
    if (filteredTransactions.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.history, size: 70, color: Colors.grey[300]),
            const SizedBox(height: 16),
            Text(
              'No transactions found',
              style: GoogleFonts.poppins(
                fontSize: 16,
                color: Colors.grey[500],
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Try changing your filters',
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: Colors.grey[400],
              ),
            ),
          ],
        ),
      );
    }

    // Return the list of transactions
    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: filteredTransactions.length,
      itemBuilder: (context, index) {
        final transaction = filteredTransactions[index];
        final formattedDate =
            DateFormat('dd MMM, HH:mm').format(transaction['date']);
        final statusColor = _getStatusColor(transaction['status']);

        return Container(
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.18),
                  spreadRadius: 0,
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Dismissible(
              key: ValueKey(transaction['id']),
              background: Container(
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(12),
                ),
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: const Icon(
                  Icons.delete_outline,
                  color: Colors.white,
                  size: 26,
                ),
              ),
              direction: DismissDirection.endToStart,
              confirmDismiss: (_) async {
                _showTransactionDetails(transaction);
                return false;
              },
              child: ListTile(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: _getTypeColor(transaction['type'])
                                    .withOpacity(0.1),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                transaction['type'],
                                style: GoogleFonts.poppins(
                                  color: _getTypeColor(transaction['type']),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: statusColor.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                transaction['status'],
                                style: GoogleFonts.poppins(
                                  color: statusColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          formattedDate,
                          style: GoogleFonts.poppins(
                            color: Colors.grey[600],
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            _getTypeIcon(transaction['type']),
                            color: _getTypeColor(transaction['type']),
                            size: 24,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      transaction['productName'],
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 15,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Text(
                                    'Qty: ${transaction['quantity']}',
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      color: _getTypeColor(transaction['type']),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text(
                                transaction['supplier'] ??
                                    transaction['customer'] ??
                                    transaction['reason'] ??
                                    '',
                                style: GoogleFonts.poppins(
                                  color: Colors.grey[700],
                                  fontSize: 13,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 2),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    transaction['id'],
                                    style: GoogleFonts.poppins(
                                      color: Colors.grey[500],
                                      fontSize: 12,
                                    ),
                                  ),
                                  Text(
                                    'By: ${transaction['operator']}',
                                    style: GoogleFonts.poppins(
                                      color: Colors.grey[500],
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ));
      },
    );
  }

  Widget _buildTimelineView() {
    List<Map<String, dynamic>> filteredTransactions = _transactions
        .where((transaction) =>
            (_selectedFilter == 'All' ||
                transaction['type'] == _selectedFilter) &&
            (_selectedStatus == null ||
                transaction['type'] ==
                    _selectedStatus) && // Changed from status to type
            (transaction['productName']
                    .toString()
                    .toLowerCase()
                    .contains(_searchController.text.toLowerCase()) ||
                transaction['id']
                    .toString()
                    .toLowerCase()
                    .contains(_searchController.text.toLowerCase())))
        .toList();

    if (filteredTransactions.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.timeline, size: 70, color: Colors.grey[300]),
            const SizedBox(height: 16),
            Text(
              'No timeline data found',
              style: GoogleFonts.poppins(
                fontSize: 16,
                color: Colors.grey[500],
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: filteredTransactions.length,
      itemBuilder: (context, index) {
        final transaction = filteredTransactions[index];
        final isFirst = index == 0;
        final isLast = index == filteredTransactions.length - 1;
        final formattedDate =
            DateFormat('dd MMM, HH:mm').format(transaction['date']);

        return _buildTimelineItem(transaction, isFirst, isLast, formattedDate);
      },
    );
  }

  Widget _buildTimelineItem(Map<String, dynamic> transaction, bool isFirst,
      bool isLast, String formattedDate) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Timeline component
            SizedBox(
              width: 60,
              child: Column(
                children: [
                  // Top connector line
                  if (!isFirst)
                    Container(
                      width: 2,
                      height: 20,
                      color: Colors.grey[300],
                    ),

                  // Indicator dot
                  Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color:
                          _getTypeColor(transaction['type']).withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Icon(
                        _getTypeIcon(transaction['type']),
                        color: _getTypeColor(transaction['type']),
                        size: 16,
                      ),
                    ),
                  ),

                  // Bottom connector line
                  if (!isLast)
                    Expanded(
                      child: Container(
                        width: 2,
                        color: Colors.grey[300],
                      ),
                    ),
                ],
              ),
            ),

            // Content
            Expanded(
              child: Container(
                margin: EdgeInsets.only(top: isFirst ? 0 : 20),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 4,
                      offset: const Offset(0, 2),
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
                          transaction['type'],
                          style: GoogleFonts.poppins(
                            color: _getTypeColor(transaction['type']),
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          formattedDate,
                          style: GoogleFonts.poppins(
                            color: Colors.grey[500],
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      transaction['productName'],
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          transaction['supplier'] ??
                              transaction['customer'] ??
                              transaction['reason'] ??
                              '',
                          style: GoogleFonts.poppins(
                            color: Colors.grey[600],
                            fontSize: 13,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: _getTypeColor(transaction['type'])
                                .withOpacity(0.1),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            'Qty: ${transaction['quantity']}',
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              color: _getTypeColor(transaction['type']),
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'ID: ${transaction['id']}',
                          style: GoogleFonts.poppins(
                            color: Colors.grey[500],
                            fontSize: 12,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: _getStatusColor(transaction['status'])
                                .withOpacity(0.1),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            transaction['status'],
                            style: GoogleFonts.poppins(
                              color: _getStatusColor(transaction['status']),
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Align(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        onTap: () => _showTransactionDetails(transaction),
                        child: Text(
                          'View Details',
                          style: GoogleFonts.poppins(
                            color: const Color(0xFF4AC7FF),
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper methods for color and icon selection
  Color _getTypeColor(String type) {
    switch (type) {
      case 'Stock In':
        return Colors.green;
      case 'Stock Out':
        return Colors.blue;
      case 'Return':
        return Colors.orange;
      case 'Adjustment':
        return Colors.indigo;
      default:
        return const Color(0xFF4AC7FF);
    }
  }

  IconData _getTypeIcon(String type) {
    switch (type) {
      case 'Stock In':
        return Icons.add_box;
      case 'Stock Out':
        return Icons.remove_shopping_cart;
      case 'Return':
        return Icons.assignment_return;
      case 'Adjustment':
        return Icons.tune;
      default:
        return Icons.history;
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Completed':
        return Colors.green;
      case 'Processing':
        return Colors.orange;
      case 'Cancelled':
        return Colors.blue;
      case 'Pending':
        return const Color(0xFF4AC7FF);
      default:
        return Colors.grey;
    }
  }

  // Dialog methods
  void _showFilterDialog() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Filter Transactions',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Transaction Type',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[700],
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _buildFilterChip('All'),
                  _buildFilterChip('Stock In'),
                  _buildFilterChip('Stock Out'),
                  _buildFilterChip('Return'),
                  _buildFilterChip('Adjustment'),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                'Transaction Status',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[700],
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _buildStatusFilterChip('All', Colors.grey),
                  _buildStatusFilterChip('Completed', Colors.green),
                  _buildStatusFilterChip('Processing', Colors.orange),
                  _buildStatusFilterChip(
                      'Cancelled', Colors.blue), // Changed from red to blue
                  _buildStatusFilterChip('Pending', const Color(0xFF4AC7FF)),
                ],
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4AC7FF),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  // REPLACE onPressed: () => Navigator.pop(context),
                  // WITH:
                  onPressed: () {
                    // Just close the modal without navigating elsewhere
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Apply Filters',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Replace the _buildStatusFilterChip method with this corrected version
  Widget _buildStatusFilterChip(String label, Color color) {
    // Convert status names for matching
    String statusValue = label;
    if (label == "In") statusValue = "Stock In";
    if (label == "Out") statusValue = "Stock Out";

    final isSelected = (_selectedStatus == statusValue) ||
        (label == 'All' && _selectedStatus == null);

    return FilterChip(
      label: Text(
        label,
        style: GoogleFonts.poppins(
          color: isSelected ? Colors.white : color,
          fontSize: 13,
          fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
        ),
      ),
      selected: isSelected,
      onSelected: (bool selected) {
        setState(() {
          if (selected) {
            _selectedStatus = label == 'All' ? null : statusValue;
          } else {
            _selectedStatus = null;
          }
        });
      },
      backgroundColor: Colors.white,
      selectedColor: color,
      checkmarkColor: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      elevation: isSelected ? 2 : 0,
      shadowColor: color.withOpacity(0.3),
      side: BorderSide(
        color: isSelected ? Colors.transparent : color.withOpacity(0.5),
        width: 1,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
    );
  }

  void _showInfoDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Transaction History',
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'This page displays all your inventory transactions.',
              style: GoogleFonts.poppins(),
            ),
            const SizedBox(height: 16),
            Text(
              'Tips:',
              style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.swipe, size: 18, color: Color(0xFF4AC7FF)),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Swipe left on a transaction to see actions',
                    style: GoogleFonts.poppins(fontSize: 13),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.filter_list,
                    size: 18, color: Color(0xFF4AC7FF)),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Use filters to narrow down transactions',
                    style: GoogleFonts.poppins(fontSize: 13),
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Got it',
              style: GoogleFonts.poppins(
                color: const Color(0xFF4AC7FF),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }

  void _showPrintConfirmDialog(String id) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Print Transaction',
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
        content: Text(
          'Do you want to print transaction $id?',
          style: GoogleFonts.poppins(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: GoogleFonts.poppins(color: Colors.grey),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // Show success message
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Print job sent for transaction $id',
                    style: GoogleFonts.poppins(),
                  ),
                  backgroundColor: Colors.green,
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4AC7FF),
            ),
            child: Text(
              'Print',
              style: GoogleFonts.poppins(),
            ),
          ),
        ],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }

  void _showRecentActivityDialog() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: const Color(0xFF4AC7FF).withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.insights,
                      color: Color(0xFF4AC7FF),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Activity Summary',
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Last 7 days',
                          style: GoogleFonts.poppins(
                            color: Colors.grey[600],
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 200,
                child: _buildSimpleChart(),
              ),
              const SizedBox(height: 16),
              const Divider(),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildActivityStat(
                    label: 'Stock In',
                    value: '1,250',
                    icon: Icons.add_box,
                    color: Colors.green,
                  ),
                  _buildActivityStat(
                    label: 'Stock Out',
                    value: '950',
                    icon: Icons.remove_shopping_cart,
                    color: Colors.blue, // Changed from red to blue
                  ),
                  _buildActivityStat(
                    label: 'Returns',
                    value: '125',
                    icon: Icons.assignment_return,
                    color: Colors.orange,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Close',
                    style: GoogleFonts.poppins(
                      color: const Color(0xFF4AC7FF),
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActivityStat({
    required String label,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: color,
            size: 24,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        Text(
          label,
          style: GoogleFonts.poppins(
            color: Colors.grey[600],
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildSimpleChart() {
    // Sample data for chart
    final barData = [
      [55.0, 40.0], // [in, out]
      [65.0, 35.0],
      [50.0, 45.0],
      [75.0, 60.0],
      [40.0, 30.0],
      [80.0, 65.0],
      [60.0, 50.0],
    ];

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: List.generate(barData.length, (index) {
          final values = barData[index];
          final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

          return Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                width: 8,
                height: values[0],
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(4),
                    topRight: Radius.circular(4),
                  ),
                ),
              ),
              Container(
                width: 8,
                height: values[1],
                decoration: BoxDecoration(
                  color: Colors.blue, // Changed from red to blue
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(4),
                    bottomRight: Radius.circular(4),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                days[index],
                style: GoogleFonts.poppins(
                  color: Colors.grey[600],
                  fontSize: 12,
                ),
              ),
            ],
          );
        }),
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

// Transaction Detail Card Component
class TransactionDetailCard extends StatelessWidget {
  final Map<String, dynamic> transaction;

  const TransactionDetailCard({Key? key, required this.transaction})
      : super(key: key);

  Color _getTypeColor(String type) {
    switch (type.toLowerCase()) {
      case 'in':
      case 'stock in':
        return Colors.green;
      case 'out':
      case 'stock out':
        return Colors.blue;
      case 'return':
        return Colors.orange;
      case 'expired':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  IconData _getTypeIcon(String type) {
    switch (type.toLowerCase()) {
      case 'in':
      case 'stock in':
        return Icons.add_circle_outline;
      case 'out':
      case 'stock out':
        return Icons.remove_circle_outline;
      case 'return':
        return Icons.replay_circle_filled_outlined;
      case 'expired':
        return Icons.warning_amber_outlined;
      default:
        return Icons.circle_outlined;
    }
  }

  @override
  Widget build(BuildContext context) {
    final typeColor = _getTypeColor(transaction['type']);
    final typeIcon = _getTypeIcon(transaction['type']);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
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
          // Header with icon and status badge
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: typeColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: typeColor.withOpacity(0.15),
                      spreadRadius: 0,
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Icon(
                  typeIcon,
                  color: typeColor,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${transaction['type']} Details',
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      transaction['id'],
                      style: GoogleFonts.poppins(
                        color: Colors.grey[600],
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: typeColor.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: typeColor.withOpacity(0.1),
                      spreadRadius: 0,
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      typeIcon,
                      size: 14,
                      color: typeColor,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      transaction['type'],
                      style: GoogleFonts.poppins(
                        color: typeColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Divider
          Divider(color: Colors.grey[200], thickness: 1),

          const SizedBox(height: 16),

          // Transaction details in a grid layout
          Row(
            children: [
              _buildDetailItem(
                context: context,
                label: 'Date',
                value: DateFormat('dd MMM, yyyy').format(transaction['date']),
                icon: Icons.calendar_today_outlined,
              ),
              const SizedBox(width: 16),
              _buildDetailItem(
                context: context,
                label: 'Time',
                value: DateFormat('HH:mm').format(transaction['date']),
                icon: Icons.access_time,
              ),
            ],
          ),

          const SizedBox(height: 16),

          Row(
            children: [
              _buildDetailItem(
                context: context,
                label: 'Staff',
                value: transaction['operator'] ?? 'John Doe',
                icon: Icons.person_outline,
              ),
              const SizedBox(width: 16),
              _buildDetailItem(
                context: context,
                label: 'Product',
                value: transaction['productName'],
                icon: Icons.medication_outlined,
              ),
            ],
          ),

          const SizedBox(height: 16),

          Row(
            children: [
              _buildDetailItem(
                context: context,
                label: 'Quantity',
                value: transaction['quantity'].toString(),
                icon: Icons.inventory_2_outlined,
              ),
              const SizedBox(width: 16),
              _buildDetailItem(
                context: context,
                label: transaction['type'] == 'Stock In'
                    ? 'Source'
                    : 'Destination',
                value: transaction['supplier'] ??
                    transaction['customer'] ??
                    'Local',
                icon: transaction['type'] == 'Stock In'
                    ? Icons.store_outlined
                    : Icons.local_shipping_outlined,
              ),
            ],
          ),

          const SizedBox(height: 16),
          Divider(color: Colors.grey[200], thickness: 1),
          const SizedBox(height: 16),

          // Notes section
          Text(
            'Notes',
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey[200]!),
            ),
            child: Text(
              transaction['notes'] ??
                  'No additional notes for this transaction.',
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: Colors.grey[800],
              ),
            ),
          ),

          const SizedBox(height: 24),

          // Action buttons
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon:
                      Icon(Icons.arrow_back, size: 18, color: Colors.grey[700]),
                  label: Text(
                    'Back',
                    style: GoogleFonts.poppins(
                      color: Colors.grey[700],
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    side: BorderSide(color: Colors.grey[300]!),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    // Print functionality
                  },
                  icon: const Icon(Icons.print, size: 18),
                  label: const Text('Print'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4AC7FF),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDetailItem({
    required BuildContext context,
    required String label,
    required String value,
    required IconData icon,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.grey[50],
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey[200]!),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 0,
                    blurRadius: 3,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: Icon(
                icon,
                size: 16,
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: GoogleFonts.poppins(
                      color: Colors.grey[600],
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    value,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      fontSize: 13,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
