import CoreFoundation
import iOSIntPackage
import StorageService
import UIKit

class PhotosViewController: UIViewController {
    
    var photosDataProccessed:[UIImage] = []
    
    fileprivate lazy var photosData = PhotoImages.makeImageArray()
    //lazy var photosData: [UIImage] = []
   
    let imageProcessor = ImageProcessor()
    
    let facade = ImagePublisherFacade()
    
    private let collectionView: UICollectionView = {
        let viewLayout = UICollectionViewFlowLayout()
            
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: viewLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = Pallete.viewControllerBackgroundColor
            
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
        
        view.backgroundColor = Pallete.viewControllerBackgroundColor
        let titleText = NSLocalizedString("photosViewControllerTitle", comment: "")
        title = titleText
        navigationController?.navigationBar.backgroundColor = Pallete.viewControllerBackgroundColor
        view.addSubview(collectionView)
        setupConstraints()
        collectionView.dataSource = self
        collectionView.delegate = self
        //facade.subscribe(self)
        /*вариант вызова метода с изображениями из библиотеки iOSlntPackage
        facade.addImagesWithTimer(time: 0.5, repeat: 20)*/
        //вариант вызова метода со своими изображениями
        //facade.addImagesWithTimer(time: 0.5, repeat: 20, userImages: PhotoImages.makeImageArray())
        
        imageProcess(qos: .default, filter: .colorInvert)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        //facade.removeSubscription(for: self)
        //facade.rechargeImageLibrary()
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
    
    func imageProcess (qos: QualityOfService, filter: ColorFilter) {
        
        let start = CFAbsoluteTimeGetCurrent()
        imageProcessor.processImagesOnThread(sourceImages: photosData, filter: filter, qos: qos, completion: { sourceImages in
                for i in sourceImages {
                    self.photosDataProccessed.append(UIImage(cgImage: i!))
                }
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                    print ("duration is \(CFAbsoluteTimeGetCurrent() - start) seconds")
                }
         })
    }
        
}

extension PhotosViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        photosDataProccessed.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotosCollectionViewCell.id, for: indexPath) as! PhotosCollectionViewCell
        
        let profile = photosDataProccessed[indexPath.row]
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

/*extension PhotosViewController:  ImageLibrarySubscriber {
    func receive(images: [UIImage]) {
        self.photosData = images
        self.collectionView.reloadData()
    }
    
}*/
