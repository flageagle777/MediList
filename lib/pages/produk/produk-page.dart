import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medilist/pages/stock/stock-in.dart';
import 'package:medilist/pages/stock/stock-out.dart';
import 'package:medilist/pages/supplier/supplier-page.dart';
import 'package:medilist/pages/report/report-page.dart';
import 'package:medilist/pages/history/history-page.dart';
import 'dart:io';

class ProductPage extends StatefulWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage>
    with SingleTickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  bool _isGridView = true;
  String _selectedCategory = 'All';
  String _sortBy = 'Name';
  TabController? _tabController;

  // Dummy data untuk produk
  final List<Map<String, dynamic>> productList = [
    {
      'id': 'P001',
      'productName': 'Paracetamol',
      'quantity': 250,
      'category': 'Analgesic',
      'image': 'assets/produk/Paracetamol.jpg',
      'price': 15000,
      'description': 'Pain reliever and fever reducer',
      'supplier': 'PT Pharma Indonesia',
      'expiry': '2026-05-24',
      'lowStock': false,
      'nearExpiry': false,
    },
    {
      'id': 'P002',
      'productName': 'Amoxicillin',
      'quantity': 120,
      'category': 'Antibiotic',
      'image': 'assets/produk/amoxilin.jpg',
      'price': 25000,
      'description': 'Antibiotic medication used to treat bacterial infections',
      'supplier': 'PT Kimia Farma',
      'expiry': '2026-03-15',
      'lowStock': false,
      'nearExpiry': false,
    },
    {
      'id': 'P003',
      'productName': 'Omeprazole',
      'quantity': 15,
      'category': 'Gastric',
      'image': 'assets/produk/Omeprazole.jpg',
      'price': 35000,
      'description': 'Used to treat certain stomach and esophagus problems',
      'supplier': 'PT Sanbe Farma',
      'expiry': '2025-09-10',
      'lowStock': true,
      'nearExpiry': false,
    },
    {
      'id': 'P004',
      'productName': 'Loratadine',
      'quantity': 65,
      'category': 'Antihistamine',
      'image': 'assets/produk/loratadine.jpg',
      'price': 18000,
      'description':
          'Antihistamine that reduces the effects of natural histamine in the body',
      'supplier': 'CV Medika Jaya',
      'expiry': '2025-11-20',
      'lowStock': false,
      'nearExpiry': false,
    },
    {
      'id': 'P005',
      'productName': 'Vitamin C',
      'quantity': 80,
      'category': 'Vitamin',
      'image': 'assets/produk/vitaminc.jpeg',
      'price': 22000,
      'description': 'Vitamin C supplement',
      'supplier': 'PT Kimia Farma',
      'expiry': '2025-07-05',
      'lowStock': false,
      'nearExpiry': true,
    },
    {
      'id': 'P006',
      'productName': 'Ibuprofen',
      'quantity': 10,
      'category': 'Analgesic',
      'image': 'assets/produk/ibuprofen.png',
      'price': 17500,
      'description': 'Nonsteroidal anti-inflammatory drug',
      'supplier': 'PT Pharma Indonesia',
      'expiry': '2025-06-15',
      'lowStock': true,
      'nearExpiry': true,
    },
  ];

  // Daftar kategori yang tersedia
  final List<String> categories = [
    'All',
    'Analgesic',
    'Antibiotic',
    'Gastric',
    'Antihistamine',
    'Vitamin'
  ];

  // Opsi pengurutan
  final List<String> sortOptions = [
    'Name',
    'Price (Low-High)',
    'Price (High-Low)',
    'Stock (Low-High)',
    'Stock (High-Low)',
    'Expiry Date'
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController?.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Filter produk berdasarkan kategori dan pencarian
    List<Map<String, dynamic>> filteredProducts = productList.where((product) {
      bool matchesCategory = _selectedCategory == 'All' ||
          product['category'] == _selectedCategory;
      bool matchesSearch = product['productName']
          .toLowerCase()
          .contains(_searchController.text.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();

    // Sort produk
    filteredProducts.sort((a, b) {
      switch (_sortBy) {
        case 'Name':
          return a['productName'].compareTo(b['productName']);
        case 'Price (Low-High)':
          return a['price'].compareTo(b['price']);
        case 'Price (High-Low)':
          return b['price'].compareTo(a['price']);
        case 'Stock (Low-High)':
          return a['quantity'].compareTo(b['quantity']);
        case 'Stock (High-Low)':
          return b['quantity'].compareTo(a['quantity']);
        case 'Expiry Date':
          return a['expiry'].compareTo(b['expiry']);
        default:
          return a['productName'].compareTo(b['productName']);
      }
    });

    return Scaffold(
      backgroundColor: Colors.white, // Changed from grey[100] to white
      appBar: AppBar(
        title: Image.asset(
          "assets/medilist2.png",
          width: 130,
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0, // Remove shadow for a cleaner look
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
                                'Product Management',
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
                      icon: Icons.add_box_outlined, // Updated icon
                      text: 'Stock In',
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const StockInPage()),
                      ),
                    ),
                    _buildDrawerItem(
                      icon: Icons.outbox_outlined, // Updated icon
                      text: 'Stock Out',
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const StockOutPage()),
                      ),
                    ),
                    _buildDrawerItem(
                      icon: Icons.inventory_2_outlined, // Updated icon
                      text: 'Products',
                      isActive: true, // This is the active page
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const ProductPage()),
                      ),
                    ),
                    _buildDrawerItem(
                      icon: Icons.person_outline, // Updated icon
                      text: 'Suppliers',
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const SupplierPage()),
                      ),
                    ),
                    _buildDrawerItem(
                      icon: Icons.receipt_long_outlined, // Updated icon
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
      body: Column(
        children: [
          // Header dengan tab
          Container(
            color: Colors.white,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Products",
                        style: GoogleFonts.poppins(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      ElevatedButton.icon(
                        onPressed: () {
                          _showAddProductDialog(context);
                        },
                        icon: const Icon(Icons.add, color: Colors.white),
                        label: Text(
                          "Add Product",
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF4AC7FF),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Stats Cards
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      _buildStatCard(
                        title: 'Total Products',
                        value: productList.length.toString(),
                        icon: Icons.inventory_2,
                        color: Colors.blue,
                      ),
                      const SizedBox(width: 12),
                      _buildStatCard(
                        title: 'Low Stock',
                        value: productList
                            .where((p) => p['lowStock'] == true)
                            .length
                            .toString(),
                        icon: Icons.warning_amber,
                        color: Colors.orange,
                      ),
                      const SizedBox(width: 12),
                      _buildStatCard(
                        title: 'Near Expiry',
                        value: productList
                            .where((p) => p['nearExpiry'] == true)
                            .length
                            .toString(),
                        icon: Icons.event_busy,
                        color: Colors.red,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                // Tab Bar
                TabBar(
                  controller: _tabController,
                  labelColor: const Color(0xFF4AC7FF),
                  unselectedLabelColor: Colors.grey,
                  indicatorColor: const Color(0xFF4AC7FF),
                  tabs: [
                    Tab(text: 'All Products'),
                    Tab(text: 'Low Stock'),
                    Tab(text: 'Near Expiry'),
                  ],
                ),
              ],
            ),
          ),

          // Search & Filter
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.white, // Changed from Colors.grey[50] to white
            child: Column(
              children: [
                // Enhanced Search field with shadow
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
                      hintText: 'Search products...',
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

                const SizedBox(
                    height: 16), // Changed from 12 to 16 to add more space

                // Enhanced Filter Row
                Row(
                  children: [
                    // Category Filter with improved styling
                    Expanded(
                      child: Container(
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
                        child: DropdownButtonFormField<String>(
                          value: _selectedCategory,
                          decoration: InputDecoration(
                            labelText: 'Category',
                            labelStyle: GoogleFonts.poppins(fontSize: 14),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                          items: categories.map((String category) {
                            return DropdownMenuItem<String>(
                              value: category,
                              child: Text(
                                category,
                                style: GoogleFonts.poppins(fontSize: 14),
                              ),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              _selectedCategory = newValue!;
                            });
                          },
                        ),
                      ),
                    ),

                    const SizedBox(width: 8),

                    // Sort By Filter with improved styling
                    Expanded(
                      child: Container(
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
                        child: DropdownButtonFormField<String>(
                          value: _sortBy,
                          decoration: InputDecoration(
                            labelText: 'Sort By',
                            labelStyle: GoogleFonts.poppins(fontSize: 14),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                          items: sortOptions.map((String option) {
                            return DropdownMenuItem<String>(
                              value: option,
                              child: Text(
                                option,
                                style: GoogleFonts.poppins(fontSize: 14),
                              ),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              _sortBy = newValue!;
                            });
                          },
                        ),
                      ),
                    ),

                    const SizedBox(width: 8),

                    // Toggle View Button with improved styling
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
                      child: IconButton(
                        icon: Icon(
                          _isGridView ? Icons.list : Icons.grid_view,
                          color: const Color(0xFF4AC7FF),
                        ),
                        onPressed: () {
                          setState(() {
                            _isGridView = !_isGridView;
                          });
                        },
                        tooltip: _isGridView ? 'List View' : 'Grid View',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Product List (Grid or List view)
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // All Products Tab
                _buildProductList(filteredProducts),

                // Low Stock Tab
                _buildProductList(filteredProducts
                    .where((p) => p['lowStock'] == true)
                    .toList()),

                // Near Expiry Tab
                _buildProductList(filteredProducts
                    .where((p) => p['nearExpiry'] == true)
                    .toList()),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        // Changed to extended FAB
        onPressed: () {
          _scanBarcode(context);
        },
        backgroundColor: const Color(0xFF4AC7FF),
        icon: const Icon(Icons.qr_code_scanner, color: Colors.white),
        label: Text(
          'Scan',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
        elevation: 4,
        tooltip: 'Scan Barcode',
      ),
    );
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.withOpacity(0.2)),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                size: 18,
                color: color,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    value,
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductList(List<Map<String, dynamic>> products) {
    if (products.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.inventory_2_outlined,
                size: 64,
                color: Colors.grey[400],
              ),
            ),
            const SizedBox(height: 24),
            Text(
              "No products found",
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Try adjusting your search or filters",
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {
                setState(() {
                  _searchController.clear();
                  _selectedCategory = 'All';
                  _sortBy = 'Name';
                });
              },
              icon: const Icon(Icons.refresh),
              label: Text('Reset Filters', style: GoogleFonts.poppins()),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4AC7FF),
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        ),
      );
    }

    return _isGridView
        ? GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.75,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemCount: products.length,
            itemBuilder: (context, index) {
              return _buildProductCard(products[index]);
            },
          )
        : ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: products.length,
            itemBuilder: (context, index) {
              return _buildProductListItem(products[index]);
            },
          );
  }

  Widget _buildProductCard(Map<String, dynamic> product) {
    return InkWell(
      onTap: () => _showProductDetailDialog(context, product),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.15),
              spreadRadius: 0,
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product image with enhanced styling
            Stack(
              children: [
                Container(
                  height: 140,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(12)),
                  ),
                  child: ClipRRect(
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(12)),
                    child: Image.asset(
                      product['image'],
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey[100],
                          child: Icon(
                            Icons.medication,
                            size: 60,
                            color: Colors.grey[400],
                          ),
                        );
                      },
                    ),
                  ),
                ),

                // Add refined status badges with improved design
                if (product['lowStock'] || product['nearExpiry'])
                  Positioned(
                    top: 10,
                    left: 10,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: product['lowStock']
                            ? Colors.orange
                            : product['nearExpiry']
                                ? Colors.red
                                : Colors.transparent,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            product['lowStock']
                                ? Icons.error_outline
                                : Icons.event_busy,
                            color: Colors.white,
                            size: 14,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            product['lowStock']
                                ? 'Low Stock'
                                : product['nearExpiry']
                                    ? 'Near Expiry'
                                    : '',
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                // Add quick access buttons with improved styling
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Colors.black.withOpacity(0.7),
                          Colors.transparent,
                        ],
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(30),
                            onTap: () {
                              // Navigate to StockInPage with this product
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const StockInPage(),
                                  // You could pass the product here
                                ),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(
                                    Icons.add_circle_outline,
                                    color: Colors.white,
                                    size: 16,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    'Add Stock',
                                    style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 16,
                          width: 1,
                          color: Colors.white30,
                        ),
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(30),
                            onTap: () {
                              // Navigate to StockOutPage with this product
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const StockOutPage(),
                                  // You could pass the product here
                                ),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(
                                    Icons.remove_circle_outline,
                                    color: Colors.white,
                                    size: 16,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    'Remove Stock',
                                    style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500,
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
                ),
              ],
            ),

            // Product details with improved styling
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product['productName'],
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: const Color(0xFF4AC7FF).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                            color: const Color(0xFF4AC7FF).withOpacity(0.3),
                            width: 1,
                          ),
                        ),
                        child: Text(
                          product['category'],
                          style: GoogleFonts.poppins(
                            fontSize: 10,
                            color: const Color(0xFF4AC7FF),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const Spacer(),
                      // Supplier indicator
                      Text(
                        product['supplier'].split(' ').last,
                        style: GoogleFonts.poppins(
                          fontSize: 10,
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        'Rp ${product['price']}',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: const Color(0xFF4AC7FF),
                        ),
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: product['quantity'] <= 20
                              ? Colors.red.withOpacity(0.1)
                              : const Color(0xFF4CAF50).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                            color: product['quantity'] <= 20
                                ? Colors.red.withOpacity(0.3)
                                : const Color(0xFF4CAF50).withOpacity(0.3),
                            width: 1,
                          ),
                        ),
                        child: Text(
                          "Stock: ${product['quantity']}",
                          style: GoogleFonts.poppins(
                            color: product['quantity'] <= 20
                                ? Colors.red
                                : const Color(0xFF4CAF50),
                            fontWeight: FontWeight.w500,
                            fontSize: 11,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductListItem(Map<String, dynamic> product) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product image
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    product['image'],
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: 80,
                        height: 80,
                        color: Colors.grey[200],
                        child: Icon(
                          Icons.medication,
                          size: 40,
                          color: Colors.grey[400],
                        ),
                      );
                    },
                  ),
                ),
                // Status badges
                if (product['lowStock'] || product['nearExpiry'])
                  Positioned(
                    top: 0,
                    left: 0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: product['lowStock']
                            ? Colors.orange
                            : product['nearExpiry']
                                ? Colors.red
                                : Colors.transparent,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(8),
                          bottomRight: Radius.circular(8),
                        ),
                      ),
                      child: Text(
                        product['lowStock']
                            ? 'Low'
                            : product['nearExpiry']
                                ? 'Expiring'
                                : '',
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ),
              ],
            ),

            const SizedBox(width: 16),

            // Product details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product['productName'],
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    product['category'],
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    product['description'],
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        'Rp ${product['price'].toString()}',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: Colors.blue[700],
                        ),
                      ),
                      const SizedBox(width: 12),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: product['quantity'] <= 20
                              ? Colors.red.withOpacity(0.1)
                              : const Color(0xFF4CAF50).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          "Stock: ${product['quantity']}",
                          style: GoogleFonts.poppins(
                            color: product['quantity'] <= 20
                                ? Colors.red
                                : const Color(0xFF4CAF50),
                            fontWeight: FontWeight.w500,
                            fontSize: 11,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showAddProductDialog(BuildContext context) {
    final nameController = TextEditingController();
    final categoryController = TextEditingController();
    final stockController = TextEditingController();
    final priceController = TextEditingController();
    final descriptionController = TextEditingController();
    final supplierController = TextEditingController();
    final expiryController = TextEditingController();

    File? _selectedImageFile;

    Future<void> _pickImage() async {
      final ImagePicker _picker = ImagePicker();
      try {
        final XFile? pickedFile = await _picker.pickImage(
          source: ImageSource.gallery,
          imageQuality: 85,
        );

        if (pickedFile != null) {
          _selectedImageFile = File(pickedFile.path);
        }
      } catch (e) {
        print("Error picking image: $e");
      }
    }

    showDialog(
        context: context,
        builder: (context) => StatefulBuilder(
              builder: (context, setState) => Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                backgroundColor: Colors.white,
                child: Container(
                  width: double.maxFinite,
                  constraints: const BoxConstraints(maxWidth: 500),
                  color: Colors.white,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Enhanced header with icon
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color:
                                      const Color(0xFF4AC7FF).withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.blue.withOpacity(0.1),
                                      spreadRadius: 0,
                                      blurRadius: 6,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: const Icon(
                                  Icons.inventory_2,
                                  color: Color(0xFF4AC7FF),
                                  size: 24,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Text(
                                "Add New Product",
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
                          const Divider(),
                          const SizedBox(height: 16),

                          // Enhanced product image upload
                          Center(
                            child: GestureDetector(
                              onTap: () async {
                                await _pickImage();
                                setState(() {});
                              },
                              child: Stack(
                                children: [
                                  Container(
                                    width: 120,
                                    height: 120,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[100],
                                      borderRadius: BorderRadius.circular(12),
                                      border:
                                          Border.all(color: Colors.grey[300]!),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.15),
                                          spreadRadius: 1,
                                          blurRadius: 8,
                                          offset: const Offset(0, 3),
                                        ),
                                      ],
                                      image: _selectedImageFile != null
                                          ? DecorationImage(
                                              image: FileImage(
                                                  _selectedImageFile!),
                                              fit: BoxFit.cover,
                                            )
                                          : null,
                                    ),
                                  ),
                                  Positioned(
                                    right: 0,
                                    bottom: 0,
                                    child: Container(
                                      padding: const EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF4AC7FF),
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                            color: Colors.white, width: 2),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.1),
                                            spreadRadius: 0,
                                            blurRadius: 4,
                                            offset: const Offset(0, 2),
                                          ),
                                        ],
                                      ),
                                      child: const Icon(
                                        Icons.add_photo_alternate,
                                        size: 20,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          const SizedBox(height: 16),
                          Center(
                            child: Text(
                              _selectedImageFile == null
                                  ? "Tap to select product image"
                                  : "Tap to change image",
                              style: GoogleFonts.poppins(
                                color: Colors.grey[600],
                                fontSize: 13,
                              ),
                            ),
                          ),

                          const SizedBox(height: 24),

                          // Enhanced section header
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: const Color(0xFF4AC7FF).withOpacity(0.08),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.info_outline,
                                  size: 18,
                                  color: Colors.blue[700],
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  "Product Details",
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                    color: Colors.blue[700],
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 16),

                          // Product Name field with shadow
                          Container(
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.1),
                                  spreadRadius: 0,
                                  blurRadius: 6,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: TextField(
                              controller: nameController,
                              decoration: InputDecoration(
                                labelText: 'Product Name*',
                                labelStyle: GoogleFonts.poppins(fontSize: 14),
                                prefixIcon: const Icon(Icons.edit_outlined),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:
                                      BorderSide(color: Colors.grey[300]!),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:
                                      BorderSide(color: Colors.grey[300]!),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                      color: Color(0xFF4AC7FF)),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 12, horizontal: 16),
                                filled: true,
                                fillColor: Colors.white,
                              ),
                            ),
                          ),

                          const SizedBox(height: 16),

                          // Supplier field with shadow
                          Container(
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.1),
                                  spreadRadius: 0,
                                  blurRadius: 6,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: TextField(
                              controller: supplierController,
                              decoration: InputDecoration(
                                labelText: 'Supplier*',
                                labelStyle: GoogleFonts.poppins(fontSize: 14),
                                prefixIcon: const Icon(Icons.business),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:
                                      BorderSide(color: Colors.grey[300]!),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:
                                      BorderSide(color: Colors.grey[300]!),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                      color: Color(0xFF4AC7FF)),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 12, horizontal: 16),
                                suffixIcon: const Icon(Icons.arrow_drop_down),
                                filled: true,
                                fillColor: Colors.white,
                              ),
                              readOnly: true,
                              onTap: () {
                                // Show supplier picker dialog with improved design
                                showModalBottomSheet(
                                  context: context,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(20)),
                                  ),
                                  builder: (context) => Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: const BorderRadius.vertical(
                                          top: Radius.circular(20)),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.2),
                                          spreadRadius: 0,
                                          blurRadius: 10,
                                          offset: const Offset(0, -5),
                                        ),
                                      ],
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 24, horizontal: 16),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        // Drag handle
                                        Center(
                                          child: Container(
                                            width: 40,
                                            height: 4,
                                            margin: const EdgeInsets.only(
                                                bottom: 20),
                                            decoration: BoxDecoration(
                                              color: Colors.grey[300],
                                              borderRadius:
                                                  BorderRadius.circular(2),
                                            ),
                                          ),
                                        ),
                                        Text(
                                          "Select Supplier",
                                          style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18,
                                          ),
                                        ),
                                        const SizedBox(height: 16),

                                        // Enhanced supplier list
                                        ...[
                                          "PT Pharma Indonesia",
                                          "CV Medika Jaya",
                                          "PT Kimia Farma",
                                          "PT Sanbe Farma"
                                        ]
                                            .map((supplier) => Container(
                                                  margin: const EdgeInsets.only(
                                                      bottom: 8),
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    border: Border.all(
                                                      color: Colors.grey
                                                          .withOpacity(0.2),
                                                    ),
                                                  ),
                                                  child: ListTile(
                                                    leading: Container(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8),
                                                      decoration: BoxDecoration(
                                                        color: const Color(
                                                                0xFF4AC7FF)
                                                            .withOpacity(0.1),
                                                        shape: BoxShape.circle,
                                                      ),
                                                      child: const Icon(
                                                        Icons.business_outlined,
                                                        color:
                                                            Color(0xFF4AC7FF),
                                                        size: 20,
                                                      ),
                                                    ),
                                                    title: Text(
                                                      supplier,
                                                      style:
                                                          GoogleFonts.poppins(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                    trailing: supplierController
                                                                .text ==
                                                            supplier
                                                        ? const Icon(
                                                            Icons.check_circle,
                                                            color: Color(
                                                                0xFF4AC7FF),
                                                          )
                                                        : null,
                                                    onTap: () {
                                                      setState(() {
                                                        supplierController
                                                            .text = supplier;
                                                      });
                                                      Navigator.pop(context);
                                                    },
                                                  ),
                                                ))
                                            .toList(),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),

                          const SizedBox(height: 16),

                          // Category and Price fields in a row
                          Row(
                            children: [
                              // Category field with shadow
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.1),
                                        spreadRadius: 0,
                                        blurRadius: 6,
                                        offset: const Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: TextField(
                                    controller: categoryController,
                                    decoration: InputDecoration(
                                      labelText: 'Category*',
                                      labelStyle:
                                          GoogleFonts.poppins(fontSize: 14),
                                      prefixIcon:
                                          const Icon(Icons.category_outlined),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                            color: Colors.grey[300]!),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                            color: Colors.grey[300]!),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(
                                            color: Color(0xFF4AC7FF)),
                                      ),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 12, horizontal: 16),
                                      suffixIcon:
                                          const Icon(Icons.arrow_drop_down),
                                      filled: true,
                                      fillColor: Colors.white,
                                    ),
                                    readOnly: true,
                                    onTap: () {
                                      // Show category picker with improved design
                                      showModalBottomSheet(
                                        context: context,
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.vertical(
                                              top: Radius.circular(20)),
                                        ),
                                        builder: (context) => Container(
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                const BorderRadius.vertical(
                                                    top: Radius.circular(20)),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey
                                                    .withOpacity(0.2),
                                                spreadRadius: 0,
                                                blurRadius: 10,
                                                offset: const Offset(0, -5),
                                              ),
                                            ],
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 24, horizontal: 16),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              // Drag handle
                                              Center(
                                                child: Container(
                                                  width: 40,
                                                  height: 4,
                                                  margin: const EdgeInsets.only(
                                                      bottom: 20),
                                                  decoration: BoxDecoration(
                                                    color: Colors.grey[300],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            2),
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                "Select Category",
                                                style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 18,
                                                ),
                                              ),
                                              const SizedBox(height: 16),

                                              // Enhanced category list
                                              ...[
                                                {
                                                  "name": "Analgesic",
                                                  "icon": Icons.healing
                                                },
                                                {
                                                  "name": "Antibiotic",
                                                  "icon": Icons.bug_report
                                                },
                                                {
                                                  "name": "Gastric",
                                                  "icon": Icons.food_bank
                                                },
                                                {
                                                  "name": "Antihistamine",
                                                  "icon": Icons.ac_unit
                                                },
                                                {
                                                  "name": "Vitamin",
                                                  "icon": Icons.fitbit
                                                }
                                              ]
                                                  .map((category) => Container(
                                                        margin: const EdgeInsets
                                                            .only(bottom: 8),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          border: Border.all(
                                                            color: Colors.grey
                                                                .withOpacity(
                                                                    0.2),
                                                          ),
                                                        ),
                                                        child: ListTile(
                                                          leading: Container(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8),
                                                            decoration:
                                                                BoxDecoration(
                                                              color: const Color(
                                                                      0xFF4AC7FF)
                                                                  .withOpacity(
                                                                      0.1),
                                                              shape: BoxShape
                                                                  .circle,
                                                            ),
                                                            child: Icon(
                                                              category["icon"]
                                                                  as IconData,
                                                              color: const Color(
                                                                  0xFF4AC7FF),
                                                              size: 20,
                                                            ),
                                                          ),
                                                          title: Text(
                                                            category["name"]
                                                                as String,
                                                            style: GoogleFonts
                                                                .poppins(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize: 14,
                                                            ),
                                                          ),
                                                          trailing:
                                                              categoryController
                                                                          .text ==
                                                                      category[
                                                                          "name"]
                                                                  ? const Icon(
                                                                      Icons
                                                                          .check_circle,
                                                                      color: Color(
                                                                          0xFF4AC7FF),
                                                                    )
                                                                  : null,
                                                          onTap: () {
                                                            setState(() {
                                                              categoryController
                                                                      .text =
                                                                  category[
                                                                          "name"]
                                                                      as String;
                                                            });
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                        ),
                                                      ))
                                                  .toList(),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),

                              // Price field with shadow
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.1),
                                        spreadRadius: 0,
                                        blurRadius: 6,
                                        offset: const Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: TextField(
                                    controller: priceController,
                                    decoration: InputDecoration(
                                      labelText: 'Price*',
                                      labelStyle:
                                          GoogleFonts.poppins(fontSize: 14),
                                      prefixIcon: const Icon(
                                          Icons.monetization_on_outlined),
                                      prefixText: "Rp ",
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                            color: Colors.grey[300]!),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                            color: Colors.grey[300]!),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(
                                            color: Color(0xFF4AC7FF)),
                                      ),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 12, horizontal: 16),
                                      filled: true,
                                      fillColor: Colors.white,
                                    ),
                                    keyboardType: TextInputType.number,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 16),

                          // Stock and Expiry Date in a row
                          Row(
                            children: [
                              // Initial Stock field with shadow
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.1),
                                        spreadRadius: 0,
                                        blurRadius: 6,
                                        offset: const Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: TextField(
                                    controller: stockController,
                                    decoration: InputDecoration(
                                      labelText: 'Initial Stock*',
                                      labelStyle:
                                          GoogleFonts.poppins(fontSize: 14),
                                      prefixIcon:
                                          const Icon(Icons.inventory_outlined),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                            color: Colors.grey[300]!),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                            color: Colors.grey[300]!),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(
                                            color: Color(0xFF4AC7FF)),
                                      ),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 12, horizontal: 16),
                                      filled: true,
                                      fillColor: Colors.white,
                                    ),
                                    keyboardType: TextInputType.number,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),

                              // Expiry Date field with shadow
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.1),
                                        spreadRadius: 0,
                                        blurRadius: 6,
                                        offset: const Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: TextField(
                                    controller: expiryController,
                                    decoration: InputDecoration(
                                      labelText: 'Expiry Date*',
                                      labelStyle:
                                          GoogleFonts.poppins(fontSize: 14),
                                      prefixIcon: const Icon(
                                          Icons.calendar_today_outlined),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                            color: Colors.grey[300]!),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                            color: Colors.grey[300]!),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(
                                            color: Color(0xFF4AC7FF)),
                                      ),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 12, horizontal: 16),
                                      filled: true,
                                      fillColor: Colors.white,
                                    ),
                                    readOnly: true,
                                    onTap: () async {
                                      final DateTime? pickedDate =
                                          await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now()
                                            .add(const Duration(days: 365)),
                                        firstDate: DateTime.now(),
                                        lastDate: DateTime.now()
                                            .add(const Duration(days: 3650)),
                                        builder: (context, child) {
                                          return Theme(
                                            data: ThemeData.light().copyWith(
                                              colorScheme:
                                                  const ColorScheme.light(
                                                primary: Color(0xFF4AC7FF),
                                              ),
                                            ),
                                            child: child!,
                                          );
                                        },
                                      );
                                      if (pickedDate != null) {
                                        setState(() {
                                          expiryController.text =
                                              "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
                                        });
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 16),

                          // Description field with shadow
                          Container(
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.1),
                                  spreadRadius: 0,
                                  blurRadius: 6,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: TextField(
                              controller: descriptionController,
                              decoration: InputDecoration(
                                labelText: 'Description',
                                labelStyle: GoogleFonts.poppins(fontSize: 14),
                                prefixIcon:
                                    const Icon(Icons.description_outlined),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:
                                      BorderSide(color: Colors.grey[300]!),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:
                                      BorderSide(color: Colors.grey[300]!),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                      color: Color(0xFF4AC7FF)),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 12, horizontal: 16),
                                filled: true,
                                fillColor: Colors.white,
                              ),
                              maxLines: 3,
                            ),
                          ),

                          const SizedBox(height: 24),
                          const Divider(),
                          const SizedBox(height: 16),

                          // Action buttons
                          Row(
                            children: [
                              // Cancel button
                              Expanded(
                                child: OutlinedButton(
                                  onPressed: () => Navigator.pop(context),
                                  style: OutlinedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 12),
                                    side: BorderSide(color: Colors.grey[300]!),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  child: Text(
                                    'CANCEL',
                                    style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey[700],
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              // Save button with shadow
                              Expanded(
                                flex: 2,
                                child: Container(
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color(0xFF4AC7FF)
                                            .withOpacity(0.3),
                                        spreadRadius: 0,
                                        blurRadius: 6,
                                        offset: const Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      // Validation including image check
                                      if (_selectedImageFile == null) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              'Please select a product image',
                                              style: GoogleFonts.poppins(),
                                            ),
                                            backgroundColor: Colors.red,
                                            behavior: SnackBarBehavior.floating,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                        );
                                        return;
                                      }

                                      // Validate other fields
                                      if (nameController.text.isEmpty ||
                                          categoryController.text.isEmpty ||
                                          stockController.text.isEmpty ||
                                          priceController.text.isEmpty ||
                                          supplierController.text.isEmpty ||
                                          expiryController.text.isEmpty) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              'Please fill all required fields',
                                              style: GoogleFonts.poppins(),
                                            ),
                                            backgroundColor: Colors.red,
                                            behavior: SnackBarBehavior.floating,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                        );
                                        return;
                                      }

                                      // Close dialog and show success dialog
                                      Navigator.pop(context);
                                      _showSuccessDialog(
                                          context, nameController.text);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF4AC7FF),
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 12),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      elevation: 0,
                                    ),
                                    child: Text(
                                      'SAVE PRODUCT',
                                      style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ));
  }
}

void _showEditProductDialog(
    BuildContext context, Map<String, dynamic> product) {
  // Add this line to define _selectedImageFile
  File? _selectedImageFile;

  final nameController = TextEditingController(text: product['productName']);
  final categoryController = TextEditingController(text: product['category']);
  final stockController =
      TextEditingController(text: product['quantity'].toString());
  final priceController =
      TextEditingController(text: product['price'].toString());
  final descriptionController =
      TextEditingController(text: product['description']);
  final supplierController = TextEditingController(text: product['supplier']);
  final expiryController = TextEditingController(text: product['expiry']);

  showDialog(
      context: context,
      builder: (context) => Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          backgroundColor: Colors.white, // Explicitly set white background
          child: Container(
            width: double.maxFinite,
            constraints: const BoxConstraints(maxWidth: 500),
            color: Colors.white, // Ensure container has white background
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.amber.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(
                            Icons.edit,
                            color: Colors.amber,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          "Edit Product",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Product Image Upload
                    Center(
                      child: Stack(
                        children: [
                          Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.asset(
                                product['image'],
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    color: Colors.grey[100],
                                    child: Icon(
                                      Icons.medication,
                                      size: 50,
                                      color: Colors.grey[500],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          Positioned(
                            right: 0,
                            bottom: 0,
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: const Color(0xFF4AC7FF),
                                shape: BoxShape.circle,
                                border:
                                    Border.all(color: Colors.white, width: 2),
                              ),
                              child: const Icon(
                                Icons.edit,
                                size: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Form Fields (Same as Add Product)
                    Text(
                      "Product Details",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: Colors.grey[800],
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                        labelText: 'Product Name*',
                        labelStyle: GoogleFonts.poppins(fontSize: 14),
                        prefixIcon: const Icon(Icons.edit_outlined),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 16),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Supplier field
                    TextField(
                      controller: supplierController,
                      decoration: InputDecoration(
                        labelText: 'Supplier*',
                        labelStyle: GoogleFonts.poppins(fontSize: 14),
                        prefixIcon: const Icon(Icons.business),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 16),
                        suffixIcon: const Icon(Icons.arrow_drop_down),
                      ),
                      readOnly: true,
                      onTap: () {
                        // Show supplier picker dialog
                        showModalBottomSheet(
                          context: context,
                          shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(16)),
                          ),
                          builder: (context) => Container(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "Select Supplier",
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                ...[
                                  "PT Pharma Indonesia",
                                  "CV Medika Jaya",
                                  "PT Kimia Farma",
                                  "PT Sanbe Farma"
                                ]
                                    .map((supplier) => ListTile(
                                          title: Text(supplier),
                                          onTap: () {
                                            supplierController.text = supplier;
                                            Navigator.pop(context);
                                          },
                                        ))
                                    .toList(),
                              ],
                            ),
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 16),

                    Row(
                      children: [
                        // Category field (left)
                        Expanded(
                          child: TextField(
                            controller: categoryController,
                            decoration: InputDecoration(
                              labelText: 'Category*',
                              labelStyle: GoogleFonts.poppins(fontSize: 14),
                              prefixIcon: const Icon(Icons.category_outlined),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 16),
                              suffixIcon: const Icon(Icons.arrow_drop_down),
                            ),
                            readOnly: true,
                            onTap: () {
                              // Show category picker dialog
                              showModalBottomSheet(
                                context: context,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(16)),
                                ),
                                builder: (context) => Container(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 20),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        "Select Category",
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      ...[
                                        "Analgesic",
                                        "Antibiotic",
                                        "Gastric",
                                        "Antihistamine",
                                        "Vitamin"
                                      ]
                                          .map((category) => ListTile(
                                                title: Text(category),
                                                onTap: () {
                                                  categoryController.text =
                                                      category;
                                                  Navigator.pop(context);
                                                },
                                              ))
                                          .toList(),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(width: 12),
                        // Price field (right)
                        Expanded(
                          child: TextField(
                            controller: priceController,
                            decoration: InputDecoration(
                              labelText: 'Price*',
                              labelStyle: GoogleFonts.poppins(fontSize: 14),
                              prefixIcon:
                                  const Icon(Icons.monetization_on_outlined),
                              prefixText: "Rp ",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 16),
                            ),
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),
                    Row(
                      children: [
                        // Initial Stock field (left)
                        Expanded(
                          child: TextField(
                            controller: stockController,
                            decoration: InputDecoration(
                              labelText: 'Initial Stock*',
                              labelStyle: GoogleFonts.poppins(fontSize: 14),
                              prefixIcon: const Icon(Icons.inventory_outlined),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 16),
                            ),
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        const SizedBox(width: 12),
                        // Expiry Date field (right)
                        Expanded(
                          child: TextField(
                            controller: expiryController,
                            decoration: InputDecoration(
                              labelText: 'Expiry Date*',
                              labelStyle: GoogleFonts.poppins(fontSize: 14),
                              prefixIcon:
                                  const Icon(Icons.calendar_today_outlined),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 16),
                            ),
                            readOnly: true,
                            onTap: () async {
                              final DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now()
                                    .add(const Duration(days: 365)),
                                firstDate: DateTime.now(),
                                lastDate: DateTime.now()
                                    .add(const Duration(days: 3650)),
                                builder: (context, child) {
                                  return Theme(
                                    data: ThemeData.light().copyWith(
                                      colorScheme: const ColorScheme.light(
                                        primary: Color(0xFF4AC7FF),
                                      ),
                                    ),
                                    child: child!,
                                  );
                                },
                              );
                              if (pickedDate != null) {
                                expiryController.text =
                                    "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
                              }
                            },
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),
                    TextField(
                      controller: descriptionController,
                      decoration: InputDecoration(
                        labelText: 'Description',
                        labelStyle: GoogleFonts.poppins(fontSize: 14),
                        prefixIcon: const Icon(Icons.description_outlined),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 16),
                      ),
                      maxLines: 3,
                    ),

                    const SizedBox(height: 24),
                    const Divider(),
                    const SizedBox(height: 16),

                    // Action buttons
                    Row(
                      children: [
                        // Cancel button
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () => Navigator.pop(context),
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              side: BorderSide(color: Colors.grey[300]!),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Text(
                              'CANCEL',
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey[700],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        // Save button with shadow
                        Expanded(
                          flex: 2,
                          child: Container(
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      const Color(0xFF4AC7FF).withOpacity(0.3),
                                  spreadRadius: 0,
                                  blurRadius: 6,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: ElevatedButton(
                              onPressed: () {
                                // Validation including image check
                                if (_selectedImageFile == null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'Please select a product image',
                                        style: GoogleFonts.poppins(),
                                      ),
                                      backgroundColor: Colors.red,
                                      behavior: SnackBarBehavior.floating,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  );
                                  return;
                                }

                                // Validate other fields
                                if (nameController.text.isEmpty ||
                                    categoryController.text.isEmpty ||
                                    stockController.text.isEmpty ||
                                    priceController.text.isEmpty ||
                                    supplierController.text.isEmpty ||
                                    expiryController.text.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'Please fill all required fields',
                                        style: GoogleFonts.poppins(),
                                      ),
                                      backgroundColor: Colors.red,
                                      behavior: SnackBarBehavior.floating,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  );
                                  return;
                                }

                                // Close dialog and show success dialog
                                Navigator.pop(context);
                                _showSuccessDialog(
                                    context, nameController.text);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF4AC7FF),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                elevation: 0,
                              ),
                              child: Text(
                                'SAVE PRODUCT',
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )));
}

void _showSuccessDialog(BuildContext context, String productName) {
  showDialog(
      context: context,
      builder: (context) => Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 0,
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.1),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.green.withOpacity(0.2),
                          spreadRadius: 0,
                          blurRadius: 8,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.check_circle,
                      color: Colors.green,
                      size: 50,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Success!",
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Product successfully added",
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.grey[700],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey[200]!),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 0,
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: const Color(0xFF4AC7FF).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(
                            Icons.medication,
                            color: Color(0xFF4AC7FF),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                productName,
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                "Product has been added to inventory",
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
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => Navigator.pop(context),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            side: BorderSide(color: Colors.grey[300]!),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            'CLOSE',
                            style: GoogleFonts.poppins(
                              color: Colors.grey[700],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.blue.withOpacity(0.2),
                                spreadRadius: 0,
                                blurRadius: 6,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: ElevatedButton.icon(
                            icon:
                                const Icon(Icons.add_circle_outline, size: 18),
                            label: Text(
                              'ADD STOCK',
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              ),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => const StockInPage()));
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF4AC7FF),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              elevation: 0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ));
}

void _scanBarcode(BuildContext context) {
  // Implement barcode scanning functionality here
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Row(
        children: [
          const Icon(Icons.qr_code_scanner, color: Colors.white),
          const SizedBox(width: 12),
          Flexible(
            // Wrap text with Flexible to prevent overflow
            child: Text(
              'Barcode scanning is not implemented yet.',
              style: GoogleFonts.poppins(fontSize: 14),
              overflow: TextOverflow
                  .ellipsis, // Optional: handle any overflowing text
            ),
          ),
        ],
      ),
      backgroundColor: Colors.blue,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.all(10),
      duration: const Duration(seconds: 2),
      action: SnackBarAction(
        label: 'OK',
        textColor: Colors.white,
        onPressed: () {},
      ),
    ),
  );
}

void _showDeleteConfirmation(
    BuildContext context, Map<String, dynamic> product) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: Colors.white, // Explicitly set white background
      title: Text(
        'Delete Product',
        style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
      ),
      content: Text(
        'Are you sure you want to delete "${product['productName']}"?',
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
        TextButton(
          onPressed: () {
            // Implement delete functionality here
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Product deleted successfully.',
                  style: GoogleFonts.poppins(),
                ),
                backgroundColor: Colors.red,
                duration: const Duration(seconds: 2),
              ),
            );
          },
          child: Text(
            'Delete',
            style: GoogleFonts.poppins(color: Colors.red),
          ),
        ),
      ],
    ),
  );
}

void _exportToExcel(BuildContext context) {
  // Implement export to Excel functionality
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        'Export to Excel feature is not implemented yet.',
        style: GoogleFonts.poppins(),
      ),
      backgroundColor: Colors.green,
      duration: const Duration(seconds: 2),
    ),
  );
}

void _importFromExcel(BuildContext context) {
  // Implement import from Excel functionality
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        'Import from Excel feature is not implemented yet.',
        style: GoogleFonts.poppins(),
      ),
      backgroundColor: Colors.green,
      duration: const Duration(seconds: 2),
    ),
  );
}

void _showProductDetailDialog(
    BuildContext context, Map<String, dynamic> product) {
  showDialog(
      context: context,
      builder: (context) => Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            backgroundColor: Colors.white, // Explicitly set white background
            child: Container(
              width: double.maxFinite,
              constraints: const BoxConstraints(maxWidth: 550),
              color: Colors.white,
              child: SingleChildScrollView(
                  child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header with product image
                  Stack(
                    children: [
                      Container(
                        height: 200,
                        width: double.infinity,
                        child: ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(20)),
                          child: Image.asset(
                            product['image'],
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: Colors.grey[200],
                                child: Icon(
                                  Icons.medication,
                                  size: 80,
                                  color: Colors.grey[400],
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      // Close button
                      Positioned(
                        top: 16,
                        right: 16,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.8),
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.close),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ),
                      ),
                      // Status badges
                      if (product['lowStock'] || product['nearExpiry'])
                        Positioned(
                          top: 16,
                          left: 16,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: product['lowStock']
                                  ? Colors.orange
                                  : product['nearExpiry']
                                      ? Colors.red
                                      : Colors.transparent,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Text(
                              product['lowStock']
                                  ? 'Low Stock'
                                  : product['nearExpiry']
                                      ? 'Near Expiry'
                                      : '',
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),

                  // Product Info
                  Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Product ID and name - Fixed overflow here by using Row with Flexible widgets
                        Wrap(
                          spacing: 12,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                product['id'],
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.blue[50],
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                product['category'],
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.blue,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),

                        Text(
                          product['productName'],
                          style: GoogleFonts.poppins(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),

                        // Price
                        Text(
                          'Rp ${product['price']}',
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.blue[700],
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Stats cards
                        Row(
                          children: [
                            _buildDetailStatCard(
                              title: 'Stock',
                              value: product['quantity'].toString(),
                              icon: Icons.inventory_2_outlined,
                              color: product['quantity'] <= 20
                                  ? Colors.red
                                  : Colors.green,
                            ),
                            const SizedBox(width: 16),
                            _buildDetailStatCard(
                              title: 'Expiry',
                              value: product['expiry'],
                              icon: Icons.event_outlined,
                              color: product['nearExpiry']
                                  ? Colors.red
                                  : Colors.blue,
                            ),
                            const SizedBox(width: 16),
                            _buildDetailStatCard(
                              title: 'Supplier',
                              value: product['supplier'].split(' ').last,
                              icon: Icons.business_outlined,
                              color: Colors.purple,
                            ),
                          ],
                        ),

                        const SizedBox(height: 24),
                        const Divider(),
                        const SizedBox(height: 16),

                        // Description
                        Text(
                          'Description',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          product['description'],
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            height: 1.5,
                            color: Colors.grey[700],
                          ),
                        ),

                        const SizedBox(height: 24),

                        // Action buttons
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: ElevatedButton.icon(
                                onPressed: () {
                                  Navigator.pop(context);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => StockInPage(),
                                    ),
                                  );
                                },
                                icon:
                                    const Icon(Icons.add, color: Colors.white),
                                label: Text(
                                  'Add Stock',
                                  style:
                                      GoogleFonts.poppins(color: Colors.white),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green,
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 12),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: ElevatedButton.icon(
                                onPressed: () {
                                  Navigator.pop(context);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => StockOutPage(),
                                    ),
                                  );
                                },
                                icon: const Icon(Icons.remove,
                                    color: Colors.white),
                                label: Text(
                                  'Remove Stock',
                                  style:
                                      GoogleFonts.poppins(color: Colors.white),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 12),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        OutlinedButton.icon(
                          onPressed: () {
                            Navigator.pop(context);
                            _showEditProductDialog(context, product);
                          },
                          icon: const Icon(Icons.edit),
                          label: Text(
                            'Edit Product',
                            style: GoogleFonts.poppins(),
                          ),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            minimumSize: const Size(double.infinity, 0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )),
            ),
          ));
}

Widget _buildDetailStatCard({
  required String title,
  required String value,
  required IconData icon,
  required Color color,
}) {
  return Expanded(
    child: Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Modified row with Flexible to handle text overflow
          Row(
            children: [
              Icon(
                icon,
                size: 16,
                color: color,
              ),
              const SizedBox(width: 4),
              Flexible(
                // Add this Flexible widget
                child: Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[700],
                  ),
                  overflow: TextOverflow.ellipsis, // Add this
                  maxLines: 1, // Ensure single line
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          // Already has overflow handling for the value
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: color,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
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
