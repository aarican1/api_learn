import 'package:flutter/material.dart';
import 'package:flutter_api_learn/cubit_view_model/reqres_userlist_cubit.dart';

import 'package:flutter_api_learn/cubit_view_model/reqres_userlist_state.dart';
import 'package:flutter_api_learn/cubit_view_model/resource_cubit.dart';
import 'package:flutter_api_learn/cubit_view_model/single_user_cubit.dart';
import 'package:flutter_api_learn/cubit_view_model/single_user_state.dart';

import 'package:flutter_api_learn/service/dio_manager.dart';
import 'package:flutter_api_learn/service/reqres_service.dart';
import 'package:flutter_api_learn/view/put_patch/reqres_add-etc.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kartal/kartal.dart';

import '../cubit_view_model/resource_state.dart';

class EmptyPage extends StatefulWidget {
  EmptyPage({Key? key}) : super(key: key);

  @override
  State<EmptyPage> createState() => _EmptyPageState();
}

class _EmptyPageState extends State<EmptyPage> {
  String stringpng = 'https://picsum.photos/200';
  String title = 'List/User';
  String singleUser = 'Single User';
  String add = 'Add';
  String empty = 'Reqres User';
  String resourcetitle = 'List/Resource';

  final ReqresUserListCubit cubit =
      ReqresUserListCubit(ReqresService(DioManager.instance));

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ReqresUserListCubit>(
      create: (context) =>
          ReqresUserListCubit(ReqresService(DioManager.instance)),
      child: Scaffold(
        appBar: AppBar(
          actions: [
            TextButton(
                onPressed: () {
                  context.navigateToPage(AddDeleteEtc());
                },
                child: Row(
                  children: [Text(add), Icon(Icons.add)],
                ))
          ],
          title: Text(empty),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                Center(
                  child: Text(
                    title,
                    style: context.textTheme.headlineLarge,
                  ),
                ),
                Container(
                    height: MediaQuery.of(context).size.height * 0.4,
                    child: myBlocExpanded()),
                Center(
                  child: Text(
                    singleUser,
                    style: context.textTheme.headlineLarge,
                  ),
                ),
                MyUser(),
                Center(
                  child: Text(
                    resourcetitle,
                    style: context.textTheme.headlineLarge,
                  ),
                ),
                Container(
                    height: MediaQuery.of(context).size.height * 0.3,
                    child: MyResource())
              ],
            ),
          ),
        ),
      ),
    );
  }

  Expanded myBlocExpanded() {
    return Expanded(
      child: BlocConsumer<ReqresUserListCubit, ReqresUserListState>(
        listener: (context, state) {
          if (ReqresUserListState().data != null) {}
        },
        builder: (context, state) {
          final items = state.data;
          return state.isLoading
              ? ListView.builder(
                  itemCount: items?.length ?? 0,
                  itemBuilder: (context, index) {
                    return Card(
                        child: ListTile(
                      leading: Image.network(
                        fit: BoxFit.cover,
                        width: 50,
                        height: 50,
                        items?[index]?.avatar ?? stringpng,
                      ),
                      title: Text(
                          '${items?[index]?.firstName}  ${items?[index]?.lastName}'),
                      subtitle: Text(items?[index]?.email ?? ''),
                    ));
                  },
                )
              : Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class MyResource extends StatelessWidget {
  const MyResource({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ResourceCubit>(
      create: (context) => ResourceCubit(ReqresService(DioManager.instance)),
      child: BlocConsumer<ResourceCubit, ResourceState>(
        listener: (context, state) {
          if (ResourceState().data != null) {}
        },
        builder: (context, state) {
          final items = state.data ?? [];
          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              return Card(
                color: Color(items[index]?.colorValue ?? 0xFFFFFF),
                child: ListTile(
                  title: Text(items[index]?.name ?? ''),
                  leading: Text(items[index]?.pantoneValue ?? ''),
                  subtitle: Text(items[index]?.year.toString() ?? ''),
                  contentPadding: EdgeInsets.all(8.0),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class MyUser extends StatelessWidget {
  const MyUser({
    super.key,
  });

  final String imagePath = 'https://reqres.in/img/faces/2-image.jpg';
  @override
  Widget build(BuildContext context) {
    return BlocProvider<SingleUserCubit>(
      create: (context) => SingleUserCubit(ReqresService(DioManager.instance)),
      child: BlocConsumer<SingleUserCubit, SingleUserState>(
        listener: (context, state) {
          if (SingleUserState().data != null) {}
        },
        builder: (context, state) {
          final item = state.data;
          return Card(
            child: ListTile(
              title: Text('${item?.firstName} ${item?.lastName}'),
              subtitle: Text(item?.email ?? ''),
              leading: CircleAvatar(
                child: Image.network(imagePath),
              ),
            ),
          );
        },
      ),
    );
  }
}
