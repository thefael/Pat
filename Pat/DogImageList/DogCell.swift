import UIKit

class DogCell: UITableViewCell {

    let imageCache = ObjectCache.shared
    var dogImageView = UIImageView()
    var imageTask: URLSessionDataTask?
    var imageURL: URL? {
        didSet {
            imageTask = dogImageView.fetchImage(from: imageURL) { result in
                switch result {
                case .failure(let error):
                    print(error.localizedDescription.description)
                case .success(let image):
                    self.dogImageView.image = image
                    if let imageURL = self.imageURL {
                        self.imageCache.put(url: imageURL, data: image)
                    }
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

extension DogCell {
    override func prepareForReuse() {
        super.prepareForReuse()
        dogImageView.image = nil
        imageTask?.cancel()
    }
}
