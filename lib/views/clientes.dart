import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:wdalivraia/models/api_response.dart';
import 'dart:async';
import 'package:wdalivraia/models/notes_users.dart';
import 'package:wdalivraia/modals/modal_adicionar_clientes.dart';
import 'package:wdalivraia/services/clientes_services.dart';
import 'package:wdalivraia/widget/floatingactionbutton_widget.dart';
import 'package:wdalivraia/widget/listview_clientes_widget.dart';
import 'package:wdalivraia/widget/search_input.dart';

class Clientes extends StatefulWidget {
  @override
  State<Clientes> createState() => _ClientesState();
}

class _ClientesState extends State<Clientes> {
  ClientesService get service => GetIt.I<ClientesService>();
  APIResponse<List<NotesClientes>>? _apiResponse;
  bool isLoading = false;
  List<NotesClientes> _filteredNotes = [];
  TextEditingController _searchController = TextEditingController();
  Timer? _debounce;

  @override
  void initState() {
    _fetchNotes();
    super.initState();
    //_searchController.addListener(_onSearchChanged);
  }

  _fetchNotes() async {
    setState(() {
      isLoading = true;
    });

    _apiResponse = await service.getNotesList();
    _filteredNotes = _apiResponse?.data ?? [];

    setState(() {
      isLoading = false;
    });
  }

  @override
  void dispose() {
    super.dispose();
    //_searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    if (_debounce?.isActive ?? false) _debounce?.cancel();
  }

  // void _onSearchChanged() {
  //   if (_debounce?.isActive ?? false) _debounce?.cancel();
  //   _debounce = Timer(const Duration(milliseconds: 500), () {
  //     setState(() {
  //       if (_searchController.text.isEmpty) {
  //         _filteredNotes = _apiResponse?.data ?? [];
  //       } else {
  //         _filteredNotes = (_apiResponse?.data ?? [])
  //             .where((note) =>
  //                 note.name
  //                     //.toLowerCase()
  //                     .contains(_searchController.text.toLowerCase()) ||
  //                 note.emailcli
  //                     .toLowerCase()
  //                     .contains(_searchController.text.toLowerCase()) ||
  //                 note.cidadecli
  //                     .toLowerCase()
  //                     .contains(_searchController.text.toLowerCase()) ||
  //                 note.enderecocli
  //                     .toLowerCase()
  //                     .contains(_searchController.text.toLowerCase()))
  //             .toList();
  //       }
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 68, 0, 82),
        title: Text(
          'Clientes',
          style: TextStyle(
              fontSize: 26, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh, color: Colors.white),
            onPressed: _fetchNotes,
          ),
        ],
      ),
      floatingActionButton: CustomFloatingActionButton(
        route: AdicionarClientes(onBack: _fetchNotes),
      ),
      body: Container(
        margin: EdgeInsets.only(right: 8, left: 8),
        child: Column(
          children: [
            CustomTextField(controller: _searchController),
            Expanded(
              child: Builder(builder: (_) {
                if (isLoading) {
                  return Center(child: CircularProgressIndicator());
                }
                if (_apiResponse?.error ?? false) {
                  return Center(
                      child: Text(
                          _apiResponse?.errorMessage ?? 'Ocorreu um erro!'));
                }
                return CustomListView3(
                    filteredNotes: _filteredNotes,
                    fetchNotes: _fetchNotes,
                    service: service);
              }),
            ),
          ],
        ),
      ),
    );
  }
}
