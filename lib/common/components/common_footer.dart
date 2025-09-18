import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_images.dart';
import '../../features/home/views/components/review_section.dart';
import '../../utils/routes/app_route_path.dart';

class CommonFooter extends StatelessWidget {
  final bool isShow;
  const CommonFooter({super.key, this.isShow = true});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        isShow ? ReviewSection() : SizedBox(),
        SizedBox(height: 30, child: Container(color: AppColors.blue_eef1ed)),
        Container(
          color: AppColors.footer_1a2531,
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                AppImages.logo,
                height: 65,
                color: AppColors.footer_logo_ffefef,
              ), // or use SVG
              const SizedBox(height: 12),
              Text(
                'SRDF Organic Private Limited',
                style: TextStyle(
                  color: AppColors.footer_logo_ffefef,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 16),
              IconTextRow(
                icon: Icons.location_on_outlined,
                text:
                    'Khasra no 678, Village Khori, Pushkar, Ajmer – 305021, Rajasthan, India.',
              ),

              IconTextRow(icon: Icons.phone_outlined, text: '+91-98289 64111'),

              IconTextRow(
                icon: Icons.email_outlined,
                text: 'srdfpushkar@gmail.com',
              ),
              SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SocialIconButton(
                    imagePath: AppImages.facebook,
                    onTap:
                        () => _launchUrl(
                          "https://www.facebook.com/shreeradheyghee",
                        ),
                  ),
                  SizedBox(width: 15),
                  SocialIconButton(
                    imagePath: AppImages.instagram,
                    onTap:
                        () => _launchUrl(
                          "https://www.instagram.com/shreeradheyghee/",
                        ),
                  ),
                  SizedBox(width: 15),
                  SocialIconButton(
                    imagePath: AppImages.twitter,
                    onTap: () => _launchUrl("https://x.com/ShreeRadheyGhee"),
                  ),
                ],
              ),

              const Divider(color: Colors.white24, height: 32),

              Wrap(
                spacing: 8,
                runSpacing: 8,
                children:
                    [
                          footerLink(
                            'About Us',
                            onTap: () {
                              context.push(AppRoutePath.aboutUsPage);
                            },
                          ),
                          footerLink(
                            'Privacy Policy',
                            onTap: () {
                              context.push(AppRoutePath.privacyPolicyPage);
                            },
                          ),
                          footerLink(
                            'Blog',
                            onTap: () {
                              context.push(AppRoutePath.bloglistingScreen);
                            },
                          ),
                          footerLink(
                            'Shipping and Delivery Policy',
                            onTap: () {
                              context.push(
                                AppRoutePath.shippingAndDeliveryPolicyPage,
                              );
                            },
                          ),
                          footerLink(
                            'Contact',
                            onTap: () {
                              context.push(AppRoutePath.dealershipFormScreen);
                            },
                          ),
                          footerLink(
                            'Terms & Conditions',
                            onTap: () {
                              context.push(AppRoutePath.termsAndConditionsPage);
                            },
                          ),
                          footerLink(
                            'Dealership Form',
                            onTap: () {
                              context.push(AppRoutePath.dealershipFormScreen);
                            },
                          ),
                          footerLink(
                            'Refund Policy',
                            onTap: () {
                              context.push(AppRoutePath.refundPolicyPage);
                            },
                          ),
                          footerLink(
                            'A2 Gir Cow Desi Ghee',
                            onTap: () {
                              context.push(AppRoutePath.a2girCowDesiGheePage);
                            },
                          ),
                          footerLink(
                            "FAQ's",
                            onTap: () {
                              context.push(AppRoutePath.faqScreen);
                            },
                          ),
                          footerLink(
                            'Wood Pressed Oil',
                            onTap: () {
                              context.push(AppRoutePath.woodpressedoilScreen);
                            },
                          ),
                        ]
                        .map(
                          (child) => SizedBox(
                            width:
                                (MediaQuery.of(context).size.width - 50) /
                                2, // adjust padding if needed
                            child: child,
                          ),
                        )
                        .toList(),
              ),
              SizedBox(height: 20),
              // Replace your current Row (My Account + Certifications) part with this:
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // My Account Column
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      footerLink(
                        'My account',
                        onTap: () {
                          context.push(AppRoutePath.dealershipFormScreen);
                        },
                      ),
                      const SizedBox(height: 8),
                      footerLink(
                        'Cart',
                        onTap: () {
                          context.push(AppRoutePath.cartPage);
                        },
                      ),
                      const SizedBox(height: 8),
                      footerLink(
                        'Checkout',
                        onTap: () {
                          context.push(AppRoutePath.checkoutScreen);
                        },
                      ),
                      const SizedBox(height: 8),
                      footerLink(
                        'Wishlist',
                        onTap: () {
                          context.push(AppRoutePath.wishlistScreen);
                        },
                      ),
                      const SizedBox(height: 8),
                    ],
                  ),

                  // Certifications Column
                  Padding(
                    padding: EdgeInsets.only(
                      right: MediaQuery.sizeOf(context).width * 0.0999,
                    ), // adjust as needed
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Our Certifications",
                          style: TextStyle(
                            color: AppColors.footer_logo_ffefef,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Row(
                            children: [
                              Image.asset(
                                AppImages.fssai,
                                height: 40,
                                width: 40,
                              ),
                              const SizedBox(width: 8),
                              Image.asset(
                                AppImages.footer_cow,
                                height: 50,
                                width: 50,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                "Get E-mail updates about our latest shop & special offers.",
                style: TextStyle(
                  color: AppColors.footer_logo_ffefef,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),

              const SizedBox(height: 24),

              Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Enter your email address',
                        hintStyle: TextStyle(color: AppColors.grey),
                        filled: true,
                        fillColor: AppColors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: BorderSide(
                            color: AppColors.grey,
                            width: 5,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: BorderSide(
                            color: AppColors.green,
                            width: 2,
                          ),
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 20),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColors.green_6cad10, AppColors.green_327801],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    minimumSize: const Size.fromHeight(40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Subscribe',
                        style: TextStyle(color: AppColors.white, fontSize: 16),
                      ),
                      SizedBox(width: 5),
                      Icon(
                        Icons.arrow_forward,
                        color: AppColors.white,
                        size: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
        Image.asset(AppImages.footer_cards),
        SizedBox(height: 20),
      ],
    );
  }

  Widget footerLink(String text, {VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap ?? () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Text(
          text,
          style: TextStyle(color: AppColors.footer_logo_ffefef, fontSize: 14),
        ),
      ),
    );
  }
}

class IconTextRow extends StatelessWidget {
  final IconData icon;
  final String text;
  final double iconSize;
  final double spacing;
  final TextStyle? textStyle;
  final Color? iconColor;

  const IconTextRow({
    Key? key,
    required this.icon,
    required this.text,
    this.iconSize = 20,
    this.spacing = 8,
    this.textStyle,
    this.iconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.start, // good for address multiline
        children: [
          Icon(
            icon,
            size: iconSize,
            color: iconColor ?? AppColors.footer_logo_ffefef,
          ),
          SizedBox(width: spacing),
          Expanded(
            child: Text(
              text,
              style:
                  textStyle ??
                  TextStyle(fontSize: 14, color: AppColors.footer_logo_ffefef),
            ),
          ),
        ],
      ),
    );
  }
}

class SocialIconButton extends StatelessWidget {
  final String imagePath; // path to PNG asset
  final VoidCallback onTap;
  final double size;
  final double borderRadius;
  final Color borderColor;
  final Color backgroundColor;
  final EdgeInsets padding;

  const SocialIconButton({
    Key? key,
    required this.imagePath,
    required this.onTap,
    this.size = 35,
    this.borderRadius = 100,
    this.borderColor = Colors.white,
    this.backgroundColor = Colors.transparent,
    this.padding = const EdgeInsets.all(8),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        padding: padding,
        decoration: BoxDecoration(
          color: backgroundColor,
          shape: BoxShape.circle,
          border: Border.all(color: borderColor, width: 1.2),
        ),
        child: Image.asset(
          imagePath,
          fit: BoxFit.contain,
          color: AppColors.white,
        ),
      ),
    );
  }
}

Future<void> _launchUrl(String url) async {
  final Uri uri = Uri.parse(url);
  if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
    throw Exception('Could not launch $url');
  }
}
