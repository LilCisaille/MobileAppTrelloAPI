import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:trelltech/arbory/services/organization_service.dart';
import 'package:trelltech/components/custom_appbar.dart';
import 'package:trelltech/components/custom_title.dart';
import 'package:trelltech/components/text_input.dart';

import '../components/custom_button.dart';

class EditOrganizationScreen extends StatefulWidget {
  final String? orgId;
  const EditOrganizationScreen({super.key, required this.orgId});

  @override
  EditOrganizationScreenState createState() => EditOrganizationScreenState();
}

class EditOrganizationScreenState extends State<EditOrganizationScreen> {
  String? newOrgName;
  String? newOrgDesc;
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Consumer<Organizations>(
        builder: (builder, organizations, child) {
          var organization = organizations.organizationsById[widget.orgId];
          return widget.orgId == null
              ? const Text("Organization not found")
              : SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTitle(text: 'Edit organization ${organization?.displayName}'),
                const SizedBox(height: 40),
                CustomTextField(
                    name: "organization name",
                    helperText: '${organization?.displayName}',
                    onTextChanged: (String value) {
                      setState(() {
                        newOrgName = value;
                      });
                    }),
                const SizedBox(height: 40),
                CustomTextField(
                    name: "organization description",
                    helperText: '${organization?.desc}',
                    onTextChanged: (String value) {
                      setState(() {
                        newOrgDesc = value;
                      });
                    }),
                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomButton(
                        iconName: Icons.save,
                        text: 'Save',
                        onPressed: () {
                          if (newOrgName == null || newOrgDesc == null) {
                            setState(() {
                              error = 'Please fill in the form';
                            });
                            return;
                          }
                          if(newOrgName == organization!.displayName && newOrgDesc == organization.desc){
                            setState(() {
                              error = 'No changes made';
                            });
                            return;
                          }
                          if(newOrgName == null && newOrgDesc != null && newOrgDesc != organization.desc){
                            newOrgName = organization.displayName;
                          }
                          if(newOrgName != null && newOrgDesc == null && newOrgName != organization.displayName){
                            newOrgDesc = organization.desc;
                          }
                          organization.update(
                              displayName: newOrgName,
                              desc: newOrgDesc
                          );
                          log('organization updated');
                          context.go('/org/${widget.orgId}');
                        }),
                    const SizedBox(width: 20),
                    TextButton(
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                          ),
                          padding: MaterialStateProperty.all(
                            const EdgeInsets.all(16.0),
                          ),
                          backgroundColor: MaterialStateProperty.all(
                              Colors.lightBlueAccent
                          ),
                        ),
                        onPressed: (){
                          context.go('/org/${widget.orgId}');
                        },
                        child:const Row(
                          children: [
                            Icon(Icons.arrow_back_ios, color: Colors.white,),
                            Text(" go back", style: TextStyle(
                                fontSize: 16.0,
                                fontFamily: 'LexendExa',
                                color: Colors.white
                            )),
                          ],
                        ))
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(left: 20),
                  child: Text(
                    error.isEmpty ? "" : error,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontFamily: 'LexendExa',
                      color: Colors.redAccent,
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

