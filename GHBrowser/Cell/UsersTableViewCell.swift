import UIKit
import Kingfisher

class UsersTableViewCell: UITableViewCell {
  private let loginImage: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.contentMode = .scaleAspectFit
    imageView.clipsToBounds = true

    return imageView
  }()

  private let loginLabel: UILabel = {
    let label = UILabel()
    label.font = .monospacedSystemFont(ofSize: 18, weight: .regular)
    label.adjustsFontForContentSizeCategory = true
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()

  private let dividerView: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.backgroundColor = .init(red:  230/255, green: 234/255, blue: 238/255, alpha: 0.8)
    return view
  }()

  private let disclosureChevron: UIImageView = {
    let imageView = UIImageView(image: UIImage(systemName: "chevron.right"))
    imageView.tintColor = .lightGray
    imageView.contentMode = .scaleAspectFit
    return imageView
  }()

  private lazy var loginAndChevron: UIStackView = {
    let stack = UIStackView(arrangedSubviews: [loginLabel, UIView(), disclosureChevron])
    stack.translatesAutoresizingMaskIntoConstraints = false
    stack.axis = .horizontal
    stack.distribution = .fillProportionally
    return stack
  }()

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupViews()
  }

  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func layoutSubviews() {
    super.layoutSubviews()
    loginImage.layer.cornerRadius = loginImage.frame.size.width / 2
  }

  private func setupViews() {
    contentView.addSubview(loginImage)
    contentView.addSubview(loginAndChevron)
    contentView.addSubview(dividerView)

    NSLayoutConstraint.activate([
      dividerView.heightAnchor.constraint(equalToConstant: 1),
      dividerView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
      dividerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
      loginImage.heightAnchor.constraint(equalToConstant: 60),
      loginImage.widthAnchor.constraint(equalToConstant: 60),
      disclosureChevron.widthAnchor.constraint(equalToConstant: 10),
      loginImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
      loginImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
      loginAndChevron.leadingAnchor.constraint(equalTo: loginImage.trailingAnchor, constant: 24),
      loginAndChevron.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
      loginAndChevron.centerYAnchor.constraint(equalTo: loginImage.centerYAnchor),
    ])
  }

  func configure(with imageURL: URL, login username: String) {
    loginLabel.text = username
    loginImage.kf.indicatorType = .activity
    loginImage.kf.setImage(with: imageURL)
  }
}
