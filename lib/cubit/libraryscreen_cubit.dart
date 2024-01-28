import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:remotea_pplication/consts.dart';
import 'package:remotea_pplication/user_model.dart';
part 'libraryscreen_state.dart';

class LibraryscreenCubit extends Cubit<LibraryscreenState> {
  LibraryscreenCubit() : super(LibraryscreenInitial()) {
    fetchLibraries();
  }
  late List<Library> list;

  void fetchLibraries() async {
    emit(Loading());
    try {
      // Perform the network request
      final response = await http.get(
        Uri.parse(Utils.getLibraryAllApi),
        // body: jsonEncode({"studentCode": ""}),
        headers: {"Content-Type": "application/json"},
      );
      if (response.statusCode == 200) {
        list = LibraryList.fromJson(
                jsonDecode(response.body)["libraries"])
            .libraries;
        emit(Success());
        // print(decodedToken);
        // Handle successful response
        // return null;
      } else {
        emit(Error(
            error: response.body,
            onCall: () {
              fetchLibraries();
            }));
        // Handle server error and display appropriate message
        // return response.body??'An error occurred. Please try again later.';
      }
    } catch (e) {
      emit(Error(
          error: e.toString(),
          onCall: () {
            fetchLibraries();
          }));
      // Handle other errors, such as network issues
      // print('Error: $e');
      // return 'An error occurred. Please try again later.';
    }
  }
}

class Library {
  int id;
  String title;
  bool isOnline;

  Library({
    required this.id,
    required this.title,
    required this.isOnline,
  });

  factory Library.fromJson(Map<String, dynamic> json) {
    return Library(
      id: json['Id'],
      title: json['Title'],
      isOnline: json['IsOnline'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'Title': title,
      'IsOnline': isOnline,
    };
  }
}

class LibraryList {
  List<Library> libraries;

  LibraryList({required this.libraries});

  factory LibraryList.fromJson(List<dynamic> json) {
    return LibraryList(
      libraries: json.map((library) => Library.fromJson(library)).toList(),
    );
  }

  List<dynamic> toJson() {
    return libraries.map((library) => library.toJson()).toList();
  }
}
