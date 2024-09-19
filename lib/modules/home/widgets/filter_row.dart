import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:montra_clone/modules/home/bloc/home_bloc.dart';
import 'package:montra_clone/modules/home/widgets/TextWidget.dart';

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
      margin: const EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 10),
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
                // onTap: () => context
                //     .read<HomeBloc>()
                //     .add(const SetFilterEvent(filterName: 'Today')),
                onTap: () {
                  final date = DateTime.parse('9/18/2024');
                  print('date : $date');
                  Timestamp timestamp = Timestamp.fromDate(date);
                  print('timestamp : $timestamp');
                },
                isSelected: state.filterName == 'Today',
              ),
              TextWidget(
                label: 'Week',
                onTap: () => context
                    .read<HomeBloc>()
                    .add(const SetFilterEvent(filterName: 'Week')),
                isSelected: state.filterName == 'Week',
              ),
              TextWidget(
                label: 'Month',
                onTap: () => context
                    .read<HomeBloc>()
                    .add(const SetFilterEvent(filterName: 'Month')),
                isSelected: state.filterName == 'Month',
              ),
              TextWidget(
                label: 'Year',
                onTap: () => context
                    .read<HomeBloc>()
                    .add(const SetFilterEvent(filterName: 'Year')),
                isSelected: state.filterName == 'Year',
              ),
            ],
          );
        },
      ),
    );
  }
}
