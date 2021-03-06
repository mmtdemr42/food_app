import 'package:akademi_flutter_ders3/constants/constants.dart';
import 'package:akademi_flutter_ders3/ui/area/area_view_model.dart';
import 'package:akademi_flutter_ders3/widget/search_item.dart';
import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'area_view.dart';

class AreaView extends StatelessWidget {
  final String? area;

  const AreaView({Key? key, this.area}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AreaViewModel>.reactive(
        viewModelBuilder: () => AreaViewModel(),
        onModelReady: (model) => model.initialize(area),
        disposeViewModel: false,
        builder: (context, model, widget) => Scaffold(
              appBar: AppBar(
                title: Text(
                  "$area Food",
                  style: TextStyle(color: Constants.titleColor),
                ),
              ),
              body: model.isBusy
                  ? Center(child: CircularProgressIndicator())
                  : Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: model.mealList!.meals!.length,
                            padding: EdgeInsets.all(4),
                            itemBuilder: (context, index) {
                              return OpenContainer(
                                closedElevation: 0,
                                openElevation: 0,
                                closedColor: Colors.transparent,
                                openColor: Colors.transparent,
                                transitionType: ContainerTransitionType.fade,
                                transitionDuration: const Duration(milliseconds: 400),
                                openBuilder: (context, action) {
                                  return Container();
                                  // return DetailView(
                                  //   id: model.mealList!.meals![index].idMeal,
                                  //   name: model.mealList!.meals![index].strMeal,
                                  //   url: model
                                  //       .mealList!.meals![index].strMealThumb,
                                  // );
                                },
                                closedBuilder: (context, action) {
                                  return SearchListItem(
                                      name: model.mealList!.meals![index].strMeal,
                                      url: model.mealList!.meals![index].strMealThumb);
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
            ));
  }
}