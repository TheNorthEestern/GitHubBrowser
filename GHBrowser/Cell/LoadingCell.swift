import UIKit

class LoadingCell : UITableViewCell {
	private let activityIndicator: UIActivityIndicatorView = {
		let indicator = UIActivityIndicatorView()
		indicator.translatesAutoresizingMaskIntoConstraints = false
		indicator.style = .medium
		indicator.hidesWhenStopped = true
		return indicator
	}()
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		setupSubviews()
	}
	
	@available(*, unavailable)
	required init?(coder aDecoder: NSCoder) {
		fatalError("This hasn't been implemented")
	}
	
	private func setupSubviews() {
		contentView.addSubview(activityIndicator)
		
		NSLayoutConstraint.activate([
			activityIndicator.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
			activityIndicator.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
			activityIndicator.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
		])
		
		activityIndicator.startAnimating()
	}
}
