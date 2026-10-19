import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/features/category/logic/category_cubit.dart';
import 'package:news_app/features/category/logic/category_state.dart';
import 'package:news_app/res/colors.dart';
import 'package:news_app/util/app_constants.dart';

import '../../../core/components/clickable_icon.dart';
import '../../../util/source.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryCubit, CategoryState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: background,
          appBar: AppBar(
            centerTitle: true,
            leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                padding: EdgeInsets.only(right: 16.0, bottom: 16.0),
                color: Colors.transparent,
                child: CustomIcon(
                  icon: Icons.arrow_back_ios,
                  padding: EdgeInsets.only(left: 24.0, top: 16.0),
                  onIconPressed: () {
                    context.pop();
                  },
                  iconColor: Colors.white,
                ),
              ),
            ),
            backgroundColor: background,
            title: Text(
              'Category',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 18.0,
                fontFamily: 'LibreBaskerville',
              ),
            ),
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 16.0,
                  top: 16.0,
                  right: 16.0,
                ),
                child: Text(
                  'Your choice determines the category type you want to filter in search screen.',
                  style: TextStyle(color: Colors.white70, fontSize: 16.0),
                ),
              ),
              SizedBox(height: 16.0),

              CategoryItem(AppConstants.general, state.selectedCategory, (
                value,
              ) {
                context.read<CategoryCubit>().savePreference(
                  value.toString(),
                  generalDomains().first,
                );
              }),

              CategoryItem(AppConstants.business, state.selectedCategory, (
                value,
              ) {
                context.read<CategoryCubit>().savePreference(
                  value.toString(),
                  businessDomains().first,
                );
              }),

              CategoryItem(AppConstants.tech, state.selectedCategory, (value) {
                context.read<CategoryCubit>().savePreference(
                  value.toString(),
                  techDomains().first,
                );
              }),

              CategoryItem(AppConstants.sports, state.selectedCategory, (
                value,
              ) {
                context.read<CategoryCubit>().savePreference(
                  value.toString(),
                  sportsDomains().first,
                );
              }),
            ],
          ),
        );
      },
    );
  }
}

class CategoryItem extends StatelessWidget {
  const CategoryItem(
    this.title,
    this.selectedCategory,
    this.onChanged, {
    super.key,
  });

  final String title;
  final String? selectedCategory;
  final Function(String?) onChanged;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title, style: TextStyle(color: Colors.white)),
      leading: Radio<String>(
        activeColor: Colors.white,
        value: title,
        groupValue: selectedCategory,
        onChanged: (value) {
          onChanged(value);
        },
      ),
    );
  }
}
