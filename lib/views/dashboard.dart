import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(home: SalesSummaryPage()));
}

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
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Image.asset(
          "assets/medilist2.png",
          width: 100,),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(child: Text('Menu')),
            ListTile(
              leading: const Icon(Icons.input),
              title: const Text('STOCK IN'),
              onTap: () => _navigateTo(const DummyPage(title: 'STOCK IN')),
            ),
            ListTile(
              leading: const Icon(Icons.output),
              title: const Text('STOCK OUT'),
              onTap: () => _navigateTo(const DummyPage(title: 'STOCK OUT')),
            ),
            ListTile(
              leading: const Icon(Icons.inventory),
              title: const Text('PRODUCT'),
              onTap: () => _navigateTo(const DummyPage(title: 'PRODUCT')),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('SUPPLIER'),
              onTap: () => _navigateTo(const DummyPage(title: 'SUPPLIER')),
            ),
            ListTile(
              leading: const Icon(Icons.receipt),
              title: const Text('REPORT'),
              onTap: () => _navigateTo(const DummyPage(title: 'REPORT')),
            ),
            ListTile(
              leading: const Icon(Icons.history),
              title: const Text('HISTORY'),
              onTap: () => _navigateTo(const DummyPage(title: 'HISTORY')),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Sales Summary", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),

            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                _summaryCard(Icons.attach_money, "Rp.2.577.500", "Today's Sale"),
                _summaryCard(Icons.bar_chart, "Rp.30.460.600", "Yearly Total Sales"),
                _summaryCard(Icons.account_balance_wallet, "Rp.1.261.790", "Net Income"),
                _summaryCard(Icons.inventory_2, "343", "Products"),
              ],
            ),

            const SizedBox(height: 20),
            const Text("Menu", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),

            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _IconButtonItem(icon: Icons.input, label: 'STOCK IN', onTap: () {
                  _navigateTo(const DummyPage(title: 'STOCK IN'));
                }),
                _IconButtonItem(icon: Icons.output, label: 'STOCK OUT', onTap: () {
                  _navigateTo(const DummyPage(title: 'STOCK OUT'));
                }),
                _IconButtonItem(icon: Icons.inventory, label: 'PRODUCT', onTap: () {
                  _navigateTo(const DummyPage(title: 'PRODUCT'));
                }),
                _IconButtonItem(icon: Icons.person, label: 'SUPPLIER', onTap: () {
                  _navigateTo(const DummyPage(title: 'SUPPLIER'));
                }),
                _IconButtonItem(icon: Icons.receipt, label: 'REPORT', onTap: () {
                  _navigateTo(const DummyPage(title: 'REPORT'));
                }),
                _IconButtonItem(icon: Icons.history, label: 'HISTORY', onTap: () {
                  _navigateTo(const DummyPage(title: 'HISTORY'));
                }),
              ],
            ),

            const SizedBox(height: 20),
            const Text("Stock Report", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),

            Column(
              children: stockData.map((item) {
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  color: Colors.lightBlue[700],
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(item['medicine'], style: const TextStyle(color: Colors.white)),
                        Text("Stock: ${item['stock']}", style: const TextStyle(color: Colors.white)),
                        Text("Exp: ${item['expDate']}", style: const TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _summaryCard(IconData icon, String amount, String label) {
    final double cardWidth = (MediaQuery.of(context).size.width - 52) / 2;
    return Container(
      width: cardWidth,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.blue[600],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white),
          const SizedBox(height: 8),
          Text(amount, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          Text(label, style: const TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
}

class _IconButtonItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _IconButtonItem({required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: Colors.black,
            radius: 28,
            child: Icon(icon, color: Colors.white, size: 28),
          ),
          const SizedBox(height: 5),
          Text(label),
        ],
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
      appBar: AppBar(title: Text(title)),
      body: Center(child: Text('$title Page')),
    );
  }
}
