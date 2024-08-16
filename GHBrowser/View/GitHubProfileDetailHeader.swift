import SwiftUI
import Kingfisher

struct GitHubProfileDetailHeader: View {
  private let viewModel: GithubProfileDetailViewModel
  @State private var selectedSorting = SortMethod.name

  init(viewModel: GithubProfileDetailViewModel) {
    self.viewModel = viewModel
  }

  var body: some View {
    HStack(spacing: 10) {
      Spacer()
      KFImage(viewModel.user?.profileImageURL)
        .resizable()
        .aspectRatio(contentMode: .fit)
        .frame(height: 100)
        .overlay(Circle().stroke(.black, lineWidth: 5))
        .clipShape(Circle())
      Spacer()
      VStack(alignment: .trailing, spacing: 5) {
        if let login = viewModel.user?.username {
          Text(login)
            .font(.largeTitle)
        }

        if let name = viewModel.user?.legalName {
          Text(name)
        }

        if let followerCount = viewModel.user?.followers {
          Text("\(followerCount) followers")
            .font(.headline)
        }

        VStack(spacing: 24) {
          VStack(alignment: .leading) {

            Text("\(viewModel.user?.followings ?? 0) following")
              .font(.subheadline)
              .foregroundStyle(.gray)
          }
        }
      }
      Spacer()
    }
    .clipShape(RoundedRectangle(cornerSize: .init(width: 20, height: 20)))
    .padding(12)
    HStack {
      Image(systemName: "arrow.up.arrow.down")
      Picker("Sort", selection: $selectedSorting) {
        ForEach(SortMethod.allCases) {
          Text($0.title)
            .tag($0)
        }
      }
      .onChange(of: selectedSorting) { _, newValue in
        viewModel.sortReposBy(sortMethod: newValue)
      }
    }
    .pickerStyle(.palette)
    .padding(.init(top: 0, leading: 24, bottom: 5, trailing: 24))
  }
}
