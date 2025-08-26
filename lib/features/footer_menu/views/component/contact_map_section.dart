import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../constants/app_colors.dart';

class ContactMapSection extends StatelessWidget {
  final String address;
  final String phone;
  final String email;
  final double latitude;
  final double longitude;

  const ContactMapSection({
    super.key,
    required this.address,
    required this.phone,
    required this.email,
    required this.latitude,
    required this.longitude,
  });

  @override
  Widget build(BuildContext context) {
    // final LatLng location = LatLng(latitude, longitude);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Google Map
        // SizedBox(
        //   height: 250,
        //   child: GoogleMap(
        //     initialCameraPosition: CameraPosition(target: location, zoom: 14),
        //     markers: {
        //       Marker(
        //         markerId: const MarkerId("office"),
        //         position: location,
        //         infoWindow: InfoWindow(title: "Shree Radhey A2 Ghee"),
        //       ),
        //     },
        //     zoomControlsEnabled: false,
        //   ),
        // ),
        // const SizedBox(height: 16),

        /// Address
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Address
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Address",
                  style: TextStyle(
                    color: AppColors.red_CC0003,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  address,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: AppColors.grey_212121,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            /// Email + Phone in one row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                /// Email
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Email Address",
                            style: TextStyle(
                              color: AppColors.red_CC0003,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        email,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: AppColors.grey_212121,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 16),

                /// Phone
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Telephone Enquiry",
                            style: TextStyle(
                              color: AppColors.red_CC0003,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        phone,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: AppColors.grey_212121,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
