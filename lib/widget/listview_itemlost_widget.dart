import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:wdalivraia/services/itemlost_services.dart';
import '../main.dart';
import '../models/notes_itemlost.dart';

class ListViewItens extends StatefulWidget {
  @override
  State<ListViewItens> createState() => _ListViewItensState();
}

class _ListViewItensState extends State<ListViewItens> {
  final ItemLostService _itemLostService = getIt<ItemLostService>();

  List<NotesItemLost> _items = [];
  List<bool> _expanded = [];
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchItems();
  }

  void _fetchItems() async {
    final response = await _itemLostService.getNotesList();
    if (response.error == false && response.data != null) {
      setState(() {
        _items = response.data!;
        _expanded = List<bool>.filled(_items.length, false);
      });
    } else {
      setState(() {
        _errorMessage = response.errorMessage ?? 'Erro desconhecido';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_errorMessage != null) {
      return Center(
        child: Text(
          _errorMessage!,
          style: TextStyle(color: Colors.red, fontSize: 16),
        ),
      );
    }

    return _items.isEmpty
        ? Center(child: CircularProgressIndicator())
        : ListView.builder(
      itemCount: _items.length,
      itemBuilder: (context, index) {
        final item = _items[index];
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            if (item.image.isNotEmpty) _buildImage(item.image),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Tooltip(
                                    message: item.name1,
                                    child: Text(
                                      "${item.name1}",
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                  ),
                                  Tooltip(
                                    message: item.color,
                                    child: Text(
                                      "Cor: ${item.color}",
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                  ),
                                  Tooltip(
                                    message: item.other,
                                    child: Text(
                                      "Outro: ${item.other}",
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          _expanded[index]
                              ? Icons.keyboard_arrow_up
                              : Icons.keyboard_arrow_down,
                        ),
                        onPressed: () {
                          setState(() {
                            _expanded[index] = !_expanded[index];
                          });
                        },
                      ),
                    ],
                  ),
                  if (_expanded[index]) ...[
                    const SizedBox(height: 8),
                    if (item.with_label) _buildInfoRow("Com etiqueta"),
                    if (item.metal) _buildInfoRow("Metálico"),
                    if (item.colored) _buildInfoRow("Colorido"),
                    if (item.broken) _buildInfoRow("Quebrado"),
                    if (item.dirty) _buildInfoRow("Sujo"),
                    if (item.opaque) _buildInfoRow("Opaco"),
                    if (item.fragile) _buildInfoRow("Frágil"),
                    if (item.missing_parts)
                      _buildInfoRow("Com peças faltando"),
                    if (item.heavy) _buildInfoRow("Pesado"),
                    if (item.with_pockets) _buildInfoRow("Com bolsos"),
                    if (item.with_buttons) _buildInfoRow("Com botões"),
                    const SizedBox(height: 8),
                    Text("Data: ${item.date}"),
                    Text("Usuário: ${item.name}"),
                  ]
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildImage(String base64Image) {
    final base64Data = base64Image.contains(",")
        ? base64Image.split(",")[1]
        : base64Image;

    Uint8List imageBytes = base64Decode(base64Data);

    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: Image.memory(
        imageBytes,
        width: MediaQuery.of(context).size.width * 0.2,
        height: MediaQuery.of(context).size.width * 0.2,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildInfoRow(String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        children: [
          Icon(Icons.check, color: Colors.green, size: 20),
          const SizedBox(width: 8),
          Text(label),
        ],
      ),
    );
  }
}