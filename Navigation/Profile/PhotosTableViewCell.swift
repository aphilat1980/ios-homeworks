import UIKit

class PhotosTableViewCell: UITableViewCell {
    
    static let id = "photosTableViewCell_id"
    
    private lazy var image1: UIImageView = {
        let myImage  = UIImageView ()
        myImage.translatesAutoresizingMaskIntoConstraints = false
        //myImage.contentMode = .scaleAspectFit
        myImage.image = UIImage(named: "1")
        myImage.backgroundColor = .black
        myImage.layer.cornerRadius = 6
        myImage.clipsToBounds = true
        return myImage
    }()
    private lazy var image2: UIImageView = {
        let myImage  = UIImageView ()
        myImage.translatesAutoresizingMaskIntoConstraints = false
        //myImage.contentMode = .scaleAspectFit
        myImage.image = UIImage(named: "2")
        myImage.backgroundColor = .black
        myImage.layer.cornerRadius = 6
        myImage.clipsToBounds = true
        return myImage
    }()
    private lazy var image3: UIImageView = {
        let myImage  = UIImageView ()
        myImage.translatesAutoresizingMaskIntoConstraints = false
        //myImage.contentMode = .scaleAspectFit
        myImage.image = UIImage(named: "3")
        myImage.backgroundColor = .black
        myImage.layer.cornerRadius = 6
        myImage.clipsToBounds = true
        return myImage
    }()
    private lazy var image4: UIImageView = {
        let myImage  = UIImageView ()
        myImage.translatesAutoresizingMaskIntoConstraints = false
        //myImage.contentMode = .scaleAspectFit
        myImage.image = UIImage(named: "4")
        myImage.backgroundColor = .black
        myImage.layer.cornerRadius = 6
        myImage.clipsToBounds = true
        return myImage
    }()
    
    private lazy var myTitle: UILabel = {
        let label = UILabel ()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Photos"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = .black
        //label.numberOfLines = 2
        return label
    }()
    
    private lazy var arrowImage: UIImageView = {
        let myImage  = UIImageView ()
        myImage.translatesAutoresizingMaskIntoConstraints = false
        myImage.contentMode = .scaleAspectFit
        myImage.image = UIImage(systemName: "arrow.forward")
        myImage.tintColor = .black
        return myImage
    }()
    
    private lazy var grayLabel: UILabel = {
        let label = UILabel ()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.backgroundColor = .systemGray6
        return label
    }()
    
    private lazy var stackView: UIStackView = { [unowned self] in
        let stackView = UIStackView ()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.addArrangedSubview(self.image1)
        stackView.addArrangedSubview(self.image2)
        stackView.addArrangedSubview(self.image3)
        stackView.addArrangedSubview(self.image4)
        stackView.spacing = 8
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .white
        contentView.addSubview(stackView)
        contentView.addSubview(myTitle)
        contentView.addSubview(arrowImage)
        contentView.addSubview(grayLabel)
        setupConstraints()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupConstraints () {
        NSLayoutConstraint.activate([
            myTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            myTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            
            stackView.topAnchor.constraint(equalTo: myTitle.bottomAnchor, constant: 12),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            stackView.heightAnchor.constraint(equalToConstant: floor((UIScreen.main.bounds.width - 48) / 4)),
            
            
            arrowImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            arrowImage.centerYAnchor.constraint(equalTo: myTitle.centerYAnchor),
            
            grayLabel.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 12),
            grayLabel.heightAnchor.constraint(equalToConstant: 15),
            grayLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            grayLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            grayLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
   
    
    
    
}
