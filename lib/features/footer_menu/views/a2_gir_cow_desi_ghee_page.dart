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

class A2GirCowDesiGheePage extends StatefulWidget {
  const A2GirCowDesiGheePage({super.key});

  @override
  State<A2GirCowDesiGheePage> createState() => _A2GirCowDesiGheePageState();
}

class _A2GirCowDesiGheePageState extends State<A2GirCowDesiGheePage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Image.asset(AppImages.a2gircowghee, fit: BoxFit.contain),
          SizedBox(height: MediaQuery.sizeOf(context).height * 0.02),
          TitleDescriptionSection(
            title: "A2 Ghee – Pure & Organic",
            description: '''In India and abroad, Shree Radhey provides home
delivery of the best organic ghee that is fresh, pure, and
healthful. Our A2 desi ghee is made from high-quality
milk of superior Indian gir cow. Our A2 organic ghee
contains all important nutrients that provide you with
healthy living. Moreover, we ensure that the process of
making A2 ghee is hygienic, chemical-free, and without
any additives. Every day, we bring a jar of A2 pure cow
ghee filled with health and happiness right from our farm
to your door. Purchase pure a2 desi ghee for a healthy
lifestyle for you and your family ''',
          ),
          SizedBox(height: MediaQuery.sizeOf(context).height * 0.02),
          TitleDescriptionSection(
            title: "Our Products – Best Bilona Cow Ghee",
            description:
                '''Shree Radhey Ghee offers home delivery of fresh, pure,
and healthy A2 ghee in India and in Abroad. Our A2 Gir
Cow Ghee is best for your health, making your food
delicious and rich in nutrients. We deliver a jar full of
health and happiness straight from our farm to your
doorstep every day. Unlike other companies, our ghee
products are unadulterated and free from artificial
preservatives. Buy our organic Gir cow ghee and give
your family healthy living.''',
          ),

          ProductSection(
            firstText: "",
            firstTextColor: AppColors.black,
            secondTextColor: AppColors.black,
            secondText: "",
            sectionBgColor: AppColors.white,
            tagText: "Best Seller",
            categoryText: "All",
          ),
          SizedBox(height: MediaQuery.sizeOf(context).height * 0.02),
          Image.asset(AppImages.pure_and_organic_a2_ghee, fit: BoxFit.contain),
          SizedBox(height: MediaQuery.sizeOf(context).height * 0.02),
          TitleDescriptionSection(
            title: "Reasons to Choose A2 Cow Desi Ghee",
            description: '''When it comes to choosing the best A2 Ghee, Shree
Radhey A2 Gir Cow Ghee is gaining popularity with each
passing year because of its excellent uses for good
heart, health, and mind. Significant uses of A2 Cow Ghee
are- Ghee is an ingredient as pure as the traditional
Bilona process. 100% Pure and Organic Bilona A2 Ghee
contains no preservatives or additives. Instead, it is
made using a Bilona Method where the Cow’s Milk is
boiled and cooled naturally By hand churning it using
Ravaiya. This desi pure cow ghee is made completely by
hand and is completely digestible, meant for all age
groups. Along with the traditional process, the cows are
treated ethically with the natural breeding process
without any artificial interference.''',
          ),
          SizedBox(height: MediaQuery.sizeOf(context).height * 0.02),
          TitleDescriptionSection(
            title: "Why Shree Radhey Ghee?",
            description:
                '''Shree Radhey Ghee, a leading producer of dairy products
focuses on the quality and tradition of its products. Shree
Radhey offers a spoonful of good health and happiness
by serving 100% pure Desi Ghee made from Indian Native
Gir Cow’s milk. The products are free from artificial
interference, preservatives, chemicals, flavors, and colors
avoiding the use of any of the commercial tools or
machinery. Shree Radhey is a premium quality brand
having a goal to serve the best Bilona ghee in India which
is rich in vitamins, minerals, and proteins. Shree Radhey
happily delivers its products directly from farm to your
doorstep every day in India and abroad.''',
          ),
          SizedBox(height: MediaQuery.sizeOf(context).height * 0.02),
          TitleDescriptionSection(
            title: "Health Benefits of A2 Cow Desi Ghee",
            description:
                '''Our organic gir cow ghee has multiple benefits on health.
When it comes to the nutritional value of ghee, our ghee
comes first on the list with other ghee brands.
Discussing some of these health benefits will definitely
inspire you to buy our A2 ghee.''',
          ),
          SizedBox(height: MediaQuery.sizeOf(context).height * 0.02),
          Image.asset(AppImages.process, fit: BoxFit.contain),
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
                  child: Image.asset(AppImages.gir_cow, fit: BoxFit.contain),
                ),
                SizedBox(height: MediaQuery.sizeOf(context).height * 0.02),
                TitleDescriptionSection(
                  title: "A2 Bilona Cow Ghee – Our Process of Making",
                  description:
                      '''A2 Cow Bilona Ghee is known as Desi A2 Gir Cow Ghee,
is made utilizing the age-old Bilona Method and is a
crucial ingredient that is 100% pure. The best Bilona ghee
in India is used to naturally obtain cow’s milk in this
technique. The milk is then cooked, cooled, and given a
tablespoon of curd before being refrigerated for the
night. After that, using Ravaiya, the curd is separated
from buttermilk. After boiling the butter, only pure ghee is
left. The “Bilona” best A2 desi cow ghee is a pure form of
ghee that not only improves food flavor but also keeps a
person physically and mentally fit. The daily use of A2
cow Ghee is regarded as an essential component of
one’s regimen. It is also used as a natural moisturizer for
the skin and hair.''',
                ),
                SizedBox(height: MediaQuery.sizeOf(context).height * 0.02),
              ],
            ),
          ),
          SizedBox(height: MediaQuery.sizeOf(context).height * 0.02),
          TitleDescriptionSection(
            title: "Vedic Bilona two-way Hand Churned Ghee",
            description: '''Shree Radhey’s cow ghee is completely Hand churned
using Bilona Method by the rural women. It follows the
two-way hand churning process in making A2 Ghee from
A2 milk produced by Gir Cows. The churning in the
process is done using an earthen pot called Ravaiya in
two motions- clockwise and anticlockwise. The
traditional way of two-way churning is what makes A2
cow gir ghee incomparable to other ghee available in the
market. Also, this Hand Churned process provides
plentiful opportunities and helps in creating an ideology
of job creation among rural women for the economic
upliftment of their families.''',
          ),
          SizedBox(height: MediaQuery.sizeOf(context).height * 0.02),
          TitleDescriptionSection(
            title: "Cruelty free Procurement",
            description:
                '''We are always committed to cruelty free procurement of
our products, and we believe that to get the best quality
and healthy ghee first our cows should be healthy and
happy. So we do everything for their health and to keep
them disease free.''',
          ),
          SizedBox(height: MediaQuery.sizeOf(context).height * 0.02),
          BulletPoint(text: "Good for overall functioning of the body."),
          BulletPoint(text: "Maintains a healthy GUT."),
          BulletPoint(text: "Rich in vitamins and minerals"),
          BulletPoint(text: "Ideal for daily use"),
          SizedBox(height: MediaQuery.sizeOf(context).height * 0.02),
          Image.asset(AppImages.eco_friendly, fit: BoxFit.contain),
          SizedBox(height: MediaQuery.sizeOf(context).height * 0.02),
          TitleDescriptionSection(
            title: "Our Products – Order Now",
            description:
                '''Our A2 ghee is a delicious, high-quality version of the
same kind of ghee that’s been used for centuries in India,
and has been known to cure everything from indigestion
to cancer. It’s also great for your skin. So why wait, just
order our ghee and enjoy the benefits of the best ghee
available in the market with a healthy lifestyle.''',
          ),

          ProductSection(
            firstText: "",
            firstTextColor: AppColors.black,
            secondTextColor: AppColors.black,
            secondText: "",
            sectionBgColor: AppColors.white,
            tagText: "Best Seller",
            categoryText: "All",
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
                  title: "Uses of A2 Organic Ghee –Healthy & Tasty",
                  description:
                      '''Ghee is the most common and is considered a primary
food item in every Indian household. The A2 cow desi
ghee is considered the purest form of ghee and has
extraordinary healing factors. Some of the Major uses of
A2 Cow Ghee are-''',
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
            title: "Why Choose Shree Radhey for A2 Bilona Ghee?",
            description:
                '''Shree Radhey promotes Healthy living in an organic way.
Shree Radhey offers the purest organic Gir Cow Ghee
directly from the farm to your home in India and Abroad.
It has its farm spread in acres of agricultural land and
extensively follows a natural breeding process for its
Cows because we believe in conserving Mother Nature
through Natural practices. This means a pack full of
100% goodness. Take a step and choose Shree Radhey’s
for A2 Cow Ghee. We assure you that you will never
regret your decision for choosing us.''',
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
            "A2 Gir Cow Ghee FAQs",
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
            title: "Aspects Of A2 Gir Cow Ghee",
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
            title: "    Gir Cow Desi Ghee for Healthy Life",
            description:
                '''For every Indian traditional family, the concept of Shudh
Desi Ghee will be of no surprise. Shudh Desi Ghee
obtained from Desi Indian Gir Cow Breeds. Every mother
prefers Shudh Desi Gir Cow Ghee to be loaded in all the
dishes to make it more healthy and tasty. Gir Cow Ghee
is prepared with a traditional method of the slow-burning
process so that Ghee retains all the essential nutrients
and fatty acids. Desi Gir Cow’s A2 Milk is used to
produce Pure A2 Cow Ghee. The Ghee has numerous
benefits.''',
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
