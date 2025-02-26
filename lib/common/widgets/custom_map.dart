import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../services/map_service.dart';
import 'alert_snackbar.dart';

class CustomMap extends StatefulWidget {
  final Function(dynamic data) onLocationChanged;
  const CustomMap({
    super.key,
    required this.onLocationChanged
  });

  @override
  State<CustomMap> createState() => _CustomMapState();
}

class _CustomMapState extends State<CustomMap> {
  final MapService _mapService = MapService();
  late LatLng _markerPosition = const LatLng(25.276987, 51.520008);

  List<Marker> getMarker() {
    return [
      Marker(
        point: _markerPosition,
        child: const Icon(
          Icons.location_on,
          color: Colors.red,
          size: 40.0,
        ),
      )
    ];
  }

  Future<void> _getLocationData(String lat, String long) async {
    try {
     dynamic? response = await _mapService.geoCoding(lat, long);

      if (response != null && response['status'] == "200") {
        widget.onLocationChanged(response);
      } else {
        if(mounted){
          showAlertSnackBar(
            context: context,
            message: "Failed to fetch location data",
            status: Status.error,
          );
        }
      }
    } catch (error) {
      if(mounted){
        showAlertSnackBar(
          context: context,
          message: "Something went wrong",
          status: Status.error,
        );
      }
      debugPrint("Error: $error");
    }
  }

  @override
  void initState() {
    super.initState();
    _getLocationData("25.276987", "51.520008");
  }


  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        initialCenter: const LatLng(25.276987, 51.520008),
        onTap: (tapPosition, point) {
          setState(() {
            _markerPosition = point;
            _getLocationData('${point.latitude}', '${point.longitude}');
          });
        },
        // Center the map over Qatar
        initialZoom: 9.2,
      ),
      children: [
        TileLayer(
          // urlTemplate: 'https://{s}.basemaps.cartocdn.com/rastertiles/voyager/{z}/{x}/{y}.png',
          urlTemplate: 'https://{s}.basemaps.cartocdn.com/light_all/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.example.app',
        ),
        MarkerLayer(
            markers: getMarker()
        ),
        RichAttributionWidget(
          attributions: [
            TextSourceAttribution(
              'OpenStreetMap contributors',
              onTap: () => launchUrl(Uri.parse('https://openstreetmap.org/copyright')),
            ),
          ],
        ),
      ],
    );
  }
}