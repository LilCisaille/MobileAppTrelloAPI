import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:trelltech/arbory/services/organization_service.dart';
import 'package:trelltech/components/checkbox.dart';
import 'package:trelltech/components/custom_appbar.dart';
import 'package:trelltech/components/custom_bottom_navigation_bar.dart';
import 'package:trelltech/components/custom_button.dart';
import 'package:trelltech/components/custom_title.dart';
import 'package:trelltech/components/text_input.dart';

class CreateWorkspaceScreen extends StatefulWidget {
  const CreateWorkspaceScreen({super.key});

  @override
  CreateWorkspaceScreenState createState() {
    return CreateWorkspaceScreenState();
  }
}

class CreateWorkspaceScreenState extends State<CreateWorkspaceScreen> {
  bool isChecked = false;
  String name = '';
  String? workspaceDesc;
  String error = '';

  void validateForm(name, workspaceDesc) {
    if (name == '' || workspaceDesc == '') {
      setState(() {
        error = 'Please fill in the form';
      });
      return;
    }
    context
        .read<Organizations>()
        .createOrganization(displayName: name, desc: workspaceDesc)
        .then(context.go('/'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const CustomTitle(text: 'Create a new workspace'),
              CustomTextField(
                  name: 'name',
                  onTextChanged: (String value) => {
                        setState(() {
                          name = value;
                        })
                      }),
              CustomTextField(
                  name: 'description',
                  onTextChanged: (String value) => {
                        setState(() {
                          workspaceDesc = value;
                        })
                      }),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'is public :',
                    style: TextStyle(fontFamily: 'LexendExa', fontSize: 14),
                  ),
                  CustomCheckbox(
                      value: isChecked,
                      onChanged: (bool? value) => {
                            setState(() {
                              isChecked = value!;
                            }),
                          })
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomButton(
                      text: 'Create',
                      iconName: Icons.add,
                      onPressed: () => {
                            validateForm(name, workspaceDesc),
                          }),
                  Container(
                    margin: const EdgeInsets.only(left: 16),
                    child: TextButton(
                      onPressed: () => {
                        context.go('/'),
                      },
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all(
                            const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 18)),
                        shape: MaterialStateProperty.all(
                            const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                        )),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.lightBlueAccent),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                          ),
                          Text(
                            'go back',
                            style: TextStyle(
                                fontFamily: 'LexendExa', color: Colors.white),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
              Text(
                error,
                style: const TextStyle(
                  fontFamily: 'LexendExa',
                  color: Colors.redAccent,
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: const CustomNavigationBar(),
    );
  }
}
