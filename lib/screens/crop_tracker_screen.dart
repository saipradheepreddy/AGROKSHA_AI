/// ─────────────────────────────────────────────────────────────────────────────



/// AGROKSHA AI — Crop Tracker Screen



/// Enter crop + sowing date → get growth stage, fertilizer, irrigation,



/// flowering alert, pest watch, harvest estimate, daily tip



/// ─────────────────────────────────────────────────────────────────────────────







library;







import 'package:flutter/material.dart';



import 'package:flutter_animate/flutter_animate.dart';



import 'package:provider/provider.dart';



import '../theme/app_theme.dart';



import '../models/models.dart';



import '../utils/app_provider.dart';



import '../widgets/widgets.dart';



import '../data/crop_stages_data.dart';







class CropTrackerScreen extends StatefulWidget {



  const CropTrackerScreen({super.key});







  @override



  State<CropTrackerScreen> createState() => _CropTrackerScreenState();



}







class _CropTrackerScreenState extends State<CropTrackerScreen> {



  String? _selectedCrop;



  DateTime? _sowingDate;



  final _noteCtrl = TextEditingController();



  bool _adding = false;







  @override



  void dispose() {



    _noteCtrl.dispose();



    super.dispose();



  }







  Future<void> _pickDate() async {



    final picked = await showDatePicker(



      context: context,



      initialDate: _sowingDate ?? DateTime.now().subtract(const Duration(days: 10)),



      firstDate: DateTime.now().subtract(const Duration(days: 365)),



      lastDate: DateTime.now(),



      helpText: 'Select Sowing / Planting Date',



      builder: (ctx, child) => Theme(



        data: Theme.of(ctx).copyWith(



          colorScheme: const ColorScheme.light(primary: AppColors.primary),



        ),



        child: child!,



      ),



    );



    if (picked != null) setState(() => _sowingDate = picked);



  }







  void _addEntry() {



    if (_selectedCrop == null || _sowingDate == null) return;



    final entry = CropTrackerEntry(



      id: 'ct_${DateTime.now().millisecondsSinceEpoch}',



      cropName: _selectedCrop!,



      cropEmoji: CropStageData.getCrop(_selectedCrop!)?['emoji'] as String? ?? '🌱',



      sowingDate: _sowingDate!,



      fieldNote: _noteCtrl.text.trim().isEmpty ? null : _noteCtrl.text.trim(),



    );



    context.read<AppProvider>().addCropEntry(entry);



    setState(() { _selectedCrop = null; _sowingDate = null; _adding = false; });



    _noteCtrl.clear();



    ScaffoldMessenger.of(context).showSnackBar(



      const SnackBar(content: Text('✅ Crop added to tracker!'), backgroundColor: AppColors.primary),



    );



  }







  @override



  Widget build(BuildContext context) {



    final isDark = Theme.of(context).brightness == Brightness.dark;



    final provider = context.watch<AppProvider>();







    return Scaffold(



      body: CustomScrollView(



        physics: const BouncingScrollPhysics(),



        slivers: [



          // App bar



          SliverAppBar(



            pinned: true,



            expandedHeight: 130,



            backgroundColor: AppColors.primary,



            flexibleSpace: FlexibleSpaceBar(



              background: Container(



                decoration: const BoxDecoration(gradient: AppColors.heroGradient),



                padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),



                alignment: Alignment.bottomLeft,



                child: SafeArea(



                  child: Column(



                    mainAxisAlignment: MainAxisAlignment.end,



                    crossAxisAlignment: CrossAxisAlignment.start,



                    children: [



                      const Text('🌱 Crop Tracker', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w800)),



                      const SizedBox(height: 2),



                      Text('Growth stage · Fertilizer · Harvest timeline',



                          style: TextStyle(color: Colors.white.withValues(alpha: 0.75), fontSize: 12)),



                    ],



                  ),



                ),



              ),



            ),



            actions: [



              Padding(



                padding: const EdgeInsets.only(right: 16),



                child: GestureDetector(



                  onTap: () => setState(() => _adding = !_adding),



                  child: Container(



                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),



                    decoration: BoxDecoration(



                      color: Colors.white.withValues(alpha: 0.2),



                      borderRadius: BorderRadius.circular(50),



                    ),



                    child: Row(



                      children: [



                        Icon(_adding ? Icons.close : Icons.add, color: Colors.white, size: 16),



                        const SizedBox(width: 4),



                        Text(_adding ? 'Cancel' : 'Add Crop',



                            style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w700)),



                      ],



                    ),



                  ),



                ),



              ),



            ],



          ),







          SliverPadding(



            padding: const EdgeInsets.fromLTRB(20, 16, 20, 100),



            sliver: SliverList(



              delegate: SliverChildListDelegate([



                // Add form



                AnimatedSize(



                  duration: const Duration(milliseconds: 350),



                  curve: Curves.easeOutCubic,



                  child: _adding ? _AddCropForm(



                    isDark: isDark,



                    selectedCrop: _selectedCrop,



                    sowingDate: _sowingDate,



                    noteCtrl: _noteCtrl,



                    onCropChanged: (v) => setState(() => _selectedCrop = v),



                    onPickDate: _pickDate,



                    onAdd: _selectedCrop != null && _sowingDate != null ? _addEntry : null,



                  ) : const SizedBox.shrink(),



                ),



                if (_adding) const SizedBox(height: 20),







                // Tracker list



                if (provider.cropEntries.isEmpty && !_adding)



                  const AgriEmptyState(



                    emoji: '🌱',



                    title: 'No crops tracked yet',



                    subtitle: 'Tap "Add Crop" above to start tracking your crop growth stages',



                  )



                else



                  ...provider.cropEntries.asMap().entries.map(



                    (e) => _CropEntryCard(



                      entry: e.value,



                      index: e.key,



                      isDark: isDark,



                      onDelete: () {



                        context.read<AppProvider>().removeCropEntry(e.value.id);



                      },



                    ),



                  ),



              ]),



            ),



          ),



        ],



      ),



    );



  }



}







// ─────────────────────────────────────────────────────────────────────────────



// Add Crop Form



// ─────────────────────────────────────────────────────────────────────────────



class _AddCropForm extends StatelessWidget {



  final bool isDark;



  final String? selectedCrop;



  final DateTime? sowingDate;



  final TextEditingController noteCtrl;



  final void Function(String?) onCropChanged;



  final VoidCallback onPickDate;



  final VoidCallback? onAdd;







  const _AddCropForm({



    required this.isDark, required this.selectedCrop, required this.sowingDate,



    required this.noteCtrl, required this.onCropChanged, required this.onPickDate,



    required this.onAdd,



  });







  @override



  Widget build(BuildContext context) {



    return Container(



      padding: const EdgeInsets.all(20),



      decoration: BoxDecoration(



        color: isDark ? AppColors.darkCard : Colors.white,



        borderRadius: BorderRadius.circular(20),



        boxShadow: AppTheme.cardShadow,



        border: Border.all(color: AppColors.primary.withValues(alpha: 0.12)),



      ),



      child: Column(



        crossAxisAlignment: CrossAxisAlignment.start,



        children: [



          const Text('Track a New Crop', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),



          const SizedBox(height: 16),



          AgriDropdown<String>(



            label: 'Crop Name',



            hint: 'Select crop',



            prefixIcon: Icons.grass_rounded,



            value: selectedCrop,



            items: CropStageData.cropNames.map((c) {



              final emoji = CropStageData.getCrop(c)?['emoji'] as String? ?? '🌱';



              return DropdownMenuItem(value: c, child: Row(children: [



                Text(emoji, style: const TextStyle(fontSize: 18)),



                const SizedBox(width: 10),



                Text(c),



              ]));



            }).toList(),



            onChanged: onCropChanged,



          ),



          const SizedBox(height: 14),



          // Date picker



          GestureDetector(



            onTap: onPickDate,



            child: Container(



              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),



              decoration: BoxDecoration(



                color: isDark ? AppColors.darkBackground : Colors.white,



                borderRadius: BorderRadius.circular(14),



                border: Border.all(color: AppColors.divider, width: 1.5),



              ),



              child: Row(



                children: [



                  const Icon(Icons.calendar_today_rounded, color: AppColors.primary, size: 20),



                  const SizedBox(width: 12),



                  Text(



                    sowingDate != null



                        ? 'Sowing: ${sowingDate!.day}/${sowingDate!.month}/${sowingDate!.year}'



                        : 'Select Sowing / Planting Date',



                    style: TextStyle(



                      fontSize: 14,



                      color: sowingDate != null ? AppColors.textDark : AppColors.textLight,



                      fontWeight: sowingDate != null ? FontWeight.w600 : FontWeight.w400,



                    ),



                  ),



                ],



              ),



            ),



          ),



          const SizedBox(height: 14),



          TextField(



            controller: noteCtrl,



            maxLines: 2,



            decoration: const InputDecoration(



              labelText: 'Field Note (optional)',



              hintText: 'e.g. Sown in north field, 1 acre',



              prefixIcon: Icon(Icons.note_rounded, color: AppColors.primary),



            ),



          ),



          const SizedBox(height: 18),



          GradientButton(



            label: '🌱 Start Tracking',



            onPressed: onAdd,



            icon: Icons.track_changes_rounded,



          ),



        ],



      ),



    ).animate().fadeIn(duration: 350.ms).slideY(begin: -0.1);



  }



}







// ─────────────────────────────────────────────────────────────────────────────



// Crop Entry Card — shows full analysis



// ─────────────────────────────────────────────────────────────────────────────



class _CropEntryCard extends StatefulWidget {



  final CropTrackerEntry entry;



  final int index;



  final bool isDark;



  final VoidCallback onDelete;







  const _CropEntryCard({required this.entry, required this.index, required this.isDark, required this.onDelete});







  @override



  State<_CropEntryCard> createState() => _CropEntryCardState();



}







class _CropEntryCardState extends State<_CropEntryCard> {



  bool _expanded = true;







  @override



  Widget build(BuildContext context) {



    final entry = widget.entry;



    final age = entry.ageInDays;



    final crop = entry.cropName;



    final stage = CropStageData.getCurrentStage(crop, age);



    final nextFert = CropStageData.nextFertilizerDay(crop, age);



    final nextPest = CropStageData.nextPestWatchDay(crop, age);



    final harvestIn = CropStageData.daysToHarvest(crop, age);



    final irrigInterval = CropStageData.irrigationInterval(crop);



    final isFlowering = CropStageData.isFlowering(crop, age);



    final totalDays = (CropStageData.getCrop(crop)?['durationDays'] as int?) ?? 120;



    final progress = (age / totalDays).clamp(0.0, 1.0);







    return Container(



      margin: const EdgeInsets.only(bottom: 16),



      decoration: BoxDecoration(



        color: widget.isDark ? AppColors.darkCard : Colors.white,



        borderRadius: BorderRadius.circular(20),



        boxShadow: AppTheme.cardShadow,



        border: isFlowering ? Border.all(color: Colors.pink.withValues(alpha: 0.4), width: 1.5) : null,



      ),



      child: Column(



        children: [



          // Header row



          InkWell(



            onTap: () => setState(() => _expanded = !_expanded),



            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),



            child: Padding(



              padding: const EdgeInsets.all(16),



              child: Row(



                children: [



                  Text(entry.cropEmoji, style: const TextStyle(fontSize: 36)),



                  const SizedBox(width: 12),



                  Expanded(



                    child: Column(



                      crossAxisAlignment: CrossAxisAlignment.start,



                      children: [



                        Text(entry.cropName,



                            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w700)),



                        const SizedBox(height: 2),



                        Text('Day $age  •  ${stage['name']} ${stage['emoji']}',



                            style: const TextStyle(fontSize: 13, color: AppColors.textMedium)),



                        const SizedBox(height: 6),



                        // Progress bar



                        ClipRRect(



                          borderRadius: BorderRadius.circular(50),



                          child: LinearProgressIndicator(



                            value: progress,



                            backgroundColor: AppColors.divider,



                            color: harvestIn <= 10 ? AppColors.riskLow : AppColors.primary,



                            minHeight: 6,



                          ),



                        ),



                        const SizedBox(height: 3),



                        Text('${(progress * 100).toInt()}% complete · Harvest in $harvestIn days',



                            style: const TextStyle(fontSize: 10, color: AppColors.textLight)),



                      ],



                    ),



                  ),



                  Column(



                    children: [



                      IconButton(



                        icon: Icon(_expanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,



                            color: AppColors.textLight),



                        onPressed: () => setState(() => _expanded = !_expanded),



                        padding: EdgeInsets.zero,



                        constraints: const BoxConstraints(),



                      ),



                      const SizedBox(height: 4),



                      IconButton(



                        icon: const Icon(Icons.delete_outline_rounded, color: AppColors.riskHigh, size: 20),



                        onPressed: widget.onDelete,



                        padding: EdgeInsets.zero,



                        constraints: const BoxConstraints(),



                      ),



                    ],



                  ),



                ],



              ),



            ),



          ),







          // Expanded analysis



          if (_expanded)



            Padding(



              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),



              child: Column(



                children: [



                  const Divider(height: 1),



                  const SizedBox(height: 14),







                  // Flowering alert banner



                  if (isFlowering) _AlertBanner(



                    emoji: '🌸',



                    title: 'Flowering Stage Alert!',



                    message: 'Avoid spraying pesticides during flowering. Protect pollinators.',



                    color: Colors.pink,



                  ),



                  if (isFlowering) const SizedBox(height: 10),







                  // Info tiles grid



                  GridView.count(



                    crossAxisCount: 2,



                    shrinkWrap: true,



                    physics: const NeverScrollableScrollPhysics(),



                    mainAxisSpacing: 10,



                    crossAxisSpacing: 10,



                    childAspectRatio: 2.4,



                    children: [



                      _InfoTile(emoji: '💧', label: 'Irrigate every', value: '$irrigInterval days'),



                      _InfoTile(



                        emoji: '🧪',



                        label: 'Next fertilizer',



                        value: nextFert != null ? 'Day $nextFert (in ${nextFert - age}d)' : 'Done ✓',



                      ),



                      _InfoTile(



                        emoji: '🐛',



                        label: 'Pest watch',



                        value: nextPest != null ? 'Day $nextPest (in ${nextPest - age}d)' : 'Done ✓',



                      ),



                      _InfoTile(



                        emoji: '🏆',



                        label: 'Harvest est.',



                        value: harvestIn > 0 ? 'In $harvestIn days' : 'Ready now!',



                      ),



                    ],



                  ),







                    if (entry.fieldNote != null) ...[



                      const SizedBox(height: 12),



                      Container(



                        width: double.infinity,



                        padding: const EdgeInsets.all(12),



                        decoration: BoxDecoration(



                          color: AppColors.primarySurface,



                          borderRadius: BorderRadius.circular(12),



                        ),



                        child: Text('📝 ${entry.fieldNote!}',



                            style: const TextStyle(fontSize: 12, color: AppColors.textMedium)),



                      ),



                    ],







                    const SizedBox(height: 20),



                    const Divider(height: 1),



                    const SizedBox(height: 16),



                    const Align(



                      alignment: Alignment.centerLeft,



                      child: Text('Crop Growth Timeline', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.textMedium)),



                    ),



                    const SizedBox(height: 12),



                    _TimelineView(cropName: crop, currentAge: age, isDark: widget.isDark),



                  ],



                ),



              ),



        ],



      ),



    )



        .animate(delay: Duration(milliseconds: widget.index * 80))



        .fadeIn(duration: 400.ms)



        .slideY(begin: 0.2, end: 0, curve: Curves.easeOutCubic);



  }



}







class _InfoTile extends StatelessWidget {



  final String emoji;



  final String label;



  final String value;







  const _InfoTile({required this.emoji, required this.label, required this.value});







  @override



  Widget build(BuildContext context) {



    return Container(



      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),



      decoration: BoxDecoration(



        color: AppColors.primarySurface,



        borderRadius: BorderRadius.circular(12),



      ),



      child: Row(



        children: [



          Text(emoji, style: const TextStyle(fontSize: 20)),



          const SizedBox(width: 8),



          Expanded(



            child: Column(



              crossAxisAlignment: CrossAxisAlignment.start,



              mainAxisAlignment: MainAxisAlignment.center,



              children: [



                Text(label, style: const TextStyle(fontSize: 9, color: AppColors.textLight)),



                Text(value, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.primary)),



              ],



            ),



          ),



        ],



      ),



    );



  }



}







class _AlertBanner extends StatelessWidget {



  final String emoji;



  final String title;



  final String message;



  final Color color;







  const _AlertBanner({required this.emoji, required this.title, required this.message, required this.color});







  @override



  Widget build(BuildContext context) {



    return Container(



      padding: const EdgeInsets.all(12),



      decoration: BoxDecoration(



        color: color.withValues(alpha: 0.08),



        borderRadius: BorderRadius.circular(12),



        border: Border.all(color: color.withValues(alpha: 0.3)),



      ),



      child: Row(



        children: [



          Text(emoji, style: const TextStyle(fontSize: 22)),



          const SizedBox(width: 10),



          Expanded(



            child: Column(



              crossAxisAlignment: CrossAxisAlignment.start,



              children: [



                Text(title, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: color)),



                Text(message, style: const TextStyle(fontSize: 11, color: AppColors.textMedium, height: 1.4)),



              ],



            ),



          ),



        ],



      ),



    );



  }



}











// ─────────────────────────────────────────────────────────────────────────────



// Vertical Timeline View



// ─────────────────────────────────────────────────────────────────────────────



class _TimelineView extends StatelessWidget {



  final String cropName;



  final int currentAge;



  final bool isDark;







  const _TimelineView({required this.cropName, required this.currentAge, required this.isDark});







  @override



  Widget build(BuildContext context) {



    final cropData = CropStageData.getCrop(cropName);



    if (cropData == null) return const SizedBox.shrink();







    final stages = cropData['stages'] as List;







    return Column(



      children: List.generate(stages.length, (index) {



        final stage = stages[index] as Map;



        final startDay = stage['startDay'] as int;



        final endDay = stage['endDay'] as int;



        



        final isCompleted = currentAge > endDay;



        final isCurrent = currentAge >= startDay && currentAge <= endDay;



        final isFuture = currentAge < startDay;







        final color = isCurrent ? AppColors.primary : (isCompleted ? AppColors.primary.withValues(alpha: 0.5) : AppColors.textLight.withValues(alpha: 0.3));



        



        return Row(



          crossAxisAlignment: CrossAxisAlignment.start,



          children: [



            // Timeline line & dot



            Column(



              children: [



                Container(



                  width: 16, height: 16,



                  decoration: BoxDecoration(



                    color: isCurrent ? AppColors.primary : Colors.transparent,



                    shape: BoxShape.circle,



                    border: Border.all(color: color, width: 2),



                  ),



                  child: isCompleted ? const Icon(Icons.check, size: 10, color: AppColors.primary) : null,



                ),



                if (index != stages.length - 1)



                  Container(



                    width: 2, height: 30,



                    color: color,



                  ),



              ],



            ),



            const SizedBox(width: 16),



            // Stage text



            Expanded(



              child: Padding(



                padding: const EdgeInsets.only(bottom: 16),



                child: Column(



                  crossAxisAlignment: CrossAxisAlignment.start,



                  children: [



                    Row(



                      children: [



                        Text('${stage['emoji']} ', style: const TextStyle(fontSize: 16)),



                        Text(



                          stage['name'] as String,



                          style: TextStyle(



                            fontSize: 14,



                            fontWeight: isCurrent ? FontWeight.w800 : FontWeight.w600,



                            color: isFuture ? AppColors.textLight : (isDark ? Colors.white : AppColors.textDark),



                          ),



                        ),



                        if (isCurrent) ...[



                          const SizedBox(width: 8),



                          Container(



                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),



                            decoration: BoxDecoration(color: AppColors.primarySurface, borderRadius: BorderRadius.circular(4)),



                            child: const Text('CURRENT', style: TextStyle(fontSize: 8, fontWeight: FontWeight.w800, color: AppColors.primary)),



                          ),



                        ],



                      ],



                    ),



                    const SizedBox(height: 2),



                    Text(



                      'Day $startDay - $endDay',



                      style: TextStyle(



                        fontSize: 12,



                        color: isFuture ? AppColors.textLight.withValues(alpha: 0.5) : AppColors.textMedium,



                      ),



                    ),



                  ],



                ),



              ),



            ),



          ],



        );



      }),



    );



  }



}







