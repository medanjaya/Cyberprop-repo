import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:cyberprop/agen/login.dart';
import 'package:cyberprop/agen/tambah_produk.dart';
import 'package:cyberprop/agen/edit_produk.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});
  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  String itemKey = '';
  bool itemDelete = false;

  late BannerAd bannerAd;
  bool isBannerReady = false;

  @override
  void initState() {
    super.initState();
    loadBannerAd();
  }

  void loadBannerAd() {
    bannerAd = BannerAd(
      size: AdSize.banner,
      adUnitId: "ca-app-pub-3940256099942544/6300978111",
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {
            isBannerReady = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          isBannerReady = false;
          bannerAd.dispose();
        },
      ),
      request: const AdRequest(),
    );
    bannerAd.load();
  }


  @override
  Widget build(BuildContext context) {
    final Map<String, String> languageChange = {
      'house': AppLocalizations.of(context)!.houseorshophouse,
      'condo': AppLocalizations.of(context)!.apartementorcondominium,
      'villa': AppLocalizations.of(context)!.villa,
      'office': AppLocalizations.of(context)!.office,
      'estate': AppLocalizations.of(context)!.estate,
    };

    final User? user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16.0
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 168, 86, 86),
        actions: [
          IconButton(
            onPressed: () async {
              user == null
              ? Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Login()
                ),
              )
              : await FirebaseAuth.instance.signOut().then(
                (value) {
                  setState(() {});
                }
              );
            },
            icon: Icon(
              user == null
              ? Icons.login
              : Icons.logout,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              AppLocalizations.of(context)!.itemlist,
              style: const TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 16.0,
              right: 12.0,
              ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: TextField(
                    onChanged: (value) {
                      itemKey = value;
                    },
                    decoration: const InputDecoration(
                      hintText: 'Search item by name' //TODO : l10n
                    ),
                  ),
                ),
                const SizedBox(width: 4.0),
                IconButton(
                  onPressed: () {
                    setState(() {});
                  },
                  icon: const Icon(
                    Icons.search,
                    size: 32.0,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    //TODO : tambah yang ajaib-ajaib disini
                  },
                  icon: const Icon(
                    Icons.filter_alt_outlined,
                    size: 32.0,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8.0),
          Expanded(
            child: StreamBuilder(
              stream: db.collection('property').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data != null) {
                  final filteredSnapshot = snapshot.data!.docs.where(
                    (e) =>
                      e.get('name').toString().toLowerCase()
                      .contains(
                        itemKey.toLowerCase(),
                      ),
                  )
                  .toList();

                  return ListView.builder(
                    itemCount: filteredSnapshot.length,
                    itemBuilder: (context, i) {
                      final item = filteredSnapshot[i];

                      return Container(
                        margin: const EdgeInsets.symmetric(
                          vertical: 8.0,
                          horizontal: 16.0,
                        ),
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 2.0,
                              blurRadius: 4.0,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: (i + 1) % 6 != 0 //TODO : atau nilainya mau dirandom aja?
                        ? Column(
                            children: [
                              Row(
                                children: [
                                  const SizedBox( //TODO : untuk map kalau jadi
                                    width: 128.0,
                                    height: 128.0,
                                    child: ColoredBox(
                                      color: Colors.black,
                                      child: Text(
                                        'tambahkan lokasi disini',
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8.0),
                                  Expanded(
                                    child: item.get('photo') != null
                                    ? Image.network(
                                        item.get('photo'),
                                        width: 128.0,
                                        height: 128.0,
                                        fit: BoxFit.fitWidth,
                                      )
                                    : const SizedBox(
                                        width: 128.0,
                                        height: 128.0,
                                        child: Image(
                                          image: AssetImage('assets/logo-new.png'),
                                        ),
                                      ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4.0),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item.get('name'),
                                        style: const TextStyle(
                                          color: Colors.black, //TODO : dry code kebawah, yang ada Colors.black nya
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        languageChange[item.get('type')]!,
                                        style: const TextStyle(color: Colors.black),
                                      ),
                                      Text(
                                        item.get('address'),
                                        style: const TextStyle(color: Colors.black),
                                      ),
                                      Text(
                                        item.get('size-length').toString(),
                                        style: const TextStyle(color: Colors.black),
                                      ),
                                      Text(
                                        item.get('size-width').toString(),
                                        style: const TextStyle(color: Colors.black),
                                      ),
                                      Text(
                                        item.get('price').toString(),
                                        style: const TextStyle(color: Colors.black),
                                      ),
                                    ],
                                  ),
                                  //TODO : conditional nya beda sendiri, perlu diubah?
                                  Column(
                                    children: user != null
                                    ? [
                                        IconButton(
                                          icon: const Icon(
                                            Icons.edit,
                                            color: Color.fromARGB(255, 168, 86, 86),
                                          ),
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => EditProduk(item: item),
                                              ),
                                            );
                                          },
                                        ),
                                        //TODO : belum jalan, mau diurus nanti
                                        IconButton(
                                          onPressed: () {
                                            itemDelete = true;
                                            ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                              SnackBar(
                                                //TODO : ubah ke 'This item will be deleted in 3 seconds'
                                                content: const Text('Choose an item to delete.'), //TODO : l10n
                                                duration: const Duration(seconds: 8),
                                                action: SnackBarAction(
                                                  label: 'Cancel',
                                                  onPressed: () {
                                                    ScaffoldMessenger.of(context)
                                                    .hideCurrentSnackBar();
                                                  }
                                                ),
                                              ),
                                            )
                                            .closed
                                            .then(
                                              (value) => itemDelete = false,
                                            );
                                          },
                                          icon: const Icon(
                                            Icons.delete,
                                            color: Color.fromARGB(255, 168, 86, 86),
                                          ),
                                        ),
                                      ]
                                    : [], //TODO : cek dis
                                  ),
                                ],
                              ),
                            ],
                          )
                        : SizedBox( //TODO : tambahkan AdMob disini
                            width: bannerAd.size.width.toDouble(),
                            height: bannerAd.size.height.toDouble(),
                            child: AdWidget(ad: bannerAd),
                          ),
                      );
                    },
                  );
                }
                else if (snapshot.hasError) {
                  return Center(
                    child: Text(AppLocalizations.of(context)!.dataerror),
                  );
                }
                else {
                  return const Center(
                    child: CircularProgressIndicator()
                  );
                }
              }
            ),
          ),
        ],
      ),
      floatingActionButton: user != null
      ? FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const Tambah(),
            ),
          );
        },
        child: const Icon(Icons.add),
      )
      : null, //TODO : mencurigakan
    );
  }
}