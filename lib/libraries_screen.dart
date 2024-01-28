import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:remotea_pplication/chaires_screen.dart';
import 'package:remotea_pplication/cubit/chairscreen_cubit.dart' as chair;
import 'package:remotea_pplication/cubit/libraryscreen_cubit.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LibrariesScreen extends StatefulWidget {
  const LibrariesScreen({super.key});

  @override
  State<LibrariesScreen> createState() => _LibrariesScreenState();
}

class _LibrariesScreenState extends State<LibrariesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple.shade600,
        elevation: 12,
        title: Text(
          "Libraries",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.deepPurple.shade200.withOpacity(0.2),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<LibraryscreenCubit, LibraryscreenState>(
          builder: (context, state) {
            // return Scaffold(body: ,)
            if (state is Loading) {
              return Center(
                child: LoadingAnimationWidget.newtonCradle(
                  color: Colors.purple,
                  size: 200,
                ),
              );
            }
            if (state is Error) {
              return Center(
                child: ElevatedButton(
                  child: Text(state.error),
                  onPressed: () => state.onCall(),
                ),
              );
            }
            return GridView.builder(
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemCount: context.read<LibraryscreenCubit>().list.length,
              itemBuilder: (context, index) {
                return InkWell(
                  borderRadius: BorderRadius.circular(16),
                  splashColor: Colors.deepPurple,
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context2) => BlocProvider(
                          create: (context2) => chair.ChairscreenCubit(
                              librariId: context
                                  .read<LibraryscreenCubit>()
                                  .list[index]
                                  .id),
                          child: ChairScreen()),
                    ));
                    // print("hello");
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.grey.shade300),

                      // boxShadow: [BoxShadow(color: Colors.grey.shade100,blurRadius: 1,spreadRadius: 5)]
                    ),
                    // color: Colors.blue,
                    // margin: const EdgeInsets.all(10),
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 6,
                          child: Container(
                            width: double.infinity,
                            height: double.infinity,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage("assets/library" +
                                        (Random().nextInt(4) + 1).toString() +
                                        ".jpg"),
                                    fit: BoxFit.cover),
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(16),
                                    topRight: Radius.circular(16))),
                          ),
                        ),
                        Flexible(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  context
                                      .read<LibraryscreenCubit>()
                                      .list[index]
                                      .title,
                                  style: TextStyle(fontSize: 16),
                                ),
                                CircleAvatar(
                                  radius: 6,
                                  backgroundColor: context
                                          .read<LibraryscreenCubit>()
                                          .list[index]
                                          .isOnline
                                      ? Colors.green
                                      : Colors.red,
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
              // crossAxisCount: 2,
              // children: List.generate(
              //   context.read<LibraryscreenCubit>().list.length,
              //   (index) {

              //   },
              // )
            );
          },
        ),
      ),
    );
  }
}
