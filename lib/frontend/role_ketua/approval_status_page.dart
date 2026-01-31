import 'package:flutter/material.dart';

class ApprovalStatusPage extends StatefulWidget {
  const ApprovalStatusPage({super.key});

  @override
  State<ApprovalStatusPage> createState() => _ApprovalStatusPageState();
}

class _ApprovalStatusPageState extends State<ApprovalStatusPage> {
  final Color navyOxigen = const Color(0xFF0D1B3E);

  List<Map<String, dynamic>> _statusList = [
    {"nama": "Rina Putri", "nim": "2301001", "perubahan": "Calon -> Aktif", "isSelected": false},
    {"nama": "Fajar Sidik", "nim": "2301005", "perubahan": "Aktif -> Alumni", "isSelected": false},
    {"nama": "Gita Gutawa", "nim": "2301009", "perubahan": "Calon -> Aktif", "isSelected": false},
  ];

  bool _isAllSelected = false;

  void _selectAll(bool? val) {
    setState(() {
      _isAllSelected = val ?? false;
      for (var item in _statusList) {
        item['isSelected'] = _isAllSelected;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    int selectedCount = _statusList.where((e) => e['isSelected']).length;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Approval Status", style: TextStyle(color: Colors.white, fontSize: 18)),
        backgroundColor: navyOxigen,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          // Bar Aksi Cepat
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              children: [
                Checkbox(value: _isAllSelected, onChanged: _selectAll),
                const Text("Ceklis Semua", style: TextStyle(fontWeight: FontWeight.w600)),
                const Spacer(),
                if (selectedCount > 0)
                  TextButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.verified, color: Colors.blue),
                    label: Text("Validasi ($selectedCount)"),
                  )
              ],
            ),
          ),
          
          Expanded(
            child: ListView.builder(
              itemCount: _statusList.length,
              itemBuilder: (context, index) {
                final item = _statusList[index];
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade200),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: CheckboxListTile(
                    activeColor: const Color(0xFF2E5BFF),
                    title: Text(item['nama'], style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text("${item['nim']} | ${item['perubahan']}"),
                    value: item['isSelected'],
                    onChanged: (bool? val) {
                      setState(() {
                        _statusList[index]['isSelected'] = val!;
                        _isAllSelected = _statusList.every((e) => e['isSelected']);
                      });
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}