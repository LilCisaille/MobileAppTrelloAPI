import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:trelltech/arbory/services/cards_service.dart';
import 'package:trelltech/components/custom_appbar.dart';
import 'package:trelltech/components/custom_bottom_navigation_bar.dart';
import 'package:trelltech/components/custom_button.dart';
import 'package:trelltech/components/custom_title.dart';
import 'package:trelltech/components/text_input.dart';

class CreateCardScreen extends StatefulWidget {
  final String listId;
  const CreateCardScreen({super.key, required this.listId, });

  @override
  _CreateCardScreenState createState() => _CreateCardScreenState();
}

class _CreateCardScreenState extends State<CreateCardScreen>{
  String? cardName;
  String? cardDesc;
  String? error;
  String? dueDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const CustomTitle(text: 'Create a new card'),
              const SizedBox(height: 40),
              CustomTextField(
                  name: "card name",
                  onTextChanged: (String value) {
                    setState(() {
                      cardName = value;
                    });
                  }),
              const SizedBox(height: 20),
              CustomTextField(
                  name: "card description",
                  onTextChanged: (String value) {
                    setState(() {
                      cardDesc = value;
                    });
                  }),
              const SizedBox(height: 20),
              InputDatePickerFormField(
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2025),
                  onDateSaved: (value){
                    setState(() {
                      dueDate = value.toString();
                    });
                  }),
              CustomButton(
                iconName: Icons.add,
                text: 'create this card',
                onPressed: (){
                  if(cardName == null || cardDesc == null){
                    setState(() {
                      error = 'Please fill in the form';
                    });
                    return;
                  }
                  context.read<Cards>().createCard(
                    idList: widget.listId,
                    name: cardName!,
                    desc: cardDesc,
                    due: dueDate
                  );
                  context.go('/list/${widget.listId}');
                },
              ),
            ],
          ),
        ),
        bottomNavigationBar: const CustomNavigationBar()
    );
  }

}