import UIKit

class DogCell: UITableViewCell {

    var dogImageView = UIImageView()

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
        dogImageView.layer.cornerRadius = 10
        dogImageView.clipsToBounds = true
    }

    func setImageContstraints() {
        dogImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        dogImageView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        dogImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        dogImageView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
    }
}
