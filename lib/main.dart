import 'package:flutter/material.dart';

void main() => runApp(const SagaEatBusinessApp());

class SagaEatBusinessApp extends StatelessWidget {
  const SagaEatBusinessApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(primarySwatch: Colors.amber, useMaterial3: true),
    home: const DashboardScreen(),
  );
}

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});
  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _currentIndex = 0;
  String _statusFilter = "Tout";
  String _employeeFilter = "Tout";
  DateTimeRange? _dateRange;

  // Filtè pou nouvo Onglet Istorik la
  String _historyEmployeeFilter = "Tout";
  DateTimeRange? _historyDateRange;

  // Filtè ak rechèch pou Onglet Plat
  String _searchQuery = "";
  String _stockSortOrder = "Tout";

  // --- VARYAB POU ONGLET PROFILE ---
  final TextEditingController _restNameController = TextEditingController(
    text: "SagaEat",
  );
  final TextEditingController _restDescController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final List<String> _phones = [""];
  String? _selectedDept;
  String? _selectedCommune;
  final List<String> _deliveryZones = []; // Komin kote restoran an ka livre

  // Done Jewografik Ayiti (10 Depatman ak Komin prensipal yo)
  final Map<String, List<String>> _haitiData = {
    "Artibonite": [
      "Gonaïves",
      "Saint-Marc",
      "Dessalines",
      "Gros-Morne",
      "Marmelade",
      "L'Estère",
    ],
    "Centre": [
      "Hinche",
      "Mirebalais",
      "Cerca-la-Source",
      "Lascahobas",
      "Savanette",
    ],
    "Grand'Anse": [
      "Jérémie",
      "Anse-d'Hainault",
      "Corail",
      "Dame-Marie",
      "Les Irois",
    ],
    "Nippes": [
      "Miragoâne",
      "Anse-à-Veau",
      "Baradères",
      "Fonds-des-Nègres",
      "Petite-Rivière-de-Nippes",
    ],
    "Nord": [
      "Cap-Haïtien",
      "Acul-du-Nord",
      "Borgne",
      "Grande-Rivière-du-Nord",
      "Limbé",
      "Plaisance",
    ],
    "Nord-Est": [
      "Fort-Liberté",
      "Ouanaminthe",
      "Trou-du-Nord",
      "Vallières",
      "Terrier-Rouge",
    ],
    "Nord-Ouest": [
      "Port-de-Paix",
      "Môle-Saint-Nicolas",
      "Saint-Louis-du-Nord",
      "Jean-Rabel",
      "Baie-de-Henne",
    ],
    "Ouest": [
      "Port-au-Prince",
      "Carrefour",
      "Delmas",
      "Pétion-Ville",
      "Cité Soleil",
      "Tabarre",
      "Croix-des-Bouquets",
      "Léogâne",
      "Petit-Goâve",
      "Arcahaie",
      "Cabaret",
      "Kenscoff",
    ],
    "Sud": [
      "Les Cayes",
      "Port-Salut",
      "Aquin",
      "Coteaux",
      "Chardonnières",
      "Camp-Perrin",
    ],
    "Sud-Est": ["Jacmel", "Bainet", "Belle-Anse", "Marigot", "Côtes-de-Fer"],
  };

  // Lis anplwaye yo (San avatar)
  List<Map<String, String>> staffList = [
    {
      "name": "Mèt Dary",
      "role": "Cuisinier",
      "phone": "+509 3456-7890",
      "address": "Carrefour, Haiti",
    },
    {
      "name": "Jean Pierre",
      "role": "Livreur",
      "phone": "+509 3123-4567",
      "address": "Port-au-Prince, Haiti",
    },
    {
      "name": "Marie",
      "role": "Cuisinier & Livreur",
      "phone": "+509 3789-0123",
      "address": "Delmas, Haiti",
    },
  ];

  // Lis kòmand yo mete a jou pou sipòte Timeline, Lè, ak Rezon Anile
  late List<Map<String, dynamic>> orders;

  @override
  void initState() {
    super.initState();
    // Inisyalize lis kòmand yo yon sèl fwa avèk dat mock pou nou wè Istorik la
    orders = List.generate(10, (i) {
      bool isAkasan = i == 0;
      // Nou kreye kèk kòmand ki deja Livre oswa Anile pou nou wè nan istorik la
      String initStatus = i < 2
          ? "En cours"
          : (i < 4 ? "En préparation" : (i < 7 ? "Livre" : "Annulé"));
      DateTime now = DateTime.now();

      return {
        "id": "ORD-00${i + 1}",
        "name": "Kliyan ${i + 1}",
        "pla": isAkasan
            ? "Akasan"
            : (i % 2 == 0 ? "Griyo ak Bannan" : "Taso Kabrit"),
        "pri": isAkasan ? "750 HTG" : (i % 2 == 0 ? "1500 HTG" : "2000 HTG"),
        "status": initStatus,
        "cuisinier": initStatus != "En cours" ? "Mèt Dary" : "",
        "livreur":
            (initStatus == "Livre" || initStatus == "En cours de livraison")
            ? "Jean Pierre"
            : "",

        // Time tracking fields
        "date": now.subtract(Duration(days: i)), // Lè kòmand lan tonbe a
        "date_prepared": initStatus == "En préparation" || initStatus == "Livre"
            ? now.subtract(Duration(days: i)).add(const Duration(minutes: 15))
            : null,
        "date_delivery": initStatus == "Livre"
            ? now.subtract(Duration(days: i)).add(const Duration(minutes: 30))
            : null,
        "date_completed": initStatus == "Livre"
            ? now.subtract(Duration(days: i)).add(const Duration(hours: 1))
            : null,
        "date_canceled": initStatus == "Annulé"
            ? now.subtract(Duration(days: i)).add(const Duration(minutes: 20))
            : null,
        "cancel_reason": initStatus == "Annulé"
            ? "Kliyan an pa t disponib lè livreur a rive"
            : "",

        "memo": isAkasan
            ? "San sik tanpri, m fè alèji ak nwa. Pa kite anyen touche l!"
            : (i == 1 ? "Mete anpil sòs pwa" : ""),
        "supplements": isAkasan
            ? ["Pen", "Lèt"]
            : (i == 2 ? ["Piment", "Bannan fri ilt"] : []),
      };
    });
  }

  // Fòma dat ak lè pou timeline lan
  String _formatDate(DateTime? dt) {
    if (dt == null) return "N/A";
    return "${dt.day.toString().padLeft(2, '0')}/${dt.month.toString().padLeft(2, '0')}/${dt.year} a ${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}";
  }

  // Lis Plat nan Meni an avèk Stock Sipleman solid
  List<Map<String, dynamic>> menuPlats = [
    {
      "name": "Pizza",
      "pri": 2500.0,
      "stock": 10,
      "available": true,
      "supplements": [
        {
          "name": "Piment",
          "pri": 250.0,
          "stock": 10,
          "syncWithPlatStock": true,
        },
        {
          "name": "Fromage",
          "pri": 500.0,
          "stock": 4,
          "syncWithPlatStock": false,
        },
      ],
    },
    {
      "name": "Griyo ak Bannan",
      "pri": 1500.0,
      "stock": 15,
      "available": true,
      "supplements": [],
    },
  ];

  // Controller prensipal yo pou Plat
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _stockController = TextEditingController();

  // Pou kreyasyon sipleman dinamik nan fòm nan
  List<Map<String, dynamic>> _tempSupplements = [];
  final TextEditingController _suppNameController = TextEditingController();
  final TextEditingController _suppPriceController = TextEditingController();
  final TextEditingController _suppStockController = TextEditingController();
  bool _tempSyncWithPlatStock = true;

  // Controllers pou fòm anplwaye (Staff)
  final TextEditingController _staffNameController = TextEditingController();
  final TextEditingController _staffPhoneController = TextEditingController();
  final TextEditingController _staffAddressController = TextEditingController();
  String _selectedRole = "Cuisinier";

  // Louvri fòm pou Ajoute/Modifye Plat ak Sipleman yo
  void _showPlatForm({int? index}) {
    if (index != null) {
      _nameController.text = menuPlats[index]['name'];
      _priceController.text = menuPlats[index]['pri'].toString();
      _stockController.text = menuPlats[index]['stock'].toString();
      _tempSupplements = List<Map<String, dynamic>>.from(
        menuPlats[index]['supplements'].map(
          (s) => Map<String, dynamic>.from(s),
        ),
      );
    } else {
      _nameController.clear();
      _priceController.clear();
      _stockController.clear();
      _tempSupplements = [];
    }
    _suppNameController.clear();
    _suppPriceController.clear();
    _suppStockController.clear();
    _tempSyncWithPlatStock = true;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) => Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            top: 20,
            left: 16,
            right: 16,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  index == null ? "Ajoute yon nouvo Plat" : "Modifye Plat la",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: "Non Plat la",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _priceController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: "Pri Debaz (HTG)",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _stockController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: "Stock Disponib",
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (v) {
                    if (v.isNotEmpty) {
                      setModalState(() {
                        for (var s in _tempSupplements) {
                          if (s['syncWithPlatStock'] == true) {
                            s['stock'] = int.tryParse(v) ?? 0;
                          }
                        }
                      });
                    }
                  },
                ),
                const Divider(height: 30),
                const Text(
                  "Sipleman pou Plat sa a",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 10),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _tempSupplements.length,
                  itemBuilder: (ctx, idx) {
                    final s = _tempSupplements[idx];
                    return ListTile(
                      title: Text(s['name']),
                      subtitle: Text(
                        "+${s['pri']} HTG • Stock: ${s['syncWithPlatStock'] ? 'Menm ak plat la' : s['stock']}",
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () =>
                            setModalState(() => _tempSupplements.removeAt(idx)),
                      ),
                    );
                  },
                ),
                Card(
                  color: Colors.grey[50],
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: _suppNameController,
                                decoration: const InputDecoration(
                                  labelText: "Non Sipleman",
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: TextField(
                                controller: _suppPriceController,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  labelText: "Pri",
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Checkbox(
                              value: _tempSyncWithPlatStock,
                              onChanged: (val) {
                                setModalState(() {
                                  _tempSyncWithPlatStock = val ?? true;
                                  if (_tempSyncWithPlatStock) {
                                    _suppStockController.clear();
                                  }
                                });
                              },
                            ),
                            const Text(
                              "Menm kantite ak plat la",
                              style: TextStyle(fontSize: 13),
                            ),
                            const SizedBox(width: 10),
                            if (!_tempSyncWithPlatStock)
                              Expanded(
                                child: TextField(
                                  controller: _suppStockController,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                    labelText: "Stock sipleman",
                                  ),
                                ),
                              )
                            else
                              const Spacer(),
                            IconButton(
                              icon: const Icon(
                                Icons.add_circle,
                                color: Colors.green,
                                size: 32,
                              ),
                              onPressed: () {
                                if (_suppNameController.text.isNotEmpty &&
                                    _suppPriceController.text.isNotEmpty) {
                                  int mainStock =
                                      int.tryParse(_stockController.text) ?? 0;
                                  int suppStock = _tempSyncWithPlatStock
                                      ? mainStock
                                      : (int.tryParse(
                                              _suppStockController.text,
                                            ) ??
                                            0);
                                  setModalState(() {
                                    _tempSupplements.add({
                                      "name": _suppNameController.text,
                                      "pri":
                                          double.tryParse(
                                            _suppPriceController.text,
                                          ) ??
                                          0.0,
                                      "stock": suppStock,
                                      "syncWithPlatStock":
                                          _tempSyncWithPlatStock,
                                    });
                                  });
                                  _suppNameController.clear();
                                  _suppPriceController.clear();
                                  _suppStockController.clear();
                                  _tempSyncWithPlatStock = true;
                                }
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                  ),
                  onPressed: () {
                    final String name = _nameController.text;
                    final double price =
                        double.tryParse(_priceController.text) ?? 0.0;
                    final int stock = int.tryParse(_stockController.text) ?? 0;
                    final bool isAvailable = stock > 0;
                    for (var s in _tempSupplements) {
                      if (s['syncWithPlatStock'] == true) s['stock'] = stock;
                    }
                    setState(() {
                      if (index == null) {
                        menuPlats.add({
                          "name": name,
                          "pri": price,
                          "stock": stock,
                          "available": isAvailable,
                          "supplements": _tempSupplements,
                        });
                      } else {
                        menuPlats[index] = {
                          "name": name,
                          "pri": price,
                          "stock": stock,
                          "available": isAvailable,
                          "supplements": _tempSupplements,
                        };
                      }
                    });
                    Navigator.pop(context);
                  },
                  child: Text(
                    index == null ? "Ajoute Plat la" : "Sove Chanjman",
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // LOUVRI FÒM POU AJOUTE OWSWA MODIFYE STAFF (San Avatar)
  void _showStaffForm({int? index}) {
    if (index != null) {
      _staffNameController.text = staffList[index]['name'] ?? "";
      _staffPhoneController.text = staffList[index]['phone'] ?? "";
      _staffAddressController.text = staffList[index]['address'] ?? "";
      _selectedRole = staffList[index]['role'] ?? "Cuisinier";
    } else {
      _staffNameController.clear();
      _staffPhoneController.clear();
      _staffAddressController.clear();
      _selectedRole = "Cuisinier";
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) => Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            top: 20,
            left: 16,
            right: 16,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  index == null
                      ? "Ajoute yon nouvo Anplwaye"
                      : "Modifye Enfòmasyon Anplwaye",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                const CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.amber,
                  child: Icon(Icons.person, size: 50, color: Colors.white),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _staffNameController,
                  decoration: const InputDecoration(
                    labelText: "Non konplè",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _staffPhoneController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    labelText: "Nimewo Telefòn",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _staffAddressController,
                  decoration: const InputDecoration(
                    labelText: "Adrès kay",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: "Wòl Anplwaye a",
                    border: OutlineInputBorder(),
                  ),
                  initialValue: _selectedRole,
                  items: ["Cuisinier", "Livreur", "Cuisinier & Livreur"]
                      .map((r) => DropdownMenuItem(value: r, child: Text(r)))
                      .toList(),
                  onChanged: (v) => setModalState(() => _selectedRole = v!),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                  ),
                  onPressed: () {
                    if (_staffNameController.text.isNotEmpty) {
                      setState(() {
                        Map<String, String> staffData = {
                          "name": _staffNameController.text,
                          "role": _selectedRole,
                          "phone": _staffPhoneController.text,
                          "address": _staffAddressController.text,
                        };

                        if (index == null) {
                          staffList.add(staffData);
                        } else {
                          staffList[index] = staffData;
                        }
                      });
                      Navigator.pop(context);
                    }
                  },
                  child: Text(
                    index == null ? "Ajoute Anplwaye" : "Sove Chanjman",
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // FÒM POU BAY REZON LÈ YAP ANILE YON KÒMAND
  void _cancelOrderWithReason(Map<String, dynamic> o) {
    TextEditingController reasonController = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Poukisa ou ap anile l?"),
        content: TextField(
          controller: reasonController,
          maxLines: 2,
          decoration: const InputDecoration(
            labelText: "Ekri rezon an la...",
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text("Fèmen", style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              setState(() {
                o['status'] = "Annulé";
                o['date_canceled'] = DateTime.now();
                o['cancel_reason'] = reasonController.text.isNotEmpty
                    ? reasonController.text
                    : "Pa gen rezon espesifik bay";
              });
              Navigator.pop(ctx);
            },
            child: const Text(
              "Konfime Anilasyon",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  // --- NOUVO WIDGET POU ONGLET PROFILE LA ---
  Widget _buildProfileTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Profile Restoran",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 15),

          // Non Restoran an (Bloke)
          TextField(
            controller: _restNameController,
            enabled: false,
            decoration: const InputDecoration(
              labelText: "Non Restoran",
              border: OutlineInputBorder(),
              filled: true,
              fillColor: Color(0xFFEEEEEE), // Yon ti gri pou montre li bloke
            ),
          ),
          const SizedBox(height: 10),

          // Deskripsyon Restoran an
          TextField(
            controller: _restDescController,
            maxLines: 3,
            decoration: const InputDecoration(
              labelText: "Deskripsyon Restoran",
              border: OutlineInputBorder(),
            ),
          ),

          const SizedBox(height: 20),
          const Text(
            "Nimewo Telefòn (Max 3)",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 8),

          // Lis jiska 3 nimewo telefòn
          ..._phones.asMap().entries.map(
            (entry) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      initialValue: entry.value,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: "Telefòn ${entry.key + 1}",
                        prefixIcon: const Icon(Icons.phone),
                      ),
                      onChanged: (v) => _phones[entry.key] = v,
                    ),
                  ),
                  if (_phones.length > 1)
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () =>
                          setState(() => _phones.removeAt(entry.key)),
                    ),
                ],
              ),
            ),
          ),

          if (_phones.length < 3)
            TextButton.icon(
              icon: const Icon(Icons.add),
              label: const Text("Ajoute yon lòt nimewo"),
              onPressed: () => setState(() => _phones.add("")),
            ),

          const SizedBox(height: 20),
          const Text(
            "Adrès Etablisman an",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 10),

          // Menou Deroulant pou Depatman an
          DropdownButtonFormField<String>(
            decoration: const InputDecoration(
              labelText: "Depatman",
              border: OutlineInputBorder(),
            ),
            initialValue: _selectedDept,
            items: _haitiData.keys
                .map((d) => DropdownMenuItem(value: d, child: Text(d)))
                .toList(),
            onChanged: (v) => setState(() {
              _selectedDept = v;
              _selectedCommune = null; // Reset komin lè depatman an chanje
            }),
          ),
          const SizedBox(height: 10),

          // Menou Deroulant pou Komin nan (Baze sou Depatman ki chwazi a)
          DropdownButtonFormField<String>(
            decoration: const InputDecoration(
              labelText: "Komin",
              border: OutlineInputBorder(),
            ),
            initialValue: _selectedCommune,
            items: (_haitiData[_selectedDept] ?? [])
                .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                .toList(),
            onChanged: (v) => setState(() => _selectedCommune = v),
          ),
          const SizedBox(height: 10),

          // Champs de texte pou rès adrès la
          TextField(
            controller: _addressController,
            decoration: const InputDecoration(
              labelText: "Rue, Ruelle, Nimewo kay",
              border: OutlineInputBorder(),
            ),
          ),

          const SizedBox(height: 30),
          const Divider(thickness: 2),
          const SizedBox(height: 10),

          // ZÒN LIVREZON (SEKIRITE)
          const Text(
            "Zòn Livrezon (Sécurité)",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.redAccent,
            ),
          ),
          const Text(
            "Koche sèlman komin kote restoran an ka fè livrezon an sekirite.",
            style: TextStyle(color: Colors.grey, fontStyle: FontStyle.italic),
          ),
          const SizedBox(height: 10),

          // Bèl tiwa (ExpansionTile) pou chak depatman ak komin li yo pou pa fè paj la twò chaje
          ..._haitiData.keys.map((dept) {
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 4),
              child: ExpansionTile(
                title: Text(
                  dept,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                children: _haitiData[dept]!.map((commune) {
                  return CheckboxListTile(
                    title: Text(commune),
                    dense: true,
                    activeColor: Colors.amber[800],
                    value: _deliveryZones.contains(commune),
                    onChanged: (bool? val) {
                      setState(() {
                        if (val == true) {
                          _deliveryZones.add(commune);
                        } else {
                          _deliveryZones.remove(commune);
                        }
                      });
                    },
                  );
                }).toList(),
              ),
            );
          }),

          const SizedBox(height: 30),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: const Size.fromHeight(55),
              backgroundColor: Colors.amber[800],
            ),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Profile Mizajou avèk Siksè!"),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: const Text(
              "Sove Chanjman yo",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 50),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Filtre Kòmand Aktif yo
    List<Map<String, dynamic>> filteredOrders = orders.where((o) {
      bool statusMatch =
          _statusFilter == "Tout" || o['status'] == _statusFilter;
      bool dateMatch =
          _dateRange == null ||
          (o['date'].isAfter(_dateRange!.start) &&
              o['date'].isBefore(_dateRange!.end.add(const Duration(days: 1))));
      bool employeeMatch =
          _employeeFilter == "Tout" ||
          o['cuisinier'] == _employeeFilter ||
          o['livreur'] == _employeeFilter;
      return statusMatch && dateMatch && employeeMatch;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          _currentIndex == 0
              ? "Kòmand SagaEat"
              : _currentIndex == 1
              ? "Meni Restoran"
              : _currentIndex == 2
              ? "Jesyon Staff"
              : _currentIndex == 3
              ? "Istorik Kòmand"
              : "Profile Restoran", // Nouvo Tit pou Profile
        ),
        backgroundColor: Colors.amber[800],
        centerTitle: true,
      ),
      body: _currentIndex == 0
          ? Column(
              children: [
                _buildFilterBar(),
                Expanded(
                  child: ListView.builder(
                    itemCount: filteredOrders.length,
                    itemBuilder: (c, i) => _buildCard(filteredOrders[i]),
                  ),
                ),
              ],
            )
          : _currentIndex == 1
          ? _buildMenuPlats()
          : _currentIndex == 2
          ? _buildStaff()
          : _currentIndex == 3
          ? _buildHistoryTab()
          : _buildProfileTab(), // Nou kloure Profile la isit la nan endèks 4
      floatingActionButton: (_currentIndex == 1 || _currentIndex == 2)
          ? FloatingActionButton(
              backgroundColor: Colors.amber[800],
              onPressed: () =>
                  _currentIndex == 1 ? _showPlatForm() : _showStaffForm(),
              child: const Icon(Icons.add, color: Colors.white),
            )
          : null,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed, // Pou pèmèt 5 items byen parèt
        selectedItemColor: Colors.amber[800],
        unselectedItemColor: Colors.grey,
        onTap: (i) => setState(() => _currentIndex = i),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.list), label: "Kòmand"),
          BottomNavigationBarItem(
            icon: Icon(Icons.restaurant_menu),
            label: "Plat",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: "Staff"),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: "Istorik"),
          BottomNavigationBarItem(
            icon: Icon(Icons.store),
            label: "Profile",
          ), // Nouvo Bouton Navigation an
        ],
      ),
    );
  }

  // ONGLET PLAT: (RETE ENTAK)
  Widget _buildMenuPlats() {
    List<Map<String, dynamic>> filteredPlats = menuPlats.where((plat) {
      return plat['name'].toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();

    if (_stockSortOrder == "Croissant") {
      filteredPlats.sort(
        (a, b) => (a['stock'] as int).compareTo(b['stock'] as int),
      );
    } else if (_stockSortOrder == "Décroissant") {
      filteredPlats.sort(
        (a, b) => (b['stock'] as int).compareTo(a['stock'] as int),
      );
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(
                decoration: const InputDecoration(
                  labelText: "Sèvi kòd pou chèche plat...",
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                ),
                onChanged: (v) => setState(() => _searchQuery = v),
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: "Triye pa Stock",
                  border: OutlineInputBorder(),
                ),
                initialValue: _stockSortOrder,
                items:
                    [
                          {"value": "Tout", "label": "Tout (Estanda)"},
                          {
                            "value": "Croissant",
                            "label": "Stock: Pi piti -> Pi plis",
                          },
                          {
                            "value": "Décroissant",
                            "label": "Stock: Pi plis -> Pi piti",
                          },
                        ]
                        .map(
                          (item) => DropdownMenuItem(
                            value: item['value'],
                            child: Text(item['label']!),
                          ),
                        )
                        .toList(),
                onChanged: (v) => setState(() => _stockSortOrder = v!),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.all(12),
          color: Colors.amber[50],
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total Pla filtre: ${filteredPlats.length}",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Text(
                "Dispo: ${filteredPlats.where((p) => p['available']).length}",
                style: const TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: filteredPlats.length,
            itemBuilder: (context, index) {
              final plat = filteredPlats[index];
              double totalSupplementsPrice = 0.0;
              for (var supp in plat['supplements']) {
                totalSupplementsPrice += supp['pri'];
              }
              double totalPriceWithSupps = plat['pri'] + totalSupplementsPrice;
              int originalIndex = menuPlats.indexOf(plat);

              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                child: ExpansionTile(
                  title: Text(
                    plat['name'],
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    "Pri Debaz: ${plat['pri']} HTG\nMax Pri (ak Sipleman): $totalPriceWithSupps HTG",
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Chip(
                        label: Text(
                          plat['available']
                              ? "Dispo (${plat['stock']})"
                              : "Out of Stock",
                        ),
                        backgroundColor: plat['available']
                            ? Colors.green[100]
                            : Colors.red[100],
                      ),
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.blue),
                        onPressed: () => _showPlatForm(index: originalIndex),
                      ),
                    ],
                  ),
                  children: [
                    if (plat['supplements'].isEmpty)
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("Pa gen sipleman pou plat sa a."),
                      )
                    else
                      ...((plat['supplements'] as List).map(
                        (s) => ListTile(
                          leading: const Icon(
                            Icons.add_box,
                            color: Colors.amber,
                          ),
                          title: Text(s['name']),
                          subtitle: Text(
                            "Stock sipleman: ${s['syncWithPlatStock'] ? plat['stock'] : s['stock']}",
                          ),
                          trailing: Text(
                            "+${s['pri']} HTG",
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      )),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  // ONGLET STAFF
  Widget _buildStaff() {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: staffList.length,
      itemBuilder: (context, index) {
        final employee = staffList[index];
        return Card(
          elevation: 2,
          margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
          child: ListTile(
            leading: const CircleAvatar(
              backgroundColor: Colors.amber,
              child: Icon(Icons.person, color: Colors.white),
            ),
            title: Text(
              employee['name']!,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              "Wòl: ${employee['role']}\nTel: ${employee['phone']}",
            ),
            isThreeLine: true,
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit, color: Colors.blue),
                  onPressed: () => _showStaffForm(index: index),
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    // SEKIRITE: Mande konfimasyon anvan efase
                    showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: const Text("Efase Anplwaye"),
                        content: Text(
                          "Èske w sèten ou vle efase ${employee['name']} nan sistèm nan?",
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(ctx),
                            child: const Text("Anile"),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                            ),
                            onPressed: () {
                              setState(() => staffList.removeAt(index));
                              Navigator.pop(ctx);
                            },
                            child: const Text(
                              "Wi, efase",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // ONGLET KÒMAND AVÈK SISTÈM LÈ A SOU BOUTON YO
  Widget _buildFilterBar() => Padding(
    padding: const EdgeInsets.all(8),
    child: Column(
      children: [
        Row(
          children: [
            Expanded(
              child: DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: "Filtre Eta",
                  border: OutlineInputBorder(),
                ),
                initialValue: _statusFilter,
                items:
                    [
                          "Tout",
                          "En cours",
                          "En préparation",
                          "En cours de livraison",
                          "Livre",
                          "Annulé",
                        ]
                        .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                        .toList(),
                onChanged: (v) => setState(() => _statusFilter = v!),
              ),
            ),
            const SizedBox(width: 8),
            IconButton(
              icon: const Icon(Icons.date_range),
              onPressed: () async {
                DateTimeRange? picked = await showDateRangePicker(
                  context: context,
                  firstDate: DateTime(2026),
                  lastDate: DateTime(2030),
                );
                if (picked != null) setState(() => _dateRange = picked);
              },
            ),
          ],
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          decoration: const InputDecoration(
            labelText: "Filtre pa Anplwaye",
            border: OutlineInputBorder(),
          ),
          initialValue: _employeeFilter,
          items: ["Tout", ...staffList.map((s) => s['name']!)]
              .map((e) => DropdownMenuItem<String>(value: e, child: Text(e)))
              .toList(),
          onChanged: (v) => setState(() => _employeeFilter = v!),
        ),
      ],
    ),
  );

  Widget _buildCard(Map<String, dynamic> o) => Card(
    margin: const EdgeInsets.all(8),
    child: ExpansionTile(
      title: Text("${o['id']} - ${o['name']}"),
      subtitle: Text(
        "Pla: ${o['pla']} | Pri: ${o['pri']} | Eta: ${o['status']}",
      ),
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- ZÒN SIPLEMAN ---
              if ((o['supplements'] as List).isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Sipleman:",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blueGrey,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Wrap(
                        spacing: 8.0,
                        children: (o['supplements'] as List)
                            .map(
                              (s) => Chip(
                                label: Text(s.toString()),
                                backgroundColor: Colors.amber[100],
                              ),
                            )
                            .toList(),
                      ),
                    ],
                  ),
                ),

              // --- ZÒN MEMO ---
              if ((o['memo'] as String).isNotEmpty)
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(bottom: 16.0),
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: Colors.red[50],
                    border: Border.all(color: Colors.red[200]!),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Icon(
                            Icons.warning_amber_rounded,
                            color: Colors.red,
                            size: 20,
                          ),
                          SizedBox(width: 8),
                          Text(
                            "MEMO / ATANSYON:",
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        o['memo'],
                        style: const TextStyle(
                          color: Colors.redAccent,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),

              // --- ZÒN KONTWÒL ETA (Cuisinier / Livreur) ---
              if (o['status'] == "En cours")
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: "Asiyen Cuisinier",
                    border: OutlineInputBorder(),
                  ),
                  initialValue: (o['cuisinier'] as String).isEmpty
                      ? null
                      : o['cuisinier'],
                  items: staffList
                      .where((s) => s['role']!.contains("Cuisinier"))
                      .map(
                        (s) => DropdownMenuItem<String>(
                          value: s['name'],
                          child: Text(s['name']!),
                        ),
                      )
                      .toList(),
                  onChanged: (v) => setState(() => o['cuisinier'] = v!),
                ),
              if (o['status'] == "En préparation")
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: "Asiyen Livreur",
                    border: OutlineInputBorder(),
                  ),
                  initialValue: (o['livreur'] as String).isEmpty
                      ? null
                      : o['livreur'],
                  items: staffList
                      .where((s) => s['role']!.contains("Livreur"))
                      .map(
                        (s) => DropdownMenuItem<String>(
                          value: s['name'],
                          child: Text(s['name']!),
                        ),
                      )
                      .toList(),
                  onChanged: (v) => setState(() => o['livreur'] = v!),
                ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (o['status'] == "En cours" &&
                      (o['cuisinier'] as String).isNotEmpty)
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          o['status'] = "En préparation";
                          o['date_prepared'] = DateTime.now(); // Sove lè a
                        });
                      },
                      child: const Text("Aksepte"),
                    ),
                  if (o['status'] == "En préparation" &&
                      (o['livreur'] as String).isNotEmpty)
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          o['status'] = "En cours de livraison";
                          o['date_delivery'] = DateTime.now(); // Sove lè a
                        });
                      },
                      child: const Text("Voye Livrezon"),
                    ),
                  if (o['status'] == "En cours de livraison")
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          o['status'] = "Livre";
                          o['date_completed'] = DateTime.now(); // Sove lè a
                        });
                      },
                      child: const Text("Konfime Livrezon"),
                    ),
                  if (o['status'] != "Annulé" && o['status'] != "Livre")
                    TextButton(
                      onPressed: () => _cancelOrderWithReason(
                        o,
                      ), // Rele fonksyon ki mande rezon an
                      child: const Text(
                        "Anile",
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // --- NOUVO ONGLET ISTORIK ---
  Widget _buildHistoryTab() {
    // Nou filtre pou n pran sèlman kòmand ki Fini ("Livre") oswa ki Anile ("Annulé")
    List<Map<String, dynamic>> historyOrders = orders.where((o) {
      bool isFinished = o['status'] == "Livre" || o['status'] == "Annulé";
      bool dateMatch =
          _historyDateRange == null ||
          (o['date'].isAfter(_historyDateRange!.start) &&
              o['date'].isBefore(
                _historyDateRange!.end.add(const Duration(days: 1)),
              ));
      bool employeeMatch =
          _historyEmployeeFilter == "Tout" ||
          o['cuisinier'] == _historyEmployeeFilter ||
          o['livreur'] == _historyEmployeeFilter;

      return isFinished && dateMatch && employeeMatch;
    }).toList();

    return Column(
      children: [
        // Filtè pou Istorik
        Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              Expanded(
                child: DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: "Filtre pa Anplwaye",
                    border: OutlineInputBorder(),
                  ),
                  initialValue: _historyEmployeeFilter,
                  items: ["Tout", ...staffList.map((s) => s['name']!)]
                      .map(
                        (e) =>
                            DropdownMenuItem<String>(value: e, child: Text(e)),
                      )
                      .toList(),
                  onChanged: (v) => setState(() => _historyEmployeeFilter = v!),
                ),
              ),
              const SizedBox(width: 8),
              IconButton(
                icon: const Icon(
                  Icons.date_range,
                  color: Colors.blueGrey,
                  size: 30,
                ),
                onPressed: () async {
                  DateTimeRange? picked = await showDateRangePicker(
                    context: context,
                    firstDate: DateTime(2026),
                    lastDate: DateTime(2030),
                  );
                  if (picked != null) {
                    setState(() => _historyDateRange = picked);
                  }
                },
              ),
            ],
          ),
        ),

        // Lis Kòmand Istorik yo
        Expanded(
          child: historyOrders.isEmpty
              ? const Center(
                  child: Text("Pa gen kòmand nan istorik la pou filtè sa yo."),
                )
              : ListView.builder(
                  itemCount: historyOrders.length,
                  itemBuilder: (c, i) {
                    final o = historyOrders[i];
                    bool isCanceled = o['status'] == "Annulé";

                    return Card(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      child: ExpansionTile(
                        leading: Icon(
                          isCanceled ? Icons.cancel : Icons.check_circle,
                          color: isCanceled ? Colors.red : Colors.green,
                          size: 36,
                        ),
                        title: Text(
                          "${o['id']} - ${o['name']}",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          "Pla: ${o['pla']} | Eta: ${o['status']}",
                        ),
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "TIMELINE KÒMAND LAN:",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey,
                                  ),
                                ),
                                const Divider(),
                                _buildTimelineRow(
                                  "Kòmand Kreye",
                                  _formatDate(o['date']),
                                  Icons.shopping_cart,
                                ),
                                _buildTimelineRow(
                                  "Kòmanse Prepare",
                                  _formatDate(o['date_prepared']),
                                  Icons.soup_kitchen,
                                ),
                                _buildTimelineRow(
                                  "Soti pou Livrezon",
                                  _formatDate(o['date_delivery']),
                                  Icons.delivery_dining,
                                ),
                                if (!isCanceled)
                                  _buildTimelineRow(
                                    "Livre ak Siksè",
                                    _formatDate(o['date_completed']),
                                    Icons.done_all,
                                    isFinal: true,
                                  ),

                                if (isCanceled) ...[
                                  _buildTimelineRow(
                                    "Kòmand lan Anile",
                                    _formatDate(o['date_canceled']),
                                    Icons.cancel,
                                    isFinal: true,
                                    isError: true,
                                  ),
                                  const SizedBox(height: 10),
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: Colors.red[50],
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(color: Colors.red),
                                    ),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Icon(
                                          Icons.info_outline,
                                          color: Colors.red,
                                          size: 20,
                                        ),
                                        const SizedBox(width: 8),
                                        Expanded(
                                          child: Text(
                                            "Rezon: ${o['cancel_reason']}",
                                            style: const TextStyle(
                                              color: Colors.red,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }

  // Ti Widget pou bèl afichaj nan Timeline lan
  Widget _buildTimelineRow(
    String title,
    String time,
    IconData icon, {
    bool isFinal = false,
    bool isError = false,
  }) {
    Color iconColor = isError
        ? Colors.red
        : (isFinal ? Colors.green : Colors.blueGrey);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(
            icon,
            color: time == "N/A" ? Colors.grey[300] : iconColor,
            size: 20,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                color: time == "N/A" ? Colors.grey : Colors.black87,
                fontWeight: isFinal ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
          Text(
            time,
            style: TextStyle(
              color: time == "N/A" ? Colors.grey : Colors.black,
              fontStyle: time == "N/A" ? FontStyle.italic : FontStyle.normal,
            ),
          ),
        ],
      ),
    );
  }
}
