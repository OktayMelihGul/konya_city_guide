import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class TransportationPage extends StatelessWidget {
  const TransportationPage({super.key});

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri uri = Uri.parse('tel:$phoneNumber');
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $phoneNumber');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Public Transportation'),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        padding: const EdgeInsets.all(16),
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        children: [
          _TransportCard(
            icon: Icons.directions_bus_filled_rounded,
            title: 'Bus',
            color: Colors.blue,
            onTap: () =>
                _launchURL('https://atus.konya.bel.tr/atus/where-is-my-bus1'),
          ),
          _TransportCard(
            icon: Icons.tram_rounded,
            title: 'Tram',
            color: Colors.red,
            onTap: () =>
                _launchURL('https://atus.konya.bel.tr/atus/where-is-the-tram'),
          ),
          _TransportCard(
            icon: Icons.local_taxi_rounded,
            title: 'Taxi',
            color: Colors.amber,
            onTap: () => _makePhoneCall('+903322650215'),
          ),
          _TransportCard(
            icon: Icons.pedal_bike_rounded,
            title: 'Bicycle',
            color: Colors.green,
            onTap: () => _launchURL(
                'https://play.google.com/store/apps/details?id=com.linkago.mediaport.aos.aos&pli=1'),
          ),
          _TransportCard(
            icon: Icons.electric_scooter_rounded,
            title: 'E-Scooter',
            color: Colors.purple,
            onTap: () => _launchURL(
                'https://play.google.com/store/apps/details?id=com.BINBIN'),
          ),
        ],
      ),
    );
  }
}

class _TransportCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color color;
  final VoidCallback onTap;

  const _TransportCard({
    required this.icon,
    required this.title,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 48,
              color: color,
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
