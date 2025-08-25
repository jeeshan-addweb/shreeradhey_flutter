import 'package:flutter/material.dart';

import '../../../common/components/awards_and_certification_section.dart';
import '../../../common/components/bullet_point.dart';
import '../../../common/components/common_footer.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/app_images.dart';
import '../../home/views/components/feature_slider_component.dart';
import '../../home/views/widgets/product_section_widget.dart';
import '../../shop/views/components/faq_section.dart';
import 'component/aspect_section.dart';
import 'component/benefits_section.dart';
import 'component/image_title_description_section.dart';
import 'component/title_description_section.dart';

class WoodPressedOilScreen extends StatefulWidget {
  const WoodPressedOilScreen({super.key});

  @override
  State<WoodPressedOilScreen> createState() => _WoodPressedOilScreenState();
}

class _WoodPressedOilScreenState extends State<WoodPressedOilScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Image.asset(AppImages.banner, fit: BoxFit.contain),
          SizedBox(height: MediaQuery.sizeOf(context).height * 0.02),
          TitleDescriptionSection(
            title: "Premium Wood-Pressed Oil: Pure, Natural, and Unparalleled",
            description:
                '''Dive into the world of pure and unadulterated oils with
our range of premium Wooden Cold-Pressed Oils.
Crafted with care and tradition, these oils are extracted
using ancient methods that retain all the natural
goodness of the ingredients, with preserved nutrients,
unmatched purity, and a rich flavor profile.''',
          ),
          SizedBox(height: MediaQuery.sizeOf(context).height * 0.02),
          TitleDescriptionSection(
            title: "Our Products – Best Wood Pressed Oils",
            description: '''Shree Radhey now brings you the goodness of fresh,
pure, and healthy wood pressed oils—delivered right to
your doorstep across India and abroad. Extracted using
traditional cold-press methods, our wood-pressed oils
retain their natural nutrients, aroma, and flavor, making
them a perfect choice for healthy cooking. Sourced
directly from trusted farms, every bottle is free from
chemicals, additives, and artificial preservatives. Unlike
mass-produced alternatives, our wood pressed oils are
unadulterated and crafted with care to support a
healthier lifestyle.''',
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ProductSection(
              firstText: "",
              firstTextColor: AppColors.black,
              secondTextColor: AppColors.black,
              secondText: "",
              sectionBgColor: AppColors.white,
              tagText: "Newly Launch",
            ),
          ),
          SizedBox(height: MediaQuery.sizeOf(context).height * 0.02),
          Image.asset(AppImages.woodpressoilBanner, fit: BoxFit.contain),
          SizedBox(height: MediaQuery.sizeOf(context).height * 0.02),
          TitleDescriptionSection(
            title: "Why to Choose Shree Radhey Wood Pressed Oil?",
            description: '''When it comes to choosing the best wood-pressed oil,
Shree Radhey’s range of traditionally extracted oils is
gaining popularity for its incredible health benefits and
natural purity. These oils are known to support heart
health, boost immunity, and enhance overall well-being.
Just like our time-honored methods, our wood-pressed
oils are extracted using the cold-press (kachhi ghani)
technique without any heat or chemicals, preserving their
natural nutrients and aroma. 100% pure and chemical-
free, our oils contain no preservatives or additives.
Sourced from ethically grown seeds, our wooden-
pressed oils are suitable for all your cooking needs.''',
          ),
          SizedBox(height: MediaQuery.sizeOf(context).height * 0.02),
          TitleDescriptionSection(
            title: "Health Benefits of Wood-Pressed Oil",
            description:
                '''Our wood-pressed oils offer a range of incredible health
benefits, making them a smart and natural choice for
your daily cooking. When it comes to nutritional value,
Shree Radhey’s oils stand out among other brands for
their purity, traditional extraction methods, and
unmatched quality.''',
          ),

          SizedBox(height: MediaQuery.sizeOf(context).height * 0.02),
          Image.asset(AppImages.benefits, fit: BoxFit.contain),
          SizedBox(height: MediaQuery.sizeOf(context).height * 0.02),
          BulletPoint(text: "Good for overall functioning of the body."),
          BulletPoint(text: "Maintains a healthy GUT."),
          BulletPoint(text: "Rich in vitamins and minerals"),
          BulletPoint(text: "Ideal for daily use"),
          SizedBox(height: MediaQuery.sizeOf(context).height * 0.02),
          Container(
            color: AppColors.pink_fffbec,
            width: double.infinity,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12.0,
                    vertical: 12.0,
                  ),
                  child: Image.asset(
                    AppImages.process_woodpress,
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(height: MediaQuery.sizeOf(context).height * 0.02),
                TitleDescriptionSection(
                  title: "Organic Wood-Pressed Oil – Our Process of Making",
                  description:
                      '''At Shree Radhey, our organic wood-pressed oils are
crafted using time-honored techniques that preserve
purity, nutrition, and natural flavor. Our oil is extracted
through a slow, chemical-free process that honors both
health and heritage. We begin by carefully sourcing high-
quality, organically grown seeds—such as mustard,
sesame, groundnut, or coconut. These seeds are cleaned
and then gently crushed using wooden churners at low
temperatures to retain their natural nutrients,
antioxidants, and aroma. No heat, chemicals, or additives
are used during the process, ensuring that the oil
remains 100% pure and nutrient-rich. Our wood-pressed
oil not only enhance the flavor of your food but also
support overall wellness—promoting heart health,
improving digestion, and nourishing the skin and hair
naturally.''',
                ),
                SizedBox(height: MediaQuery.sizeOf(context).height * 0.02),
              ],
            ),
          ),
          SizedBox(height: MediaQuery.sizeOf(context).height * 0.02),
          TitleDescriptionSection(
            title: "Wood Pressed Oil – 100% Pure & Natural Cold",
            description: '''Shree Radhey's wood-pressed oils are extracted using
the age-old wooden cold-press (Ghani) method, where
seeds are slowly crushed at low temperatures without
the use of heat or chemicals. This ensures the oil retains
all its natural nutrients, antioxidants, and rich flavor. Free
from preservatives, additives, or artificial processing, our
wood pressed oils are pure, unrefined, and packed with
health benefits—making them the perfect choice for
conscious cooking and holistic living.''',
          ),
          SizedBox(height: MediaQuery.sizeOf(context).height * 0.02),
          TitleDescriptionSection(
            title: "Our Oil Products – Order Now",
            description:
                '''Our wood-pressed oil is a pure, high-quality oil made
using traditional methods that have been trusted in India
for generations. Rich in natural nutrients and
antioxidants, it supports overall wellness—from
improving digestion to promoting heart health. It's also
known to nourish the skin and enhance natural radiance.
So why wait? Bring home the goodness of our wood-
pressed oil and enjoy a healthier lifestyle with every drop.''',
          ),
          SizedBox(height: MediaQuery.sizeOf(context).height * 0.02),
          ProductSection(
            firstText: "",
            firstTextColor: AppColors.black,
            secondTextColor: AppColors.black,
            secondText: "",
            sectionBgColor: AppColors.white,
            tagText: "Newly Launch",
          ),
          SizedBox(height: MediaQuery.sizeOf(context).height * 0.02),

          Container(
            color: AppColors.pink_fffbec,
            width: double.infinity,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12.0,
                    vertical: 12.0,
                  ),
                  child: Image.asset(AppImages.a2_ghee, fit: BoxFit.contain),
                ),
                SizedBox(height: MediaQuery.sizeOf(context).height * 0.02),
                TitleDescriptionSection(
                  title: "Uses of Wood Pressed Oil – Nutritious & Flavorful",
                  description:
                      '''Wood pressed oil is a staple in many Indian kitchens and
is valued for its purity and nutritional benefits. Extracted
through traditional slow-pressing methods without heat
or chemicals, it retains its natural aroma, flavor, and
nutrients. Here are some of the key uses of wood
pressed oil:''',
                ),
                SizedBox(height: MediaQuery.sizeOf(context).height * 0.02),
                BulletPoint(text: "Good for overall functioning of the body."),
                BulletPoint(text: "Maintains a healthy GUT."),
                BulletPoint(text: "Rich in vitamins and minerals"),
                BulletPoint(text: "Ideal for daily use"),
                SizedBox(height: MediaQuery.sizeOf(context).height * 0.02),
              ],
            ),
          ),
          SizedBox(height: MediaQuery.sizeOf(context).height * 0.02),
          TitleDescriptionSection(
            title: "Naturally Extracted Wooden Cold Pressed Oils",
            description: '''Shree Radhey offers Naturally Extracted Wooden Cold
Pressed Oils crafted through traditional methods that
preserve nature’s true essence. Using the age-old
wooden Ghani technique, our oils are extracted slowly at
low temperatures to retain their original nutrients, rich
aroma, and natural flavor. Free from chemicals,
preservatives, or artificial additives, our cold-pressed oils
—like groundnut, sesame, and coconut—are perfect for
cooking, skin care, and holistic wellness. Every bottle
from Shree Radhey is a promise of purity, handcrafted
with care and rooted in our commitment to healthy,
organic living.''',
          ),
          SizedBox(height: MediaQuery.sizeOf(context).height * 0.02),
          ImageTitleDescriptionSection(
            image: AppImages.hh_cow,
            title: "Happy and Healthy Cows",
            description:
                '''Our cows are healthy and are cleaned regularly by natural
processes. They graze freely and are treated with
ayurvedic herbs and medicines.''',
          ),
          SizedBox(height: MediaQuery.sizeOf(context).height * 0.02),
          ImageTitleDescriptionSection(
            image: AppImages.organic_farm,
            title: "Organic Farm",
            description: '''Our cows graze in a 100% organic farm where no
chemical-based fertilizers are used. This makes our A2
ghee healthier and contains effective nutrients.''',
          ),
          SizedBox(height: MediaQuery.sizeOf(context).height * 0.02),
          ImageTitleDescriptionSection(
            image: AppImages.organic_sources,
            title: "Organic Sources",
            description:
                '''Our ghee is produced from organic sources and does not
contain any artificial preservatives or additives. That
makes it pure and healthy.''',
          ),
          SizedBox(height: MediaQuery.sizeOf(context).height * 0.02),
          ImageTitleDescriptionSection(
            image: AppImages.hand_churned,
            title: "Hand Churned",
            description: '''We use the traditional technique of hand churning to
make A2 ghee. It is 100% natural based, and the ghee
produced is incomparable with other ghee.''',
          ),
          SizedBox(height: MediaQuery.sizeOf(context).height * 0.02),
          Text(
            "Wood-Pressed Oil FAQs",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: AppColors.grey_65758b,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: FAQSection(
              faqColor: AppColors.grey_65758b,
              faqs: [
                {
                  "question": "What is the shelf life of this product?",
                  "answer":
                      "The product has a shelf life of 12 months from the date of manufacture.",
                },
                {
                  "question": "Does it contain preservatives?",
                  "answer":
                      "No, our products are made with 100% natural ingredients.",
                },
                {
                  "question": "Is this product vegan?",
                  "answer": "Yes, it is completely plant-based.",
                },
              ],
            ),
          ),
          SizedBox(height: MediaQuery.sizeOf(context).height * 0.02),
          AspectsSection(
            title: "Aspects Of Wooden-Pressed Oil",
            aspects: [
              {"icon": AppImages.mental_health, "text": "Mental health"},
              {"icon": AppImages.physical_health, "text": "Physical health"},
              {"icon": AppImages.pregnancy, "text": "Pregnancy"},
              {"icon": AppImages.daily_diet, "text": "Daily diet"},
              {"icon": AppImages.weigth_loss, "text": "Weight loss"},
            ],
          ),
          SizedBox(height: MediaQuery.sizeOf(context).height * 0.02),

          TitleDescriptionSection(
            title: "Organic Wooden Cold Pressed Oil for a Healthier Lifestyle",
            description:
                '''In every traditional Indian household, the concept of
using pure, chemical-free oils is deeply rooted. Wood-
pressed oils, extracted using age-old cold pressing
techniques, are a natural choice for those seeking flavor
and wellness in their daily cooking. These oils are
extracted at low temperatures without the use of heat or
chemicals, helping retain their natural nutrients, aroma,
and essential fatty acids. From mothers in the kitchen to
wellness enthusiasts, wood-pressed oils are making a
strong comeback. Here’s why:''',
          ),
          SizedBox(height: MediaQuery.sizeOf(context).height * 0.02),
          BenefitsSection(
            benefits: [
              {
                "icon": AppImages.weigth_loss,
                "title": "Helps in better Digestion",
                "desc":
                    "If there is one natural product directly related to digestion, it is Desi A2 Gir Cow Ghee.",
              },
              {
                "icon": AppImages.weigth_loss,
                "title": "Essential item for weight reduction",
                "desc":
                    "Even though it is fatty in nature, it helps in mobilizing fat cells and improving metabolism.",
              },
              {
                "icon": AppImages.weigth_loss,
                "title": "Makes bones stronger",
                "desc":
                    "Desi Ghee is a daily diet essential because it increases calcium absorption.",
              },
            ],
          ),
          SizedBox(height: MediaQuery.sizeOf(context).height * 0.02),
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
          SizedBox(height: MediaQuery.sizeOf(context).height * 0.02),
          FeatureSlider(),
          SizedBox(height: MediaQuery.sizeOf(context).height * 0.02),
          CommonFooter(),
        ],
      ),
    );
  }
}
