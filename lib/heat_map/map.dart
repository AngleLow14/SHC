import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'dart:math' as math;

class HeatMapApp extends StatelessWidget {
  const HeatMapApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HeatMapScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HeatMapScreen extends StatefulWidget {
  const HeatMapScreen({super.key});

  @override
  State<HeatMapScreen> createState() => _HeatMapScreenState();
}

class _HeatMapScreenState extends State<HeatMapScreen> {
  final List<Map<String, dynamic>> barangays = [
    // barangay 1
    {
      "name": "Santa Catalina",
      "center": LatLng(14.126699234904981, 121.34569592230034),
      "cases": 1,
    },
    {
      "name": "San Buenaventura",
      "center": LatLng(14.117819846408196, 121.33079391353299),
      "cases": 201,
    },
    {
      "name": "San Lorenzo",
      "center": LatLng(14.110606462445773, 121.35230882303901),
      "cases": 401,
    },
    {
      "name": "Santo Angel",
      "center": LatLng(14.105403719124766, 121.36865013870252),
      "cases": 601,
    },
    {
      "name": "San Mateo",
      "center": LatLng(14.109184692053718, 121.29907585679572),
      "cases": 0,
    },
    {
      "name": "Dolores",
      "center": LatLng(14.102789184168682, 121.33341376244512),
      "cases": 200,
    },
    {
      "name": "San Marcos",
      "center": LatLng(14.103311365270002, 121.30303839144838),
      "cases": 0,
    },
    {
      "name": "Santa Maria Magdalena",
      "center": LatLng(14.09630456398764, 121.31044797316588),
      "cases": 0,
    },
    {
      "name": "San Pedro",
      "center": LatLng(14.093592182111163, 121.33584150524842),
      "cases": 0,
    },
    {
      "name": "San Lucas 2",
      "center": LatLng(14.089829237862235, 121.32680348109213),
      "cases": 0,
    },
    {
      "name": "San Juan",
      "center": LatLng(14.092725291883346, 121.29998731648094),
      "cases": 0,
    },
    {
      "name": "San Diego",
      "center": LatLng(14.08868355986889, 121.36661070931122),
      "cases": 0,
    },
    {
      "name": "Santa Isabel",
      "center": LatLng(14.081122463915857, 121.38032810753329),
      "cases": 0,
    },
    {
      "name": "Santa Felomina",
      "center": LatLng(14.088915145817364, 121.28879222162092),
      "cases": 0,
    },
    {
      "name": "Del Remedio",
      "center": LatLng(14.084650802947115, 121.31022831658115),
      "cases": 0,
    },
    {
      "name": "San Lucas 1",
      "center": LatLng(14.082459238557192, 121.3247341816932),
      "cases": 0,
    },
    {
      "name": "Concepcion",
      "center": LatLng(14.078990049407135, 121.33892262918081),
      "cases": 0,
    },
    {
      "name": "Barangay VI-E",
      "center": LatLng(14.07526283001729, 121.3171837594464),
      "cases": 0,
    },
    {
      "name": "Barangay VI-D",
      "center": LatLng(14.078976852964995, 121.32046687534452),
      "cases": 100,
    },
    {
      "name": "Barangay V-A",
      "center": LatLng(14.076162292420914, 121.32485084649846),
      "cases": 0,
    },
    {
      "name": "San Crispin",
      "center": LatLng(14.079628014269478, 121.28193510681486),
      "cases": 0,
    },
    {
      "name": "Bagong Pook VI-C",
      "center": LatLng(14.076648038836144, 121.3212939898413),
      "cases": 0,
    },
    {
      "name": "Barangay VI-A",
      "center": LatLng(14.073332595972014, 121.32315726505006),
      "cases": 0,
    },
    {
      "name": "Barangay VI-B",
      "center": LatLng(14.074597596009433, 121.3220910290521),
      "cases": 0,
    },
    {
      "name": "Barangay IV-A",
      "center": LatLng(14.072600731609281, 121.33167146926866),
      "cases": 0,
    },
    {
      "name": "Barangay V-D",
      "center": LatLng(14.072316900971067, 121.32557385994629),
      "cases": 0,
    },
    {
      "name": "San Roque",
      "center": LatLng(14.064020608707095, 121.31028299437315),
      "cases": 0,
    },
    {
      "name": "Barangay V-B",
      "center": LatLng(14.07283855534443, 121.32454957112239),
      "cases": 0,
    },
    {
      "name": "Barangay I-A",
      "center": LatLng(14.072593344946206, 121.31778940974219),
      "cases": 0,
    },
    {
      "name": "Barangay IV-C",
      "center": LatLng(14.072020275751802, 121.32636650999929),
      "cases": 0,
    },
    {
      "name": "Barangay V-C",
      "center": LatLng(14.072636243919442, 121.32505863857855),
      "cases": 0,
    },
    {
      "name": "Barangay IV-B",
      "center": LatLng(14.071885452238606, 121.32754857466729),
      "cases": 0,
    },
    {
      "name": "Barangay III-E",
      "center": LatLng(14.072028721963171, 121.33373997745534),
      "cases": 0,
    },
    {
      "name": "San Rafael",
      "center": LatLng(14.071135878263535, 121.30527050509339),
      "cases": 0,
    },
    {
      "name": "Barangay VII-A",
      "center": LatLng(14.070577159977086, 121.32178233301684),
      "cases": 0,
    },
    {
      "name": "Barangay III-D",
      "center": LatLng(14.069940699093737, 121.33130849439709),
      "cases": 0,
    },
    {
      "name": "Barangay I-B",
      "center": LatLng(14.069570823528196, 121.31607631556095),
      "cases": 0,
    },
    {
      "name": "Barangay VII-B",
      "center": LatLng(14.069867338719913, 121.32358279228612),
      "cases": 0,
    },
    {
      "name": "Barangay III-B",
      "center": LatLng(14.06969820787994, 121.32733704280027),
      "cases": 0,
    },
    {
      "name": "Barangay II-A",
      "center": LatLng(14.062708694889048, 121.31994098646737),
      "cases": 0,
    },
    {
      "name": "Barangay VII-C",
      "center": LatLng(14.069353893362317, 121.32470195206973),
      "cases": 0,
    },
    {
      "name": "San Jose",
      "center": LatLng(14.064596182187422, 121.38606318071923),
      "cases": 0,
    },
    {
      "name": "Barangay VII-D",
      "center": LatLng(14.06883104426907, 121.32550999439702),
      "cases": 0,
    },
    {
      "name": "Barangay II-D",
      "center": LatLng(14.067413210354154, 121.32319080350356),
      "cases": 0,
    },
    {
      "name": "Barangay III-F",
      "center": LatLng(14.068900599520822, 121.32856687719824),
      "cases": 0,
    },
  ];

  final List<Map<String, dynamic>> municipalities = [
    {"name": "Alaminos", "center": LatLng(14.0708, 121.2467), "cases": 450},
    {"name": "Rizal", "center": LatLng(14.1006, 121.3878), "cases": 890},
    {"name": "Nagcarlan", "center": LatLng(14.1362, 121.4106), "cases": 320},
    {"name": "Liliw", "center": LatLng(14.1351, 121.4326), "cases": 350},
    {"name": "Majayjay", "center": LatLng(14.1444, 121.4703), "cases": 150},
    {"name": "Calauan", "center": LatLng(14.1486, 121.3142), "cases": 680},
    {"name": "Victoria", "center": LatLng(14.2136, 121.3250), "cases": 420},
    {"name": "Tiaong", "center": LatLng(13.9612, 121.3257), "cases": 750},
    {"name": "Dolores", "center": LatLng(14.0302, 121.3860), "cases": 210},
    {"name": "Candelaria", "center": LatLng(13.9314, 121.4243), "cases": 820},
    {"name": "San Pablo", "center": LatLng(14.0692, 121.3250), "cases": 0},
  ];

  Map<String, dynamic>? selectedArea;
  final MapController _mapController = MapController();

  // Get a filtered list of areas with cases > 0
  List<Map<String, dynamic>> get areasWithCases {
    return [
      ...barangays.where((area) => area["cases"] > 0),
      ...municipalities.where((area) => area["cases"] > 0),
    ];
  }

  Color getColorByCases(int cases) {
    if (cases < 200) return Colors.green;
    if (cases < 400) return Colors.yellow;
    if (cases < 600) return Colors.orange;
    return Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              center: const LatLng(14.0692, 121.3250),
              zoom: 11.0,
              onTap: (_, point) {
                // Find the closest heat area to the tap
                _selectNearestArea(point);
              },
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.heatmap',
              ),
              // Heat circles implemented with CircleLayer
              CircleLayer(circles: _buildHeatCircles()),
            ],
          ),
          if (selectedArea != null) _buildInfoCard(),
          _buildLegend(),
        ],
      ),
    );
  }

  List<CircleMarker> _buildHeatCircles() {
    final List<CircleMarker> circles = [];

    // Add heat circles for all areas with cases
    for (var area in areasWithCases) {
      final caseCount = area["cases"] as int;
      final point = area["center"] as LatLng;
      final color = getColorByCases(caseCount);

      // Determine if it's a municipality or barangay
      final isMunicipality = municipalities.any(
        (m) => m["name"] == area["name"],
      );

      // Set different size scaling factors for municipalities vs barangays
      // Municipalities get larger circles, barangays get smaller ones
      final sizeFactor = isMunicipality ? 1.5 : 0.6;

      // Create outer heat circle (gradient effect)
      for (var i = 4; i >= 1; i--) {
        // Calculate radius based on case count but with appropriate sizing
        final radius = (caseCount / 100) * sizeFactor * 200 * math.sqrt(i) / 2;
        final opacity = 0.7 / i;

        circles.add(
          CircleMarker(
            point: point,
            radius: radius,
            useRadiusInMeter: true,
            color: color.withOpacity(opacity),
            borderColor: Colors.transparent,
            borderStrokeWidth: 0,
          ),
        );
      }

      // Add inner circle for precise location
      circles.add(
        CircleMarker(
          point: point,
          radius:
              isMunicipality ? 5 : 3, // Slightly larger dot for municipalities
          color: Colors.white,
          borderColor: color,
          borderStrokeWidth: 2,
        ),
      );
    }

    return circles;
  }

  void _selectNearestArea(LatLng tappedPoint) {
    Map<String, dynamic>? nearest;
    double minDistance = double.infinity;

    for (var area in areasWithCases) {
      final areaPoint = area["center"] as LatLng;
      final distance = _calculateDistance(
        tappedPoint.latitude,
        tappedPoint.longitude,
        areaPoint.latitude,
        areaPoint.longitude,
      );

      // Find the nearest area within a reasonable distance (0.02 degrees ~ 2km)
      if (distance < 0.02 && distance < minDistance) {
        minDistance = distance;
        nearest = area;
      }
    }

    setState(() {
      selectedArea = nearest;
    });
  }

  double _calculateDistance(
    double lat1,
    double lon1,
    double lat2,
    double lon2,
  ) {
    // Simple Euclidean distance for demonstration
    return math.sqrt(math.pow(lat1 - lat2, 2) + math.pow(lon1 - lon2, 2));
  }

  Widget _buildInfoCard() {
    return Positioned(
      top: 20,
      left: 20,
      right: 20,
      child: Card(
        color: Colors.white.withOpacity(0.95),
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: getColorByCases(selectedArea!["cases"]),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      selectedArea!["name"],
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      setState(() {
                        selectedArea = null;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _buildStatItem(
                "Total Cases",
                selectedArea!["cases"].toString(),
                getColorByCases(selectedArea!["cases"]),
              ),
              const SizedBox(height: 8),
              Text(
                "Status: ${_getStatusText(selectedArea!["cases"])}",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[700],
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String value, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
        Text(
          value,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }

  Widget _buildLegend() {
    return Positioned(
      bottom: 20,
      right: 20,
      child: Card(
        color: Colors.white.withOpacity(0.95),
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: const Padding(
          padding: EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Heat Map Legend",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
              SizedBox(height: 8),
              IndicatorRow(color: Colors.green, label: "Low (<200 cases)"),
              IndicatorRow(color: Colors.yellow, label: "Moderate (200-399)"),
              IndicatorRow(color: Colors.orange, label: "High (400-599)"),
              IndicatorRow(color: Colors.red, label: "Critical (600+)"),
              SizedBox(height: 8),
              Text(
                "Note: Larger heat circles indicate higher case numbers",
                style: TextStyle(fontSize: 10, fontStyle: FontStyle.italic),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getStatusText(int cases) {
    if (cases < 200) return "Low Risk (Normal Operations)";
    if (cases < 400) return "Moderate Risk (Increased Monitoring)";
    if (cases < 600) return "High Risk (Restrictions Recommended)";
    return "Critical Risk (Lockdown Recommended)";
  }
}

class IndicatorRow extends StatelessWidget {
  final Color color;
  final String label;

  const IndicatorRow({super.key, required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Container(
            width: 16,
            height: 16,
            decoration: BoxDecoration(
              gradient: RadialGradient(
                colors: [color.withOpacity(0.8), color.withOpacity(0.3)],
                stops: const [0.0, 1.0],
              ),
              shape: BoxShape.circle,
              border: Border.all(color: Colors.black26, width: 0.5),
            ),
          ),
          const SizedBox(width: 8),
          Text(label, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}
