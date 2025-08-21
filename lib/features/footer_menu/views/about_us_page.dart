import 'package:flutter/material.dart';

import '../../../common/components/awards_and_certification_section.dart';
import '../../../common/components/common_footer.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/app_images.dart';
import 'component/about_us_infolist_section.dart';

class AboutUsPage extends StatefulWidget {
  const AboutUsPage({super.key});

  @override
  State<AboutUsPage> createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: AboutUsCard(
                    imagePath: AppImages.gir_cow,
                    title: "Our Story",
                    description: '''
          Shree Radhey is a well-known name
          in the organic farming
          industry. Started by Mr. Abhimanyu
          Singh Rathore and Mrs. Renu
          Nathawat, our products are sourced
          directly from our farm, processed
          under stringent quality measures to
          ensure you get the best of what
          nature has to offer. We have been at
          this for 6 years now and it’s just
          getting better as we innovate and
          bring more options on your plate.
          Whether you’re looking for pure
          ghee or indigenous spices, your
          search for healthy, natural, pure food
          ends here. 
                        ''',
                  ),
                ),

                AboutUsInfoListSection(
                  items: [
                    AboutUsInfoItem(
                      iconPath: AppImages.cart,
                      title: "Our Beliefs",
                      description: ''' 
We believe everyone deserves food with the
ingredients they would choose, without any
chemicals. We have a range of certified organic
products to ensure purity and make your world
healthy with organic products.
                          ''',
                    ),
                    AboutUsInfoItem(
                      iconPath: AppImages.cart,
                      title: "100% Natural and Certified",
                      description: ''' 
We believe everyone deserves food with the
ingredients they would choose, without any
chemicals. We have a range of certified organic
products to ensure purity and make your world
healthy with organic products.
                          ''',
                    ),
                    AboutUsInfoItem(
                      iconPath: AppImages.cart,
                      title: "Our Promise to our customers",
                      description: ''' 
We believe everyone deserves food with the
ingredients they would choose, without any
chemicals. We have a range of certified organic
products to ensure purity and make your world
healthy with organic products.
                          ''',
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Image.asset(AppImages.hand_churned, fit: BoxFit.contain),
                SizedBox(height: 32),
                AwardsAndCertificationsSection(
                  awards: [
                    AwardItem(
                      imageUrl:
                          "https://images.unsplash.com/photo-1507842217343-583bb7270b66?w=800",
                      title: "ISO 9001 Certification",
                    ),
                    AwardItem(
                      imageUrl:
                          "https://images.unsplash.com/photo-1521791136064-7986c2920216?w=800",
                      title: "Best Organic Brand 2024",
                    ),
                    AwardItem(
                      imageUrl: "https://picsum.photos/800/400?random=3",
                      title: "FSSAI Certified",
                    ),
                    AwardItem(
                      imageUrl: "https://picsum.photos/800/400?random=4",
                      title: "Environmental Excellence Award",
                    ),
                  ],
                ),
              ],
            ),
          ),
          CommonFooter(),
        ],
      ),
    );
  }
}

class AboutUsCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String description;

  const AboutUsCard({
    super.key,
    required this.imagePath,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 6,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Top Image
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
            child: Image.asset(
              imagePath,
              fit: BoxFit.cover,
              height: 180,
              width: double.infinity,
            ),
          ),

          // Inner container with Title & Description
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  description,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.grey_212121,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
