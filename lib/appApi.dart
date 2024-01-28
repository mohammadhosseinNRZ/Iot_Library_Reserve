// import 'dart:async';
// import 'dart:io';

// import 'package:dio/dio.dart';
// import 'package:dio_smart_retry/dio_smart_retry.dart';
// import 'package:flutter/foundation.dart';

// import '../logic/model/error_model.dart';

// class AppApi {
//   static final AppApi _instance = AppApi._internal();

//   AppApi._internal();

//   static AppApi get instance => _instance;

//   final _dio = Dio(
//     BaseOptions(
//       receiveTimeout: const Duration(seconds: 15),
//       sendTimeout: const Duration(seconds: 15),
//       connectTimeout: const Duration(seconds: 15),
//     ),
//   );

// //   void _onErrorCatch({required Exception e ,required Function(ErrorModel error) onError,  }){
// //  onError!(ErrorModel(
// //               title: e.message ?? "unkown problem",
// //               errorStatus: ErrorStatus.server));
// // if(e is DioException)
// // {}
// // else if(e is TimeoutException){
// // }
// // else if(e is SocketException){}
// // else{
// // }
// //   }
//   Future<void> deleteApi(
//       {required String url,
//       Function(String response)? onSuccess,
//       Function(ErrorModel error)? onError,
//       Map<String, dynamic>? queryParameters,
//       Map<String, dynamic>? headers,
//       int retryNumber = 1}) async {
//     if (retryNumber > 1) {
//       List<Duration> retryDelays = [];

//       for (int i = 0; i < retryNumber; i++) {
//         retryDelays.add(Duration(seconds: i + 1));
//       }
//       _dio.interceptors.add(RetryInterceptor(
//         dio: _dio,
//         // logPrint: print, // specify log function (optional)
//         retries: retryNumber, // retry count (optional)
//         retryDelays: retryDelays,
//       ));
//     }

//     try {
//       Response response;

//       response = await _dio.delete(url,
//           options: Options(responseType: ResponseType.plain, headers: headers),
//           queryParameters: queryParameters);
//       if (kDebugMode) {
//         print("response api: ${response.data.toString()}");
//       }

//       if (response.statusCode == 200 || response.statusCode == 201) {
//         if (onSuccess != null) {
//           onSuccess(response.data.toString());
//         }
//       } else {
//         if (onError != null) {
//           onError(ErrorModel(title: "Server is unavailable!", errorStatus: ErrorStatus.server));
//         }
//       }
//     } on DioException catch (e) {
//       if (e.response != null) {
//         if (kDebugMode) {
//           onError!(ErrorModel(title: e.response!.data, errorStatus: ErrorStatus.server));
//           print(e.response!.data + "hi");
//           print("${e.response!.headers}hi2");
//           print("${e.response!.requestOptions}hi3");
//         }
//       } else {
//         if (kDebugMode) {
//           print(e.requestOptions);
//           print(e.message);
//         }
//         if (e.message != null && e.message!.contains("connection")) {
//           onError!(ErrorModel(title: "check your connection", errorStatus: ErrorStatus.server));
//         } else {
//           onError!(ErrorModel(title: e.message ?? "unkown problem", errorStatus: ErrorStatus.server));
//         }
//       }
//       // if (onError != null) {
//       //   onError(ErrorModel(title: "Server is unavailable!", errorStatus: ErrorStatus.server));
//       // }
//     } on TimeoutException {
//       if (onError != null) {
//         onError(ErrorModel(title: "Poor connection!", errorStatus: ErrorStatus.timeout));
//       }
//     } on SocketException {
//       if (onError != null) {
//         onError(ErrorModel(title: "No connection!, Check your connection!", errorStatus: ErrorStatus.socket));
//       }
//     } catch (e) {
//       if (onError != null) {
//         onError(ErrorModel(title: e.toString(), errorStatus: ErrorStatus.unknown));
//       }
//     }
//   }

//   Future<bool> loadNetworkImage({required List<Uint8List> data, required String url}) async {
//     Response response;
//     try {
//       response = await _dio.get<List<int>>(url, options: Options(responseType: ResponseType.bytes));
//       if (response.statusCode == 200 || response.statusCode == 201) {
//         data.clear();
//         data.add(response.data);
//         return true;
//       }
//       return false;
//     } catch (e) {
//       return false;
//     }
//   }

//   Future<void> getApi(
//       {required String url,
//       Function(String response)? onSuccess,
//       Function(ErrorModel error)? onError,
//       Map<String, dynamic>? queryParameters,
//       Map<String, dynamic>? headers,
//       int retryNumber = 1}) async {
//     if (retryNumber > 1) {
//       List<Duration> retryDelays = [];

//       for (int i = 0; i < retryNumber; i++) {
//         retryDelays.add(Duration(seconds: i + 1));
//       }

//       _dio.interceptors.add(RetryInterceptor(
//         dio: _dio,
//         // logPrint: print, // specify log function (optional)
//         retries: retryNumber, // retry count (optional)
//         retryDelays: retryDelays,
//       ));
//     }

//     try {
//       Response response;

//       response = await _dio.get(url,
//           options: Options(responseType: ResponseType.plain, headers: headers),
//           queryParameters: queryParameters);
//       if (kDebugMode) {
//         print("response api: ${response.data.toString()}");
//       }

//       if (response.statusCode == 200 || response.statusCode == 201) {
//         if (onSuccess != null) {
//           onSuccess(response.data.toString());
//         }
//       }
//       // else {
//       //   if (onError != null) {
//       //     onError(ErrorModel(title: "Server is unavailable!", errorStatus: ErrorStatus.server));
//       //   }
//       // }
//     } on DioException catch (e) {
//       if (e.response != null) {
//         onError!(ErrorModel(title: e.response!.data, errorStatus: ErrorStatus.server));
//         if (kDebugMode) {
//           print(e.response!.data + "hi");
//           print("${e.response!.headers}hi2");
//           print("${e.response!.requestOptions}hi3");
//         }
//       } else {
//         if (kDebugMode) {
//           print(e.requestOptions);
//           print(e.message);
//         }
//         if (e.message != null && e.message!.contains("connection")) {
//           onError!(ErrorModel(title: "check your connection", errorStatus: ErrorStatus.server));
//         } else {
//           onError!(ErrorModel(title: e.message ?? "unkown problem", errorStatus: ErrorStatus.server));
//         }
//       }

//       // if (onError != null) {
//       //   onError(ErrorModel(title: "Server is unavailable!", errorStatus: ErrorStatus.server));
//       // }
//     } on TimeoutException {
//       if (onError != null) {
//         onError(ErrorModel(title: "Poor connection!", errorStatus: ErrorStatus.timeout));
//       }
//     } on SocketException {
//       if (onError != null) {
//         onError(ErrorModel(title: "No connection!, Check your connection!", errorStatus: ErrorStatus.socket));
//       }
//     } catch (e) {
//       if (onError != null) {
//         onError(ErrorModel(title: e.toString(), errorStatus: ErrorStatus.unknown));
//       }
//     }
//   }

//   Future<void> postApi(
//       {required String url,
//       Map<String, dynamic>? header,
//       required Map<String, dynamic> body,
//       FormData? formData,
//       Map<String, dynamic>? queryParameters,
//       Function(dynamic response)? onSuccess,
//       Function(ErrorModel error)? onError,
//       ResponseType responseType = ResponseType.plain,
//       int retryNumber = 1}) async {
//     if (retryNumber > 1) {
//       List<Duration> retryDelays = [];

//       for (int i = 0; i < retryNumber; i++) {
//         retryDelays.add(Duration(seconds: i + 1));
//       }

//       _dio.interceptors.add(RetryInterceptor(
//         dio: _dio,
//         // logPrint: print, // specify log function (optional)
//         retries: retryNumber, // retry count (optional)
//         retryDelays: retryDelays,
//       ));
//     }

//     try {
//       Response response;
//       response = await _dio.post(url,
//           data: formData ?? body,
//           queryParameters: queryParameters,
//           options: Options(responseType: responseType, headers: header));
//       if (kDebugMode) {
//         print(response.data);
//       }

//       if (response.statusCode == 200 || response.statusCode == 201) {
//         if (onSuccess != null) {
//           onSuccess(response.data);
//         }
//       }
//       // else {
//       //   if (onError != null) {
//       //     onError(ErrorModel(title: "Server is unavailable!", errorStatus: ErrorStatus.server));
//       //   }
//       // }
//     } on DioException catch (e) {
//       if (e.response != null) {
//         if (kDebugMode) {
//           if (onError != null) {
//             print(e.response);
//             if (e.response!.data.toString().contains("500")) {
//               onError(ErrorModel(title: "server error", errorStatus: ErrorStatus.server));
//             } else {
//               onError(ErrorModel(title: e.response!.data, errorStatus: ErrorStatus.unknown));
//             }
//           }
//           print(e.response!.data);
//           print(e.response!.headers);
//           print(e.response!.requestOptions);
//         }
//       } else {
//         if (e.message != null && e.message!.contains("connection")) {
//           onError!(ErrorModel(title: "check your connection", errorStatus: ErrorStatus.server));
//         } else {
//           onError!(ErrorModel(title: e.message ?? "unkown problem", errorStatus: ErrorStatus.server));
//         }
//         if (kDebugMode) {
//           print(e.requestOptions);
//           print(e.message);
//         }
//       }
//       // if (onError != null) {
//       //   onError(ErrorModel(title: "Poor connection!", errorStatus: ErrorStatus.unknown));
//       // }
//     } on TimeoutException {
//       if (onError != null) {
//         onError(ErrorModel(title: "Poor connection!", errorStatus: ErrorStatus.timeout));
//       }
//     } on SocketException {
//       if (onError != null) {
//         onError(ErrorModel(title: "No connection!, Check your connection!", errorStatus: ErrorStatus.socket));
//       }
//     } catch (e) {
//       if (kDebugMode) {
//         print(e.toString());
//       }
//       if (onError != null) {
//         onError(ErrorModel(title: "Something wrong!", errorStatus: ErrorStatus.unknown));
//       }
//     }
//   }

//   Future<void> patchApi(
//       {required String url,
//       Map<String, dynamic>? header,
//       required Map<String, dynamic> body,
//       FormData? formData,
//       Function(dynamic response)? onSuccess,
//       Function(ErrorModel error)? onError,
//       ResponseType responseType = ResponseType.plain,
//       int retryNumber = 1}) async {
//     if (retryNumber > 1) {
//       List<Duration> retryDelays = [];

//       for (int i = 0; i < retryNumber; i++) {
//         retryDelays.add(Duration(seconds: i + 1));
//       }

//       _dio.interceptors.add(RetryInterceptor(
//         dio: _dio,
//         // logPrint: print, // specify log function (optional)
//         retries: retryNumber, // retry count (optional)
//         retryDelays: retryDelays,
//       ));
//     }

//     try {
//       Response response;
//       response = await _dio.patch(url,
//           data: formData ?? body, options: Options(responseType: responseType, headers: header));
//       if (kDebugMode) {
//         print(response.data);
//       }

//       if (response.statusCode == 200 || response.statusCode == 201) {
//         if (onSuccess != null) {
//           onSuccess(response.data);
//         }
//       }
//       // else {
//       //   if (onError != null) {
//       //     onError(ErrorModel(title: "Server is unavailable!", errorStatus: ErrorStatus.server));
//       //   }
//       // }
//     } on DioException catch (e) {
//       if (e.response != null) {
//         if (onError != null) {
//           if (e.message != null && e.message!.contains("connection")) {
//             onError!(ErrorModel(title: "check your connection", errorStatus: ErrorStatus.server));
//           } else {
//             onError!(ErrorModel(title: e.message ?? "unkown problem", errorStatus: ErrorStatus.server));
//           }
//           // if (e.response!.data.toString().contains("500")) {
//           //   onError(ErrorModel(title: "server error", errorStatus: ErrorStatus.server));
//           // } else {
//           //   onError(ErrorModel(title: e.response!.data, errorStatus: ErrorStatus.unknown));
//           // }
//         }
//         if (kDebugMode) {
//           print(e.response!.data);
//           print(e.response!.headers);
//           print(e.response!.requestOptions);
//         }
//       } else {
//         if (kDebugMode) {
//           print(e.requestOptions);
//           print(e.message);
//         }
//       }
//       // if (onError != null) {
//       //   onError(ErrorModel(title: "Poor connection!", errorStatus: ErrorStatus.unknown));
//       // }
//     } on TimeoutException {
//       if (onError != null) {
//         onError(ErrorModel(title: "Poor connection!", errorStatus: ErrorStatus.timeout));
//       }
//     } on SocketException {
//       if (onError != null) {
//         onError(ErrorModel(title: "No connection!, Check your connection!", errorStatus: ErrorStatus.socket));
//       }
//     } catch (e) {
//       if (kDebugMode) {
//         print(e.toString());
//       }
//       if (onError != null) {
//         onError(ErrorModel(title: "Something wrong!", errorStatus: ErrorStatus.unknown));
//       }
//     }
//   }
// }
