import UIKit

class BreedCell: UITableViewCell {
    let breedLabel = UILabel()
    let favButton = UIButton()
    let favourites = Favourites.shared
    var updateFaveList: ((UIButton) -> Void)?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        favButton.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        favButton.addTarget(self, action: #selector(handleMarkAsFavourite), for: .touchUpInside)
        accessoryView = favButton
    }

    @objc private func handleMarkAsFavourite() {
        toggleButton()
        updateFaveList?(favButton)
    }

    func labelIsInFaveList(label: String) -> Bool {
        let favList = Favourites.shared.getFavList()
        if favList.contains(label) {
            return true
        } else {
            return false
        }
    }

    func toggleButton() {
        favButton.isSelected = !favButton.isSelected
        guard let onImg = UIImage(systemName: "heart.fill"),
            let offImg = UIImage(systemName: "heart") else { return }
        DispatchQueue.main.async {
            self.setButtonImage(button: self.favButton,
            onImg: onImg,
            offImg: offImg,
            isOn: self.favButton.isSelected)
        }
    }

    func setButtonInitialImage(string: String) {
        if let favList = self.favourites.defaults.object(forKey: "favouritesListKey") as? [String] {
            if favList.contains(string) {
                favButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            } else {
                favButton.setImage(UIImage(systemName: "heart"), for: .normal)
            }
        }
    }

    func setButtonImage(button: UIButton, onImg: UIImage, offImg: UIImage, isOn: Bool ) {
        if isOn {
            button.setImage(onImg, for: .normal)
        } else {
            button.setImage(offImg, for: .normal)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")

    }
}
