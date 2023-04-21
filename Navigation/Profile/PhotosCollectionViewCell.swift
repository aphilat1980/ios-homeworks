

import UIKit
import StorageService

class PhotosCollectionViewCell: UICollectionViewCell {
    
    static let id = "photoCollectionViewCell_id"
    
    private lazy var image: UIImageView = {
        let myImage  = UIImageView ()
        myImage.contentMode = .scaleToFill
        myImage.translatesAutoresizingMaskIntoConstraints = false
        return myImage
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        contentView.backgroundColor = .black
        contentView.addSubview(image)
        setupConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
            
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: contentView.topAnchor),
            image.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            image.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            image.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
        
    }
    
    func setup( with profile: UIImage) {
        
        //image.image = UIImage(named: profile.photo)
        image.image = profile
    }
    
}
