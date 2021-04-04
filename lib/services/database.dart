import 'package:pineapple_demo3/model/imageSaving.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:core';

class DatabaseService{

  final String userid;
  final String imageID;
  DatabaseService({this.userid, this.imageID});

  // collection reference
  final CollectionReference userCollection = FirebaseFirestore.instance.collection('users');
  
  Future updateUserData(String name) async {
    return await userCollection.doc(userid).set({'name' : name});
  }

  Future updateImageData(Imagesaving save, bool _updatetime) async{
    return await userCollection.doc(userid).collection('image').doc(imageID).set({
      'url' : save.url,
      'time' : _updatetime == true ? Timestamp.now() : Timestamp.fromDate(DateTime.parse(save.time)),
      'ratio' : save.ratio,
      'comment' : save.comment,
      'username' : save.username,
      'userid' : this.userid,
      'likenum' : save.likenum,
      'tag' : save.tag ?? '其他'
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
  List<Imagesaving> _imageListFromSnapshot(QuerySnapshot snapshot, double start, double end){
    return snapshot.docs.map((doc){
      return Imagesaving(
        userid: doc.data()['userid'] ?? 'Error',
        comment: doc.data()['comment'] ?? '(尚無評論)',
        ratio: doc.data()['ratio'] ?? 0.0,
        time: "${doc.data()['time'].toDate().year.toString()}/${doc.data()['time'].toDate().month.toString().padLeft(2,'0')}/${doc.data()['time'].toDate().day.toString().padLeft(2,'0')}   ${doc.data()['time'].toDate().hour.toString().padLeft(2,'0')}:${doc.data()['time'].toDate().minute.toString().padLeft(2,'0')}:${doc.data()['time'].toDate().second.toString().padLeft(2,'0')}" ?? 'No time(??)',
        url: doc.data()['url'] ?? null,
        username: doc.data()['username'] ?? 'Unknown',
        imageID : doc.id,
        likenum: doc.data()['likenum'] ?? 0,
        tag: doc.data()['tag'] ?? '其他',
      );
    }).where((element){
      if(element.ratio >= start && element.ratio <= end){
        return true;
      }else{
        return false;
      }
    }
    ).toList();
  }

  // self : get images stream
  Stream<List<Imagesaving>> selfimages(String status, int start, int end) {
    if(status == '由舊到新'){
      var q = FirebaseFirestore.instance.collection('users').doc(userid).collection('image').orderBy("time", descending: false);
      return q.get().then((QuerySnapshot snapshot){
        return _imageListFromSnapshot(snapshot, (start - 1) * 16.67 , end * 16.67);
      }).asStream();
    }else if(status == '由新到舊'){
      var q = FirebaseFirestore.instance.collection('users').doc(userid).collection('image').orderBy("time", descending: true);
      return q.get().then((QuerySnapshot snapshot){
        return _imageListFromSnapshot(snapshot,  (start - 1) * 16.67 , end * 16.67);
      }).asStream();
    }else if(status == "熱門度"){
      var q = FirebaseFirestore.instance.collection('users').doc(userid).collection('image').orderBy("likenum", descending: true);
      return q.get().then((QuerySnapshot snapshot){
        return _imageListFromSnapshot(snapshot,  (start - 1) * 16.67 , end * 16.67);
      }).asStream();
    }
    return null;
  }


  // all : get images stream
  Stream<List<Imagesaving>> allimages(String status, int start, int end) {
    if(status == '由舊到新'){
      var q = FirebaseFirestore.instance.collectionGroup('image').orderBy("time", descending: false);
      return q.get().then((QuerySnapshot snapshot){
        return _imageListFromSnapshot(snapshot, (start - 1) * 16.67 , end * 16.67);
      }).asStream();
    }else if(status == '由新到舊'){
      var q = FirebaseFirestore.instance.collectionGroup('image').orderBy("time", descending: true);
      return q.get().then((QuerySnapshot snapshot){
        return _imageListFromSnapshot(snapshot,  (start - 1) * 16.67 , end * 16.67);
      }).asStream();
    }else if(status == "熱門度"){
      var q = FirebaseFirestore.instance.collectionGroup('image').orderBy("likenum", descending: true);
      return q.get().then((QuerySnapshot snapshot){
        return _imageListFromSnapshot(snapshot,  (start - 1) * 16.67 , end * 16.67);
      }).asStream();
    }
    return null;
  }

  Future updateLikeImage(Imagesaving save) async{
    return await userCollection.doc(userid).collection("likes").doc(save.imageID).set({});
  }

  Future deleteLikeImage(Imagesaving save) async{
    return await userCollection.doc(userid).collection("likes").doc(save.imageID).delete().whenComplete((){
      print("Delete Image Like");
    });
  }

  Future<bool> checkLikeImage(Imagesaving save) async{
    List<String> list = [];
    await userCollection.doc(userid).collection("likes").get().then((value){
      value.docs.forEach((doc) {
        list.add(doc.id);
      });
    });
    if(list.contains(save.imageID)){
      return true;
    }else{
      return false;
    }
  }

}