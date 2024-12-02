import 'dart:convert';
import 'package:wdalivraia/models/api_response.dart';
import 'package:wdalivraia/models/notes_add_users.dart';
import 'package:wdalivraia/models/notes_users.dart';
import 'package:http/http.dart' as http;
import 'package:wdalivraia/models/notes_update_users.dart';

class ClientesService {
  static const API = 'http://192.168.18.125:5000';

  Future<APIResponse<List<NotesClientes>>> getNotesList() {
    return http.get(Uri.parse(API + '/api/User')).then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        final notes = <NotesClientes>[];
        for (var item in jsonData) {
          notes.add(NotesClientes.fromJson(item));
        }
        return APIResponse<List<NotesClientes>>(data: notes);
      }
      return APIResponse<List<NotesClientes>>(
          error: true, errorMessage: 'Ocorreu um erro!');
    }).catchError((_) => APIResponse<List<NotesClientes>>(
        error: true, errorMessage: 'Ocorreu um erro!'));
  }

  Future<APIResponse<NotesClientes>> getNote(int id) {
    return http
        .get(Uri.parse(API + '/api/User/' + id.toString()))
        .then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        return APIResponse<NotesClientes>(
            data: NotesClientes.fromJson(jsonData));
      }
      return APIResponse<NotesClientes>(
          error: true, errorMessage: 'Ocorreu um erro!');
    }).catchError((_) => APIResponse<NotesClientes>(
            error: true, errorMessage: 'Ocorreu um erro!'));
  }

  Future<APIResponse<NotesClientes>> getNoteEmail(String email) {
    return http
        .get(Uri.parse(API + '/api/User/by-email/' + email.toString()))
        .then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        return APIResponse<NotesClientes>(
            data: NotesClientes.fromJson(jsonData));
      }
      return APIResponse<NotesClientes>(
          error: true, errorMessage: 'Ocorreu um erro!');
    }).catchError((_) => APIResponse<NotesClientes>(
        error: true, errorMessage: 'Ocorreu um erro!'));
  }

  Future<APIResponse<bool>> createNote(NoteAddUser item) {
    return http
        .post(Uri.parse(API + '/api/User'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(item.toJson()))
        .then((data) {
      if (data.statusCode == 200) {
        return APIResponse<bool>(data: true);
      } else if (data.statusCode == 409) { // Exemplo de código para conflito (email duplicado)
        return APIResponse<bool>(
            error: true, errorMessage: 'Email já existente!');
      } else {
        return APIResponse<bool>(
            error: true, errorMessage: 'Erro ao cadastrar usuário!');
      }
    }).catchError((error) {
      return APIResponse<bool>(
          error: true, errorMessage: 'Erro de conexão com o servidor!');
    });
  }


  Future<APIResponse<bool>> updateNote(NoteUpdtUsers item) {
    return http
        .put(Uri.parse(API + '/api/User'),
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
          errorMessage: 'Não foi possível editar, email já existente!');
    }).catchError((error) {
      //print('Error: $error');
      return APIResponse<bool>(
          error: true,
          errorMessage: 'Não foi possível editar, email já existente!');
    });
  }

  Future<APIResponse<bool>> deleteNote(String id) {
    return http.delete(Uri.parse(API + '/api/User/' + id.toString()),
        headers: {'Content-Type': 'application/json'}).then((data) {
      if (data.statusCode == 200) {
        return APIResponse<bool>(data: true);
      }
      //print('HTTP status code: ${data.statusCode}');
      //print('HTTP response body: ${data.body}');
      return APIResponse<bool>(
          error: true,
          errorMessage:
              'O cliente não pode ser deletado, ele possui alugueis!');
    }).catchError((error) {
      //print('Error: $error');
      return APIResponse<bool>(
          error: true,
          errorMessage:
              'O cliente não pode ser deletado, ele possui alugueis!');
    });
  }
}
