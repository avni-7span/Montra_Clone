import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:montra_clone/modules/home/bloc/home_bloc.dart';
import 'package:montra_clone/modules/home/widgets/text_widget.dart';

class FilterRow extends StatelessWidget implements AutoRouteWrapper {
  const FilterRow({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(),
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8, top: 8),
      padding: const EdgeInsets.only(left: 8, right: 8),
      height: 40,
      width: double.infinity,
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextWidget(
                label: 'Today',
                onTap: () {
                  context
                      .read<HomeBloc>()
                      .add(const SetFilterEvent(filterName: 'Today'));
                  context.read<HomeBloc>().add(const FetchDataOfCurrentDay());
                },
                isSelected: state.filterName == 'Today',
              ),
              TextWidget(
                label: 'Week',
                onTap: () {
                  context
                      .read<HomeBloc>()
                      .add(const SetFilterEvent(filterName: 'Week'));
                  context.read<HomeBloc>().add(const FetchDataByWeek());
                },
                isSelected: state.filterName == 'Week',
              ),
              TextWidget(
                label: 'Month',
                onTap: () {
                  context
                      .read<HomeBloc>()
                      .add(const SetFilterEvent(filterName: 'Month'));
                  context.read<HomeBloc>().add(const FetchDataByMonth());
                },
                isSelected: state.filterName == 'Month',
              ),
              TextWidget(
                label: 'Year',
                onTap: () {
                  context
                      .read<HomeBloc>()
                      .add(const SetFilterEvent(filterName: 'Year'));
                  context.read<HomeBloc>().add(const FetchDataByYear());
                },
                isSelected: state.filterName == 'Year',
              ),
            ],
          );
        },
      ),
    );
  }
}
