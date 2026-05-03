import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

// ================= APP =================
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pengurus ITC',
      home: HomePage(),
    );
  }
}

// ================= DATA =================
List data = [
  {
    "name": "Andi",
    "role": "Ketua",
    "division": "ITC",
    "phone": "08123456789",
    "email": "andi@gmail.com",
  },
  {
    "name": "Budi",
    "role": "Wakil",
    "division": "ITC",
    "phone": "08987654321",
    "email": "budi@gmail.com",
  },
  {
    "name": "Citra",
    "role": "Kadiv Mobile",
    "division": "Mobile Dev",
    "phone": "08111111111",
    "email": "citra@gmail.com",
  }, 
  {
    "name": "Reza",
    "role": "Kadiv web",
    "division": "web Dev",
    "phone": "082323232323",
    "email": "reza@gmail.com",
  },
  {
    "name": "Febi",
    "role": "Anggota web",
    "division": "web Dev",
    "phone": "082321627489",
    "email": "febi@gmail.com",
  },
];

// ================= HOME PAGE =================
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var ketua = data.firstWhere((p) => p["role"] == "Ketua");

    // Hitung jumlah divisi unik
    var divisions = data.map((p) => p["division"]).toSet();

    return Scaffold(
      appBar: AppBar(title: Text("Pengurus ITC")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //  DESKRIPSI ITC
            Text(
              "ITC adalah organisasi yang bergerak di bidang teknologi, "
              "berfokus pada pengembangan skill mahasiswa dalam dunia IT.",
              style: TextStyle(fontSize: 16),
            ),

            SizedBox(height: 20),

            //  JUMLAH DIVISI
            Text(
              "Jumlah Divisi: ${divisions.length}",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
      
            SizedBox(height: 20),

            //  HIGHLIGHT KETUA
            Text("Ketua", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            ListTile(
              leading: CircleAvatar(
                child: Text(ketua["name"][0]),
              ),
              title: Text(ketua["name"]),
              subtitle: Text(ketua["role"]),
            ),

            SizedBox(height: 20),

            // 🔥 BUTTON KE HALAMAN LIST
            ElevatedButton(
              child: Text("Lihat Struktur"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => ListPage()),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

// ================= LIST PAGE =================
class ListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var ketua = data.where((p) => p["role"] == "Ketua").toList();
    var wakil = data.where((p) => p["role"] == "Wakil").toList();
    var kadiv = data.where((p) => p["role"].toString().contains("Kadiv")).toList();
    var anggota = data.where((p) => p["role"].toString().contains("Anggota")).toList();

    return Scaffold(
      appBar: AppBar(title: Text("Struktur Pengurus")),
      body: ListView(
        children: [
          buildSection("Ketua", ketua, context, Colors.green),
          buildSection("Wakil", wakil, context, Colors.blue),
          buildSection("Kepala Divisi", kadiv, context, Colors.orange),
          buildSection("Anggota Divisi", anggota, context, Colors.purple),
        ],
      ),
    );
  }

  Widget buildSection(String title, List list, BuildContext context, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(12),
          child: Text(
            title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        ...list.map((p) => ListTile(
              leading: CircleAvatar(
                backgroundColor: color,
                child: Text(p["name"][0]),
              ),
              title: Text(p["name"]),
              subtitle: Text(p["role"]),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => DetailPage(person: p),
                  ),
                );
              },
            ))
      ],
    );
  }
}

// ================= DETAIL PAGE =================
class DetailPage extends StatefulWidget {
  final Map person;

  DetailPage({required this.person});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    var p = widget.person;

    return Scaffold(
      appBar: AppBar(
        title: Text(p["name"]),
        actions: [
          IconButton(
            icon: Icon(isFavorite ? Icons.star : Icons.star_border),
            onPressed: () {
              setState(() {
                isFavorite = !isFavorite;
              });
            },
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 40,
                child: Text(p["name"][0], style: TextStyle(fontSize: 24)),
              ),
            ),
            SizedBox(height: 20),

            Text("Nama: ${p["name"]}", style: TextStyle(fontSize: 18)),
            Text("Jabatan: ${p["role"]}"),
            Text("Divisi: ${p["division"]}"),

            SizedBox(height: 20),

            Text("Kontak Cepat", style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 10),

            Text("📞 ${p["phone"]}"),
            Text("📧 ${p["email"]}"),
          ],
        ),
      ),
    );
  }
}