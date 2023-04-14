# Flutter
Публичный репозиторий хендбука по Flutter

# How to add new gist
Документация: https://github.com/dart-lang/dart-pad/wiki/Embedding-Guide
Хороший пример: https://medium.com/flutter/how-to-embed-a-flutter-application-in-a-website-using-dartpad-b8fd0ee8c4b9

1. Завести папку в корне по паттерну {номер.статьи}_{название на английском в snake_case}
2. Создать подпапку с порядковым номером гиста
3. В ней нужно добавить файл dartpad_metadata.yaml, про его структуру можно почитать тут - https://github.com/dart-lang/dart-pad/wiki/Workshop-Authoring-Guide#metadata-file-format
4. Создать main.dart файл и написать там код
5. Собрать embeded-link по примеру: https://dartpad.dev/embed-flutter.html?gh_owner=yndx-handbook&gh_repo=flutter-handbook&gh_path={путь до dartpad_metadata.yaml}