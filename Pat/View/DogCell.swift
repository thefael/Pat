import UIKit

class DogCell: UITableViewCell {

    let imageFetcher: ImageFetcher = .shared

    var dogImageView = UIImageView()
    var imageURL: URL? {
        didSet {
            imageFetcher.fetchImage(from: imageURL, into: dogImageView)
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        dogImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(dogImageView)
        configureImageView()
        setImageContstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureImageView() {
        dogImageView.clipsToBounds = true
    }

    func setImageContstraints() {
        dogImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        dogImageView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor).isActive = true
        dogImageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
        dogImageView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor).isActive = true
        dogImageView.contentMode = .scaleAspectFill
    }
}

extension DogCell: UITableViewDelegate {
    override func prepareForReuse() {
        dogImageView.image = nil
        if let url = imageURL {
            URLSession.shared.dataTask(with: url).suspend()
        }
    }
}
