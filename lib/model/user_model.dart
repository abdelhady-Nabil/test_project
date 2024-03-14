// class _SalesData {
//   _SalesData(this.year, this.sales);
//   final String year;
//   final double sales;
// }
class UserModel{

  late var userId,email, password,name,phone;


  UserModel({
    required this.userId,
    required this.email,
    required this.password,
    this.name,
    this.phone,
  });

  UserModel.fromJson(Map<dynamic,dynamic>map){
    if(map == null){
      return;
    }
    userId = map['userId'];  //map['userId'] data get from fire store

    email=map['emil'];
    password=map['password'];

    name=map['name'];
    phone=map['phone'];

  }


  //anther form
  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['num1'] = this.num1;
  //   data['num2'] = this.num2;
  //   return data;
  // }

  toMap(){
    return {
      'userId': userId,
      'emil' : email,
      'password':password,
      'name':name,
      'phone':phone,
    };
  }





}