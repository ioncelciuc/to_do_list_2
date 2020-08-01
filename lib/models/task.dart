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

  // Convert Task object to a Map object
  Map<String, dynamic> toMap() {
    Map map = Map<String, dynamic>();
    if (_id != null) {
      map['id'] = _id;
    }
    map['title'] = _title;
    map['description'] = _description;
    return map;
  }

  // Convert Map object to a Task object
  Task.fromMapToObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._title = map['title'];
    this._description = map['description'];
  }
}
