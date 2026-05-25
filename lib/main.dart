import 'package:flutter/material.dart';

// =====================================================================
//  SAGAEAT BUSINESS — UI/UX REFRESH (Material 3)
//  Logique métier 100% préservée. Seul le rendu visuel a changé.
// =====================================================================

void main() => runApp(const SagaEatBusinessApp());

// ---------------------------------------------------------------------
//  DESIGN SYSTEM
// ---------------------------------------------------------------------
class AppPalette {
  static const Color seed = Color(0xFFEF6C00); // Deep orange (food vibe)
  static const Color cream = Color(0xFFFFFBF5);
  static const Color ink = Color(0xFF1F1B16);

  // Une couleur par statut (cohérence visuelle dans toute l'app)
  static const Map<String, Color> statusBg = {
    "En cours": Color(0xFFE3F2FD),
    "En préparation": Color(0xFFFFF3E0),
    "Disponible": Color(0xFFE0F2F1),
    "En cours de livraison": Color(0xFFEDE7F6),
    "Livre": Color(0xFFE8F5E9),
    "Annulé": Color(0xFFFFEBEE),
  };
  static const Map<String, Color> statusFg = {
    "En cours": Color(0xFF1565C0),
    "En préparation": Color(0xFFE65100),
    "Disponible": Color(0xFF00695C),
    "En cours de livraison": Color(0xFF5E35B1),
    "Livre": Color(0xFF2E7D32),
    "Annulé": Color(0xFFC62828),
  };
  static const Map<String, IconData> statusIcon = {
    "En cours": Icons.receipt_long_rounded,
    "En préparation": Icons.soup_kitchen_rounded,
    "Disponible": Icons.restaurant_menu_rounded,
    "En cours de livraison": Icons.delivery_dining_rounded,
    "Livre": Icons.check_circle_rounded,
    "Annulé": Icons.cancel_rounded,
  };
}

ThemeData buildAppTheme() {
  final scheme = ColorScheme.fromSeed(
    seedColor: AppPalette.seed,
    brightness: Brightness.light,
  );
  return ThemeData(
    useMaterial3: true,
    colorScheme: scheme,
    scaffoldBackgroundColor: AppPalette.cream,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppPalette.cream,
      foregroundColor: AppPalette.ink,
      surfaceTintColor: AppPalette.cream,
      elevation: 0,
      centerTitle: false,
      titleTextStyle: TextStyle(
        color: AppPalette.ink,
        fontSize: 22,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.2,
      ),
    ),
    cardTheme: CardThemeData(
      elevation: 0,
      color: Colors.white,
      surfaceTintColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: BorderSide(color: scheme.outlineVariant.withValues(alpha: .4)),
      ),
      margin: EdgeInsets.zero,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      labelStyle: TextStyle(color: scheme.onSurfaceVariant),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: scheme.outlineVariant),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: scheme.outlineVariant),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: scheme.primary, width: 1.6),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: scheme.outlineVariant.withValues(alpha: .5)),
      ),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        minimumSize: const Size.fromHeight(52),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        textStyle:
            const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: scheme.primary,
        foregroundColor: scheme.onPrimary,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        textStyle:
            const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        textStyle: const TextStyle(fontWeight: FontWeight.w600),
      ),
    ),
    navigationBarTheme: NavigationBarThemeData(
      height: 76,
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      indicatorColor: scheme.primaryContainer,
      labelTextStyle: WidgetStateProperty.resolveWith(
        (states) => TextStyle(
          fontSize: 11.5,
          fontWeight: states.contains(WidgetState.selected)
              ? FontWeight.w700
              : FontWeight.w500,
          color: states.contains(WidgetState.selected)
              ? scheme.primary
              : scheme.onSurfaceVariant,
        ),
      ),
    ),
    expansionTileTheme: const ExpansionTileThemeData(
      shape: Border(),
      collapsedShape: Border(),
      tilePadding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      childrenPadding: EdgeInsets.zero,
    ),
    chipTheme: ChipThemeData(
      shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      side: BorderSide(color: scheme.outlineVariant.withValues(alpha: .5)),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
    ),
    dividerTheme: DividerThemeData(
      color: scheme.outlineVariant.withValues(alpha: .4),
      thickness: 1,
      space: 1,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: scheme.primary,
      foregroundColor: scheme.onPrimary,
      shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      elevation: 2,
    ),
    snackBarTheme: SnackBarThemeData(
      behavior: SnackBarBehavior.floating,
      shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  );
}

class SagaEatBusinessApp extends StatelessWidget {
  const SagaEatBusinessApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'SagaEat Business',
        theme: buildAppTheme(),
        home: const DashboardScreen(),
      );
}

// ---------------------------------------------------------------------
//  DASHBOARD
// ---------------------------------------------------------------------
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
  final TextEditingController _restNameController =
      TextEditingController(text: "SagaEat");
  final TextEditingController _restDescController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final List<String> _phones = [""];
  String? _selectedDept;
  String? _selectedCommune;
  final List<String> _deliveryZones = [];

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

  // Lis anplwaye yo
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

  // Lis kòmand yo
  late List<Map<String, dynamic>> orders;

  @override
  void initState() {
    super.initState();
    orders = List.generate(10, (i) {
      bool isAkasan = i == 0;
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
        "date": now.subtract(Duration(days: i)),
        "date_prepared":
            initStatus == "En préparation" || initStatus == "Livre"
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

  // Fòma dat
  String _formatDate(DateTime? dt) {
    if (dt == null) return "N/A";
    return "${dt.day.toString().padLeft(2, '0')}/${dt.month.toString().padLeft(2, '0')}/${dt.year} a ${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}";
  }

  // Lis Plat
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

  // Controllers plat
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _stockController = TextEditingController();

  List<Map<String, dynamic>> _tempSupplements = [];
  final TextEditingController _suppNameController = TextEditingController();
  final TextEditingController _suppPriceController = TextEditingController();
  final TextEditingController _suppStockController = TextEditingController();
  bool _tempSyncWithPlatStock = true;

  // Controllers staff
  final TextEditingController _staffNameController = TextEditingController();
  final TextEditingController _staffPhoneController = TextEditingController();
  final TextEditingController _staffAddressController = TextEditingController();
  String _selectedRole = "Cuisinier";

  // =================================================================
  //  FÒM PLAT (logique préservée)
  // =================================================================
  void _showPlatForm({int? index}) {
    if (index != null) {
      _nameController.text = menuPlats[index]['name'];
      _priceController.text = menuPlats[index]['pri'].toString();
      _stockController.text = menuPlats[index]['stock'].toString();
      _tempSupplements = List<Map<String, dynamic>>.from(
        menuPlats[index]['supplements']
            .map((s) => Map<String, dynamic>.from(s)),
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
      backgroundColor: AppPalette.cream,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) => Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: DraggableScrollableSheet(
            initialChildSize: 0.85,
            minChildSize: 0.5,
            maxChildSize: 0.95,
            expand: false,
            builder: (ctx, scrollController) => SingleChildScrollView(
              controller: scrollController,
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _DragHandle(),
                  const SizedBox(height: 8),
                  _SheetHeader(
                    icon: Icons.restaurant_menu_rounded,
                    title: index == null
                        ? "Ajoute yon nouvo Plat"
                        : "Modifye Plat la",
                    subtitle:
                        "Antre detay yo ak sipleman ki disponib pou plat sa a",
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: "Non Plat la",
                      prefixIcon: Icon(Icons.fastfood_rounded),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _priceController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: "Pri Debaz (HTG)",
                            prefixIcon: Icon(Icons.payments_rounded),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          controller: _stockController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: "Stock",
                            prefixIcon: Icon(Icons.inventory_2_rounded),
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
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  _SectionHeader(
                    icon: Icons.add_circle_outline_rounded,
                    title: "Sipleman pou plat sa a",
                    trailing: Text(
                      "${_tempSupplements.length}",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  if (_tempSupplements.isEmpty)
                    _InlineHint(
                      icon: Icons.info_outline_rounded,
                      text: "Pa gen sipleman ankò. Ajoute youn pi ba a.",
                    )
                  else
                    Column(
                      children: List.generate(_tempSupplements.length, (idx) {
                        final s = _tempSupplements[idx];
                        return Container(
                          margin: const EdgeInsets.only(bottom: 8),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: Theme.of(context)
                                  .colorScheme
                                  .outlineVariant
                                  .withValues(alpha: .4),
                            ),
                          ),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 16,
                                backgroundColor: AppPalette.seed
                                    .withValues(alpha: .12),
                                child: const Icon(Icons.add,
                                    size: 18, color: AppPalette.seed),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(s['name'],
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w600)),
                                    Text(
                                      "+${s['pri']} HTG • Stock: ${s['syncWithPlatStock'] ? 'Menm ak plat la' : s['stock']}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.delete_outline,
                                    color: Colors.red[400]),
                                onPressed: () => setModalState(
                                    () => _tempSupplements.removeAt(idx)),
                              ),
                            ],
                          ),
                        );
                      }),
                    ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: Theme.of(context)
                            .colorScheme
                            .outlineVariant
                            .withValues(alpha: .5),
                      ),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: _suppNameController,
                                decoration: const InputDecoration(
                                  labelText: "Non sipleman",
                                  isDense: true,
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
                                  isDense: true,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
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
                            const Expanded(
                              child: Text(
                                "Menm kantite ak plat la",
                                style: TextStyle(fontSize: 13),
                              ),
                            ),
                            if (!_tempSyncWithPlatStock)
                              SizedBox(
                                width: 110,
                                child: TextField(
                                  controller: _suppStockController,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                    labelText: "Stock",
                                    isDense: true,
                                  ),
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          width: double.infinity,
                          child: OutlinedButton.icon(
                            icon: const Icon(Icons.add),
                            label: const Text("Ajoute sipleman"),
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: () {
                              if (_suppNameController.text.isNotEmpty &&
                                  _suppPriceController.text.isNotEmpty) {
                                int mainStock =
                                    int.tryParse(_stockController.text) ?? 0;
                                int suppStock = _tempSyncWithPlatStock
                                    ? mainStock
                                    : (int.tryParse(
                                            _suppStockController.text) ??
                                        0);
                                setModalState(() {
                                  _tempSupplements.add({
                                    "name": _suppNameController.text,
                                    "pri": double.tryParse(
                                            _suppPriceController.text) ??
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
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  FilledButton.icon(
                    icon: Icon(index == null
                        ? Icons.add_rounded
                        : Icons.save_rounded),
                    label: Text(index == null
                        ? "Ajoute Plat la"
                        : "Sove Chanjman"),
                    onPressed: () {
                      final String name = _nameController.text;
                      final double price =
                          double.tryParse(_priceController.text) ?? 0.0;
                      final int stock =
                          int.tryParse(_stockController.text) ?? 0;
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
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // =================================================================
  //  FÒM STAFF (logique préservée)
  // =================================================================
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
      backgroundColor: AppPalette.cream,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) => Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _DragHandle(),
                const SizedBox(height: 8),
                _SheetHeader(
                  icon: Icons.person_add_alt_1_rounded,
                  title: index == null
                      ? "Ajoute yon nouvo Anplwaye"
                      : "Modifye Enfòmasyon Anplwaye",
                  subtitle: "Antre detay anplwaye a ak wòl li nan ekip la",
                ),
                const SizedBox(height: 20),
                Center(
                  child: _Avatar(
                    name: _staffNameController.text.isEmpty
                        ? "?"
                        : _staffNameController.text,
                    size: 78,
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _staffNameController,
                  decoration: const InputDecoration(
                    labelText: "Non konplè",
                    prefixIcon: Icon(Icons.person_outline_rounded),
                  ),
                  onChanged: (_) => setModalState(() {}),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _staffPhoneController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    labelText: "Nimewo Telefòn",
                    prefixIcon: Icon(Icons.phone_outlined),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _staffAddressController,
                  decoration: const InputDecoration(
                    labelText: "Adrès kay",
                    prefixIcon: Icon(Icons.home_outlined),
                  ),
                ),
                const SizedBox(height: 16),
                _SectionHeader(
                  icon: Icons.badge_outlined,
                  title: "Wòl nan ekip la",
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: ["Cuisinier", "Livreur", "Cuisinier & Livreur"]
                      .map(
                        (r) => ChoiceChip(
                          label: Text(r),
                          selected: _selectedRole == r,
                          onSelected: (_) =>
                              setModalState(() => _selectedRole = r),
                        ),
                      )
                      .toList(),
                ),
                const SizedBox(height: 24),
                FilledButton.icon(
                  icon: Icon(index == null
                      ? Icons.person_add_rounded
                      : Icons.save_rounded),
                  label: Text(index == null
                      ? "Ajoute Anplwaye"
                      : "Sove Chanjman"),
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // =================================================================
  //  DIALOG ANILASYON (logique préservée)
  // =================================================================
  void _cancelOrderWithReason(Map<String, dynamic> o) {
    TextEditingController reasonController = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        icon: Icon(Icons.cancel_outlined,
            color: Colors.red[700], size: 36),
        title: const Text("Poukisa ou ap anile l?",
            textAlign: TextAlign.center),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Bay yon rezon klè pou ede swiv kalite sèvis la.",
              style: TextStyle(color: Colors.grey[600], fontSize: 13),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 14),
            TextField(
              controller: reasonController,
              maxLines: 3,
              decoration: const InputDecoration(
                hintText: "Ekri rezon an la...",
              ),
            ),
          ],
        ),
        actionsPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        actions: [
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => Navigator.pop(ctx),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text("Fèmen"),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: FilledButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: Colors.red[600],
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
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
                  child: const Text("Konfime"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // =================================================================
  //  DIALOG ASIYEN CUISINIER
  // =================================================================
  void _showAssignCuisinierDialog(Map<String, dynamic> o) {
    final cuisiniers =
        staffList.where((s) => s['role']!.contains("Cuisinier")).toList();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        icon: const Icon(Icons.soup_kitchen_rounded,
            color: AppPalette.seed, size: 36),
        title: const Text("Asiyen Cuisinier", textAlign: TextAlign.center),
        contentPadding: const EdgeInsets.symmetric(vertical: 8),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.grey[200],
                child: const Icon(Icons.person_off_rounded, color: Colors.grey),
              ),
              title: const Text("Non défini"),
              selected: (o['cuisinier'] as String).isEmpty,
              selectedTileColor: AppPalette.seed.withValues(alpha: .08),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              onTap: () {
                Navigator.pop(ctx);
                setState(() => o['cuisinier'] = "");
              },
            ),
            ...cuisiniers.map(
              (s) => ListTile(
                leading: CircleAvatar(
                  backgroundColor: AppPalette.seed.withValues(alpha: .15),
                  child: Text(
                    s['name']![0].toUpperCase(),
                    style: const TextStyle(
                        color: AppPalette.seed, fontWeight: FontWeight.w700),
                  ),
                ),
                title: Text(s['name']!),
                subtitle: Text(s['role']!),
                selected: o['cuisinier'] == s['name'],
                selectedTileColor: AppPalette.seed.withValues(alpha: .08),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                onTap: () {
                  Navigator.pop(ctx);
                  setState(() => o['cuisinier'] = s['name']!);
                },
              ),
            ),
          ],
        ),
        actionsPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        actions: [
          OutlinedButton(
            onPressed: () => Navigator.pop(ctx),
            style: OutlinedButton.styleFrom(
              minimumSize: const Size.fromHeight(48),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text("Fèmen"),
          ),
        ],
      ),
    );
  }

  // =================================================================
  //  BUILD
  // =================================================================
  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> filteredOrders = orders.where((o) {
      bool statusMatch =
          _statusFilter == "Tout" || o['status'] == _statusFilter;
      bool dateMatch = _dateRange == null ||
          (o['date'].isAfter(_dateRange!.start) &&
              o['date']
                  .isBefore(_dateRange!.end.add(const Duration(days: 1))));
      bool employeeMatch = _employeeFilter == "Tout" ||
          o['cuisinier'] == _employeeFilter ||
          o['livreur'] == _employeeFilter;
      return statusMatch && dateMatch && employeeMatch;
    }).toList();

    final titles = [
      "Kòmand",
      "Meni",
      "Ekip",
      "Istorik",
      "Profile",
    ];
    final subtitles = [
      "${orders.where((o) => o['status'] != 'Livre' && o['status'] != 'Annulé').length} kòmand aktif",
      "${menuPlats.length} plat nan meni an",
      "${staffList.length} anplwaye",
      "${orders.where((o) => o['status'] == 'Livre' || o['status'] == 'Annulé').length} kòmand fini",
      _restNameController.text,
    ];

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 20,
        toolbarHeight: 72,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(titles[_currentIndex]),
            const SizedBox(height: 2),
            Text(
              subtitles[_currentIndex],
              style: TextStyle(
                fontSize: 12.5,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: CircleAvatar(
              radius: 18,
              backgroundColor: AppPalette.seed.withValues(alpha: .12),
              child: const Icon(Icons.notifications_none_rounded,
                  color: AppPalette.seed, size: 20),
            ),
          ),
        ],
      ),
      body: SafeArea(
        top: false,
        child: IndexedStack(
          index: _currentIndex,
          children: [
            _buildOrdersTab(filteredOrders),
            _buildMenuPlats(),
            _buildStaff(),
            _buildHistoryTab(),
            _buildProfileTab(),
          ],
        ),
      ),
      floatingActionButton: (_currentIndex == 1 || _currentIndex == 2)
          ? FloatingActionButton.extended(
              onPressed: () =>
                  _currentIndex == 1 ? _showPlatForm() : _showStaffForm(),
              icon: const Icon(Icons.add),
              label: Text(_currentIndex == 1 ? "Nouvo Plat" : "Nouvo Staff"),
            )
          : null,
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (i) => setState(() => _currentIndex = i),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.receipt_long_outlined),
            selectedIcon: Icon(Icons.receipt_long_rounded),
            label: "Kòmand",
          ),
          NavigationDestination(
            icon: Icon(Icons.restaurant_menu_outlined),
            selectedIcon: Icon(Icons.restaurant_menu_rounded),
            label: "Plat",
          ),
          NavigationDestination(
            icon: Icon(Icons.people_outline_rounded),
            selectedIcon: Icon(Icons.people_rounded),
            label: "Staff",
          ),
          NavigationDestination(
            icon: Icon(Icons.history_rounded),
            selectedIcon: Icon(Icons.history_rounded),
            label: "Istorik",
          ),
          NavigationDestination(
            icon: Icon(Icons.storefront_outlined),
            selectedIcon: Icon(Icons.storefront_rounded),
            label: "Profile",
          ),
        ],
      ),
    );
  }

  // =================================================================
  //  ONGLET KÒMAND
  // =================================================================
  Widget _buildOrdersTab(List<Map<String, dynamic>> filteredOrders) {
    return Column(
      children: [
        _buildFilterBar(),
        Expanded(
          child: filteredOrders.isEmpty
              ? const _EmptyState(
                  icon: Icons.inbox_rounded,
                  title: "Pa gen kòmand",
                  message: "Pa gen kòmand ki koresponn ak filtè yo.",
                )
              : ListView.separated(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                  itemCount: filteredOrders.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 12),
                  itemBuilder: (c, i) => _buildOrderCard(filteredOrders[i]),
                ),
        ),
      ],
    );
  }

  Widget _buildFilterBar() {
    final statuses = [
      "Tout",
      "En cours",
      "En préparation",
      "Disponible",
      "En cours de livraison",
      "Livre",
      "Annulé",
    ];
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 38,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: statuses.length,
              separatorBuilder: (_, _) => const SizedBox(width: 8),
              itemBuilder: (ctx, i) {
                final s = statuses[i];
                final selected = _statusFilter == s;
                final fg = s == "Tout"
                    ? Theme.of(context).colorScheme.primary
                    : (AppPalette.statusFg[s] ?? AppPalette.seed);
                return ChoiceChip(
                  label: Text(s),
                  selected: selected,
                  showCheckmark: false,
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: selected ? Colors.white : fg,
                  ),
                  selectedColor: fg,
                  backgroundColor: Colors.white,
                  side: BorderSide(color: fg.withValues(alpha: .35)),
                  onSelected: (_) => setState(() => _statusFilter = s),
                );
              },
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: DropdownButtonFormField<String>(
                  isExpanded: true,
                  decoration: const InputDecoration(
                    labelText: "Anplwaye",
                    prefixIcon: Icon(Icons.person_outline_rounded),
                    isDense: true,
                  ),
                  initialValue: _employeeFilter,
                  items: ["Tout", ...staffList.map((s) => s['name']!)]
                      .map((e) =>
                          DropdownMenuItem<String>(value: e, child: Text(e)))
                      .toList(),
                  onChanged: (v) => setState(() => _employeeFilter = v!),
                ),
              ),
              const SizedBox(width: 8),
              Material(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                child: InkWell(
                  borderRadius: BorderRadius.circular(14),
                  onTap: () async {
                    DateTimeRange? picked = await showDateRangePicker(
                      context: context,
                      firstDate: DateTime(2026),
                      lastDate: DateTime(2030),
                    );
                    if (picked != null) setState(() => _dateRange = picked);
                  },
                  child: Container(
                    width: 54,
                    height: 54,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: Theme.of(context)
                            .colorScheme
                            .outlineVariant
                            .withValues(alpha: .5),
                      ),
                    ),
                    child: Icon(Icons.date_range_rounded,
                        color: _dateRange != null
                            ? AppPalette.seed
                            : Colors.grey[600]),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOrderCard(Map<String, dynamic> o) {
    final String status = o['status'];
    final Color sFg = AppPalette.statusFg[status] ?? AppPalette.seed;
    final Color sBg = AppPalette.statusBg[status] ?? Colors.grey[100]!;
    final IconData sIcon =
        AppPalette.statusIcon[status] ?? Icons.receipt_long_rounded;

    return Card(
      child: Theme(
        data: Theme.of(context)
            .copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          tilePadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          childrenPadding:
              const EdgeInsets.fromLTRB(16, 0, 16, 16),
          leading: Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: sBg,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(sIcon, color: sFg),
          ),
          title: Row(
            children: [
              Expanded(
                child: Text(
                  o['name'],
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                  ),
                ),
              ),
              _StatusPill(status: status),
            ],
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              "${o['id']} • ${o['pla']} • ${o['pri']}",
              style: TextStyle(
                fontSize: 12.5,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
            const Divider(height: 24),
            if ((o['supplements'] as List).isNotEmpty) ...[
              _SectionHeader(
                icon: Icons.add_circle_outline_rounded,
                title: "Sipleman",
              ),
              const SizedBox(height: 6),
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: (o['supplements'] as List)
                    .map(
                      (s) => Chip(
                        label: Text(s.toString()),
                        backgroundColor: AppPalette.seed.withValues(alpha: .08),
                        side: BorderSide(
                            color: AppPalette.seed.withValues(alpha: .25)),
                        labelStyle: const TextStyle(
                            color: AppPalette.seed,
                            fontWeight: FontWeight.w600,
                            fontSize: 12),
                      ),
                    )
                    .toList(),
              ),
              const SizedBox(height: 12),
            ],
            if ((o['memo'] as String).isNotEmpty)
              _MemoBlock(text: o['memo']),
            if ((o['memo'] as String).isNotEmpty) const SizedBox(height: 12),
            if (status == "Disponible")
              DropdownButtonFormField<String>(
                isExpanded: true,
                decoration: const InputDecoration(
                  labelText: "Asiyen Livreur",
                  prefixIcon: Icon(Icons.delivery_dining_rounded),
                ),
                initialValue: (o['livreur'] as String).isEmpty
                    ? null
                    : o['livreur'],
                items: staffList
                    .where((s) => s['role']!.contains("Livreur"))
                    .map((s) => DropdownMenuItem<String>(
                          value: s['name'],
                          child: Text(s['name']!),
                        ))
                    .toList(),
                onChanged: (v) => setState(() => o['livreur'] = v!),
              ),
            if (status == "Disponible") const SizedBox(height: 12),
            if ((o['cuisinier'] as String).isNotEmpty ||
                (o['livreur'] as String).isNotEmpty) ...[
              if ((o['cuisinier'] as String).isNotEmpty)
                _AssigneeRow(
                  icon: Icons.soup_kitchen_rounded,
                  label: "Cuisinier",
                  name: o['cuisinier'],
                ),
              if ((o['livreur'] as String).isNotEmpty)
                _AssigneeRow(
                  icon: Icons.delivery_dining_rounded,
                  label: "Livreur",
                  name: o['livreur'],
                ),
              const SizedBox(height: 12),
            ],
            if (status == "En cours")
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          icon: const Icon(Icons.soup_kitchen_rounded, size: 18),
                          label: Text(
                            (o['cuisinier'] as String).isNotEmpty
                                ? o['cuisinier']
                                : "Asiyen Cuisinier",
                          ),
                          style: OutlinedButton.styleFrom(
                            minimumSize: const Size(0, 44),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                          ),
                          onPressed: () => _showAssignCuisinierDialog(o),
                        ),
                      ),
                      const SizedBox(width: 8),
                      OutlinedButton.icon(
                        icon: const Icon(Icons.close_rounded,
                            size: 18, color: Colors.red),
                        label: const Text("Anile",
                            style: TextStyle(color: Colors.red)),
                        style: OutlinedButton.styleFrom(
                          minimumSize: const Size(0, 44),
                          side: BorderSide(
                              color: Colors.red.withValues(alpha: .4)),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                        ),
                        onPressed: () => _cancelOrderWithReason(o),
                      ),
                    ],
                  ),
                  if ((o['cuisinier'] as String).isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: FilledButton.icon(
                        icon: const Icon(Icons.check_rounded, size: 18),
                        label: const Text("Aksepte"),
                        style: FilledButton.styleFrom(
                          minimumSize: const Size.fromHeight(44),
                        ),
                        onPressed: () {
                          setState(() {
                            o['status'] = "En préparation";
                            o['date_prepared'] = DateTime.now();
                          });
                        },
                      ),
                    ),
                ],
              ),
            if (status == "En préparation")
              Row(
                children: [
                  Expanded(
                    child: FilledButton.icon(
                      icon: const Icon(Icons.restaurant_menu_rounded, size: 18),
                      label: const Text("Mete Disponib"),
                      style: FilledButton.styleFrom(
                        minimumSize: const Size.fromHeight(44),
                        backgroundColor: const Color(0xFF00695C),
                      ),
                      onPressed: () {
                        setState(() {
                          o['status'] = "Disponible";
                          o['date_disponib'] = DateTime.now();
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  OutlinedButton.icon(
                    icon: const Icon(Icons.close_rounded,
                        size: 18, color: Colors.red),
                    label: const Text("Anile",
                        style: TextStyle(color: Colors.red)),
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size(0, 44),
                      side: BorderSide(color: Colors.red.withValues(alpha: .4)),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                    onPressed: () => _cancelOrderWithReason(o),
                  ),
                ],
              ),
            if (status == "Disponible")
              Row(
                children: [
                  if ((o['livreur'] as String).isNotEmpty) ...[
                    Expanded(
                      child: FilledButton.icon(
                        icon: const Icon(Icons.local_shipping_rounded, size: 18),
                        label: const Text("Voye Livrezon"),
                        style: FilledButton.styleFrom(
                          minimumSize: const Size.fromHeight(44),
                        ),
                        onPressed: () {
                          setState(() {
                            o['status'] = "En cours de livraison";
                            o['date_delivery'] = DateTime.now();
                          });
                        },
                      ),
                    ),
                    const SizedBox(width: 8),
                  ],
                  OutlinedButton.icon(
                    icon: const Icon(Icons.close_rounded,
                        size: 18, color: Colors.red),
                    label: const Text("Anile",
                        style: TextStyle(color: Colors.red)),
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size(0, 44),
                      side: BorderSide(color: Colors.red.withValues(alpha: .4)),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                    onPressed: () => _cancelOrderWithReason(o),
                  ),
                ],
              ),
            if (status == "En cours de livraison")
              Row(
                children: [
                  Expanded(
                    child: FilledButton.icon(
                      icon: const Icon(Icons.done_all_rounded, size: 18),
                      label: const Text("Konfime Livrezon"),
                      style: FilledButton.styleFrom(
                        minimumSize: const Size.fromHeight(44),
                        backgroundColor: Colors.green[700],
                      ),
                      onPressed: () {
                        setState(() {
                          o['status'] = "Livre";
                          o['date_completed'] = DateTime.now();
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  OutlinedButton.icon(
                    icon: const Icon(Icons.close_rounded,
                        size: 18, color: Colors.red),
                    label: const Text("Anile",
                        style: TextStyle(color: Colors.red)),
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size(0, 44),
                      side: BorderSide(color: Colors.red.withValues(alpha: .4)),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                    onPressed: () => _cancelOrderWithReason(o),
                  ),
                ],
              ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // =================================================================
  //  ONGLET PLAT
  // =================================================================
  Widget _buildMenuPlats() {
    List<Map<String, dynamic>> filteredPlats = menuPlats.where((plat) {
      return plat['name'].toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();

    if (_stockSortOrder == "Croissant") {
      filteredPlats
          .sort((a, b) => (a['stock'] as int).compareTo(b['stock'] as int));
    } else if (_stockSortOrder == "Décroissant") {
      filteredPlats
          .sort((a, b) => (b['stock'] as int).compareTo(a['stock'] as int));
    }

    final dispoCount =
        filteredPlats.where((p) => p['available']).length;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  hintText: "Chèche yon plat...",
                  prefixIcon: const Icon(Icons.search_rounded),
                  suffixIcon: _searchQuery.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.close_rounded),
                          onPressed: () => setState(() => _searchQuery = ""),
                        )
                      : null,
                ),
                onChanged: (v) => setState(() => _searchQuery = v),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: _StatPill(
                      icon: Icons.inventory_2_outlined,
                      label: "Total",
                      value: "${filteredPlats.length}",
                      color: AppPalette.seed,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _StatPill(
                      icon: Icons.check_circle_outline,
                      label: "Dispo",
                      value: "$dispoCount",
                      color: Colors.green[700]!,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 36,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _SortChip(
                      label: "Tout",
                      selected: _stockSortOrder == "Tout",
                      onTap: () => setState(() => _stockSortOrder = "Tout"),
                    ),
                    const SizedBox(width: 8),
                    _SortChip(
                      label: "Stock ↑",
                      selected: _stockSortOrder == "Croissant",
                      onTap: () =>
                          setState(() => _stockSortOrder = "Croissant"),
                    ),
                    const SizedBox(width: 8),
                    _SortChip(
                      label: "Stock ↓",
                      selected: _stockSortOrder == "Décroissant",
                      onTap: () =>
                          setState(() => _stockSortOrder = "Décroissant"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: filteredPlats.isEmpty
              ? const _EmptyState(
                  icon: Icons.no_meals_rounded,
                  title: "Pa gen plat",
                  message:
                      "Pa gen plat ki koresponn ak rechèch la. Eseye yon lòt mo.",
                )
              : ListView.separated(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 100),
                  itemCount: filteredPlats.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final plat = filteredPlats[index];
                    double totalSupplementsPrice = 0.0;
                    for (var supp in plat['supplements']) {
                      totalSupplementsPrice += supp['pri'];
                    }
                    double totalPriceWithSupps =
                        plat['pri'] + totalSupplementsPrice;
                    int originalIndex = menuPlats.indexOf(plat);
                    final bool dispo = plat['available'];

                    return Card(
                      child: Theme(
                        data: Theme.of(context)
                            .copyWith(dividerColor: Colors.transparent),
                        child: ExpansionTile(
                          tilePadding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          childrenPadding:
                              const EdgeInsets.fromLTRB(16, 0, 16, 16),
                          leading: Container(
                            width: 44,
                            height: 44,
                            decoration: BoxDecoration(
                              color: AppPalette.seed.withValues(alpha: .1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(Icons.restaurant_rounded,
                                color: AppPalette.seed),
                          ),
                          title: Text(
                            plat['name'],
                            style: const TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 15),
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: Text(
                              "${plat['pri']} HTG • Max ${totalPriceWithSupps.toStringAsFixed(0)} HTG",
                              style: TextStyle(
                                fontSize: 12.5,
                                color: Colors.grey[600],
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: dispo
                                      ? Colors.green.withValues(alpha: .1)
                                      : Colors.red.withValues(alpha: .1),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  dispo
                                      ? "${plat['stock']} dispo"
                                      : "Rete",
                                  style: TextStyle(
                                    color: dispo
                                        ? Colors.green[700]
                                        : Colors.red[700],
                                    fontWeight: FontWeight.w700,
                                    fontSize: 11.5,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 4),
                              IconButton(
                                icon: const Icon(Icons.edit_outlined),
                                color: AppPalette.seed,
                                onPressed: () =>
                                    _showPlatForm(index: originalIndex),
                              ),
                            ],
                          ),
                          children: [
                            const Divider(height: 24),
                            if (plat['supplements'].isEmpty)
                              _InlineHint(
                                icon: Icons.info_outline_rounded,
                                text: "Pa gen sipleman pou plat sa a.",
                              )
                            else ...[
                              _SectionHeader(
                                icon: Icons.add_circle_outline_rounded,
                                title: "Sipleman",
                                trailing: Text(
                                  "${plat['supplements'].length}",
                                  style: const TextStyle(
                                    color: AppPalette.seed,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              ...((plat['supplements'] as List).map(
                                (s) => Container(
                                  margin: const EdgeInsets.only(bottom: 6),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 10),
                                  decoration: BoxDecoration(
                                    color: AppPalette.cream,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(Icons.add_circle_rounded,
                                          color: AppPalette.seed
                                              .withValues(alpha: .7),
                                          size: 18),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(s['name'],
                                                style: const TextStyle(
                                                    fontWeight:
                                                        FontWeight.w600)),
                                            Text(
                                              "Stock: ${s['syncWithPlatStock'] ? plat['stock'] : s['stock']}",
                                              style: TextStyle(
                                                  fontSize: 11.5,
                                                  color: Colors.grey[600]),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Text(
                                        "+${s['pri']} HTG",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w700,
                                            color: AppPalette.seed),
                                      ),
                                    ],
                                  ),
                                ),
                              )),
                            ],
                          ],
                        ),
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }

  // =================================================================
  //  ONGLET STAFF
  // =================================================================
  Widget _buildStaff() {
    if (staffList.isEmpty) {
      return const _EmptyState(
        icon: Icons.people_outline_rounded,
        title: "Pa gen anplwaye",
        message: "Klike sou bouton + pou ajoute premye anplwaye a.",
      );
    }
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 100),
      itemCount: staffList.length,
      separatorBuilder: (_, _) => const SizedBox(height: 10),
      itemBuilder: (context, index) {
        final employee = staffList[index];
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                _Avatar(name: employee['name']!, size: 54),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        employee['name']!,
                        style: const TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 15),
                      ),
                      const SizedBox(height: 2),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: AppPalette.seed.withValues(alpha: .1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          employee['role']!,
                          style: const TextStyle(
                            color: AppPalette.seed,
                            fontWeight: FontWeight.w600,
                            fontSize: 11,
                          ),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Icon(Icons.phone_outlined,
                              size: 13, color: Colors.grey[600]),
                          const SizedBox(width: 4),
                          Text(
                            employee['phone']!,
                            style: TextStyle(
                                fontSize: 12.5, color: Colors.grey[700]),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.edit_outlined),
                  color: AppPalette.seed,
                  onPressed: () => _showStaffForm(index: index),
                ),
                IconButton(
                  icon: const Icon(Icons.delete_outline),
                  color: Colors.red[400],
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        icon: Icon(Icons.warning_amber_rounded,
                            color: Colors.red[700], size: 36),
                        title: const Text("Efase Anplwaye",
                            textAlign: TextAlign.center),
                        content: Text(
                          "Èske w sèten ou vle efase ${employee['name']} nan sistèm nan?",
                          textAlign: TextAlign.center,
                        ),
                        actionsPadding:
                            const EdgeInsets.fromLTRB(16, 0, 16, 16),
                        actions: [
                          Row(
                            children: [
                              Expanded(
                                child: OutlinedButton(
                                  onPressed: () => Navigator.pop(ctx),
                                  style: OutlinedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 14),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                  ),
                                  child: const Text("Anile"),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: FilledButton(
                                  style: FilledButton.styleFrom(
                                    backgroundColor: Colors.red[600],
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 14),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                  ),
                                  onPressed: () {
                                    setState(() => staffList.removeAt(index));
                                    Navigator.pop(ctx);
                                  },
                                  child: const Text("Wi, efase"),
                                ),
                              ),
                            ],
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

  // =================================================================
  //  ONGLET ISTORIK
  // =================================================================
  Widget _buildHistoryTab() {
    List<Map<String, dynamic>> historyOrders = orders.where((o) {
      bool isFinished = o['status'] == "Livre" || o['status'] == "Annulé";
      bool dateMatch = _historyDateRange == null ||
          (o['date'].isAfter(_historyDateRange!.start) &&
              o['date'].isBefore(
                  _historyDateRange!.end.add(const Duration(days: 1))));
      bool employeeMatch = _historyEmployeeFilter == "Tout" ||
          o['cuisinier'] == _historyEmployeeFilter ||
          o['livreur'] == _historyEmployeeFilter;
      return isFinished && dateMatch && employeeMatch;
    }).toList();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
          child: Row(
            children: [
              Expanded(
                child: DropdownButtonFormField<String>(
                  isExpanded: true,
                  decoration: const InputDecoration(
                    labelText: "Anplwaye",
                    prefixIcon: Icon(Icons.person_outline_rounded),
                    isDense: true,
                  ),
                  initialValue: _historyEmployeeFilter,
                  items: ["Tout", ...staffList.map((s) => s['name']!)]
                      .map((e) =>
                          DropdownMenuItem<String>(value: e, child: Text(e)))
                      .toList(),
                  onChanged: (v) =>
                      setState(() => _historyEmployeeFilter = v!),
                ),
              ),
              const SizedBox(width: 8),
              Material(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                child: InkWell(
                  borderRadius: BorderRadius.circular(14),
                  onTap: () async {
                    DateTimeRange? picked = await showDateRangePicker(
                      context: context,
                      firstDate: DateTime(2026),
                      lastDate: DateTime(2030),
                    );
                    if (picked != null) {
                      setState(() => _historyDateRange = picked);
                    }
                  },
                  child: Container(
                    width: 54,
                    height: 54,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: Theme.of(context)
                            .colorScheme
                            .outlineVariant
                            .withValues(alpha: .5),
                      ),
                    ),
                    child: Icon(Icons.date_range_rounded,
                        color: _historyDateRange != null
                            ? AppPalette.seed
                            : Colors.grey[600]),
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: historyOrders.isEmpty
              ? const _EmptyState(
                  icon: Icons.history_rounded,
                  title: "Pa gen istorik",
                  message:
                      "Pa gen kòmand fini oswa anile ki koresponn ak filtè yo.",
                )
              : ListView.separated(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                  itemCount: historyOrders.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 12),
                  itemBuilder: (c, i) {
                    final o = historyOrders[i];
                    bool isCanceled = o['status'] == "Annulé";
                    final Color sFg = isCanceled
                        ? Colors.red[700]!
                        : Colors.green[700]!;
                    final Color sBg = isCanceled
                        ? Colors.red.withValues(alpha: .1)
                        : Colors.green.withValues(alpha: .1);

                    return Card(
                      child: Theme(
                        data: Theme.of(context)
                            .copyWith(dividerColor: Colors.transparent),
                        child: ExpansionTile(
                          tilePadding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          childrenPadding:
                              const EdgeInsets.fromLTRB(16, 0, 16, 16),
                          leading: Container(
                            width: 44,
                            height: 44,
                            decoration: BoxDecoration(
                              color: sBg,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(
                              isCanceled
                                  ? Icons.cancel_rounded
                                  : Icons.check_circle_rounded,
                              color: sFg,
                            ),
                          ),
                          title: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  o['name'],
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 15),
                                ),
                              ),
                              _StatusPill(status: o['status']),
                            ],
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: Text(
                              "${o['id']} • ${o['pla']}",
                              style: TextStyle(
                                fontSize: 12.5,
                                color: Colors.grey[600],
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          children: [
                            const Divider(height: 24),
                            _SectionHeader(
                              icon: Icons.timeline_rounded,
                              title: "Timeline kòmand lan",
                            ),
                            const SizedBox(height: 8),
                            _TimelineStep(
                              icon: Icons.shopping_cart_rounded,
                              title: "Kòmand Kreye",
                              time: _formatDate(o['date']),
                              isFirst: true,
                              done: true,
                            ),
                            _TimelineStep(
                              icon: Icons.soup_kitchen_rounded,
                              title: "Kòmanse Prepare",
                              time: _formatDate(o['date_prepared']),
                              done: o['date_prepared'] != null,
                            ),
                            _TimelineStep(
                              icon: Icons.restaurant_menu_rounded,
                              title: "Plat Disponib",
                              time: _formatDate(o['date_disponib']),
                              done: o['date_disponib'] != null,
                            ),
                            _TimelineStep(
                              icon: Icons.delivery_dining_rounded,
                              title: "Soti pou Livrezon",
                              time: _formatDate(o['date_delivery']),
                              done: o['date_delivery'] != null,
                            ),
                            if (!isCanceled)
                              _TimelineStep(
                                icon: Icons.done_all_rounded,
                                title: "Livre ak Siksè",
                                time: _formatDate(o['date_completed']),
                                done: o['date_completed'] != null,
                                isLast: true,
                                doneColor: Colors.green[700],
                              ),
                            if (isCanceled) ...[
                              _TimelineStep(
                                icon: Icons.cancel_rounded,
                                title: "Kòmand lan Anile",
                                time: _formatDate(o['date_canceled']),
                                done: true,
                                isLast: true,
                                doneColor: Colors.red[700],
                              ),
                              const SizedBox(height: 8),
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.red.withValues(alpha: .06),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                      color: Colors.red
                                          .withValues(alpha: .25)),
                                ),
                                child: Row(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Icon(Icons.info_outline_rounded,
                                        color: Colors.red[700], size: 18),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text("Rezon anilasyon",
                                              style: TextStyle(
                                                  color: Colors.red[700],
                                                  fontWeight:
                                                      FontWeight.w700,
                                                  fontSize: 12)),
                                          const SizedBox(height: 4),
                                          Text(
                                            o['cancel_reason'],
                                            style: TextStyle(
                                                color: Colors.red[900],
                                                fontSize: 13),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }

  // =================================================================
  //  ONGLET PROFILE
  // =================================================================
  Widget _buildProfileTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // En-tête restaurant
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFFEF6C00), Color(0xFFFF9800)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Icon(Icons.storefront_rounded,
                        color: Colors.white, size: 28),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _restNameController.text,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "Restoran • ${_deliveryZones.length} zòn livrezon",
                          style: TextStyle(
                              color: Colors.grey[600], fontSize: 12.5),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          _ProfileSection(
            icon: Icons.info_outline_rounded,
            title: "Enfòmasyon Restoran",
            children: [
              TextField(
                controller: _restNameController,
                enabled: false,
                decoration: const InputDecoration(
                  labelText: "Non Restoran",
                  prefixIcon: Icon(Icons.storefront_outlined),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _restDescController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: "Deskripsyon Restoran",
                  alignLabelWithHint: true,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _ProfileSection(
            icon: Icons.phone_outlined,
            title: "Nimewo Telefòn",
            subtitle: "Max 3 nimewo",
            children: [
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
                                labelText: "Telefòn ${entry.key + 1}",
                                prefixIcon: const Icon(Icons.phone_outlined),
                              ),
                              onChanged: (v) => _phones[entry.key] = v,
                            ),
                          ),
                          if (_phones.length > 1)
                            IconButton(
                              icon: Icon(Icons.delete_outline,
                                  color: Colors.red[400]),
                              onPressed: () => setState(
                                  () => _phones.removeAt(entry.key)),
                            ),
                        ],
                      ),
                    ),
                  ),
              if (_phones.length < 3)
                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton.icon(
                    icon: const Icon(Icons.add_rounded),
                    label: const Text("Ajoute yon lòt nimewo"),
                    onPressed: () => setState(() => _phones.add("")),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 16),
          _ProfileSection(
            icon: Icons.location_on_outlined,
            title: "Adrès Etablisman",
            children: [
              DropdownButtonFormField<String>(
                isExpanded: true,
                decoration: const InputDecoration(
                  labelText: "Depatman",
                  prefixIcon: Icon(Icons.map_outlined),
                ),
                initialValue: _selectedDept,
                items: _haitiData.keys
                    .map((d) => DropdownMenuItem(value: d, child: Text(d)))
                    .toList(),
                onChanged: (v) => setState(() {
                  _selectedDept = v;
                  _selectedCommune = null;
                }),
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                isExpanded: true,
                decoration: const InputDecoration(
                  labelText: "Komin",
                  prefixIcon: Icon(Icons.location_city_outlined),
                ),
                initialValue: _selectedCommune,
                items: (_haitiData[_selectedDept] ?? [])
                    .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                    .toList(),
                onChanged: (v) => setState(() => _selectedCommune = v),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _addressController,
                decoration: const InputDecoration(
                  labelText: "Rue, Ruelle, Nimewo kay",
                  prefixIcon: Icon(Icons.home_outlined),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _ProfileSection(
            icon: Icons.local_shipping_outlined,
            title: "Zòn Livrezon",
            subtitle:
                "Koche sèlman komin kote restoran an ka livre an sekirite",
            accent: Colors.red[700],
            children: [
              if (_deliveryZones.isNotEmpty)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: Colors.green.withValues(alpha: .08),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.check_circle_rounded,
                          color: Colors.green[700], size: 18),
                      const SizedBox(width: 8),
                      Text(
                        "${_deliveryZones.length} komin chwazi",
                        style: TextStyle(
                            color: Colors.green[800],
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ..._haitiData.keys.map((dept) {
                final selectedInDept = _haitiData[dept]!
                    .where((c) => _deliveryZones.contains(c))
                    .length;
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  decoration: BoxDecoration(
                    color: AppPalette.cream,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Theme(
                    data: Theme.of(context)
                        .copyWith(dividerColor: Colors.transparent),
                    child: ExpansionTile(
                      shape: const Border(),
                      collapsedShape: const Border(),
                      title: Text(
                        dept,
                        style:
                            const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      trailing: selectedInDept > 0
                          ? Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 3),
                              decoration: BoxDecoration(
                                color: AppPalette.seed,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                "$selectedInDept",
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 11),
                              ),
                            )
                          : const Icon(Icons.expand_more),
                      children: _haitiData[dept]!.map((commune) {
                        return CheckboxListTile(
                          title: Text(commune),
                          dense: true,
                          activeColor: AppPalette.seed,
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
                  ),
                );
              }),
            ],
          ),
          const SizedBox(height: 24),
          FilledButton.icon(
            icon: const Icon(Icons.save_rounded),
            label: const Text("Sove Chanjman yo"),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Row(
                    children: [
                      Icon(Icons.check_circle_rounded, color: Colors.white),
                      SizedBox(width: 10),
                      Text("Profile Mizajou avèk Siksè!"),
                    ],
                  ),
                  backgroundColor: Colors.green[700],
                ),
              );
            },
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

// =====================================================================
//  WIDGETS RÉUTILISABLES
// =====================================================================

class _StatusPill extends StatelessWidget {
  final String status;
  const _StatusPill({required this.status});

  @override
  Widget build(BuildContext context) {
    final fg = AppPalette.statusFg[status] ?? AppPalette.seed;
    final bg = AppPalette.statusBg[status] ?? Colors.grey[100]!;
    final icon = AppPalette.statusIcon[status] ?? Icons.circle;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: fg, size: 12),
          const SizedBox(width: 4),
          Text(
            status,
            style: TextStyle(
              color: fg,
              fontWeight: FontWeight.w700,
              fontSize: 10.5,
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final IconData icon;
  final String title;
  final Widget? trailing;
  const _SectionHeader({
    required this.icon,
    required this.title,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 18, color: AppPalette.seed),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 13.5,
              color: AppPalette.ink,
            ),
          ),
        ),
        ?trailing,
      ],
    );
  }
}

class _MemoBlock extends StatelessWidget {
  final String text;
  const _MemoBlock({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.amber.withValues(alpha: .12),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.amber.withValues(alpha: .4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.warning_amber_rounded,
                  color: Colors.amber[800], size: 18),
              const SizedBox(width: 6),
              Text(
                "MEMO / ATANSYON",
                style: TextStyle(
                  color: Colors.amber[900],
                  fontWeight: FontWeight.w800,
                  fontSize: 11,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            text,
            style: TextStyle(
              color: Colors.amber[900],
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}

class _AssigneeRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String name;
  const _AssigneeRow(
      {required this.icon, required this.label, required this.name});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, size: 16, color: Colors.grey[700]),
          const SizedBox(width: 8),
          Text(
            "$label : ",
            style: TextStyle(color: Colors.grey[700], fontSize: 12.5),
          ),
          Text(
            name,
            style: const TextStyle(
                fontWeight: FontWeight.w600, fontSize: 12.5),
          ),
        ],
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  final IconData icon;
  final String title;
  final String message;
  const _EmptyState({
    required this.icon,
    required this.title,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 88,
              height: 88,
              decoration: BoxDecoration(
                color: AppPalette.seed.withValues(alpha: .08),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 40, color: AppPalette.seed),
            ),
            const SizedBox(height: 20),
            Text(
              title,
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey[600], fontSize: 13.5),
            ),
          ],
        ),
      ),
    );
  }
}

class _InlineHint extends StatelessWidget {
  final IconData icon;
  final String text;
  const _InlineHint({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, size: 18, color: Colors.grey[600]),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: TextStyle(color: Colors.grey[700], fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatPill extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;
  const _StatPill({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withValues(alpha: .25)),
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: color.withValues(alpha: .12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                value,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: color,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SortChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;
  const _SortChip(
      {required this.label, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: Text(label),
      selected: selected,
      showCheckmark: false,
      labelStyle: TextStyle(
        fontWeight: FontWeight.w600,
        color: selected ? Colors.white : AppPalette.ink,
        fontSize: 12,
      ),
      selectedColor: AppPalette.seed,
      backgroundColor: Colors.white,
      side: BorderSide(
        color: selected
            ? AppPalette.seed
            : Theme.of(context).colorScheme.outlineVariant,
      ),
      onSelected: (_) => onTap(),
    );
  }
}

class _Avatar extends StatelessWidget {
  final String name;
  final double size;
  const _Avatar({required this.name, this.size = 44});

  String get initials {
    final parts = name.trim().split(RegExp(r'\s+'));
    if (parts.isEmpty || parts.first.isEmpty) return "?";
    if (parts.length == 1) return parts.first[0].toUpperCase();
    return (parts[0][0] + parts[1][0]).toUpperCase();
  }

  Color get bgColor {
    final colors = [
      const Color(0xFFEF6C00),
      const Color(0xFF1565C0),
      const Color(0xFF6A1B9A),
      const Color(0xFF2E7D32),
      const Color(0xFFC62828),
      const Color(0xFF00838F),
    ];
    return colors[name.hashCode.abs() % colors.length];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [bgColor, bgColor.withValues(alpha: .7)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: Text(
        initials,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w800,
          fontSize: size * 0.36,
        ),
      ),
    );
  }
}

class _TimelineStep extends StatelessWidget {
  final IconData icon;
  final String title;
  final String time;
  final bool done;
  final bool isFirst;
  final bool isLast;
  final Color? doneColor;
  const _TimelineStep({
    required this.icon,
    required this.title,
    required this.time,
    required this.done,
    this.isFirst = false,
    this.isLast = false,
    this.doneColor,
  });

  @override
  Widget build(BuildContext context) {
    final color = done
        ? (doneColor ?? AppPalette.seed)
        : Colors.grey[400]!;
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: .15),
                  shape: BoxShape.circle,
                  border: Border.all(color: color, width: 1.5),
                ),
                child: Icon(icon, size: 16, color: color),
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    color: done
                        ? color.withValues(alpha: .4)
                        : Colors.grey[300],
                  ),
                ),
            ],
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                top: 4,
                bottom: isLast ? 0 : 16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: done ? AppPalette.ink : Colors.grey[500],
                      fontSize: 13.5,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    time,
                    style: TextStyle(
                      color: done ? Colors.grey[600] : Colors.grey[400],
                      fontStyle:
                          done ? FontStyle.normal : FontStyle.italic,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DragHandle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 40,
        height: 4,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(2),
        ),
      ),
    );
  }
}

class _SheetHeader extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  const _SheetHeader({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: AppPalette.seed.withValues(alpha: .12),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(Icons.menu_book_rounded,
              color: AppPalette.seed, size: 22),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 12.5,
                ),
              ),
            ],
          ),
        ),
        IconButton(
          icon: const Icon(Icons.close_rounded),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );
  }
}

class _ProfileSection extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final Color? accent;
  final List<Widget> children;
  const _ProfileSection({
    required this.icon,
    required this.title,
    this.subtitle,
    this.accent,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    final c = accent ?? AppPalette.seed;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: c.withValues(alpha: .12),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(icon, color: c, size: 18),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 15),
                      ),
                      if (subtitle != null) ...[
                        const SizedBox(height: 2),
                        Text(
                          subtitle!,
                          style: TextStyle(
                              color: Colors.grey[600], fontSize: 12),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ...children,
          ],
        ),
      ),
    );
  }
}
