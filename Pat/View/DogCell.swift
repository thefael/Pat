import UIKit

class DogCell: UITableViewCell {

//    let imageFetcher: ImageFetcher = .shared

    var dogImageView = UIImageView()
    var dogImage: UIImage?
    var imageData: Data? {
        didSet {
            self.setImage(using: imageData)
        }
    }
    var imageURL: URL? {
        didSet {
            self.loadImageData()
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

    func loadImageData() {
//        imageFetcher.loadImageData(from: imageURL)
//        self.imageData = self.imageFetcher.imageData
        if let dogImageURL = imageURL {
            DispatchQueue.global(qos: .background).async {
                do {
                    self.imageData = try Data(contentsOf: dogImageURL)
                } catch {
                    print("Unable to load data. \(error)")
                }
            }
        }
    }

    func setImage(using imageData: Data?) {
        DispatchQueue.main.async {
            self.dogImage = UIImage(data: imageData ?? Data())
            self.dogImageView.image = self.dogImage
        }
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
