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
        primaryColor: Color(0xFF1A237E),
        scaffoldBackgroundColor: Color(0xFFF1F4F9),
      ),
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
    "role": "Kadiv Web",
    "division": "Web Dev",
    "phone": "082323232323",
    "email": "reza@gmail.com",
  },
  {
    "name": "Febi",
    "role": "Anggota Web",
    "division": "Web Dev",
    "phone": "082321627489",
    "email": "febi@gmail.com",
  },
  {
    "name": "Indra",
    "role": "Anggota Mobile",
    "division": "Mobile Dev",
    "phone": "082322437489",
    "email": "indra@gmail.com",
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
            // HEADER GRADIENT
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
                  SizedBox(height: 5),
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
                    style: TextStyle(fontSize: 14, color: Colors.black87),
                  ),
                  SizedBox(height: 12),
                  Container(
                    padding: EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.indigo,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Jumlah Pengurus",
                            style: TextStyle(color: Colors.white)),
                        Text("${data.length}",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18)),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 20),

            // KETUA H
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(color: Colors.black12, blurRadius: 8)
                  ],
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.indigo,
                      child: Text(ketua["name"][0],
                          style: TextStyle(color: Colors.white)),
                    ),
                    SizedBox(width: 15),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(ketua["name"],
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        Text(ketua["role"],
                            style: TextStyle(color: Colors.grey)),
                      ],
                    )
                  ],
                ),
              ),
            ),

            SizedBox(height: 30),

            // BUTTON
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.all(16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: Text("Lihat Semua Pengurus"),
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
        .where((p) => p["name"].toLowerCase().contains(search.toLowerCase()))
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
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
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

                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(color: Colors.black12, blurRadius: 6)
                    ],
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.indigo,
                      child: Text(p["name"][0]),
                    ),
                    title: Text(p["name"]),
                    subtitle: Text(p["role"]),
                    trailing: IconButton(
                      icon: Icon(
                        fav ? Icons.star : Icons.star_border,
                        color: fav ? Colors.amber : Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          fav
                              ? favorites.remove(p["name"])
                              : favorites.add(p["name"]);
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
                  ),
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
  final Map person;

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
        title: Text(p["name"]),
        actions: [
          IconButton(
            icon: Icon(fav ? Icons.star : Icons.star_border),
            onPressed: () {
              setState(() {
                fav
                    ? favorites.remove(p["name"])
                    : favorites.add(p["name"]);
              });
            },
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            CircleAvatar(
              radius: 45,
              backgroundColor: Colors.indigo,
              child: Text(p["name"][0],
                  style: TextStyle(fontSize: 28, color: Colors.white)),
            ),
            SizedBox(height: 10),

            Text(p["name"],
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Text(p["role"], style: TextStyle(color: Colors.grey)),

            SizedBox(height: 20),

            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(color: Colors.black12, blurRadius: 6)
                ],
              ),
              child: Column(
                children: [
                  Row(children: [Icon(Icons.business), SizedBox(width: 10), Text(p["division"])]),
                  SizedBox(height: 10),
                  Row(children: [Icon(Icons.phone), SizedBox(width: 10), Text(p["phone"])]),
                  SizedBox(height: 10),
                  Row(children: [Icon(Icons.email), SizedBox(width: 10), Text(p["email"])]),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
