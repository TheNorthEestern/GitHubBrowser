import Combine
import SwiftUI

class GithubUserListViewController: UIViewController {
  private let viewModel: GitHubUserListViewModel
  private var subscribers = Set<AnyCancellable>()
  weak var coordinator: GithubProfileCoordinator?

  private let errorLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textAlignment = .center
    label.numberOfLines = 0

    return label
  }()

  private lazy var errorView: UIView = {
    let errorStack = UIStackView(arrangedSubviews: [errorLabel])
    errorStack.alignment = .center

    NSLayoutConstraint.activate([
      errorLabel.centerXAnchor.constraint(equalTo: errorStack.centerXAnchor),
      errorLabel.centerYAnchor.constraint(equalTo: errorStack.centerYAnchor)
    ])

    return errorStack
  }()

  private let loadingView: UIView = {
    let indicator = UIActivityIndicatorView()
    indicator.translatesAutoresizingMaskIntoConstraints = false
    indicator.style = .large
    indicator.startAnimating()

    let errorStack = UIStackView(arrangedSubviews: [indicator])
    errorStack.alignment = .center

    NSLayoutConstraint.activate([
      indicator.centerXAnchor.constraint(equalTo: errorStack.centerXAnchor),
      indicator.centerYAnchor.constraint(equalTo: errorStack.centerYAnchor)
    ])

    return errorStack
  }()

  private lazy var refreshControl: UIRefreshControl = {
    let control = UIRefreshControl()
	  control.addAction(
		.init { [viewModel] _ in viewModel.fetchUsers(fromStart: true) },
		for: .valueChanged
	  )
    return control
  }()

  private lazy var usersTableView: UITableView = {
    let tableView = UITableView()
    tableView.delegate = self
    tableView.dataSource = self
    tableView.translatesAutoresizingMaskIntoConstraints = false
    tableView.refreshControl = refreshControl
    tableView.register(
      UsersTableViewCell.self,
      forCellReuseIdentifier: String(describing: UsersTableViewCell.self)
    )
    tableView.separatorStyle = .none
    return tableView
  }()

  init(viewModel: GitHubUserListViewModel) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }

  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    setupBindings()
    setupViews()
    viewModel.fetchUsers(fromStart: true)
  }

  private func setupBindings() {
    viewModel
      .$loadingState
      .receive(on: DispatchQueue.main)
      .sink { [usersTableView, refreshControl, errorView, errorLabel] state in
        switch state {
        case .done:
          refreshControl.endRefreshing()
          usersTableView.backgroundView = nil
          usersTableView.reloadData()
        case let .failure(error):
          refreshControl.endRefreshing()
          let errorText = "\n\nPull down to refresh and try again.\n\nIf you continue to encounter errors, please ensure that you've entered your GitHub token per the instructions in the README."
          errorLabel.text = error.localizedDescription + errorText
          usersTableView.backgroundView = errorView
        case .loading:
          refreshControl.beginRefreshing()
        }
      }
      .store(in: &subscribers)
  }

  private func setupViews() {
    view.backgroundColor = .systemGray
    view.addSubview(usersTableView)

    NSLayoutConstraint.activate([
      usersTableView.topAnchor.constraint(equalTo: view.topAnchor),
      usersTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      usersTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      usersTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ])
  }
}

extension GithubUserListViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    86
  }

  func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
    if let headerView = view as? UITableViewHeaderFooterView {
      headerView.textLabel?.textAlignment = .center
      headerView.textLabel?.font = .monospacedSystemFont(ofSize: 16, weight: .regular)
      let view = UIView()
      view.backgroundColor = .systemBackground
      headerView.backgroundView = view
    }
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    let user = viewModel.user(for: indexPath)
    guard let profileURL = user?.url, let reposURL = user?.reposUrl else { return }
    coordinator?.showDetail(profileURL: profileURL, reposURL: reposURL)
  }
}

extension GithubUserListViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    let indexOfLastOnScreenCell = (indexPath.row + 1)
    if indexOfLastOnScreenCell.isMultiple(of: viewModel.userCount) {
      viewModel.fetchUsers()
    }
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    viewModel.userCount
  }

  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    if section == 0 && viewModel.userCount > 0 {
      return NSLocalizedString("GitHub Browser", comment: "Title for github profiles view")
    }
    return nil
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "UsersTableViewCell", for: indexPath) as? UsersTableViewCell else { return UITableViewCell() }
    let currentUser = viewModel.user(for: indexPath)!
    cell.configure(with: currentUser.avatarUrl, login: currentUser.login)
    return cell
  }
}

