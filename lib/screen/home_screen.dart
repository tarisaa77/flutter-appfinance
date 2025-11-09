//home_screen.dart
import 'package:flutter/material.dart';
import '../../widgets/atm_card.dart';
import '../../widgets/transaction_item.dart';
import '../../models/transaction.dart';
import '../../widgets/grid_menu_item.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final transactions = [
      TransactionModel('Mie Jangkoeng', '-Rp35.000', 'Food'),
      TransactionModel('Bobocabin', '-Rp625.000', 'Travel'),
      TransactionModel('Pilates', '-Rp550.000', 'Health'),
      TransactionModel('Seminar', '-Rp60.000', 'Event'),
      TransactionModel('Salary', '+Rp15.000.000', 'Income'),
    ];

    return Scaffold(
      // ===== Gradient Background =====
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFF4AFC3), Color(0xFFF4AFC3)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ===== AppBar Custom =====
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Finance Mate',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    CircleAvatar(
                      radius: 20,
                      backgroundImage: AssetImage('assets/ava.jpeg'),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // ===== Title =====
                const Text(
                  'My Cards',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 12),

                SizedBox(
                  height: 200,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: const [
                      AtmCard(
                        bankName: 'BANK BCA',
                        cardNumber: '**** 2345',
                        balance: 'Rp7.500.000',
                        backgroundImage: 'assets/bankbca.jpeg',
                      ),
                      AtmCard(
                        bankName: 'BANK BNI',
                        cardNumber: '**** 6666',
                        balance: 'Rp50.350.000',
                        backgroundImage: 'assets/bankbni.jpeg',
                      ),
                      AtmCard(
                        bankName: 'BANK BRI',
                        cardNumber: '**** 2231',
                        balance: 'Rp8.890.000',
                        backgroundImage: 'assets/bankbri.jpeg',
                      ),
                      AtmCard(
                        bankName: 'BANK MANDIRI',
                        cardNumber: '**** 7659',
                        balance: 'Rp18.300.000',
                        backgroundImage: 'assets/bankmandiri.jpeg',
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                const Text(
                  'Menu',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 140,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      _animatedMenuItem(
                        Icons.health_and_safety,
                        'Health',
                        Colors.greenAccent,
                        0,
                      ),
                      _animatedMenuItem(
                        Icons.travel_explore,
                        'Travel',
                        Colors.blueAccent,
                        1,
                      ),
                      _animatedMenuItem(
                        Icons.fastfood,
                        'Food',
                        Colors.yellowAccent,
                        2,
                      ),
                      _animatedMenuItem(
                        Icons.event,
                        'Event',
                        Colors.pinkAccent,
                        3,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                const Text(
                  'Recent Transactions',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),

                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: transactions.length,
                  itemBuilder: (context, index) {
                    return TweenAnimationBuilder(
                      tween: Tween<Offset>(
                        begin: const Offset(-1, 0),
                        end: const Offset(0, 0),
                      ),
                      duration: Duration(milliseconds: 300 + (index * 100)),
                      builder: (context, Offset offset, child) {
                        return Transform.translate(
                          offset: Offset(offset.dx * 200, 0),
                          child: Opacity(
                            opacity: 1 - offset.dx.abs(),
                            child: child,
                          ),
                        );
                      },
                      child: TransactionItem(transaction: transactions[index]),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _animatedMenuItem(
    IconData icon,
    String label,
    Color color,
    int index,
  ) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0.8, end: 1.0),
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOut,
      builder: (context, double scale, child) {
        return Transform.scale(
          scale: scale,
          child: Container(
            width: 140,
            margin: EdgeInsets.only(right: index == 3 ? 0 : 16),
            child: GridMenuItem(icon: icon, label: label, color: color),
          ),
        );
      },
    );
  }
}