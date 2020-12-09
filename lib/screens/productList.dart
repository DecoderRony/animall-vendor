import 'package:animall_vendor/models/dbUploads.dart';
import 'package:animall_vendor/models/productFetch.dart';
import 'package:animall_vendor/models/productModel.dart';
import 'package:animall_vendor/screens/landingscreen.dart';
import 'package:animall_vendor/screens/productDescription.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductList extends StatefulWidget {
  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  bool runOnce = true;
  @override
  void didChangeDependencies() {
    if (runOnce) {
      Provider.of<DatabaseFetch>(context).productFetch();
    }
    runOnce = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var useriD = FirebaseAuth.instance.currentUser.uid;
    List<dynamic> data = Provider.of<DatabaseFetch>(context).fetchedData;
    var userProducts = FirebaseFirestore.instance.collection('Categories/').doc(useriD).collection('products/');
    // return ListView.builder(
    //         itemCount: data.length,
    //         itemBuilder: (ctx, index){
    //            return Padding(
    //           padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
    //           child: Container(
    //             decoration: BoxDecoration(
    //               border: Border.all(width: 1),
    //               borderRadius: BorderRadius.circular(3),
    //             ),
    //             child: Column(
    //               children: [
    //                 Padding(
    //                   padding: const EdgeInsets.all(8.0),
    //                   child: ListTile(
    //                     leading: CircleAvatar(
    //                         backgroundImage: data[index].imageUrls.length <= 0
    //                             ? null
    //                             : NetworkImage(data[index].imageUrls[0])),
    //                     title: Text(data[index].productName),
    //                     subtitle: data[index].productDescription.toString().length >= 15
    //                         ? Text(
    //                             data[index].productDescription.toString().substring(0, 15))
    //                         : Text(data[index].productDescription),
    //                     trailing: Text('Rs.${data[index].price.toString()}'),
    //                   ),
    //                 ),
    //                 Row(
    //                   crossAxisAlignment: CrossAxisAlignment.start,
    //                   mainAxisAlignment: MainAxisAlignment.end,
    //                   children: [
    //                     IconButton(icon: Icon(Icons.edit), onPressed: () {
    //                       Provider.of<DatabaseFetch>(context,listen: false).findProduct(data[index].timestamp);
    //                       Navigator.of(context).pushNamed(LandingScreen().routeName, arguments: [true, data[index].timestamp]);
    //                     }),
    //                     IconButton(
    //                         icon: Icon(
    //                           Icons.delete,
    //                           color: Colors.red[800],
    //                         ),
    //                         onPressed: () {})
    //                   ],
    //                 )
    //               ],
    //             ),
    //           ),
    //         );
    //         }
    //     );
    return StreamBuilder<QuerySnapshot>(
      stream: userProducts.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        return ListView.builder(
            itemCount: snapshot.data.docs.length,
            itemBuilder: (ctx, i) {
              ProductModel tempData = ProductModel(
                productName: snapshot.data.docs[i].data()['productName'],
                productDescription: snapshot.data.docs[i].data()['productDesc'],
                price: snapshot.data.docs[i].data()['price'],
                imageUrls: snapshot.data.docs[i].data()['imagesUrl'],
              );
              return GestureDetector(
                onTap: () {
                  Provider.of<DatabaseFetch>(context)
                      .singleProductFetch(snapshot.data.docs[i].id);
                  Navigator.of(context).pushNamed(
                    Description().routeName,
                  );
                },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(width: 1),
                      borderRadius: BorderRadius.circular(3),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                height: 70,
                                width: 70,
                                child: snapshot.data.docs[i]
                                            .data()['imagesUrl']
                                            .length <=
                                        0
                                    ? null
                                    : FittedBox(
                                        fit: BoxFit.cover,
                                        child: Image.network(snapshot
                                            .data.docs[i]
                                            .data()['imagesUrl'][0]),
                                      ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8),
                                child: 
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          snapshot.data.docs[i]
                                              .data()['productName'],
                                          style: TextStyle(fontSize: 18),
                                        ),
                                        snapshot.data.docs[i]
                                                    .data()['productDesc']
                                                    .toString()
                                                    .length >=
                                                15
                                            ? Text(snapshot.data.docs[i]
                                                .data()['productDesc']
                                                .toString()
                                                .substring(0, 15))
                                            : Text(snapshot.data.docs[i]
                                                .data()['productDesc']),
                                      ],
                                    ),
                              ),
                                    Expanded(
                                                                          child: Text(
                                          'Rs.${snapshot.data.docs[i].data()['price'].toInt().toString()}',
                                          style: TextStyle(fontSize: 16),
                                          textAlign: TextAlign.end
                                        ),
                                    ),
                                  
                              
                              // Container(
                              //   child:  ListTile(
                              //   title: Text(snapshot.data.docs[i].data()['productName']),
                              //   subtitle: snapshot.data.docs[i].data()['productDesc'].toString().length >= 15
                              //       ? Text(
                              //           snapshot.data.docs[i].data()['productDesc'].toString().substring(0, 15))
                              //       : Text(snapshot.data.docs[i].data()['productDesc']),
                              //   trailing: Text('Rs.${snapshot.data.docs[i].data()['price'].toString()}'),
                              // ),
                              // ),
                            ],
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: () {
                                  Provider.of<DatabaseFetch>(context,
                                          listen: false)
                                      .getId(
                                          tempData, snapshot.data.docs[i].id);

                                  Navigator.of(context).pushNamed(
                                      LandingScreen().routeName,
                                      arguments: true);
                                  print("DOC ID");
                                  print(snapshot.data.docs[i].id);
                                }),
                            IconButton(
                                icon: Icon(
                                  Icons.delete,
                                  color: Colors.red[800],
                                ),
                                onPressed: () {
                                  FirebaseUploads()
                                      .deleteProduct(snapshot.data.docs[i].id);
                                })
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              );
            });
      },
    );
  }
}
