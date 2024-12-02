import 'dart:convert';
import 'package:wdalivraia/models/api_response.dart';
import 'package:wdalivraia/models/notes_add_itemlost.dart';
import 'package:wdalivraia/models/notes_itemlost.dart';
import 'package:http/http.dart' as http;
import 'package:wdalivraia/models/notes_livrosid.dart';
import 'package:wdalivraia/models/notes_update_itemlost.dart';

class ItemLostService {
  static const API = 'http://192.168.18.125:5000';

  Future<APIResponse<List<NotesItemLost>>> getNotesList() {
    return http.get(Uri.parse(API + '/api/ItemLost')).then((data) {
      print('Resposta da API (status): ${data.statusCode}');
      print('Resposta da API (body): ${data.body}');
      if (data.statusCode == 200) {
        try {
          final jsonData = json.decode(data.body);
          if (jsonData is List) {
            final notes = jsonData
                .map((item) => NotesItemLost.fromJson(item))
                .toList();
            return APIResponse<List<NotesItemLost>>(data: notes);
          } else {
            return APIResponse<List<NotesItemLost>>(
                error: true, errorMessage: 'Formato de dados inválido');
          }
        } catch (e) {
          print('Erro ao decodificar JSON: $e');
          return APIResponse<List<NotesItemLost>>(
              error: true, errorMessage: 'Erro ao processar dados da API');
        }
      }
      return APIResponse<List<NotesItemLost>>(
          error: true, errorMessage: 'Erro HTTP: ${data.statusCode}');
    }).catchError((error) {
      print('Erro ao conectar à API: $error');
      return APIResponse<List<NotesItemLost>>(
          error: true, errorMessage: 'Erro de conexão com a API');
    });
  }

  Future<APIResponse<NotesLivrosId>> getNote(int id) {
    return http
        .get(Uri.parse(API + '/api/ItemLost/' + id.toString()))
        .then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        return APIResponse<NotesLivrosId>(
            data: NotesLivrosId.fromJson(jsonData));
      }
      return APIResponse<NotesLivrosId>(
          error: true, errorMessage: 'Ocorreu um erro!');
    }).catchError((_) => APIResponse<NotesLivrosId>(
            error: true, errorMessage: 'Ocorreu um erro!'));
  }

  Future<APIResponse<bool>> createNote(NoteAddItemLost item) {
    return http
        .post(Uri.parse(API + '/api/ItemLost'),
            headers: {'Content-Type': 'application/json'},
            body: json.encode(item.toJson()))
        .then((data) {
      if (data.statusCode == 200) {
        return APIResponse<bool>(data: true);
      }
      //print('HTTP status code: ${data.statusCode}');
      //print('HTTP response body: ${data.body}');
      return APIResponse<bool>(error: true, errorMessage: 'Ocorreu um erro!');
    }).catchError((error) {
      //print('Error: $error');
      return APIResponse<bool>(error: true, errorMessage: 'Ocorreu um erro!');
    });
  }

  Future<APIResponse<bool>> updateNote(NoteUpdtItemLost item) {
    return http
        .put(Uri.parse(API + '/api/ItemLost'),
            headers: {'Content-Type': 'application/json'},
            body: json.encode(item.toJson()))
        .then((data) {
      if (data.statusCode == 200) {
        return APIResponse<bool>(data: true);
      }
      //print('HTTP status code: ${data.statusCode}');
      //print('HTTP response body: ${data.body}');
      return APIResponse<bool>(error: true, errorMessage: 'Ocorreu um erro!');
    }).catchError((error) {
      //print('Error: $error');
      return APIResponse<bool>(error: true, errorMessage: 'Ocorreu um erro!');
    });
  }

  Future<APIResponse<bool>> deleteNote(String id) {
    return http.delete(Uri.parse(API + '/api/ItemLost/' + id.toString()),
        headers: {'Content-Type': 'application/json'}).then((data) {
      if (data.statusCode == 200) {
        return APIResponse<bool>(data: true);
      }
      //print('HTTP status code: ${data.statusCode}');
      //print('HTTP response body: ${data.body}');
      return APIResponse<bool>(
          error: true,
          errorMessage: 'O item não pode ser deletado, ele possui alugueis!');
    }).catchError((error) {
      //print('Error: $error');
      return APIResponse<bool>(
          error: true,
          errorMessage: 'O item não pode ser deletado, ele possui alugueis!');
    });
  }
}
