class Task {
  int _id;
  String _title;
  String _description;

  Task(this._title, this._description);

  Task.withId(this._id, this._title, this._description);

  int get id => _id;

  String get title => _title;

  String get description => _description;

  set title(String title) {
    this._title = title;
  }

  set description(String description) {
    this._description = description;
  }
}
