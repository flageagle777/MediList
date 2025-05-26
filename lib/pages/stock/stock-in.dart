import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medilist/pages/stock/stock-out.dart';
import 'package:medilist/pages/produk/produk-page.dart';
import 'package:medilist/pages/supplier/supplier-page.dart';
import 'package:medilist/pages/report/report-page.dart';
import 'package:medilist/pages/history/history-page.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class StockInPage extends StatefulWidget {
  const StockInPage({Key? key}) : super(key: key);

  @override
  _StockInPageState createState() => _StockInPageState();
}

class _StockInPageState extends State<StockInPage> {
  // Dummy data untuk recent activity
  final List<Map<String, dynamic>> recentActivity = [
    {
      'productName': 'Paracetamol',
      'quantity': 100,
      'date': '24 May 2025',
      'supplier': 'PT Pharma Indonesia',
      'type': 'in',
    },
  ];

  // Dummy data untuk product list
  final List<Map<String, dynamic>> productList = [
    {
      'productName': 'Paracetamol',
      'quantity': 250,
      'category': 'Analgesic',
      'image': 'assets/produk/Paracetamol.jpg'
    },
    {
      'productName': 'Amoxicillin',
      'quantity': 120,
      'category': 'Antibiotic',
      'image': 'assets/produk/amoxilin.jpg'
    },
    {
      'productName': 'Omeprazole',
      'quantity': 85,
      'category': 'Gastric',
      'image': 'assets/produk/Omeprazole.jpg'
    },
    {
      'productName': 'Loratadine',
      'quantity': 65,
      'category': 'Antihistamine',
      'image': 'assets/produk/loratadine.jpg'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Changed from Colors.grey[100] to white
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
        automaticallyImplyLeading: false, // Menghilangkan tombol back
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
                                'Stock In Management',
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
                      icon: Icons
                          .add_box_outlined, // Updated icon for consistency
                      text: 'Stock In',
                      isActive: true, // This page is active
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const StockInPage()),
                      ),
                    ),
                    _buildDrawerItem(
                      icon:
                          Icons.outbox_outlined, // Updated icon for consistency
                      text: 'Stock Out',
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const StockOutPage()),
                      ),
                    ),
                    _buildDrawerItem(
                      icon: Icons
                          .inventory_2_outlined, // Updated icon for consistency
                      text: 'Products',
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const ProductPage()),
                      ),
                    ),
                    _buildDrawerItem(
                      icon:
                          Icons.person_outline, // Updated icon for consistency
                      text: 'Suppliers',
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const SupplierPage()),
                      ),
                    ),
                    _buildDrawerItem(
                      icon: Icons
                          .receipt_long_outlined, // Updated icon for consistency
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header section with Inventory title and Add Product button
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Inventory",
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

            // Recent Activity Section
            Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
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
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      "Recent Activity",
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  const Divider(height: 1),

                  // Recent activity items
                  if (recentActivity.isEmpty)
                    Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Center(
                        child: Column(
                          children: [
                            Icon(
                              Icons.hourglass_empty,
                              size: 40,
                              color: Colors.grey[400],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "No recent activity",
                              style: GoogleFonts.poppins(
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  else
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: recentActivity.length,
                      separatorBuilder: (context, index) =>
                          const Divider(height: 1),
                      itemBuilder: (context, index) {
                        final activity = recentActivity[index];
                        return ListTile(
                          leading: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: activity['type'] == 'in'
                                  ? const Color(0xFF4CAF50).withOpacity(0.1)
                                  : const Color(0xFFF44336).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(
                              activity['type'] == 'in'
                                  ? Icons.add
                                  : Icons.remove,
                              color: activity['type'] == 'in'
                                  ? const Color(0xFF4CAF50)
                                  : const Color(0xFFF44336),
                            ),
                          ),
                          title: Text(
                            activity['productName'],
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                          subtitle: Text(
                            "${activity['supplier']} • ${activity['date']}",
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                          trailing: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: activity['type'] == 'in'
                                  ? const Color(0xFF4CAF50).withOpacity(0.1)
                                  : const Color(0xFFF44336).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Text(
                              activity['type'] == 'in'
                                  ? "+${activity['quantity']}"
                                  : "-${activity['quantity']}",
                              style: GoogleFonts.poppins(
                                color: activity['type'] == 'in'
                                    ? const Color(0xFF4CAF50)
                                    : const Color(0xFFF44336),
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        );
                      },
                    ),

                  // View all button
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Center(
                      child: TextButton.icon(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const HistoryPage()));
                        },
                        icon: const Icon(Icons.arrow_forward_ios,
                            size: 14, color: Color(0xFF4AC7FF)),
                        label: Text(
                          "View All Activities",
                          style: GoogleFonts.poppins(
                            color: const Color(0xFF4AC7FF),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        style: TextButton.styleFrom(
                          backgroundColor:
                              const Color(0xFF4AC7FF).withOpacity(0.05),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Product List Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                "Product List",
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ),

            const SizedBox(height: 12),

            // Search and filter
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
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
                        decoration: InputDecoration(
                          hintText: 'Search products...',
                          hintStyle: GoogleFonts.poppins(fontSize: 14),
                          prefixIcon: const Icon(Icons.search),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: EdgeInsets.zero,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
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
                      icon: const Icon(Icons.filter_list),
                      onPressed: () {},
                      tooltip: 'Filter products',
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // Product List Grid
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.8,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemCount: productList.length,
                itemBuilder: (context, index) {
                  final product = productList[index];
                  return _buildProductCard(product);
                },
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddStockDialog(context);
        },
        backgroundColor: const Color(0xFF4AC7FF),
        elevation: 4,
        child: const Icon(Icons.add_shopping_cart, color: Colors.white),
        tooltip: 'Add Stock',
      ),
    );
  }

  Widget _buildProductCard(Map<String, dynamic> product) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.15),
            spreadRadius: 0,
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product image
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(12)),
              ),
              child: Center(
                child: ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(12)),
                  child: Image.asset(
                    product['image'],
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                    errorBuilder: (context, error, stackTrace) {
                      print(
                          "Error loading image: ${product['image']} - $error");
                      return Icon(
                        Icons.medication,
                        size: 60,
                        color: Colors.grey[400],
                      );
                    },
                  ),
                ),
              ),
            ),
          ),

          // Product details
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
                const SizedBox(height: 2),
                Text(
                  product['category'],
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF4CAF50).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        "Stock: ${product['quantity']}",
                        style: GoogleFonts.poppins(
                          color: const Color(0xFF4CAF50),
                          fontWeight: FontWeight.w500,
                          fontSize: 11,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        _showAddStockDialog(context, product: product);
                      },
                      icon: const Icon(
                        Icons.add_circle_outline,
                        size: 20,
                        color: Color(0xFF4AC7FF),
                      ),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      tooltip: 'Add stock',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showAddProductDialog(BuildContext context) {
    final nameController = TextEditingController();
    final categoryController = TextEditingController();
    final stockController = TextEditingController();
    final priceController = TextEditingController();
    final supplierController = TextEditingController();
    final expiryDateController = TextEditingController();

    // Variable to store image path
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
                  borderRadius: BorderRadius.circular(16),
                ),
                backgroundColor: Colors.white, // Ensuring white background
                child: Container(
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    color: Colors.white, // Explicit white background
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 0,
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 400),
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Enhanced header with colored container and shadowed icon
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF4AC7FF)
                                        .withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(10),
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

                            // Enhanced product image upload with better shadow and animation
                            Center(
                              child: GestureDetector(
                                onTap: () async {
                                  await _pickImage();
                                  setState(() {});
                                },
                                child: Stack(
                                  children: [
                                    AnimatedContainer(
                                      duration:
                                          const Duration(milliseconds: 200),
                                      width: 120,
                                      height: 120,
                                      decoration: BoxDecoration(
                                        color: Colors.grey[100],
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                            color: Colors.grey[300]!),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.grey.withOpacity(0.15),
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
                                      child: _selectedImageFile == null
                                          ? Center(
                                              child: Icon(
                                                Icons.medication_outlined,
                                                size: 50,
                                                color: Colors.grey[500],
                                              ),
                                            )
                                          : null,
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
                                color:
                                    const Color(0xFF4AC7FF).withOpacity(0.08),
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

                            // Form fields with enhanced shadow and focus states
                            // Product Name field
                            _buildShadowedTextField(
                              controller: nameController,
                              labelText: 'Product Name*',
                              prefixIcon: Icons.edit_outlined,
                              colorTheme: const Color(0xFF4AC7FF),
                            ),
                            const SizedBox(height: 16),

                            // Supplier field with picker
                            _buildShadowedTextField(
                              controller: supplierController,
                              labelText: 'Supplier*',
                              prefixIcon: Icons.business,
                              suffixIcon: Icons.arrow_drop_down,
                              colorTheme: const Color(0xFF4AC7FF),
                              readOnly: true,
                              onTap: () {
                                _showSupplierPickerSheet(
                                    context, supplierController, setState);
                              },
                            ),
                            const SizedBox(height: 16),

                            // Category and Price fields in a row
                            Row(
                              children: [
                                // Category field (left)
                                Expanded(
                                  child: _buildShadowedTextField(
                                    controller: categoryController,
                                    labelText: 'Category*',
                                    prefixIcon: Icons.category_outlined,
                                    suffixIcon: Icons.arrow_drop_down,
                                    colorTheme: const Color(0xFF4AC7FF),
                                    readOnly: true,
                                    onTap: () {
                                      _showCategoryPickerSheet(context,
                                          categoryController, setState);
                                    },
                                  ),
                                ),
                                const SizedBox(width: 12),
                                // Price field (right)
                                Expanded(
                                  child: _buildShadowedTextField(
                                    controller: priceController,
                                    labelText: 'Price*',
                                    prefixIcon: Icons.monetization_on_outlined,
                                    prefixText: "Rp ",
                                    colorTheme: const Color(0xFF4AC7FF),
                                    keyboardType: TextInputType.number,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),

                            // Initial Stock field
                            _buildShadowedTextField(
                              controller: stockController,
                              labelText: 'Initial Stock*',
                              prefixIcon: Icons.inventory_outlined,
                              colorTheme: const Color(0xFF4AC7FF),
                              keyboardType: TextInputType.number,
                            ),
                            const SizedBox(height: 16),

                            // Expiry Date field with date picker
                            _buildShadowedTextField(
                              controller: expiryDateController,
                              labelText: 'Expiry Date*',
                              prefixIcon: Icons.calendar_today_outlined,
                              colorTheme: const Color(0xFF4AC7FF),
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
                                        colorScheme: const ColorScheme.light(
                                          primary: Color(0xFF4AC7FF),
                                        ),
                                      ),
                                      child: child!,
                                    );
                                  },
                                );

                                if (pickedDate != null) {
                                  setState(() {
                                    expiryDateController.text =
                                        "${pickedDate.day.toString().padLeft(2, '0')}/${pickedDate.month.toString().padLeft(2, '0')}/${pickedDate.year}";
                                  });
                                }
                              },
                            ),
                            const SizedBox(height: 24),
                            const Divider(),
                            const SizedBox(height: 16),

                            // Enhanced buttons with better shadow and hover effect
                            Row(
                              children: [
                                // Cancel button
                                Expanded(
                                  child: OutlinedButton(
                                    onPressed: () => Navigator.pop(context),
                                    style: OutlinedButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 12),
                                      side:
                                          BorderSide(color: Colors.grey[300]!),
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
                                // Save button with enhanced shadow
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
                                        _validateAndSaveProduct(
                                          context,
                                          _selectedImageFile,
                                          nameController,
                                          categoryController,
                                          stockController,
                                          priceController,
                                          supplierController,
                                          expiryDateController,
                                        );
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            const Color(0xFF4AC7FF),
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 12),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
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

                            // Optional note at bottom about required fields
                            const SizedBox(height: 12),
                            Center(
                              child: Text(
                                "* Required fields",
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color: Colors.grey[600],
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ));
  }

  void _showAddStockDialog(BuildContext context,
      {Map<String, dynamic>? product}) {
    final productNameController = TextEditingController();
    final quantityController = TextEditingController();
    final supplierController = TextEditingController();
    final expiryDateController = TextEditingController();
    final batchNumberController = TextEditingController();

    if (product != null) {
      productNameController.text = product['productName'];
    }

    showDialog(
        context: context,
        builder: (context) => Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              backgroundColor: Colors.white, // Ensuring white background
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white, // Explicit white background
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 0,
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 400),
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Enhanced header with green theme
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color:
                                      const Color(0xFF4CAF50).withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.green.withOpacity(0.1),
                                      spreadRadius: 0,
                                      blurRadius: 6,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: const Icon(
                                  Icons.add_shopping_cart,
                                  color: Color(0xFF4CAF50),
                                  size: 24,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Add Stock",
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 20,
                                      ),
                                    ),
                                    if (product != null)
                                      Text(
                                        product['productName'],
                                        style: GoogleFonts.poppins(
                                          color: Colors.grey[700],
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
                          const Divider(),
                          const SizedBox(height: 16),

                          // Enhanced product image display with shadow
                          if (product != null && product['image'] != null)
                            Center(
                              child: Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  color: Colors.grey[100],
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                      color: Colors.grey[200]!, width: 1),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.15),
                                      spreadRadius: 1,
                                      blurRadius: 8,
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.asset(
                                    product['image'],
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Icon(
                                        Icons.medication,
                                        size: 40,
                                        color: Colors.grey[400],
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),

                          if (product != null) const SizedBox(height: 24),

                          // Enhanced section header with green theme
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: const Color(0xFF4CAF50).withOpacity(0.08),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.info_outline,
                                  size: 18,
                                  color: Colors.green[700],
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  "Stock Details",
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                    color: Colors.green[700],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16),

                          // Enhanced product name field with search
                          _buildShadowedTextField(
                            controller: productNameController,
                            labelText: 'Product Name*',
                            prefixIcon: Icons.medication,
                            suffixIcon: product == null ? Icons.search : null,
                            colorTheme: const Color(0xFF4CAF50),
                            readOnly: true,
                            enabled: product == null,
                            onTap: product == null
                                ? () => _showProductSearchDialog(
                                    context, productNameController)
                                : null,
                          ),
                          const SizedBox(height: 16),

                          // Quantity and Batch number fields in a row
                          Row(
                            children: [
                              // Quantity field
                              Expanded(
                                child: _buildShadowedTextField(
                                  controller: quantityController,
                                  labelText: 'Quantity*',
                                  prefixIcon: Icons.inventory_outlined,
                                  colorTheme: const Color(0xFF4CAF50),
                                  keyboardType: TextInputType.number,
                                ),
                              ),
                              const SizedBox(width: 12),
                              // Batch Number field
                              Expanded(
                                child: _buildShadowedTextField(
                                  controller: batchNumberController,
                                  labelText: 'Batch Number',
                                  prefixIcon: Icons.numbers,
                                  colorTheme: const Color(0xFF4CAF50),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),

                          // Supplier field with picker
                          _buildShadowedTextField(
                            controller: supplierController,
                            labelText: 'Supplier*',
                            prefixIcon: Icons.business,
                            suffixIcon: Icons.arrow_drop_down,
                            colorTheme: const Color(0xFF4CAF50),
                            readOnly: true,
                            onTap: () {
                              _showSupplierPickerSheetGreen(
                                  context, supplierController);
                            },
                          ),
                          const SizedBox(height: 16),

                          // Expiry Date field with date picker
                          _buildShadowedTextField(
                            controller: expiryDateController,
                            labelText: 'Expiry Date*',
                            prefixIcon: Icons.calendar_today_outlined,
                            colorTheme: const Color(0xFF4CAF50),
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
                                        primary: Color(0xFF4CAF50),
                                      ),
                                    ),
                                    child: child!,
                                  );
                                },
                              );

                              if (pickedDate != null) {
                                expiryDateController.text =
                                    "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
                              }
                            },
                          ),
                          const SizedBox(height: 24),
                          const Divider(),
                          const SizedBox(height: 16),

                          // Enhanced buttons with shadow effects
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
                              // Add Stock button with enhanced shadow
                              Expanded(
                                flex: 2,
                                child: Container(
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color(0xFF4CAF50)
                                            .withOpacity(0.3),
                                        spreadRadius: 0,
                                        blurRadius: 6,
                                        offset: const Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      _validateAndSaveStock(
                                        context,
                                        productNameController,
                                        quantityController,
                                        supplierController,
                                        expiryDateController,
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF4CAF50),
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 12),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      elevation: 0,
                                    ),
                                    child: Text(
                                      'ADD STOCK',
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

                          // Optional note about required fields
                          const SizedBox(height: 12),
                          Center(
                            child: Text(
                              "* Required fields",
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: Colors.grey[600],
                                fontStyle: FontStyle.italic,
                              ),
                            ),
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
  final nameController = TextEditingController(text: product['productName']);
  final categoryController = TextEditingController(text: product['category']);
  final stockController =
      TextEditingController(text: product['quantity'].toString());
  final priceController = TextEditingController(
      text: product['price'] != null ? product['price'].toString() : "");
  final supplierController = TextEditingController(text: product['supplier']);

  // Tambahkan variable untuk menyimpan path gambar
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
        // Update UI will be handled by StatefulBuilder
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
                child: Container(
                  padding: const EdgeInsets.all(24),
                  constraints: const BoxConstraints(maxWidth: 400),
                  child: SingleChildScrollView(
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
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Icon(
                                Icons.inventory_2,
                                color: Color(0xFF4AC7FF),
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

                        // Product Image
                        Center(
                          child: GestureDetector(
                            onTap: () async {
                              await _pickImage();
                              setState(() {});

                              // Refresh dialog UI
                            },
                            child: Stack(
                              children: [
                                Container(
                                  width: 120,
                                  height: 120,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    image: _selectedImageFile != null
                                        ? DecorationImage(
                                            image:
                                                FileImage(_selectedImageFile!),
                                            fit: BoxFit.cover,
                                          )
                                        : DecorationImage(
                                            image: AssetImage(product['image']),
                                            fit: BoxFit.cover,
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
                                      border: Border.all(
                                          color: Colors.white, width: 2),
                                    ),
                                    child: const Icon(
                                      Icons.edit,
                                      size: 20,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 24),

                        // Form Fields
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
                            labelText: 'Product Name',
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

                        TextField(
                          controller: supplierController,
                          decoration: InputDecoration(
                            labelText: 'Supplier',
                            labelStyle: GoogleFonts.poppins(fontSize: 14),
                            prefixIcon: const Icon(Icons.business),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 16),
                            suffixIcon: const Icon(Icons.arrow_drop_down),
                          ),
                          onTap: () {
                            // Show supplier picker dialog
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
                                                supplierController.text =
                                                    supplier;
                                                Navigator.pop(context);
                                              },
                                            ))
                                        .toList(),
                                  ],
                                ),
                              ),
                            );
                          },
                          readOnly: true,
                        ),
                        const SizedBox(height: 16),

                        Row(
                          children: [
                            // Category field (left)
                            Expanded(
                              child: TextField(
                                controller: categoryController,
                                decoration: InputDecoration(
                                  labelText: 'Category',
                                  labelStyle: GoogleFonts.poppins(fontSize: 14),
                                  prefixIcon:
                                      const Icon(Icons.category_outlined),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 12, horizontal: 16),
                                  suffixIcon: const Icon(Icons.arrow_drop_down),
                                ),
                                onTap: () {
                                  // Show category picker dialog
                                  showModalBottomSheet(
                                    context: context,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(16)),
                                    ),
                                    builder: (context) => Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 20),
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
                                            "Vitamin",
                                            "Other"
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
                                readOnly: true,
                              ),
                            ),
                            const SizedBox(width: 12),
                            // Price field (right)
                            Expanded(
                              child: TextField(
                                controller: priceController,
                                decoration: InputDecoration(
                                  labelText: 'Price',
                                  labelStyle: GoogleFonts.poppins(fontSize: 14),
                                  prefixIcon: const Icon(
                                      Icons.monetization_on_outlined),
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
                        TextField(
                          controller: stockController,
                          decoration: InputDecoration(
                            labelText: 'Initial Stock',
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

                        const SizedBox(height: 16),
                        TextField(
                          decoration: InputDecoration(
                            labelText: 'Expiry Date',
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
                              initialDate:
                                  DateTime.now().add(const Duration(days: 365)),
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
                            // Handle date selection
                          },
                        ),

                        const SizedBox(height: 24),
                        const Divider(),
                        const SizedBox(height: 16),

                        // Enhanced buttons
                        Row(
                          children: [
                            // Cancel button
                            Expanded(
                              child: OutlinedButton(
                                onPressed: () => Navigator.pop(context),
                                style: OutlinedButton.styleFrom(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 12),
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
                            // Save Changes button with enhanced shadow
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
                                    // Simulate success
                                    Navigator.pop(context);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Row(
                                          children: [
                                            const Icon(Icons.check_circle,
                                                color: Colors.white),
                                            const SizedBox(width: 12),
                                            Text(
                                              'Product updated successfully!',
                                              style: GoogleFonts.poppins(
                                                  fontSize: 14),
                                            ),
                                          ],
                                        ),
                                        backgroundColor: Colors.green,
                                        behavior: SnackBarBehavior.floating,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        margin: const EdgeInsets.all(10),
                                      ),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF4AC7FF),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 12),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  child: Text(
                                    'SAVE CHANGES',
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

// Common shadowed text field builder
Widget _buildShadowedTextField({
  required TextEditingController controller,
  required String labelText,
  required IconData prefixIcon,
  required Color colorTheme,
  IconData? suffixIcon,
  String? prefixText,
  bool readOnly = false,
  bool enabled = true,
  TextInputType keyboardType = TextInputType.text,
  VoidCallback? onTap,
}) {
  return Container(
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
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: GoogleFonts.poppins(fontSize: 14),
        prefixIcon: Icon(prefixIcon),
        prefixText: prefixText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: colorTheme),
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        suffixIcon: suffixIcon != null ? Icon(suffixIcon) : null,
        filled: true,
        fillColor: Colors.white,
        enabled: enabled,
      ),
      readOnly: readOnly,
      onTap: onTap,
      keyboardType: keyboardType,
    ),
  );
}

// Show supplier picker bottom sheet with blue theme
void _showSupplierPickerSheet(BuildContext context,
    TextEditingController controller, StateSetter setState) {
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    backgroundColor: Colors.white,
    builder: (context) => Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 0,
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag handle
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            "Select Supplier",
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 16),
          const Divider(),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                const SizedBox(height: 8),
                ...[
                  "PT Pharma Indonesia",
                  "CV Medika Jaya",
                  "PT Kimia Farma",
                  "PT Sanbe Farma"
                ]
                    .map((supplier) => Container(
                          margin: const EdgeInsets.only(bottom: 8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                spreadRadius: 0,
                                blurRadius: 3,
                                offset: const Offset(0, 1),
                              ),
                            ],
                          ),
                          child: ListTile(
                            leading: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: const Color(0xFF4AC7FF).withOpacity(0.1),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.business_outlined,
                                color: Color(0xFF4AC7FF),
                                size: 20,
                              ),
                            ),
                            title: Text(
                              supplier,
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              ),
                            ),
                            trailing: controller.text == supplier
                                ? const Icon(Icons.check_circle,
                                    color: Color(0xFF4AC7FF))
                                : null,
                            onTap: () {
                              setState(() {
                                controller.text = supplier;
                              });
                              Navigator.pop(context);
                            },
                          ),
                        ))
                    .toList(),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

// Show supplier picker bottom sheet with green theme
void _showSupplierPickerSheetGreen(
    BuildContext context, TextEditingController controller) {
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    backgroundColor: Colors.white,
    builder: (context) => Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 0,
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag handle
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            "Select Supplier",
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 16),
          const Divider(),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                const SizedBox(height: 8),
                ...[
                  "PT Pharma Indonesia",
                  "CV Medika Jaya",
                  "PT Kimia Farma",
                  "PT Sanbe Farma"
                ]
                    .map((supplier) => Container(
                          margin: const EdgeInsets.only(bottom: 8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                spreadRadius: 0,
                                blurRadius: 3,
                                offset: const Offset(0, 1),
                              ),
                            ],
                          ),
                          child: ListTile(
                            leading: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: const Color(0xFF4CAF50).withOpacity(0.1),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.business_outlined,
                                color: Color(0xFF4CAF50),
                                size: 20,
                              ),
                            ),
                            title: Text(
                              supplier,
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              ),
                            ),
                            trailing: controller.text == supplier
                                ? const Icon(Icons.check_circle,
                                    color: Color(0xFF4CAF50))
                                : null,
                            onTap: () {
                              controller.text = supplier;
                              Navigator.pop(context);
                            },
                          ),
                        ))
                    .toList(),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

// Show category picker bottom sheet
void _showCategoryPickerSheet(BuildContext context,
    TextEditingController controller, StateSetter setState) {
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    backgroundColor: Colors.white,
    builder: (context) => Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 0,
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag handle
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            "Select Category",
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 16),
          const Divider(),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                const SizedBox(height: 8),
                ...[
                  {"name": "Analgesic", "icon": Icons.healing},
                  {"name": "Antibiotic", "icon": Icons.bug_report},
                  {"name": "Gastric", "icon": Icons.food_bank},
                  {"name": "Antihistamine", "icon": Icons.ac_unit},
                  {"name": "Vitamin", "icon": Icons.fitbit}
                ]
                    .map((category) => Container(
                          margin: const EdgeInsets.only(bottom: 8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                spreadRadius: 0,
                                blurRadius: 3,
                                offset: const Offset(0, 1),
                              ),
                            ],
                          ),
                          child: ListTile(
                            leading: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: const Color(0xFF4AC7FF).withOpacity(0.1),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                category["icon"] as IconData,
                                color: const Color(0xFF4AC7FF),
                                size: 20,
                              ),
                            ),
                            title: Text(
                              category["name"] as String,
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              ),
                            ),
                            trailing: controller.text == category["name"]
                                ? const Icon(Icons.check_circle,
                                    color: Color(0xFF4AC7FF))
                                : null,
                            onTap: () {
                              setState(() {
                                controller.text = category["name"] as String;
                              });
                              Navigator.pop(context);
                            },
                          ),
                        ))
                    .toList(),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

// Show product search dialog
void _showProductSearchDialog(
    BuildContext context, TextEditingController controller) {
  showDialog(
      context: context,
      builder: (context) => Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            backgroundColor: Colors.white,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 0,
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(24),
              width: double.maxFinite,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header with search icon
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: const Color(0xFF4CAF50).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(
                          Icons.search,
                          color: Color(0xFF4CAF50),
                          size: 22,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        "Select Product",
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Enhanced search field
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
                      decoration: InputDecoration(
                        hintText: 'Search products...',
                        hintStyle: GoogleFonts.poppins(fontSize: 14),
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.grey[300]!),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.grey[300]!),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: Color(0xFF4CAF50)),
                        ),
                        contentPadding: EdgeInsets.zero,
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Divider(),

                  // Product list with enhanced styling
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxHeight: 300),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: 4,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                spreadRadius: 0,
                                blurRadius: 6,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: ListTile(
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            leading: Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.15),
                                    spreadRadius: 0,
                                    blurRadius: 4,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.asset(
                                  'assets/produk/Paracetamol.jpg',
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.cover,
                                  errorBuilder: (ctx, err, _) => Container(
                                    color: Colors.grey[200],
                                    child: const Icon(Icons.medication,
                                        color: Colors.grey),
                                  ),
                                ),
                              ),
                            ),
                            title: Text(
                              [
                                "Paracetamol",
                                "Amoxicillin",
                                "Omeprazole",
                                "Loratadine"
                              ][index],
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            subtitle: Text(
                              [
                                "Analgesic",
                                "Antibiotic",
                                "Gastric",
                                "Antihistamine"
                              ][index],
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: Colors.grey[600],
                              ),
                            ),
                            trailing: Icon(
                              Icons.chevron_right,
                              color: Colors.grey[400],
                            ),
                            onTap: () {
                              controller.text = [
                                "Paracetamol",
                                "Amoxicillin",
                                "Omeprazole",
                                "Loratadine"
                              ][index];
                              Navigator.pop(context);
                            },
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Cancel button
                  SizedBox(
                    width: double.infinity,
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
                ],
              ),
            ),
          ));
}

// Validation and save for Add Product
void _validateAndSaveProduct(
  BuildContext context,
  File? selectedImageFile,
  TextEditingController nameController,
  TextEditingController categoryController,
  TextEditingController stockController,
  TextEditingController priceController,
  TextEditingController supplierController,
  TextEditingController expiryController,
) {
  // Image validation
  if (selectedImageFile == null) {
    _showErrorSnackBar(context, 'Please select a product image');
    return;
  }

  // Required fields validation
  if (nameController.text.isEmpty ||
      categoryController.text.isEmpty ||
      stockController.text.isEmpty ||
      priceController.text.isEmpty ||
      supplierController.text.isEmpty ||
      expiryController.text.isEmpty) {
    _showErrorSnackBar(context, 'Please fill all required fields');
    return;
  }

  // Success case
  Navigator.pop(context);
  _showSuccessDialog(context, nameController.text);
}

// Validation and save for Add Stock
void _validateAndSaveStock(
  BuildContext context,
  TextEditingController productNameController,
  TextEditingController quantityController,
  TextEditingController supplierController,
  TextEditingController expiryDateController,
) {
  if (productNameController.text.isEmpty ||
      quantityController.text.isEmpty ||
      supplierController.text.isEmpty ||
      expiryDateController.text.isEmpty) {
    _showErrorSnackBar(context, 'Please fill all required fields');
    return;
  }

  // Success case
  Navigator.pop(context);
  _showSuccessSnackBar(context, 'Stock added successfully!');
}

// Error SnackBar
void _showErrorSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: GoogleFonts.poppins(),
      ),
      backgroundColor: Colors.red,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
  );
}

// Success SnackBar
void _showSuccessSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Row(
        children: [
          const Icon(Icons.check_circle, color: Colors.white),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              style: GoogleFonts.poppins(fontSize: 14),
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
      action: SnackBarAction(
        label: 'VIEW',
        textColor: Colors.white,
        onPressed: () {},
      ),
    ),
  );
}

// Success dialog after product addition
void _showSuccessDialog(BuildContext context, String productName) {
  showDialog(
      context: context,
      builder: (context) => Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            backgroundColor: Colors.white,
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
                  // Success icon
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
                              // Open Add Stock dialog for this product
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
