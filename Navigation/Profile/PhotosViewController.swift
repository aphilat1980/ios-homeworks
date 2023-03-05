

import UIKit

class PhotosViewController: UIViewController {

    fileprivate lazy var photosData = PhotoImages.make()
    
    
    private let collectionView: UICollectionView = {
        let viewLayout = UICollectionViewFlowLayout()
            
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: viewLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
            
        collectionView.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: PhotosCollectionViewCell.id)
        
        return collectionView
    }()
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        collectionView.collectionViewLayout.invalidateLayout()
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        title = "Photo Gallery"
        navigationController?.navigationBar.backgroundColor = .systemGray6
        view.addSubview(collectionView)
        setupConstraints()
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    private func setupConstraints() {
        let safeAreaGuide = view.safeAreaLayoutGuide
            
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safeAreaGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor)
        ])
    }
    
}

extension PhotosViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        photosData.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotosCollectionViewCell.id, for: indexPath) as! PhotosCollectionViewCell
        
        let profile = photosData[indexPath.row]
        cell.setup(with: profile)
        return cell
    }
}
extension PhotosViewController: UICollectionViewDelegateFlowLayout {
    
    private func itemWidth() -> CGFloat {
        let spacing = 8.0
        let width = view.safeAreaLayoutGuide.layoutFrame.width
        let itemsInRow: CGFloat = 3.0
        let totalSpacing: CGFloat = 2.0 * spacing + (itemsInRow - 1.0) * spacing
        let finalWidth = (width - totalSpacing) / itemsInRow - 2
        return floor(finalWidth)
    }
    
   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
           let width = itemWidth()
           return CGSize(width: width, height: width)
       
   }
       
    func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    }

}

