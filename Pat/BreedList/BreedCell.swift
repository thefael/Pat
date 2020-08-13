import UIKit

class BreedCell: UITableViewCell {
    let breedLabel = UILabel()
    let favButton = UIButton()
    var updateFaveList: ((UIButton) -> Void)?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        favButton.setImage(UIImage(systemName: "heart"), for: .normal)
        favButton.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        favButton.addTarget(self, action: #selector(handleMarkAsFavourite), for: .touchUpInside)
        accessoryView = favButton
    }

    @objc private func handleMarkAsFavourite() {
        toggleButton()
        updateFaveList?(favButton)
    }

    func toggleButton() {
        favButton.isSelected = !favButton.isSelected
        guard let onImg = UIImage(systemName: "heart.fill"),
            let offImg = UIImage(systemName: "heart") else { return }
        DispatchQueue.main.async {
            self.setButtonImage(view: self.favButton,
            onImg: onImg,
            offImg: offImg,
            onOffStatus: self.favButton.isSelected)
        }
    }

    func setButtonImage(view: UIButton, onImg: UIImage, offImg: UIImage, onOffStatus: Bool ) {
        switch onOffStatus {
        case true:
            view.setImage(onImg, for: .normal)
            print("Button Pressed")
        default:
            view.setImage(offImg, for: .normal)
            print("Button Unpressed")
        }
        self.setNeedsLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")

    }
}
