import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../theme/app_theme.dart';

class StockManagementScreen extends StatefulWidget {
  const StockManagementScreen({super.key});

  @override
  State<StockManagementScreen> createState() => _StockManagementScreenState();
}

class _StockManagementScreenState extends State<StockManagementScreen> {
  final List<Map<String, dynamic>> _inventory = [
    {'name': 'Wheat Seeds', 'quantity': 150.0, 'unit': 'Kg', 'icon': Icons.grass_rounded, 'color': Colors.green},
    {'name': 'Urea Fertilizer', 'quantity': 20.0, 'unit': 'Bags', 'icon': Icons.science_rounded, 'color': Colors.blue},
    {'name': 'Pesticides', 'quantity': 5.0, 'unit': 'Liters', 'icon': Icons.pest_control_rounded, 'color': Colors.redAccent},
  ];

  final _nameController = TextEditingController();
  final _qtyController = TextEditingController();
  String _selectedUnit = 'Kg';
  IconData _selectedIcon = Icons.inventory_2_rounded;
  Color _selectedColor = Colors.teal;

  final List<String> _units = ['Kg', 'Bags', 'Liters', 'Quintals', 'Tons', 'Packets', 'Boxes'];
  final Map<String, Map<String, dynamic>> _iconOptions = {
    'Seeds': {'icon': Icons.grass_rounded, 'color': Colors.green},
    'Fertilizer': {'icon': Icons.science_rounded, 'color': Colors.blue},
    'Pesticide': {'icon': Icons.pest_control_rounded, 'color': Colors.redAccent},
    'Equipment': {'icon': Icons.agriculture_rounded, 'color': Colors.brown},
    'Other': {'icon': Icons.inventory_2_rounded, 'color': Colors.teal},
  };

  @override
  void dispose() {
    _nameController.dispose();
    _qtyController.dispose();
    super.dispose();
  }

  void _showStockModal({int? editIndex}) {
    final isEdit = editIndex != null;
    if (isEdit) {
      final item = _inventory[editIndex];
      _nameController.text = item['name'];
      _qtyController.text = item['quantity'].toString();
      _selectedUnit = item['unit'];
      _selectedIcon = item['icon'];
      _selectedColor = item['color'];
    } else {
      _nameController.clear();
      _qtyController.clear();
      _selectedUnit = 'Kg';
      _selectedIcon = Icons.inventory_2_rounded;
      _selectedColor = Colors.teal;
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) => Container(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom + 24,
            left: 24, right: 24, top: 28,
          ),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.teal.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(isEdit ? Icons.edit_rounded : Icons.add_rounded, color: Colors.teal, size: 22),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    isEdit ? 'Edit Stock Item' : 'Add Stock Item',
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // Item type selector
              Text('Item Type', style: TextStyle(fontSize: 13, color: Colors.grey.shade600, fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _iconOptions.entries.map((e) {
                  final selected = _selectedIcon == e.value['icon'];
                  return GestureDetector(
                    onTap: () => setModalState(() {
                      _selectedIcon = e.value['icon'];
                      _selectedColor = e.value['color'];
                    }),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: selected ? _selectedColor.withOpacity(0.15) : Colors.grey.shade100,
                        border: Border.all(color: selected ? _selectedColor : Colors.transparent, width: 2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(e.value['icon'], color: selected ? _selectedColor : Colors.grey, size: 16),
                          const SizedBox(width: 4),
                          Text(e.key, style: TextStyle(fontSize: 12, color: selected ? _selectedColor : Colors.grey.shade700, fontWeight: FontWeight.w600)),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Item Name',
                  hintText: 'e.g. BPT Rice Seeds',
                  prefixIcon: Icon(_selectedIcon, color: _selectedColor),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.teal, width: 2),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: TextField(
                      controller: _qtyController,
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      decoration: InputDecoration(
                        labelText: 'Quantity',
                        prefixIcon: const Icon(Icons.numbers_rounded),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Colors.teal, width: 2),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: _selectedUnit,
                      decoration: InputDecoration(
                        labelText: 'Unit',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      items: _units.map((u) => DropdownMenuItem(value: u, child: Text(u))).toList(),
                      onChanged: (v) => setModalState(() => _selectedUnit = v!),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  if (isEdit)
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {
                          setState(() => _inventory.removeAt(editIndex));
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Item deleted'), backgroundColor: Colors.red),
                          );
                        },
                        icon: const Icon(Icons.delete_rounded, color: Colors.red),
                        label: const Text('Delete', style: TextStyle(color: Colors.red)),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.red),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                      ),
                    ),
                  if (isEdit) const SizedBox(width: 12),
                  Expanded(
                    flex: 2,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        final name = _nameController.text.trim();
                        final qty = double.tryParse(_qtyController.text.trim());
                        if (name.isEmpty || qty == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Please fill all fields correctly')),
                          );
                          return;
                        }
                        final newItem = {
                          'name': name,
                          'quantity': qty,
                          'unit': _selectedUnit,
                          'icon': _selectedIcon,
                          'color': _selectedColor,
                        };
                        setState(() {
                          if (isEdit) {
                            _inventory[editIndex] = newItem;
                          } else {
                            _inventory.insert(0, newItem);
                          }
                        });
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(isEdit ? 'Stock updated!' : 'Stock item added!'),
                            backgroundColor: Colors.teal,
                          ),
                        );
                      },
                      icon: Icon(isEdit ? Icons.save_rounded : Icons.check_rounded),
                      label: Text(isEdit ? 'Update' : 'Save Item'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Farm Inventory'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Summary header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
            decoration: const BoxDecoration(
              color: Colors.teal,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(28),
                bottomRight: Radius.circular(28),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _SummaryChip(label: 'Items', value: '${_inventory.length}', icon: Icons.inventory_2_rounded),
                _SummaryChip(
                  label: 'Low Stock',
                  value: '${_inventory.where((i) => (i['quantity'] as double) < 10).length}',
                  icon: Icons.warning_amber_rounded,
                  color: Colors.orange,
                ),
              ],
            ),
          ),
          // Item list
          Expanded(
            child: _inventory.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.inventory_2_outlined, size: 72, color: Colors.grey.shade300),
                        const SizedBox(height: 16),
                        Text('No inventory items yet', style: TextStyle(color: Colors.grey.shade500, fontSize: 16)),
                        const SizedBox(height: 8),
                        Text('Tap + to add your first item', style: TextStyle(color: Colors.grey.shade400, fontSize: 13)),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(20),
                    itemCount: _inventory.length,
                    itemBuilder: (context, index) {
                      final item = _inventory[index];
                      final qty = item['quantity'] as double;
                      final isLow = qty < 10;
                      return Card(
                        margin: const EdgeInsets.only(bottom: 14),
                        elevation: 2,
                        shadowColor: Colors.black12,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                        child: InkWell(
                          onTap: () => _showStockModal(editIndex: index),
                          borderRadius: BorderRadius.circular(18),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: (item['color'] as Color).withOpacity(0.12),
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                  child: Icon(item['icon'] as IconData, color: item['color'] as Color, size: 26),
                                ),
                                const SizedBox(width: 14),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(item['name'], style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
                                      const SizedBox(height: 4),
                                      Row(
                                        children: [
                                          Text(
                                            '${qty % 1 == 0 ? qty.toInt() : qty} ${item['unit']}',
                                            style: TextStyle(color: Colors.grey.shade600, fontSize: 13, fontWeight: FontWeight.w500),
                                          ),
                                          if (isLow) ...[
                                            const SizedBox(width: 8),
                                            Container(
                                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                              decoration: BoxDecoration(color: Colors.orange.shade50, borderRadius: BorderRadius.circular(6)),
                                              child: Text('Low Stock', style: TextStyle(color: Colors.orange.shade800, fontSize: 10, fontWeight: FontWeight.bold)),
                                            ),
                                          ],
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Icon(Icons.edit_outlined, color: Colors.grey.shade400, size: 20),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showStockModal(),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text('Add Item', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }
}

class _SummaryChip extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;
  const _SummaryChip({required this.label, required this.value, required this.icon, this.color = Colors.white});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: color.withOpacity(0.85), size: 22),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 22)),
        Text(label, style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 12)),
      ],
    );
  }
}
