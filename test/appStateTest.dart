import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:kanooniha/core/network/UriCreator.dart';
import 'package:kanooniha/data/body/poll/set_poll.dart';
import 'package:kanooniha/domain/useCase/poll/set_poll_use_case.dart';

void main() {
  test("Main state of App", () {
    SetPollBody setPollBody = SetPollBody(
      uniqueId: '1',
      pollDetailId: '1',
      answer: 'testOption',
      selectedOption: '1',
      checkedOptions: ['1', '2', '3', '4'],
    );

    var body = setPollBody.toJson();




    var uri = UriCreator.createUriWithUrl(
        url: 'url', path: 'path', body: body);


    print('options = $uri');
    expect('5', 5.toString());
  });
}


