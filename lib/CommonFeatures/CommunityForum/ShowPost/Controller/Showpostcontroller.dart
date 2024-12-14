import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../Model/ShowPostModel.dart';

class ShowPostController extends GetxController {
  final _postList = RxList<Post>([]);

  List<Post> get posts => _postList.value;

  final _collectionReference = FirebaseFirestore.instance.collection("post");

  get user => FirebaseAuth.instance.currentUser;

  @override
  void onInit() {
    super.onInit();
    _postList.bindStream(getPosts());
  }

  Stream<List<Post>> getPosts() {
    return _collectionReference
        .orderBy("time", descending: true)
        .snapshots()
        .map((QuerySnapshot querySnapshot) {
      List<Post> list = [];
      for (var element in querySnapshot.docs) {
        list.add(Post.fromDocumentSnapshot(element));
      }
      return list;
    });
  }
  Future<void> setLike(String postId) async{
    DocumentSnapshot doc = await FirebaseFirestore.instance.collection("post").doc(postId).get();

    // if it contains current user id then
    if ((doc.data()! as dynamic)['likes'].contains(user.uid)) {

      // true --> remove id
      await _collectionReference
          .doc(postId)
          .update({
        "likes": FieldValue.arrayRemove([user.uid]),
      })
          .catchError((e){
        throw Exception("Something went wrong");
      });

    } else {

      await _collectionReference
          .doc(postId)
          .update({
        "likes": FieldValue.arrayUnion([user.uid]),
      })
          .catchError((e){
        throw Exception("Something went wrong");
      });

    }
  }
}

