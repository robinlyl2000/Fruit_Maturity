import 'package:pineapple_demo1/model/imageSaving.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService{

  final String userid;
  final String imageID;
  DatabaseService({this.userid, this.imageID});

  // collection reference
  final CollectionReference userCollection = FirebaseFirestore.instance.collection('users');



  Future updateUserData(String name) async {
    return await userCollection.doc(userid).set({'name' : name});
  }

  Future updateImageData(Imagesaving save) async{
    return await userCollection.doc(userid).collection('image').doc(imageID).set({
      'url' : save.url,
      'time' : Timestamp.now(),
      'ratio' : save.ratio,
      'comment' : save.comment,
      'username' : save.username,
      'userid' : this.userid,
    });
  }

  Future deleteImageData() async{
    return await userCollection.doc(userid).collection('image').doc(imageID).delete().whenComplete((){
      print('Image Deleted');
    });
  }

  Future<String> getusername(String userid) async {
    DocumentReference documentReference = userCollection.doc(userid);
    String specie;
    await documentReference.get().then((snapshot) {
      specie = snapshot.data()['name'].toString();
    });
    return specie;
  }
  
  // images list from snapshot
  List<Imagesaving> _imageListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.docs.map((doc){
      return Imagesaving(
        userid: doc.data()['userid'] ?? 'Error',
        comment: doc.data()['comment'] ?? '(尚無評論)',
        ratio: doc.data()['ratio'] ?? 0,
        time: "${doc.data()['time'].toDate().year.toString()}/${doc.data()['time'].toDate().month.toString().padLeft(2,'0')}/${doc.data()['time'].toDate().day.toString().padLeft(2,'0')}   ${doc.data()['time'].toDate().hour.toString().padLeft(2,'0')}:${doc.data()['time'].toDate().minute.toString().padLeft(2,'0')}:${doc.data()['time'].toDate().second.toString().padLeft(2,'0')}" ?? 'No time(??)',
        url: doc.data()['url'] ?? null,
        username: doc.data()['username'] ?? 'Unknown',
        imageID : doc.id,
      );
    }).toList();
  }

  // self : get images stream
  Stream<List<Imagesaving>> get selfimages {
    final CollectionReference imageCollection = FirebaseFirestore.instance.collection('users').doc(userid).collection('image');
    return imageCollection.snapshots().map(_imageListFromSnapshot);
  }

  // all : get images stream
  Stream<List<Imagesaving>> get allimages {
    var q = FirebaseFirestore.instance.collectionGroup('image').orderBy("ratio").startAt(["0"]).endAt(["30"]);
    return q.get().then(_imageListFromSnapshot).asStream();
  }
}