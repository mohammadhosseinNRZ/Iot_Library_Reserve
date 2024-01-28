import 'package:remotea_pplication/user_model.dart';

class Utils {
  Utils._();
  static bool isLoggedIn = false;
  static late DateTime lastLoginDate;
  static String baseUrl = "http://192.168.126.163:8080";
  static String loginApi = "$baseUrl/api/user/login";
  static String registerApi = "$baseUrl/api/user/register";
  static String insertApi = "$baseUrl/api/libraryinsert";
  static String getLibraryApi = "$baseUrl/api/library/get-library";
  static String getLibraryAllApi = "$baseUrl/api/library/get-all";
   static String getChairs = "$baseUrl/api/library/get";
  
   static late User userModel;
  // static late Box infoBox;
  // static String? refreshToken = "9Xstumy5uhw2TOSDI2qHXvqVRYMdbC";
  // static String? accessToken = "Z4ZDvIuVJbRXpeFJfhjJ8oZMrLlFfQ";
  // static User? user;
  // static Auth? auth;
  // static final MyLocalization _myLocalizatkion = MyLocalization();
  // static MyLocalizationDelegate myLocalizationDelegate = MyLocalizationDelegate(_myLocalization);
}
// sepidar_1     | [GIN-debug] POST   /api/user/register        --> github.com/Amir1848/samrt-library/routes/users.AddRoutes.registerUserFunc.func2 (3 handlers)
// sepidar_1     | [GIN-debug] POST   /api/user/login           --> github.com/Amir1848/samrt-library/routes/users.AddRoutes.func1 (3 handlers)
// sepidar_1     | [GIN-debug] POST   /api/user/register-library-admin --> github.com/Amir1848/samrt-library/routes/users.AddRoutes.registerUserFunc.func4 (4 handlers)
// sepidar_1     | [GIN-debug] POST   /api/library/insert       --> github.com/Amir1848/samrt-library/routes/library.AddRoutes.func1 (4 handlers)
// sepidar_1     | [GIN-debug] GET    /api/library/get-library  --> github.com/Amir1848/samrt-library/routes/library.AddRoutes.func2 (4 handlers)
// sepidar_1     | [GIN-debug] GET    /api/library/get-all      --> github.com/Amir1848/samrt-library/routes/library.AddRoutes.func3 (3 handlers)
// sepidar_1     | [GIN-debug] GET    /api/library/get          --> github.com/Amir1848/samrt-library/routes/library.AddRoutes.func4 (3 handlers)
// panel library man ham baiad bezani /api/library/get-library 
// get-all  hame library haro mide bara student
// /api/library/get  ba id ke az get-all migir mitooni chair begiri