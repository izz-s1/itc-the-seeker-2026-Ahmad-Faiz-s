import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

// ================= GLOBAL FAVORITE =================
Set<String> favorites = {};

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pengurus ITC',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        scaffoldBackgroundColor: Color(0xFFF1F4F9),
      ),
      home: HomePage(),
    );
  }
}

// ================= DATA =================
List<Map<String, String>> data = [
  {
    "name": "Andi",
    "role": "Ketua",
    "division": "ITC",
    "phone": "08123456789",
    "email": "andi@gmail.com",
    "desc": "Memimpin organisasi, mengambil keputusan, dan mengawasi seluruh divisi.",
  },
  {
    "name": "Budi",
    "role": "Wakil",
    "division": "ITC",
    "phone": "08987654321",
    "email": "budi@gmail.com",
    "desc": "Membantu ketua dalam koordinasi dan menggantikan peran saat diperlukan.",
  },
  {
    "name": "Citra",
    "role": "Kadiv Mobile",
    "division": "Mobile Dev",
    "phone": "08111111111",
    "email": "citra@gmail.com",
    "desc": "Mengelola tim mobile developer dan mengembangkan aplikasi berbasis mobile.",
  },
  {
    "name": "Reza",
    "role": "Kadiv Web",
    "division": "Web Dev",
    "phone": "082323232323",
    "email": "reza@gmail.com",
    "desc": "Mengelola pengembangan website dan memastikan kualitas sistem web.",
  },
  {
    "name": "Febi",
    "role": "Anggota Web",
    "division": "Web Dev",
    "phone": "082321627489",
    "email": "febi@gmail.com",
    "desc": "Membantu pengembangan website dan mengerjakan tugas teknis dari divisi.",
  },
   {
    "name": "Indra",
    "role": "Anggota Mobile",
    "division": "Mobile Dev",
    "phone": "082323127489",
    "email": "indra@gmail.com",
    "desc": "Membantu pengembangan mobile app dan mengerjakan tugas teknis dari divisi.",
  },
];

// ================= HOME PAGE =================
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var ketua = data.firstWhere((p) => p["role"] == "Ketua");

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // HEADER
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF1A237E), Color(0xFF3949AB)],
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("ITC Organization",
                      style: TextStyle(color: Colors.white70)),
                  Text("Pengurus ITC",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold)),
                ],
              ),
            ),

            SizedBox(height: 20),

            // DESKRIPSI + JUMLAH
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "ITC adalah organisasi teknologi yang berfokus pada pengembangan skill mahasiswa di bidang IT.",
                  ),
                  SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.indigo,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Jumlah Pengurus",
                            style: TextStyle(color: Colors.white)),
                        Text("${data.length}",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 20),

            // KETUA
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.indigo,
                    child: Text(ketua["name"]![0]),
                  ),
                  title: Text(ketua["name"]!),
                  subtitle: Text(ketua["role"]!),
                ),
              ),
            ),

            Spacer(),

            Padding(
              padding: EdgeInsets.all(16),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  child: Text("Lihat Semua"),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => ListPage()),
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

// ================= LIST PAGE =================
class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  String search = "";

  @override
  Widget build(BuildContext context) {
    var filtered = data
        .where((p) => p["name"]!
            .toLowerCase()
            .contains(search.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(title: Text("Pengurus")),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(12),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Cari nama...",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (val) {
                setState(() {
                  search = val;
                });
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filtered.length,
              itemBuilder: (context, index) {
                var p = filtered[index];
                bool fav = favorites.contains(p["name"]);

                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.indigo,
                    child: Text(p["name"]![0]),
                  ),
                  title: Text(p["name"]!),
                  subtitle: Text(p["role"]!),
                  trailing: IconButton(
                    icon: Icon(
                      fav ? Icons.star : Icons.star_border,
                      color: fav ? Colors.amber : Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        fav
                            ? favorites.remove(p["name"])
                            : favorites.add(p["name"]!);
                      });
                    },
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => DetailPage(person: p),
                      ),
                    ).then((_) => setState(() {}));
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

// ================= DETAIL PAGE =================
class DetailPage extends StatefulWidget {
  final Map<String, String> person;

  DetailPage({required this.person});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    var p = widget.person;
    bool fav = favorites.contains(p["name"]);

    return Scaffold(
      appBar: AppBar(
        title: Text(p["name"]!),
        actions: [
          IconButton(
            icon: Icon(fav ? Icons.star : Icons.star_border),
            onPressed: () {
              setState(() {
                fav
                    ? favorites.remove(p["name"])
                    : favorites.add(p["name"]!);
              });
            },
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 40,
                backgroundColor: Colors.indigo,
                child: Text(p["name"]![0],
                    style: TextStyle(fontSize: 24, color: Colors.white)),
              ),
            ),
            SizedBox(height: 16),

            Text(p["name"]!,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Text(p["role"]!),

            SizedBox(height: 20),

            Text("Deskripsi Pekerjaan",
                style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 6),
            Text(p["desc"]!),

            SizedBox(height: 20),

            Text("Kontak",
                style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 6),
            Text("📞 ${p["phone"]}"),
            Text("📧 ${p["email"]}"),
          ],
        ),
      ),
    );
  }
}