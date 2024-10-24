
class Alim{
   final String? name;
   String id;
   String email;
   String password;
   String address;
   String qualification;
   String intitution;
   String phoneNumber;
   String? storeImage;
   String? storeDocument;
   String  country;
   String  state;
   String city;

  Alim({
    required this.name,
    required this.id,
    required this.email,
    required this.password,
    required this.address,
    required this.qualification,
    required this.intitution,
    required this.phoneNumber,
     this.storeImage,
     this.storeDocument,
    required this.country,
    required this.state,
    required this.city,

});
   Map<String, dynamic> toMap() {
     return {
       'id': id,
       'email': email,
       'password': password,
       'name': name,
       'address': address,
       'phoneNumber': phoneNumber,
       'qualification':qualification,
       'institution':intitution,

       'storeImage': storeImage,
       'storeDocument':storeDocument,
       'country': country,
       'state': state,
       'city':city,
     };
   }
   factory Alim.fromMap(Map<String, dynamic> map) {
     return Alim(
       id: map['id'],
       email: map['email'],
       password: map['password'],
       name: map['name'],
       address: map['address'],
       phoneNumber: map['phoneNumber'],
       qualification: map['qualification'],
       intitution: map['intitution'],
       storeImage: map['storeImage'],
       storeDocument: map['storeDocument'],
       country: map['country'],
       state: map['state'],
       city: map['city'],
     );
   }
}
