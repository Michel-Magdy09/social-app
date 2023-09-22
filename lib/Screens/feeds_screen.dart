import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:socialapp/Bloc/Home_Bloc/home_cubit.dart';
import 'package:socialapp/Constants/components.dart';

class FeedsScreen extends StatelessWidget {
  const FeedsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        var homeCubit = HomeCubit.get(context);
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Card(
                margin: const EdgeInsets.all(8),
                elevation: 10,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Image.network(
                        fit: BoxFit.cover,
                        height: 200.h,
                        width: double.infinity,
                        "https://img.freepik.com/free-photo/happy-mixed-race-woman-has-cheerful-expression-points-away-with-both-fore-fingers-says-follow-there-shows-direction-copy-space-wears-denim-clothes-white-hijab-isolated-purple-wall_273609-26320.jpg?w=1380&t=st=1694697732~exp=1694698332~hmac=c50a0301c2dbdff7b1d73ae8cd7760cdcde6fb484c61132aaf5ad802422079ab"),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        "Communicate with friends",
                        style: TextStyle(
                            fontSize: 15.sp, fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ),
              ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    print(homeCubit.postsList.length);
                    return PostItem(
                      model: homeCubit.postsList[index],
                      index: index,
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const Divider();
                  },
                  itemCount: homeCubit.postsList.length),
              SizedBox(height: 6.h),
            ],
          ),
        );
      },
    );
  }
}
