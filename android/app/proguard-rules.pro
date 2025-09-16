# Keep Razorpay SDK classes
-keep class com.razorpay.** { *; }
-dontwarn com.razorpay.**

# Fix for missing proguard.annotation.Keep
-keep class proguard.annotation.Keep { *; }
-keep class proguard.annotation.KeepClassMembers { *; }

# Keep annotations
-keepattributes *Annotation*

# Sometimes R8 strips methods used by reflection
-keepclassmembers class * {
    @proguard.annotation.Keep <methods>;
    @proguard.annotation.KeepClassMembers <fields>;
}
