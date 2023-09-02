import UIKit

class InfoViewController: UIViewController {
    
    override var overrideUserInterfaceStyle: UIUserInterfaceStyle {
        get {
            .light
        } set {
        }
    }
    
    var residentsNames: [String] = []
    
    var residentsTable: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    
  private lazy var button: CustomButton = {
        let title = NSLocalizedString("infoViewControllerButtonTitle", comment: "")
        let button = CustomButton(title: title, radius: 8, backColor: .systemBlue)
        button.completionHandler = {self.buttonPressed()}
        return button
  }()
    
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel ()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var orbitalPeriodLabel: UILabel = {
        let label = UILabel ()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.numberOfLines = 2
        return label
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        residentsTable.dataSource = self
        residentsTable.delegate = self
        
        view.backgroundColor = .white
        view.addSubview(button)
        view.addSubview(titleLabel)
        view.addSubview(orbitalPeriodLabel)
        view.addSubview(residentsTable)
        
        setupConstraints()
        networkRequests()
        
      
    }
   
    func networkRequests () {
        
        NetworkManager().requestFromUrl1 {title in
            DispatchQueue.main.async {
                self.titleLabel.text = title
                }
        }
        
        NetworkManager().requestFromUrl2 {answer in
            DispatchQueue.main.async {
                let text = NSLocalizedString("infoViewControllerPlanetText", comment: "")
                self.orbitalPeriodLabel.text = text + "\(answer)"
                }
        }
        
        NetworkManager().requestResidentsArray {answer in
            for i in answer {
                NetworkManager().requestResidentName (url: i) { name in
                    self.residentsNames.append(name)
                    DispatchQueue.main.async {
                        self.residentsTable.reloadData()
                    }
                }
            }
        }
        
    }
    
    func setupConstraints () {
        let safeAreaLayoutGuide = view.safeAreaLayoutGuide
            NSLayoutConstraint.activate([
                button.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor,constant: 20.0),
                button.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor,constant: -20.0),
                button.topAnchor.constraint(equalTo:safeAreaLayoutGuide.topAnchor, constant: 20),
                button.heightAnchor.constraint(equalToConstant: 44.0),
                titleLabel.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 20),
                titleLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
                titleLabel.trailingAnchor.constraint(equalTo:safeAreaLayoutGuide.trailingAnchor, constant: -20),
                orbitalPeriodLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
                orbitalPeriodLabel.trailingAnchor.constraint(equalTo:safeAreaLayoutGuide.trailingAnchor, constant: -20),
                orbitalPeriodLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
                
                residentsTable.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor,constant: 20.0),
                residentsTable.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor,constant: -20.0),
                residentsTable.topAnchor.constraint(equalTo:orbitalPeriodLabel.bottomAnchor, constant: 20),
                residentsTable.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
    
    
    @objc func buttonPressed() {
        let alertTitle = NSLocalizedString("infoViewControllerAlertTitle", comment: "")
        let alertMessage = NSLocalizedString("infoViewControllerAlertMessage", comment: "")
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        let alertAction1Title = NSLocalizedString("infoViewControllerAlertAction1Title", comment: "")
        let alertAction1Result = NSLocalizedString("infoViewControllerAlertAction1ResultText", comment: "")
        let action1 = UIAlertAction(title: alertAction1Title, style: .default, handler: {action in print(alertAction1Result)})
        let alertAction2Title = NSLocalizedString("infoViewControllerAlertAction2Title", comment: "")
        let alertAction2Result = NSLocalizedString("infoViewControllerAlertAction2ResultText", comment: "")
        let action2 = UIAlertAction(title: alertAction2Title, style: .default, handler: {action in print(alertAction2Result)})
        alert.addAction(action1)
        alert.addAction(action2)
        present(alert, animated: true)
        }
}


extension InfoViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return residentsNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = residentsNames[indexPath.row]
        return cell
    }
    
    
}


extension InfoViewController: UITableViewDelegate {
    
}
