import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../constants/api_urls.dart';
import '../model/profileModel.dart';
import '../services/api_services.dart';

class UserDetailsScreen extends StatefulWidget {
  @override
  _UserDetailsScreenState createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  ProfileModel? user;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    dynamic responseData =
        await ApiService().getApiCall(ApiConstants.profileURL);
    if (responseData != "" && responseData != null) {
      print(responseData);
      ProfileModel model = profileModelFromJson(responseData.body);
      setState(() {
        user = model;
        print(user?.info?.results ?? 0);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: user?.results?.length ?? 0,
          itemBuilder: (BuildContext context, int index) {
            final userr = user?.results?[index];
            return ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(userr?.picture?.thumbnail ?? ""),
              ),
              title: Text(
                  "${userr?.name?.title} ${userr?.name?.first} ${userr?.name?.last}"),
              subtitle: Text(
                  "${userr?.location?.street?.number} ${userr?.location?.street?.name}"),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: fetchData,
        child: Icon(Icons.refresh),
      ),
    );
  }
}
