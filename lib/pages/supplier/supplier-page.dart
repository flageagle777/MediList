import 'package:medilist/pages/stock/stock-in.dart';
import 'package:medilist/pages/stock/stock-out.dart';
import 'package:medilist/pages/produk/produk-page.dart';
import 'package:medilist/pages/report/report-page.dart';
import 'package:medilist/pages/history/history-page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fl_chart/fl_chart.dart';

class SupplierPage extends StatefulWidget {
  const SupplierPage({super.key});

  @override
  State<SupplierPage> createState() => _SupplierPageState();
}

class _SupplierPageState extends State<SupplierPage> {
  // Data supplier contoh
  final List<Map<String, dynamic>> suppliers = [
    {
      'name': 'PT Kimia Farma',
      'email': 'procurement@kimiafarma.co.id',
      'phone': '+62219999777',
      'orders': 120,
      'rating': 4.9,
      'color': const Color(0xFF4AC7FF),
    },
    {
      'name': 'CV Medika Utama',
      'email': 'orders@medikautama.co.id',
      'phone': '+62219876543',
      'orders': 85,
      'rating': 4.7,
      'color': const Color(0xFF4CAF50),
    },
    {
      'name': 'PT Kalbe Farma',
      'email': 'supply@kalbefarma.com',
      'phone': '+62218765432',
      'orders': 65,
      'rating': 4.5,
      'color': const Color(0xFFFF9800),
    },
    {
      'name': 'PT Indofarma Global',
      'email': 'sales@indofarma.co.id',
      'phone': '+62217654321',
      'orders': 45,
      'rating': 4.2,
      'color': const Color(0xFF9C27B0),
    },
    {
      'name': 'CV Sehat Sejahtera',
      'email': 'order@sehatshop.net',
      'phone': '+62216543210',
      'orders': 30,
      'rating': 4.0,
      'color': const Color(0xFFF44336),
    }
  ];

  // Controllers untuk form
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _fullNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  // Perbaikan untuk dialog Add Supplier yang mengalami overflow
  void _showAddSupplierDialog() {
    _nameController.clear();
    _fullNameController.clear();
    _emailController.clear();
    _phoneController.clear();

    // Form validation state
    final _formKey = GlobalKey<FormState>();
    bool _isSubmitting = false;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(builder: (context, setState) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          backgroundColor: Colors.white, // Ensure white background, not pink
          child: Container(
            width: double.maxFinite,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  spreadRadius: 0,
                ),
              ],
            ),
            child: SingleChildScrollView(
              // Tambahkan SingleChildScrollView di sini
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Dialog Header
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: const Color(0xFF4AC7FF).withOpacity(0.2),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.person_add,
                              color: Color(0xFF4AC7FF), size: 24),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          'Add New Supplier',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Divider
                    const Divider(),
                    const SizedBox(height: 20),

                    // Form Fields
                    Text(
                      'Supplier Information',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[700],
                      ),
                    ),
                    const SizedBox(height: 16),

                    TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        labelText: 'Supplier Name',
                        hintText: 'Enter company name',
                        prefixIcon: const Icon(Icons.business,
                            color: Color(0xFF4AC7FF)),
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
                              const BorderSide(color: Color(0xFF4AC7FF)),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.red),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Supplier name is required';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    TextFormField(
                      controller: _fullNameController,
                      decoration: InputDecoration(
                        labelText: 'Full Name',
                        hintText: 'Enter contact person name',
                        prefixIcon:
                            const Icon(Icons.person, color: Color(0xFF4AC7FF)),
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
                              const BorderSide(color: Color(0xFF4AC7FF)),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.red),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Contact person name is required';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        hintText: 'Enter email address',
                        prefixIcon: const Icon(Icons.email_outlined,
                            color: Color(0xFF4AC7FF)),
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
                              const BorderSide(color: Color(0xFF4AC7FF)),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.red),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Email is required';
                        }
                        // Basic email validation
                        final emailRegex =
                            RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                        if (!emailRegex.hasMatch(value)) {
                          return 'Enter a valid email address';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    TextFormField(
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        labelText: 'Phone',
                        hintText: 'Enter phone number',
                        prefixIcon:
                            const Icon(Icons.phone, color: Color(0xFF4AC7FF)),
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
                              const BorderSide(color: Color(0xFF4AC7FF)),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.red),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Phone number is required';
                        }
                        // Basic phone validation (adjust as needed)
                        if (value.length < 10) {
                          return 'Enter a valid phone number';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),

                    // Action Buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        OutlinedButton(
                          onPressed: _isSubmitting
                              ? null
                              : () => Navigator.pop(context),
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: Colors.grey[400]!),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            'Cancel',
                            style: GoogleFonts.poppins(
                              color: Colors.grey[700],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF4AC7FF),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: _isSubmitting
                              ? null
                              : () async {
                                  if (_formKey.currentState!.validate()) {
                                    // Set loading state
                                    setState(() => _isSubmitting = true);

                                    try {
                                      // Simulate API call with delay
                                      await Future.delayed(
                                          const Duration(seconds: 1));

                                      // Create new supplier object here
                                      // final newSupplier = {
                                      //   'name': _nameController.text,
                                      //   'fullName': _fullNameController.text,
                                      //   'email': _emailController.text,
                                      //   'phone': _phoneController.text,
                                      //   'orders': 0,
                                      //   'rating': 0.0,
                                      //   'color': const Color(0xFF607D8B),
                                      // };
                                      // Here you would add the new supplier to your list

                                      Navigator.pop(context);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Row(
                                            children: [
                                              const Icon(Icons.check_circle,
                                                  color: Colors.white),
                                              const SizedBox(width: 12),
                                              Flexible(
                                                child: Text(
                                                  'New supplier has been added!',
                                                  style: GoogleFonts.poppins(),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
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
                                    } catch (e) {
                                      // Handle error
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content:
                                              Text('Error: ${e.toString()}'),
                                          backgroundColor: Colors.red,
                                        ),
                                      );
                                    } finally {
                                      // Reset loading state if dialog is still visible
                                      if (mounted)
                                        setState(() => _isSubmitting = false);
                                    }
                                  }
                                },
                          child: _isSubmitting
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2.0,
                                  ),
                                )
                              : Text(
                                  'Add Supplier',
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
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
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Changed from pink/grey to white
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top section with add button and summary
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFF4AC7FF), Color(0xFF2196F3)],
                  ),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF4AC7FF).withOpacity(0.3),
                      spreadRadius: 0,
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${suppliers.length} Suppliers',
                            style: GoogleFonts.poppins(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Manage your suppliers and track performance',
                            style: GoogleFonts.poppins(
                              color: Colors.white.withOpacity(0.9),
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: _showAddSupplierDialog,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 3,
                      ),
                      icon: const Icon(Icons.add,
                          color: Color(0xFF4AC7FF), size: 20),
                      label: Text(
                        "Add Supplier",
                        style: GoogleFonts.poppins(
                          color: const Color(0xFF4AC7FF),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Top Suppliers Section with Pie Chart
              Text(
                "Top Suppliers",
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 16),
              Container(
                height: 450,
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
                  children: [
                    // Top 3 Podium
                    SizedBox(
                      height: 120,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          // Top 2
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              _buildMedalIcon(2, const Color(0xFFAAAAAA)),
                              const SizedBox(height: 6),
                              Container(
                                width: 80,
                                height: 60,
                                decoration: BoxDecoration(
                                  color: suppliers[1]['color'],
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(8),
                                    topRight: Radius.circular(8),
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: suppliers[1]['color']
                                          .withOpacity(0.3),
                                      spreadRadius: 0,
                                      blurRadius: 6,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      suppliers[1]['name']
                                          .toString()
                                          .split(' ')[1],
                                      style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      '${suppliers[1]['orders']} orders',
                                      style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontSize: 10,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          // Top 1
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                _buildMedalIcon(1, const Color(0xFFFFD700)),
                                const SizedBox(height: 6),
                                Container(
                                  width: 80,
                                  height: 80,
                                  decoration: BoxDecoration(
                                    color: suppliers[0]['color'],
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(8),
                                      topRight: Radius.circular(8),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: suppliers[0]['color']
                                            .withOpacity(0.3),
                                        spreadRadius: 0,
                                        blurRadius: 6,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        suppliers[0]['name']
                                            .toString()
                                            .split(' ')[1],
                                        style: GoogleFonts.poppins(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        '${suppliers[0]['orders']} orders',
                                        style: GoogleFonts.poppins(
                                          color: Colors.white,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // Top 3
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              _buildMedalIcon(3, const Color(0xFFCD7F32)),
                              const SizedBox(height: 6),
                              Container(
                                width: 80,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: suppliers[2]['color'],
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(8),
                                    topRight: Radius.circular(8),
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: suppliers[2]['color']
                                          .withOpacity(0.3),
                                      spreadRadius: 0,
                                      blurRadius: 6,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      suppliers[2]['name']
                                          .toString()
                                          .split(' ')[1],
                                      style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    Text(
                                      '${suppliers[2]['orders']} orders',
                                      style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontSize: 9,
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

                    const SizedBox(height: 20),
                    const Divider(),
                    const SizedBox(height: 50),

                    // Pie Chart
                    Row(
                      children: [
                        // Pie chart
                        Expanded(
                          flex: 3,
                          child: SizedBox(
                            height: 180,
                            child: PieChart(
                              PieChartData(
                                sections: suppliers.take(5).map((supplier) {
                                  return PieChartSectionData(
                                    value: supplier['orders'].toDouble(),
                                    title: '',
                                    color: supplier['color'],
                                    radius: 75,
                                    titleStyle: GoogleFonts.poppins(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  );
                                }).toList(),
                                centerSpaceRadius: 40,
                                sectionsSpace: 2,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(width: 30),

                        // Legend
                        Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Order Distribution',
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                ),
                              ),
                              const SizedBox(height: 16),
                              ...suppliers.take(5).map((supplier) {
                                final index = suppliers.indexOf(supplier);
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 8),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 12,
                                        height: 12,
                                        decoration: BoxDecoration(
                                          color: supplier['color'],
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: Text(
                                          supplier['name']
                                              .toString()
                                              .split(' ')
                                              .last,
                                          style: GoogleFonts.poppins(
                                            fontSize: 12,
                                            color: Colors.grey[800],
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // All Suppliers List
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "All Suppliers",
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () {
                      // View all suppliers
                    },
                    icon: const Icon(Icons.sort, size: 18),
                    label: Text('Sort by', style: GoogleFonts.poppins()),
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.grey[700],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Supplier List Cards
              ...suppliers.asMap().entries.map((entry) {
                final index = entry.key;
                final supplier = entry.value;
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 0,
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    leading: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: supplier['color'].withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          supplier['name'].substring(0, 1),
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: supplier['color'],
                          ),
                        ),
                      ),
                    ),
                    title: Text(
                      supplier['name'],
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 2),
                        Text(
                          supplier['email'],
                          style: GoogleFonts.poppins(
                            color: Colors.grey[600],
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(
                              Icons.shopping_bag_outlined,
                              size: 14,
                              color: Colors.grey[600],
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '${supplier['orders']} orders',
                              style: GoogleFonts.poppins(
                                color: Colors.grey[600],
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Icon(
                              Icons.star,
                              size: 14,
                              color: Colors.amber,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '${supplier['rating']}',
                              style: GoogleFonts.poppins(
                                color: Colors.grey[600],
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.more_vert),
                      onPressed: () {
                        showModalBottomSheet(
                            context: context,
                            backgroundColor: Colors.transparent,
                            isScrollControlled: true,
                            builder: (context) => Container(
                                  padding: const EdgeInsets.all(24),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: const BorderRadius.vertical(
                                        top: Radius.circular(20)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.15),
                                        blurRadius: 15,
                                        spreadRadius: 0,
                                        offset: const Offset(0, -5),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            width: 40,
                                            height: 40,
                                            decoration: BoxDecoration(
                                              color: supplier['color']
                                                  .withOpacity(0.2),
                                              shape: BoxShape.circle,
                                            ),
                                            child: Center(
                                              child: Text(
                                                supplier['name']
                                                    .substring(0, 1),
                                                style: GoogleFonts.poppins(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color: supplier['color'],
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 12),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  supplier['name'],
                                                  style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                                Text(
                                                  supplier['email'],
                                                  style: GoogleFonts.poppins(
                                                    color: Colors.grey[600],
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 16),
                                      const Divider(),
                                      const SizedBox(height: 8),
                                      Text(
                                        'Supplier Actions',
                                        style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.grey[700],
                                        ),
                                      ),
                                      const SizedBox(height: 16),
                                      InkWell(
                                        onTap: () {
                                          Navigator.pop(context);
                                          // Handle edit supplier
                                        },
                                        borderRadius: BorderRadius.circular(12),
                                        child: Ink(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16, vertical: 12),
                                          decoration: BoxDecoration(
                                            color: Colors.blue[50],
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          child: Row(
                                            children: [
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(8),
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  shape: BoxShape.circle,
                                                ),
                                                child: Icon(Icons.edit,
                                                    color: Colors.blue,
                                                    size: 20),
                                              ),
                                              const SizedBox(width: 16),
                                              Expanded(
                                                child: Text(
                                                  'Edit Supplier',
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.blue,
                                                  ),
                                                ),
                                              ),
                                              Icon(Icons.arrow_forward_ios,
                                                  color: Colors.blue, size: 16),
                                            ],
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 12),
                                      Row(
                                        children: [
                                          // Call button
                                          Expanded(
                                            child: InkWell(
                                              onTap: () {
                                                Navigator.pop(context);
                                                // Handle call supplier
                                              },
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              child: Ink(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 16,
                                                        vertical: 16),
                                                decoration: BoxDecoration(
                                                  color: Colors.green[50],
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                ),
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8),
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        shape: BoxShape.circle,
                                                      ),
                                                      child: Icon(Icons.phone,
                                                          color: Colors.green,
                                                          size: 20),
                                                    ),
                                                    const SizedBox(height: 8),
                                                    Text(
                                                      'Call',
                                                      style:
                                                          GoogleFonts.poppins(
                                                        fontSize: 13,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Colors.green,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 12),
                                          // Email button
                                          Expanded(
                                            child: InkWell(
                                              onTap: () {
                                                Navigator.pop(context);
                                                // Handle email supplier
                                              },
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              child: Ink(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 16,
                                                        vertical: 16),
                                                decoration: BoxDecoration(
                                                  color: Colors.orange[50],
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                ),
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8),
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        shape: BoxShape.circle,
                                                      ),
                                                      child: Icon(
                                                          Icons.email_outlined,
                                                          color: Colors.orange,
                                                          size: 20),
                                                    ),
                                                    const SizedBox(height: 8),
                                                    Text(
                                                      'Email',
                                                      style:
                                                          GoogleFonts.poppins(
                                                        fontSize: 13,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Colors.orange,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 12),
                                          // Delete button
                                          Expanded(
                                            child: InkWell(
                                              onTap: () {
                                                Navigator.pop(context);
                                                // Handle delete supplier with confirmation
                                              },
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              child: Ink(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 16,
                                                        vertical: 16),
                                                decoration: BoxDecoration(
                                                  color: Colors.red[50],
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                ),
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8),
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        shape: BoxShape.circle,
                                                      ),
                                                      child: Icon(
                                                          Icons.delete_outline,
                                                          color: Colors.red,
                                                          size: 20),
                                                    ),
                                                    const SizedBox(height: 8),
                                                    Text(
                                                      'Delete',
                                                      style:
                                                          GoogleFonts.poppins(
                                                        fontSize: 13,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Colors.red,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ));
                      },
                    ),
                    onTap: () {
                      // Navigate to supplier details
                    },
                  ),
                );
              }).toList(),
            ],
          ),
        ),
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
                                'Supplier Management',
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
                      isActive: true,
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
      floatingActionButton: FloatingActionButton.extended(
        // Changed to extended for better usability
        backgroundColor: const Color(0xFF4AC7FF),
        onPressed: _showAddSupplierDialog,
        elevation: 4,
        icon: const Icon(Icons.person_add, color: Colors.white),
        label: Text(
          'Add Supplier',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
        tooltip: 'Add Supplier',
      ),
    );
  }

  // Helper method to build medal icons
  Widget _buildMedalIcon(int rank, Color color) {
    IconData icon = Icons.emoji_events;

    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.3),
            spreadRadius: 0,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Icon(
        icon,
        color: color,
        size: 20,
      ),
    );
  }

  // Add this method inside the _SupplierPageState class
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
