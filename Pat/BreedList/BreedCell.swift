import UIKit

class BreedCell: UITableViewCell {
    let favourites = Favourites.shared
    let favButton = UIButton()
    var updateFaveList: (() -> Void)?
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        favButton.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        favButton.addTarget(self, action: #selector(handleMarkAsFavourite), for: .touchUpInside)
        accessoryView = favButton
    }

    @objc private func handleMarkAsFavourite() {
        switchButtonImage()
        updateFaveList?()
    }

    func switchButtonImage() {
        guard let breed = textLabel?.text else { return }
        if favourites.isFavourite(breed: breed) {
            DispatchQueue.main.async {
                self.favButton.setImage(UIImage(systemName: "heart"), for: .normal)
            }
        } else {
            DispatchQueue.main.async {
                self.favButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            }
        }
    }

    func setButtonInitialImage(breed: String) {
        if favourites.isFavourite(breed: breed) {
            favButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        } else {
            favButton.setImage(UIImage(systemName: "heart"), for: .normal)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")

    }
}
