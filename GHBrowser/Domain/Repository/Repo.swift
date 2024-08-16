import SwiftUI

struct Repo: Hashable, Identifiable {
  let id: UUID = UUID()
  let repositoryName: String
  let programmingLanguage: String
  let numberOfStars: Int
  let description: String
  let htmlURL: URL
	
	var backgroundColor: Color {
		Color.gitHubColor(for: programmingLanguage)
	}
	
	var foregroundColor: Color {
		if Color.contrastRatio(between: backgroundColor, and: .white) < 4.5 {
			.black
		} else {
			.white
		}
	}
}
