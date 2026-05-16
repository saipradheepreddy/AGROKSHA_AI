/// ─────────────────────────────────────────────────────────────────────────────




/// AGROKSHA AI — Reusable Widgets




/// Premium, production-ready UI components




/// ─────────────────────────────────────────────────────────────────────────────









import 'package:flutter/material.dart';




import 'package:flutter_animate/flutter_animate.dart';




import 'package:shimmer/shimmer.dart';




import '../theme/app_theme.dart';




import '../models/models.dart';









// ══════════════════════════════════════════════════════════╕




// 1. PREMIUM GRADIENT BUTTON




// ══════════════════════════════════════════════════════════╛




class GradientButton extends StatelessWidget {




  final String label;




  final VoidCallback? onPressed;




  final bool isLoading;




  final double height;




  final IconData? icon;









  const GradientButton({




    super.key,




    required this.label,




    this.onPressed,




    this.isLoading = false,




    this.height = 56,




    this.icon,




  });









  @override




  Widget build(BuildContext context) {




    return SizedBox(




      height: height,




      width: double.infinity,




      child: Material(




        color: Colors.transparent,




        borderRadius: AppTheme.buttonRadius,




        child: InkWell(




          onTap: isLoading ? null : onPressed,




          borderRadius: AppTheme.buttonRadius,




          child: Ink(




            decoration: BoxDecoration(




              gradient: onPressed == null




                  ? LinearGradient(




                      colors: [Colors.grey.shade400, Colors.grey.shade300],




                    )




                  : AppColors.primaryGradient,




              borderRadius: AppTheme.buttonRadius,




              boxShadow: onPressed == null ? null : AppTheme.elevatedShadow,




            ),




            child: Center(




              child: isLoading




                  ? const SizedBox(




                      width: 24,




                      height: 24,




                      child: CircularProgressIndicator(




                        color: Colors.white,




                        strokeWidth: 2.5,




                      ),




                    )




                  : Row(




                      mainAxisSize: MainAxisSize.min,




                      children: [




                        if (icon != null) ...[




                          Icon(icon, color: Colors.white, size: 20),




                          const SizedBox(width: 8),




                        ],




                        Text(




                          label,




                          style: const TextStyle(




                            color: Colors.white,




                            fontSize: 16,




                            fontWeight: FontWeight.w600,




                            letterSpacing: 0.3,




                          ),




                        ),




                      ],




                    ),




            ),




          ),




        ),




      ),




    );




  }




}









// ══════════════════════════════════════════════════════════╕




// 2. PREMIUM TEXT FIELD




// ══════════════════════════════════════════════════════════╛




class AgriTextField extends StatefulWidget {




  final String label;




  final String hint;




  final IconData prefixIcon;




  final TextEditingController controller;




  final bool isPassword;




  final TextInputType keyboardType;




  final String? Function(String?)? validator;




  final TextInputAction textInputAction;




  final Iterable<String>? autofillHints;









  const AgriTextField({




    super.key,




    required this.label,




    required this.hint,




    required this.prefixIcon,




    required this.controller,




    this.isPassword = false,




    this.keyboardType = TextInputType.text,




    this.validator,




    this.textInputAction = TextInputAction.next,




    this.autofillHints,




  });









  @override




  State<AgriTextField> createState() => _AgriTextFieldState();




}









class _AgriTextFieldState extends State<AgriTextField> {




  bool _obscure = true;









  @override




  Widget build(BuildContext context) {




    final isDark = Theme.of(context).brightness == Brightness.dark;









    return TextFormField(




      controller: widget.controller,




      obscureText: widget.isPassword ? _obscure : false,




      keyboardType: widget.keyboardType,




      textInputAction: widget.textInputAction,




      autofillHints: widget.autofillHints,




      validator: widget.validator,




      style: TextStyle(




        fontSize: 15,




        color: isDark ? AppColors.darkText : AppColors.textDark,




        fontWeight: FontWeight.w500,




      ),




      decoration: InputDecoration(




        labelText: widget.label,




        hintText: widget.hint,




        prefixIcon: Icon(widget.prefixIcon, color: AppColors.primary, size: 22),




        suffixIcon: widget.isPassword




            ? IconButton(




                icon: Icon(




                  _obscure ? Icons.visibility_off_rounded : Icons.visibility_rounded,




                  color: AppColors.textLight,




                  size: 20,




                ),




                onPressed: () => setState(() => _obscure = !_obscure),




              )




            : null,




      ),




    );




  }




}









// ══════════════════════════════════════════════════════════╕




// 3. CROP RISK CARD (Home Dashboard)




// ══════════════════════════════════════════════════════════╛




class CropRiskCard extends StatelessWidget {




  final CropRiskModel crop;




  final int index;









  const CropRiskCard({super.key, required this.crop, required this.index});









  Color get _riskColor {




    switch (crop.riskLevel) {




      case RiskLevel.high:




        return AppColors.riskHigh;




      case RiskLevel.medium:




        return AppColors.riskMedium;




      case RiskLevel.low:




        return AppColors.riskLow;




      case RiskLevel.none:




        return AppColors.riskNone;




    }




  }









  Color get _riskBg {




    return _riskColor.withValues(alpha: 0.1);




  }









  @override




  Widget build(BuildContext context) {




    final isDark = Theme.of(context).brightness == Brightness.dark;




    final percentage = crop.riskPercentage / 100;









    return Container(




      margin: const EdgeInsets.only(bottom: 12),




      padding: const EdgeInsets.all(16),




      decoration: BoxDecoration(




        color: isDark ? AppColors.darkCard : Colors.white,




        borderRadius: BorderRadius.circular(18),




        boxShadow: AppTheme.cardShadow,




        border: Border.all(




          color: _riskColor.withValues(alpha: 0.15),




          width: 1,




        ),




      ),




      child: Row(




        children: [




          // Crop emoji in circle




          Container(




            width: 52,




            height: 52,




            decoration: BoxDecoration(




              color: AppColors.primarySurface,




              borderRadius: BorderRadius.circular(14),




            ),




            child: Center(




              child: Text(crop.cropEmoji, style: const TextStyle(fontSize: 28)),




            ),




          ),




          const SizedBox(width: 14),




          // Crop info




          Expanded(




            child: Column(




              crossAxisAlignment: CrossAxisAlignment.start,




              children: [




                Row(




                  mainAxisAlignment: MainAxisAlignment.spaceBetween,




                  children: [




                    Text(




                      crop.cropName,




                      style: const TextStyle(




                        fontSize: 15,




                        fontWeight: FontWeight.w700,




                      ),




                    ),




                    // Risk badge




                    Container(




                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),




                      decoration: BoxDecoration(




                        color: _riskBg,




                        borderRadius: BorderRadius.circular(50),




                      ),




                      child: Text(




                        crop.riskLevel.label,




                        style: TextStyle(




                          fontSize: 10,




                          fontWeight: FontWeight.w700,




                          color: _riskColor,




                          letterSpacing: 0.5,




                        ),




                      ),




                    ),




                  ],




                ),




                const SizedBox(height: 6),




                // Progress bar




                Stack(




                  children: [




                    Container(




                      height: 7,




                      decoration: BoxDecoration(




                        color: _riskColor.withValues(alpha: 0.12),




                        borderRadius: BorderRadius.circular(50),




                      ),




                    ),




                    FractionallySizedBox(




                      widthFactor: percentage,




                      child: Container(




                        height: 7,




                        decoration: BoxDecoration(




                          color: _riskColor,




                          borderRadius: BorderRadius.circular(50),




                        ),




                      ),




                    ),




                  ],




                ),




                const SizedBox(height: 6),




                Row(




                  mainAxisAlignment: MainAxisAlignment.spaceBetween,




                  children: [




                    Text(




                      crop.description ?? '',




                      style: TextStyle(




                        fontSize: 11,




                        color: isDark ? AppColors.darkTextMedium : AppColors.textLight,




                      ),




                      maxLines: 1,




                      overflow: TextOverflow.ellipsis,




                    ),




                    Text(




                      '${crop.riskPercentage.toInt()}%',




                      style: TextStyle(




                        fontSize: 13,




                        fontWeight: FontWeight.w700,




                        color: _riskColor,




                      ),




                    ),




                  ],




                ),




              ],




            ),




          ),




        ],




      ),




    )




        .animate(delay: Duration(milliseconds: index * 100))




        .fadeIn(duration: 400.ms)




        .slideX(begin: 0.3, end: 0, curve: Curves.easeOutCubic);




  }




}









// ══════════════════════════════════════════════════════════╕




// 4. SHIMMER LOADING CARD




// ══════════════════════════════════════════════════════════╛




class ShimmerCard extends StatelessWidget {




  final double height;




  final double? width;




  final double borderRadius;









  const ShimmerCard({




    super.key,




    this.height = 80,




    this.width,




    this.borderRadius = 18,




  });









  @override




  Widget build(BuildContext context) {




    final isDark = Theme.of(context).brightness == Brightness.dark;









    return Shimmer.fromColors(




      baseColor: isDark ? const Color(0xFF1E3024) : const Color(0xFFE8F0EA),




      highlightColor: isDark ? const Color(0xFF2E4433) : const Color(0xFFF5FAF7),




      child: Container(




        height: height,




        width: width ?? double.infinity,




        margin: const EdgeInsets.only(bottom: 12),




        decoration: BoxDecoration(




          color: isDark ? AppColors.darkCard : Colors.white,




          borderRadius: BorderRadius.circular(borderRadius),




        ),




      ),




    );




  }




}









// ══════════════════════════════════════════════════════════╕




// 5. WEATHER STAT TILE




// ══════════════════════════════════════════════════════════╛




class WeatherStatTile extends StatelessWidget {




  final String emoji;




  final String value;




  final String label;









  const WeatherStatTile({




    super.key,




    required this.emoji,




    required this.value,




    required this.label,




  });









  @override




  Widget build(BuildContext context) {




    return Column(




      mainAxisSize: MainAxisSize.min,




      children: [




        Text(emoji, style: const TextStyle(fontSize: 22)),




        const SizedBox(height: 4),




        Text(




          value,




          style: const TextStyle(




            fontSize: 15,




            fontWeight: FontWeight.w700,




            color: Colors.white,




          ),




        ),




        Text(




          label,




          style: const TextStyle(




            fontSize: 10,




            color: Colors.white70,




            letterSpacing: 0.3,




          ),




        ),




      ],




    );




  }




}









// ══════════════════════════════════════════════════════════╕




// 6. SECTION HEADER




// ══════════════════════════════════════════════════════════╛




class SectionHeader extends StatelessWidget {




  final String title;




  final String? subtitle;




  final Widget? trailing;









  const SectionHeader({




    super.key,




    required this.title,




    this.subtitle,




    this.trailing,




  });









  @override




  Widget build(BuildContext context) {




    return Row(




      mainAxisAlignment: MainAxisAlignment.spaceBetween,




      crossAxisAlignment: CrossAxisAlignment.center,




      children: [




        Column(




          crossAxisAlignment: CrossAxisAlignment.start,




          children: [




            Text(




              title,




              style: Theme.of(context).textTheme.titleLarge?.copyWith(




                    fontWeight: FontWeight.w700,




                  ),




            ),




            if (subtitle != null) ...[




              const SizedBox(height: 2),




              Text(




                subtitle!,




                style: Theme.of(context).textTheme.bodySmall,




              ),




            ],




          ],




        ),




        if (trailing != null) trailing!,




      ],




    );




  }




}









// ══════════════════════════════════════════════════════════╕




// 7. ANIMATED RISK PERCENTAGE METER




// ══════════════════════════════════════════════════════════╛




class RiskMeter extends StatelessWidget {




  final double percentage;




  final Color color;




  final double size;









  const RiskMeter({




    super.key,




    required this.percentage,




    required this.color,




    this.size = 70,




  });









  @override




  Widget build(BuildContext context) {




    return SizedBox(




      width: size,




      height: size,




      child: Stack(




        fit: StackFit.expand,




        children: [




          CircularProgressIndicator(




            value: percentage / 100,




            strokeWidth: 7,




            backgroundColor: color.withValues(alpha: 0.12),




            valueColor: AlwaysStoppedAnimation<Color>(color),




            strokeCap: StrokeCap.round,




          ),




          Center(




            child: Text(




              '${percentage.toInt()}%',




              style: TextStyle(




                fontSize: 14,




                fontWeight: FontWeight.w800,




                color: color,




              ),




            ),




          ),




        ],




      ),




    );




  }




}









// ══════════════════════════════════════════════════════════╕




// 8. RECOMMENDATION CARD




// ══════════════════════════════════════════════════════════╛




class RecommendationCard extends StatelessWidget {




  final CropRecommendation crop;




  final int index;









  const RecommendationCard({




    super.key,




    required this.crop,




    required this.index,




  });









  Color get _riskColor {




    switch (crop.riskLevel) {




      case RiskLevel.high:




        return AppColors.riskHigh;




      case RiskLevel.medium:




        return AppColors.riskMedium;




      case RiskLevel.low:




        return AppColors.riskLow;




      case RiskLevel.none:




        return AppColors.riskNone;




    }




  }









  @override




  Widget build(BuildContext context) {




    final isDark = Theme.of(context).brightness == Brightness.dark;









    return Container(




      margin: const EdgeInsets.only(bottom: 14),




      decoration: BoxDecoration(




        color: isDark ? AppColors.darkCard : Colors.white,




        borderRadius: BorderRadius.circular(20),




        boxShadow: AppTheme.cardShadow,




        border: Border.all(




          color: _riskColor.withValues(alpha: 0.18),




          width: 1,




        ),




      ),




      child: Column(




        children: [




          // Header row




          Padding(




            padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),




            child: Row(




              children: [




                // Emoji + name




                Container(




                  width: 56,




                  height: 56,




                  decoration: BoxDecoration(




                    gradient: LinearGradient(




                      colors: [




                        _riskColor.withValues(alpha: 0.15),




                        _riskColor.withValues(alpha: 0.05),




                      ],




                    ),




                    borderRadius: BorderRadius.circular(14),




                  ),




                  child: Center(




                    child: Text(crop.cropEmoji, style: const TextStyle(fontSize: 28)),




                  ),




                ),




                const SizedBox(width: 14),




                Expanded(




                  child: Column(




                    crossAxisAlignment: CrossAxisAlignment.start,




                    children: [




                      Text(




                        crop.cropName,




                        style: const TextStyle(




                          fontSize: 16,




                          fontWeight: FontWeight.w700,




                        ),




                      ),




                      const SizedBox(height: 4),




                      Text(




                        crop.suitabilityNote,




                        style: TextStyle(




                          fontSize: 12,




                          color: isDark ? AppColors.darkTextMedium : AppColors.textMedium,




                          height: 1.4,




                        ),




                      ),




                    ],




                  ),




                ),




                const SizedBox(width: 10),




                // Risk meter




                RiskMeter(




                  percentage: crop.riskPercentage,




                  color: _riskColor,




                  size: 64,




                ),




              ],




            ),




          ),




          // Risk label bar




          Container(




            width: double.infinity,




            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),




            decoration: BoxDecoration(




              color: _riskColor.withValues(alpha: 0.08),




              borderRadius: const BorderRadius.only(




                bottomLeft: Radius.circular(20),




                bottomRight: Radius.circular(20),




              ),




            ),




            child: Row(




              children: [




                Container(




                  width: 10,




                  height: 10,




                  decoration: BoxDecoration(




                    color: _riskColor,




                    shape: BoxShape.circle,




                  ),




                ),




                const SizedBox(width: 8),




                Text(




                  crop.riskLevel.label,




                  style: TextStyle(




                    fontSize: 12,




                    fontWeight: FontWeight.w700,




                    color: _riskColor,




                    letterSpacing: 0.5,




                  ),




                ),




                const Spacer(),




                // Benefits chips




                ...crop.benefits.take(2).map(




                      (b) => Container(




                        margin: const EdgeInsets.only(left: 6),




                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),




                        decoration: BoxDecoration(




                          color: AppColors.primarySurface,




                          borderRadius: BorderRadius.circular(50),




                        ),




                        child: Text(




                          b.split(' ').take(2).join(' '),




                          style: const TextStyle(




                            fontSize: 9,




                            fontWeight: FontWeight.w600,




                            color: AppColors.primary,




                          ),




                        ),




                      ),




                    ),




              ],




            ),




          ),




        ],




      ),




    )




        .animate(delay: Duration(milliseconds: 100 + index * 120))




        .fadeIn(duration: 500.ms)




        .slideY(begin: 0.3, end: 0, curve: Curves.easeOutCubic);




  }




}









// ══════════════════════════════════════════════════════════╕




// 9. EMPTY STATE WIDGET




// ══════════════════════════════════════════════════════════╛




class AgriEmptyState extends StatelessWidget {




  final String emoji;




  final String title;




  final String subtitle;




  final Widget? action;









  const AgriEmptyState({




    super.key,




    required this.emoji,




    required this.title,




    required this.subtitle,




    this.action,




  });









  @override




  Widget build(BuildContext context) {




    return Center(




      child: Padding(




        padding: const EdgeInsets.all(32),




        child: Column(




          mainAxisSize: MainAxisSize.min,




          children: [




            Text(emoji, style: const TextStyle(fontSize: 64))




                .animate(onPlay: (c) => c.repeat(reverse: true))




                .scaleXY(begin: 1, end: 1.1, duration: 1500.ms, curve: Curves.easeInOut),




            const SizedBox(height: 20),




            Text(




              title,




              style: Theme.of(context).textTheme.headlineSmall,




              textAlign: TextAlign.center,




            ),




            const SizedBox(height: 8),




            Text(




              subtitle,




              style: Theme.of(context).textTheme.bodyMedium?.copyWith(




                    color: AppColors.textLight,




                  ),




              textAlign: TextAlign.center,




            ),




            if (action != null) ...[




              const SizedBox(height: 24),




              action!,




            ],




          ],




        ),




      ),




    );




  }




}









// ══════════════════════════════════════════════════════════╕




// 10. AGRI DROPDOWN




// ══════════════════════════════════════════════════════════╛




class AgriDropdown<T> extends StatelessWidget {




  final String label;




  final String hint;




  final T? value;




  final List<DropdownMenuItem<T>> items;




  final ValueChanged<T?> onChanged;




  final IconData prefixIcon;









  const AgriDropdown({




    super.key,




    required this.label,




    required this.hint,




    required this.value,




    required this.items,




    required this.onChanged,




    required this.prefixIcon,




  });









  @override




  Widget build(BuildContext context) {




    final isDark = Theme.of(context).brightness == Brightness.dark;









    return Column(




      crossAxisAlignment: CrossAxisAlignment.start,




      children: [




        Text(




          label,




          style: TextStyle(




            fontSize: 13,




            fontWeight: FontWeight.w600,




            color: isDark ? AppColors.darkTextMedium : AppColors.textMedium,




          ),




        ),




        const SizedBox(height: 8),




        Container(




          padding: const EdgeInsets.symmetric(horizontal: 16),




          decoration: BoxDecoration(




            color: isDark ? AppColors.darkCard : Colors.white,




            borderRadius: BorderRadius.circular(14),




            border: Border.all(




              color: value != null




                  ? AppColors.primary.withValues(alpha: 0.4)




                  : (isDark




                      ? AppColors.primaryLight.withValues(alpha: 0.3)




                      : AppColors.divider),




              width: 1.5,




            ),




          ),




          child: DropdownButtonHideUnderline(




            child: DropdownButton<T>(




              value: value,




              hint: Row(




                children: [




                  Icon(prefixIcon, color: AppColors.primary, size: 20),




                  const SizedBox(width: 10),




                  Text(




                    hint,




                    style: TextStyle(




                      fontSize: 14,




                      color: isDark ? AppColors.darkTextMedium : AppColors.textLight,




                    ),




                  ),




                ],




              ),




              isExpanded: true,




              icon: const Icon(Icons.keyboard_arrow_down_rounded,




                  color: AppColors.primary),




              dropdownColor: isDark ? AppColors.darkCard : Colors.white,




              borderRadius: BorderRadius.circular(14),




              items: items,




              onChanged: onChanged,




            ),




          ),




        ),




      ],




    );




  }




}




