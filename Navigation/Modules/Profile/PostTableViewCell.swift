
import UIKit
import StorageService

class PostTableViewCell: UITableViewCell {

    var completionHandler: (() -> Void)?
    
    static let id = "customTableView_id"
    
    var post : Post? {
     didSet {
         author.text = post?.author
         image.image = UIImage(named: post!.image)
         my_description.text = post?.my_description
         likes.text = "Likes: \(post!.likes)"
         views.text = "Views: \(post!.views)"
     }
     }
    
    lazy var author: UILabel = {
        let label = UILabel ()
        label.translatesAutoresizingMaskIntoConstraints = false
        //label.text = Post.author
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .black
        label.numberOfLines = 2
        return label
    }()
    
    lazy var image: UIImageView = {
        let myImage  = UIImageView ()
        myImage.translatesAutoresizingMaskIntoConstraints = false
        myImage.contentMode = .scaleAspectFit
        myImage.backgroundColor = .black
        myImage.clipsToBounds = true
        return myImage
    }()
    
    lazy var my_description: UILabel = {
        let label = UILabel ()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = label.font.withSize(14)
        label.textColor = .systemGray
        label.textAlignment = .justified
        label.numberOfLines = 0
        return label
    }()
    
    lazy var likes: UILabel = {
        let label = UILabel ()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = label.font.withSize(16)
        return label
    }()
    
    lazy var views: UILabel = {
        let label = UILabel ()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = label.font.withSize(16)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        let tapView = UITapGestureRecognizer( target: self, action: #selector(didTapView))
        tapView.numberOfTapsRequired = 2
        contentView.addGestureRecognizer(tapView)
        contentView.backgroundColor = .white
        contentView.addSubview(author)
        contentView.addSubview(image)
        contentView.addSubview(my_description)
        contentView.addSubview(likes)
        contentView.addSubview(views)
        setupConstraints()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        let screenWidth = contentView.bounds.width
        NSLayoutConstraint.activate([
           author.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
           author.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
           image.topAnchor.constraint(equalTo: author.bottomAnchor, constant: 12),
           image.widthAnchor.constraint(equalTo: contentView.widthAnchor),
           image.heightAnchor.constraint(equalToConstant: screenWidth),
           my_description.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 16),
           my_description.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
           my_description.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
           likes.topAnchor.constraint(equalTo: my_description.bottomAnchor, constant: 16),
           likes.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
           likes.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
           views.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
           views.topAnchor.constraint(equalTo: my_description.bottomAnchor, constant: 16)
        ])
    }
    
    @objc private func didTapView () {
        completionHandler?()
    }

}
