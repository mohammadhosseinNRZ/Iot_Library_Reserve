import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:remotea_pplication/cubit/chairscreen_cubit.dart';

class ChairScreen extends StatefulWidget {
  const ChairScreen({super.key});

  @override
  State<ChairScreen> createState() => _ChairScreenState();
}

class _ChairScreenState extends State<ChairScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple.shade600,
        elevation: 12,
        title: Text(
          "chairs",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.deepPurple.shade200.withOpacity(0.2),
      body: RefreshIndicator(
        onRefresh:(){
          context.read<ChairscreenCubit>().fetchcChairs();
          return Future.value(null);
        } ,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocBuilder<ChairscreenCubit, ChairscreenState>(
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
                itemCount: context.read<ChairscreenCubit>().chairs.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    borderRadius: BorderRadius.circular(16),
                    splashColor: Colors.deepPurple,
                    onTap: () {
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
                                      image: AssetImage("assets/chair" +
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
                                        .read<ChairscreenCubit>()
                                        .chairs[index]
                                        .title,
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  CircleAvatar(
                                    radius: 6,
                                    backgroundColor: context
                                                .read<ChairscreenCubit>()
                                                .chairs[index]
                                                .status ==
                                            1
                                        ? Colors.green
                                        : context
                                                    .read<ChairscreenCubit>()
                                                    .chairs[index]
                                                    .status ==
                                                2
                                            ? Colors.yellow
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
      ),
    );
  }
}
