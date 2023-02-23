import UIKit

class ProfileHeaderView: UIView {
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 4
        button.setTitle("Show status", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.shadowOffset = CGSize(width: 4.0, height: 4.0)
        button.layer.shadowRadius = 4.0
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.7
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        return button
        }()
    
    private var label1: UILabel = {
        let label1 = UILabel ()
        label1.translatesAutoresizingMaskIntoConstraints = false
        label1.text = "Hipster Cat"
        label1.font = UIFont.boldSystemFont(ofSize: 18)
        label1.textColor = .black
        return label1
    }()
    
    private var label2: UILabel = {
        let label2 = UILabel ()
        label2.translatesAutoresizingMaskIntoConstraints = false
        label2.text = "Waiting for something..."
        label2.font = label2.font.withSize(14)
        label2.textColor = .gray
        return label2
    }()
    
    private var myImage: UIImageView = {
        let myImage  = UIImageView ()
        myImage.translatesAutoresizingMaskIntoConstraints = false
        myImage.image = UIImage(named: "avatar")
        myImage.layer.borderWidth = 3
        myImage.layer.borderColor = UIColor.white.cgColor
        myImage.layer.cornerRadius = 60
        myImage.clipsToBounds = true
        return myImage
    }()
    
    override func didMoveToSuperview () {
        self.addSubview(button)
        self.addSubview(label2)
        self.addSubview(myImage)
        self.addSubview(label1)
        setupObjects()
    }
    
    
    private func setupObjects () {
        label1.topAnchor.constraint(equalTo: self.topAnchor, constant: 27).isActive = true
        label1.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        myImage.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16).isActive = true
        myImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 16).isActive = true
        myImage.widthAnchor.constraint(equalToConstant: 120).isActive = true
        myImage.heightAnchor.constraint(equalToConstant: 120).isActive = true
        button.trailingAnchor.constraint(equalTo: superview!.safeAreaLayoutGuide.trailingAnchor, constant:-16.0).isActive = true
        button.leadingAnchor.constraint(equalTo: superview!.safeAreaLayoutGuide.leadingAnchor, constant: 16.0).isActive = true
        button.topAnchor.constraint(equalTo: myImage.bottomAnchor, constant: 16).isActive = true
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        label2.bottomAnchor.constraint(equalTo: button.topAnchor, constant: -34).isActive = true
        label2.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 30).isActive = true
        
        }
    
    @objc func buttonPressed(_ sender: UIButton) {
        if let text2 = label2.text {
            print (text2)
        }
        }
    
}
