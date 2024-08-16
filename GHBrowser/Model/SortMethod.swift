enum SortMethod: String, CaseIterable, Identifiable {
  case stars
  case name
  case language
  var id: Self { return self }

  var title: String {
    switch self {
    case .stars:
      return "Stars"
    case .name:
      return "Name"
    case .language:
      return "Lang"
    }
  }
}
