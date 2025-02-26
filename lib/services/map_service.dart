import 'dart:convert';
import 'package:http/http.dart' as http;

class MapService {
  Future<Map<String, dynamic>?> geoCoding(String latitude, String longitude) async {

    try {
      final Map<String, String> queryParams = {
        'lat': latitude,
        'lon': longitude,
        'format': 'json',
        'accept-language': 'en',
      };

      final response = await http.get(
        Uri.parse('https://nominatim.openstreetmap.org/reverse').replace(
            queryParameters: queryParams
        ),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      final Map<String, dynamic> responseBody = json.decode(response.body);

      if (response.statusCode == 200) {
        return {
          'status': "200",
          'placeId': responseBody['place_id'].toString(),
          'placeName': responseBody['display_name'],
          'latitude': responseBody['lat'],
          'longitude': responseBody['lon']
        };
      } else {
        return {
          'status': "500",
          'message': "Failed to fetch location details"
        };
      }
    } catch (error) {
      print('Error: $error');
      return {
        'status': "500",
        'message': "Something went wrong"
      };
    }
  }
}
