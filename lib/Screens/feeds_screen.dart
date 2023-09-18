import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FeedsScreen extends StatelessWidget {
  const FeedsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [
          Card(
            margin: EdgeInsets.all(8),
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
                  padding: EdgeInsets.all(10),
                  child: Text(
                    "Communicate with friends",
                    style:
                        TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ),
          ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Card(
                  elevation: 10,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  margin: EdgeInsets.symmetric(horizontal: 8),
                  child: Padding(
                    padding: EdgeInsets.all(8.0.w),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 25.r,
                                backgroundImage: const NetworkImage(
                                    "https://img.freepik.com/free-photo/happy-attractive-woman-dancing-having-fun-raising-hands-up-carefree-enjoying-music-standing-against-white-wall_176420-38816.jpg?w=1380&t=st=1694698504~exp=1694699104~hmac=3da34ab33024edfc22197bd985ad713e15bdea4af3e4c30fc53a32502a5a1414"),
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Michel Magdy",
                                      style: TextStyle(
                                          height: 1.1.h,
                                          fontSize: 17.sp,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      "January 21, 2023 at 11:00PM",
                                      style: Theme.of(context)
                                          .textTheme
                                          .caption
                                          ?.copyWith(height: 1.1.h),
                                    )
                                  ],
                                ),
                              ),
                              IconButton(
                                  onPressed: () {},
                                  icon: Icon(FontAwesomeIcons.ellipsis))
                            ],
                          ),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Divider(
                              thickness: 2,
                            ),
                          ),
                          Text(
                            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
                            style: TextStyle(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w500,
                                height: 1.15.h),
                          ),
                          Wrap(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsetsDirectional.only(end: 5.0),
                                child: InkWell(
                                  onTap: () {},
                                  child: Text(
                                    "#Software_developer",
                                    style: Theme.of(context)
                                        .textTheme
                                        .caption
                                        ?.copyWith(
                                          color: Colors.blue,
                                          fontSize: 13.sp,
                                        ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsetsDirectional.only(end: 5.0),
                                child: InkWell(
                                  onTap: () {},
                                  child: Text(
                                    "#Made_my_day",
                                    style: Theme.of(context)
                                        .textTheme
                                        .caption
                                        ?.copyWith(
                                          color: Colors.blue,
                                          fontSize: 13.sp,
                                        ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsetsDirectional.only(end: 5.0),
                                child: InkWell(
                                  onTap: () {},
                                  child: Text(
                                    "#Software_developer",
                                    style: Theme.of(context)
                                        .textTheme
                                        .caption
                                        ?.copyWith(
                                          color: Colors.blue,
                                          fontSize: 13.sp,
                                        ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsetsDirectional.only(end: 5.0),
                                child: InkWell(
                                  onTap: () {},
                                  child: Text(
                                    "#Software_developer",
                                    style: Theme.of(context)
                                        .textTheme
                                        .caption
                                        ?.copyWith(
                                          color: Colors.blue,
                                          fontSize: 13.sp,
                                        ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsetsDirectional.only(end: 5.0),
                                child: InkWell(
                                  onTap: () {},
                                  child: Text(
                                    "#Software_developer",
                                    style: Theme.of(context)
                                        .textTheme
                                        .caption
                                        ?.copyWith(
                                          color: Colors.blue,
                                          fontSize: 13.sp,
                                        ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsetsDirectional.only(end: 5.0),
                                child: InkWell(
                                  onTap: () {},
                                  child: Text(
                                    "#Hello_world",
                                    style: Theme.of(context)
                                        .textTheme
                                        .caption
                                        ?.copyWith(
                                          color: Colors.blue,
                                          fontSize: 13.sp,
                                        ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsetsDirectional.only(end: 5.0),
                                child: InkWell(
                                  onTap: () {},
                                  child: Text(
                                    "#IG",
                                    style: Theme.of(context)
                                        .textTheme
                                        .caption
                                        ?.copyWith(
                                          color: Colors.blue,
                                          fontSize: 13.sp,
                                        ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Image.network(
                              fit: BoxFit.cover,
                              height: 200.h,
                              width: double.infinity,
                              "https://img.freepik.com/free-photo/happy-mixed-race-woman-has-cheerful-expression-points-away-with-both-fore-fingers-says-follow-there-shows-direction-copy-space-wears-denim-clothes-white-hijab-isolated-purple-wall_273609-26320.jpg?w=1380&t=st=1694697732~exp=1694698332~hmac=c50a0301c2dbdff7b1d73ae8cd7760cdcde6fb484c61132aaf5ad802422079ab"),
                          const Divider(
                            thickness: 2,
                          ),
                          Row(
                            children: [
                              InkWell(
                                onTap: () {},
                                child: Row(
                                  children: [
                                    Icon(FontAwesomeIcons.heart, size: 18.r),
                                    SizedBox(width: 7.w),
                                    Text("1000"),
                                  ],
                                ),
                              ),
                              const Spacer(),
                              InkWell(
                                onTap: () {},
                                child: Row(
                                  children: [
                                    Icon(FontAwesomeIcons.comments, size: 18.r),
                                    SizedBox(width: 7.w),
                                    Text("1000"),
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
                                backgroundImage: const NetworkImage(
                                    "https://img.freepik.com/free-photo/happy-attractive-woman-dancing-having-fun-raising-hands-up-carefree-enjoying-music-standing-against-white-wall_176420-38816.jpg?w=1380&t=st=1694698504~exp=1694699104~hmac=3da34ab33024edfc22197bd985ad713e15bdea4af3e4c30fc53a32502a5a1414"),
                              ),
                              SizedBox(
                                width: 3.w,
                              ),
                              const Text("Write Comment ..."),
                              Spacer(),
                              InkWell(
                                onTap: () {},
                                child: Row(
                                  children: [
                                    Icon(FontAwesomeIcons.heart, size: 18.r),
                                    SizedBox(width: 7.w),
                                    Text("Like"),
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
                return const Divider(
                  color: Colors.transparent,
                );
              },
              itemCount: 4),
          SizedBox(height: 6.h),
        ],
      ),
    );
  }
}
