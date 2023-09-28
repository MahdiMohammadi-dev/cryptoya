import 'package:flutter/material.dart';

class ResponseModel<T> {
  late Status status;
  late T data;
  late String message;

  ResponseModel.loading(this.message) : status = Status.Loading;
  ResponseModel.complete(this.data) : status = Status.Completed;
  ResponseModel.error(this.message) : status = Status.Error;

  @override
  String toString() {
    return "Status : $status \n Message : $message \n Data : $data";
  }
}

enum Status { Loading, Completed, Error }
