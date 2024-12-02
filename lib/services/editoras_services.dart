import 'dart:convert';
import 'package:wdalivraia/models/api_response.dart';
import 'package:wdalivraia/models/notes_add_editora.dart';
import 'package:wdalivraia/models/notes_editora.dart';
import 'package:http/http.dart' as http;
import 'package:wdalivraia/models/notes_update_editora.dart';

class EditorasService {
  static const API = 'http://192.168.15.15:5000';

  Future<APIResponse<List<NotesEditora>>> getNotesList() {
    return http.get(Uri.parse(API + '/api/Editoras')).then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        final notes = <NotesEditora>[];
        for (var item in jsonData) {
          notes.add(NotesEditora.fromJson(item));
        }
        return APIResponse<List<NotesEditora>>(data: notes);
      }
      return APIResponse<List<NotesEditora>>(
          error: true, errorMessage: 'Ocorreu um erro!');
    }).catchError((_) => APIResponse<List<NotesEditora>>(
        error: true, errorMessage: 'Ocorreu um erro!'));
  }

  Future<APIResponse<NotesEditora>> getNote(int idedi) {
    return http
        .get(Uri.parse(API + '/api/Editoras/' + idedi.toString()))
        .then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        return APIResponse<NotesEditora>(data: NotesEditora.fromJson(jsonData));
      }
      return APIResponse<NotesEditora>(
          error: true, errorMessage: 'Ocorreu um erro!');
    }).catchError((_) => APIResponse<NotesEditora>(
            error: true, errorMessage: 'Ocorreu um erro!'));
  }

  Future<APIResponse<bool>> createNote(NoteAddEditora item) {
    return http
        .post(Uri.parse(API + '/api/Editoras'),
            headers: {'Content-Type': 'application/json'},
            body: json.encode(item.toJson()))
        .then((data) {
      if (data.statusCode == 200) {
        return APIResponse<bool>(data: true);
      }
      //print('HTTP status code: ${data.statusCode}');
      //print('HTTP response body: ${data.body}');
      return APIResponse<bool>(
          error: true,
          errorMessage: 'Não foi possível adicionar, editora já existente!');
    }).catchError((error) {
      //print('Error: $error');
      return APIResponse<bool>(
          error: true,
          errorMessage: 'Não foi possível adicionar, editora já existente!');
    });
  }

  Future<APIResponse<bool>> updateNote(NoteUpdtEditora item) {
    return http
        .put(Uri.parse(API + '/api/Editoras'),
            headers: {'Content-Type': 'application/json'},
            body: json.encode(item.toJson()))
        .then((data) {
      if (data.statusCode == 200) {
        return APIResponse<bool>(data: true);
      }
      //print('HTTP status code: ${data.statusCode}');
      //print('HTTP response body: ${data.body}');
      return APIResponse<bool>(
          error: true,
          errorMessage: 'Não foi possível editar, editora já existente!');
    }).catchError((error) {
      //print('Error: $error');
      return APIResponse<bool>(
          error: true,
          errorMessage: 'Não foi possível editar, editora já existente!');
    });
  }

  Future<APIResponse<bool>> deleteNote(String idedi) {
    return http.delete(Uri.parse(API + '/api/Editoras/' + idedi.toString()),
        headers: {'Content-Type': 'application/json'}).then((data) {
      if (data.statusCode == 200) {
        return APIResponse<bool>(data: true);
      }
      //print('HTTP status code: ${data.statusCode}');
      //print('HTTP response body: ${data.body}');
      return APIResponse<bool>(
          error: true,
          errorMessage: 'A editora não pode ser deletada, ela possui livros!');
    }).catchError((error) {
      //print('Error: $error');
      return APIResponse<bool>(
          error: true,
          errorMessage: 'A editora não pode ser deletada, ela possui livros!');
    });
  }
}
