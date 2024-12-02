import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:wdalivraia/main.dart';
import 'package:wdalivraia/widget/input_label_widget.dart';
import 'package:wdalivraia/widget/submit_button_widget.dart';
import 'package:wdalivraia/models/notes_add_users.dart';

import '../models/notes_add_itemlost.dart';
import '../models/notes_users.dart';
import '../services/itemlost_services.dart';
import '../views/home_page.dart';

class BottomSheetItem extends StatefulWidget {
  final double screenHeight;
  final int userId;

  const BottomSheetItem({
    Key? key,
    required this.screenHeight,
    required this.userId
  }) : super(key: key);

  @override
  State<BottomSheetItem> createState() => _BottomSheetItemState();
}

class _BottomSheetItemState extends State<BottomSheetItem> {
  late int userId;

  @override
  void initState() {
    super.initState();
    userId = widget.userId;
    with_label = false;
    metal = false;
    colored = false;
    broken = false;
    dirty = false;
    opaque = false;
    fragile = false;
    missing_parts = false;
    heavy = false;
    with_pockets = false;
    with_buttons = false;
  }

  @override
  void dispose() {
    super.dispose();
  }
  ItemLostService get service => GetIt.I<ItemLostService>();

  String? errorMessage;
  NotesClientes? note;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController colorController = TextEditingController();
  bool with_label = false;
  bool metal = false;
  bool colored = false;
  bool broken = false;
  bool dirty = false;
  bool opaque = false;
  bool fragile = false;
  bool missing_parts = false;
  bool heavy = false;
  bool with_pockets = false;
  bool with_buttons = false;
  final TextEditingController otherController = TextEditingController();
  //int? id = userId;
  final TextEditingController dateController = TextEditingController();
  final TextEditingController imageController = TextEditingController();


  int selectedType = -1;

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.screenHeight * 0.90,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 25, left: 45, right: 45, bottom: 10),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 20,),
                InputLabelWidget(type: 3, controller: nameController, maxLength: 100, minLength: 5, placeholder: "name...", label: "Nome"),
                InputLabelWidget(type: 3, controller: colorController, maxLength: 50, minLength: 5, placeholder: "Cor", label: "Cor"),
                _buildCheckboxRow("Etiqueta", with_label, (value) => setState(() => with_label = value)),
                _buildCheckboxRow("Metálico", metal, (value) => setState(() => metal = value)),
                _buildCheckboxRow("Colorido", colored, (value) => setState(() => colored = value)),
                _buildCheckboxRow("Quebrado", broken, (value) => setState(() => broken = value)),
                _buildCheckboxRow("Sujo", dirty, (value) => setState(() => dirty = value)),
                _buildCheckboxRow("Opaco", opaque, (value) => setState(() => opaque = value)),
                _buildCheckboxRow("Frágil", fragile, (value) => setState(() => fragile = value)),
                _buildCheckboxRow("Parte faltando", missing_parts, (value) => setState(() => missing_parts = value)),
                _buildCheckboxRow("Pesado", heavy, (value) => setState(() => heavy = value)),
                _buildCheckboxRow("Com bolsos", with_pockets, (value) => setState(() => with_pockets = value)),
                _buildCheckboxRow("Botão", with_buttons, (value) => setState(() => with_buttons = value)),
                InputLabelWidget(type: 3, controller: otherController, maxLength: 50, minLength: 6, placeholder: "outro", label: "outro"),
                InputLabelWidget(type: 3, controller: dateController, maxLength: 50, minLength: 6, placeholder: "Data", label: "Data"),
                InputLabelWidget(type: 3, controller: imageController, maxLength: 50, minLength: 6, placeholder: "Imagem", label: "Imagem"),
                SizedBox(height: 20,),
                SubmitButtonWidget(
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      final note = NoteAddItemLost(
                        name: nameController.text,
                        color: colorController.text,
                        other: otherController.text,
                        with_label: with_label,
                        metal: metal,
                        colored: colored,
                        broken: broken,
                        dirty: dirty,
                        opaque: opaque,
                        fragile: fragile,
                        missing_parts: missing_parts,
                        heavy: heavy,
                        with_pockets: with_pockets,
                        with_buttons: with_buttons,
                        id_user: userId,
                        date: dateController.text,
                        image: imageController.text,
                      );
                      print('Dados enviados: ${note.toJson()}');
                      final result = await service.createNote(note);
                      //final titleModal = "Info";
                      final textError = result.error!
                          ? (result.errorMessage ??
                          'Ocorreu um erro desconhecido')
                          : 'Usuário criado!';

                      // Use o contexto do Builder widget
                      final snackBar = SnackBar(
                        content: Text(textError),
                        action: SnackBarAction(
                          label: 'Fechar',
                          onPressed: () {},
                        ),
                      );
                      ScaffoldMessenger.of(context)
                          .showSnackBar(snackBar);
                    };
                  },
                  placeholder: "SALVAR",
                ),
                SizedBox(height: 20,),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget _buildCheckboxRow(String label, bool value, ValueChanged<bool> onChanged) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 18)),
        Checkbox(
          value: value,
          onChanged: (bool? newValue) {
            onChanged(newValue ?? false);
          },
        ),
        Text('Status: ${value ? "Sim" : "Não"}'),
      ],
    );
  }
}

