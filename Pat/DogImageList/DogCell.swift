import UIKit

class DogCell: UITableViewCell {

    var dogImageView = UIImageView()
    var imageURL: URL? {
        didSet {
            dogImageView.fetchImage(from: imageURL) { result in
                switch result {
                case .failure(let error):
                    print("Failed trying to fetch image. \(error)")
                case .success(let image):
                    self.dogImageView.image = image
                    ImageCache.shared.imageCache[self.imageURL!] = image
                }
            }
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
    }
}
