import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:socialapp/Bloc/Home_Bloc/home_cubit.dart';

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
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('posts')
                    .orderBy('dateTime', descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  var docs = snapshot.data?.docs;
                  return docs != null && docs.isNotEmpty
                      ? ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Card(
                              elevation: 10,
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              margin: const EdgeInsets.symmetric(horizontal: 8),
                              child: Padding(
                                padding: EdgeInsets.all(8.0.w),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          CircleAvatar(
                                            radius: 25.r,
                                            backgroundImage: NetworkImage(
                                                docs[index]['userImage']),
                                          ),
                                          SizedBox(
                                            width: 10.w,
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  docs[index]['userName'],
                                                  style: TextStyle(
                                                      height: 1.1.h,
                                                      fontSize: 17.sp,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                Text(
                                                  docs[index]['dateTime'],
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodySmall
                                                      ?.copyWith(height: 1.1.h),
                                                )
                                              ],
                                            ),
                                          ),
                                          IconButton(
                                              onPressed: () {},
                                              icon: const Icon(
                                                  FontAwesomeIcons.ellipsis))
                                        ],
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Divider(
                                          thickness: 2,
                                        ),
                                      ),
                                      Text(
                                        docs[index]['text'],
                                        style: TextStyle(
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.w500,
                                            height: 1.15.h),
                                      ),
                                      Wrap(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsetsDirectional
                                                .only(end: 5.0),
                                            child: InkWell(
                                              onTap: () {},
                                              child: Text(
                                                "#Software_developer",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall
                                                    ?.copyWith(
                                                      color: Colors.blue,
                                                      fontSize: 13.sp,
                                                    ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsetsDirectional
                                                .only(end: 5.0),
                                            child: InkWell(
                                              onTap: () {},
                                              child: Text(
                                                "#Made_my_day",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall
                                                    ?.copyWith(
                                                      color: Colors.blue,
                                                      fontSize: 13.sp,
                                                    ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsetsDirectional
                                                .only(end: 5.0),
                                            child: InkWell(
                                              onTap: () {},
                                              child: Text(
                                                "#Software_developer",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall
                                                    ?.copyWith(
                                                      color: Colors.blue,
                                                      fontSize: 13.sp,
                                                    ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsetsDirectional
                                                .only(end: 5.0),
                                            child: InkWell(
                                              onTap: () {},
                                              child: Text(
                                                "#Software_developer",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall
                                                    ?.copyWith(
                                                      color: Colors.blue,
                                                      fontSize: 13.sp,
                                                    ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsetsDirectional
                                                .only(end: 5.0),
                                            child: InkWell(
                                              onTap: () {},
                                              child: Text(
                                                "#Software_developer",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall
                                                    ?.copyWith(
                                                      color: Colors.blue,
                                                      fontSize: 13.sp,
                                                    ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsetsDirectional
                                                .only(end: 5.0),
                                            child: InkWell(
                                              onTap: () {},
                                              child: Text(
                                                "#Hello_world",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall
                                                    ?.copyWith(
                                                      color: Colors.blue,
                                                      fontSize: 13.sp,
                                                    ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsetsDirectional
                                                .only(end: 5.0),
                                            child: InkWell(
                                              onTap: () {},
                                              child: Text(
                                                "#IG",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall
                                                    ?.copyWith(
                                                      color: Colors.blue,
                                                      fontSize: 13.sp,
                                                    ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      if (docs[index]['postImage'] != '')
                                        Image.network(
                                            fit: BoxFit.cover,
                                            height: 200.h,
                                            width: double.infinity,
                                            "${docs[index]['postImage']}"),
                                      const Divider(
                                        thickness: 2,
                                      ),
                                      Row(
                                        children: [
                                          InkWell(
                                            onTap: () {},
                                            child: Row(
                                              children: [
                                                Icon(FontAwesomeIcons.heart,
                                                    size: 18.r),
                                                SizedBox(width: 7.w),
                                                const Text("1000"),
                                              ],
                                            ),
                                          ),
                                          const Spacer(),
                                          InkWell(
                                            onTap: () {},
                                            child: Row(
                                              children: [
                                                Icon(FontAwesomeIcons.comments,
                                                    size: 18.r),
                                                SizedBox(width: 7.w),
                                                const Text("1000"),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      const Divider(
                                        thickness: 2,
                                      ),
                                      Row(
                                        children: [
                                          CircleAvatar(
                                            radius: 17.r,
                                            backgroundImage: NetworkImage(
                                                homeCubit.userModel!.image),
                                          ),
                                          SizedBox(
                                            width: 3.w,
                                          ),
                                          const Text("Write Comment ..."),
                                          const Spacer(),
                                          InkWell(
                                            onTap: () {
                                              homeCubit
                                                  .likePost(docs[index].id);
                                            },
                                            child: Row(
                                              children: [
                                                Icon(FontAwesomeIcons.heart,
                                                    size: 18.r),
                                                SizedBox(width: 7.w),
                                                const Text("Likes"),
                                              ],
                                            ),
                                          ),
                                        ],
                                      )
                                    ]),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const Divider();
                          },
                          itemCount: docs.length)
                      : const Center(
                          child: CircularProgressIndicator(),
                        );
                },
              ),
              SizedBox(height: 6.h),
            ],
          ),
        );
      },
    );
  }
}
