import 'dart:convert';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:wdalivraia/main.dart';
import 'package:wdalivraia/models/notes_itemlost.dart';
import 'package:wdalivraia/widget/input_label_widget.dart';
import 'package:wdalivraia/widget/submit_button_widget.dart';

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
  //ItemLostService get service => GetIt.I<ItemLostService>();
  final service = GetIt.I.call<ItemLostService>();

  String? errorMessage;
  NotesItemLost? note;

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
      height: widget.screenHeight * 1,
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
                InputLabelWidget(type: 3, controller: nameController, maxLength: 45, minLength: 1, placeholder: "name...", label: "Nome"),
                InputLabelWidget(type: 3, controller: colorController, maxLength: 45, minLength: 1, placeholder: "Cor", label: "Cor"),
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
                InputLabelWidget(type: 3, controller: otherController, maxLength: 100, minLength: 1, placeholder: "outro", label: "outro"),
                GestureDetector(
                  onTap: () => _selectDate(context),
                  child: AbsorbPointer(
                    child: InputLabelWidget(
                      type: 3,
                      controller: dateController,
                      maxLength: 50,
                      minLength: 6,
                      placeholder: "Selecione a data",
                      label: "Data",
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: _pickImage,
                  child: Container(
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: imageController.text.isNotEmpty
                        ? ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.memory(
                        base64Decode(imageController.text.split(',')[1]),
                        fit: BoxFit.cover,
                      ),
                    )
                        : Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.camera_alt,
                              size: 40, color: Colors.grey),
                          SizedBox(height: 10),
                          Text("Adicionar Imagem",
                              style: TextStyle(color: Colors.grey)),
                        ],
                      ),
                    ),
                  ),
                ),
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
                      final textError = result.error!
                          ? (result.errorMessage ?? 'Ocorreu um erro desconhecido')
                          : 'Item Adicionado!';

                      final snackBar = SnackBar(
                        content: Text(textError),
                        action: SnackBarAction(
                          label: 'Fechar',
                          onPressed: () {},
                        ),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);

                      // Após salvar, limpar os campos e checkboxes
                      nameController.clear();
                      colorController.clear();
                      otherController.clear();
                      dateController.clear();
                      imageController.clear();
                      setState(() {
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
                      });

                      // Navegar para a próxima página
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomePage(userId: userId),
                        ),
                      );
                    }
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
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2124),
    );
    if (picked != null) {
      setState(() {
        dateController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final bytes = await File(pickedFile.path).readAsBytes();
      final base64Image = "data:image/jpeg;base64,${base64Encode(bytes)}";

      setState(() {
        imageController.text = base64Image;
      });
    }
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
        Text('${value ? "Sim" : "Não"}'),
      ],
    );
  }
}

