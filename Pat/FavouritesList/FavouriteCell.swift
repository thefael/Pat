import UIKit

class FavouriteCell: UITableViewCell {

    var breed = String()
    let imageViews = [UIImageView](repeating: UIImageView(), count: 4)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        configureImageViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureImageViews() {
        for imageView in imageViews {
            imageView.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(imageView)
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        }
        imageViews[0].leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        imageViews[0].widthAnchor.constraint(equalToConstant: (UIScreen.main.bounds.size.width/4)).isActive = true

        imageViews[1].leftAnchor.constraint(equalTo: imageViews[0].rightAnchor).isActive = true
        imageViews[1].widthAnchor.constraint(equalToConstant: (UIScreen.main.bounds.size.width/4)).isActive = true

        imageViews[2].leftAnchor.constraint(equalTo: imageViews[1].rightAnchor).isActive = true
        imageViews[2].widthAnchor.constraint(equalToConstant: (UIScreen.main.bounds.size.width/4)).isActive = true

        imageViews[3].leftAnchor.constraint(equalTo: imageViews[2].rightAnchor).isActive = true
        imageViews[3].widthAnchor.constraint(equalToConstant: (UIScreen.main.bounds.size.width/4)).isActive = true

    }
}
