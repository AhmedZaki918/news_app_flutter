import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/features/source/logic/source_cubit.dart';
import 'package:news_app/features/source/logic/source_state.dart';

import '../../../../core/components/clickable_icon.dart';
import '../../../../res/colors.dart';

class SourceScreen extends StatelessWidget {
  const SourceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SourceCubit, SourceState>(
        builder: (context, state){
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
                'Source',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 18.0,
                  fontFamily: 'LibreBaskerville',
                ),
              ),
            ),
            body: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, top: 16.0, right: 16.0),
                  child: Text(
                    'Your choice determines the source of the news you want in search screen.',
                    style: TextStyle(color: Colors.white70, fontSize: 16.0),
                  ),
                ),
                SizedBox(height: 16.0),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: state.source.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        state.source[index],
                        style: TextStyle(color: Colors.white),
                      ),
                      leading: Radio<String>(
                        activeColor: Colors.white,
                        value: state.source[index],
                        groupValue: state.selectedSource,
                        onChanged: (value) {
                          context.read<SourceCubit>().saveSelectedSource(value.toString());
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        }
    );
  }
}
