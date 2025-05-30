class EntryModel {
  final String? title;
  final List<EntryModel>? children;
  EntryModel({this.title, this.children});
}

List<EntryModel> data = <EntryModel>[
  EntryModel(title: "Number1", children: [
    EntryModel(title: "title two", children: [
      EntryModel(title: "Subtitle"),
      EntryModel(title: "Subtitle2")
    ]),
    EntryModel(title: "Number2", children: [
      EntryModel(title: "Subtitle"),
      EntryModel(title: "Subtitle2"),
    ])
  ])
];
