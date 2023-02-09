//
//  HomeViewController.swift
//  Login_App
//
//  Created by Henadzi on 27/11/2022.
//

import Foundation
import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet private weak var loginLabel: UILabel!
    @IBOutlet private weak var passwordLabel: UILabel!
    @IBOutlet private weak var lastTappedCellLabel: UILabel!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var getFactButton: UIButton!

    @IBAction func getFactTapped(_ sender: UIButton) {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        
        getFactButton.setTitle("", for: .normal)
        
        catFactService.getFactsAlamofireRequest()
        
        activityIndicator.isHidden = true
        activityIndicator.stopAnimating()
        
        getFactButton.setTitle("Get Facts", for: .normal)

//        catFactService.getFactAlamofireRequest { [weak self] catFact in
//            self?.activityIndicator.isHidden = true
//            self?.activityIndicator.stopAnimating()
//
//            self?.getFactButton.setTitle("Get Cat Fact", for: .normal)
//
//            self?.lastTappedCellLabel.text = catFact?.fact ?? ""
//            self?.lastTappedCellLabel.numberOfLines = 0
//        }
    }
    
    var loginText: String = ""
    var passwordText: String = ""
    let catFactService: CatFactService = CatFactService()
    
    private var tableViewDataArray: [HomeInnerVCProtocol] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        setup()
        lastTappedCellLabel.text = UserDefaults.standard.string(forKey: "LastTappedCellTitle")
    }
}

private extension HomeViewController {
    func setup() {
        if let userLoginData = UserDefaults.standard.object(forKey: userLogindataUDKey) as? [String] {
            loginLabel.text = userLoginData[0]
            passwordLabel.text = userLoginData[1]
        }
        
        activityIndicator.isHidden = true
        
        setupAppearance()
        setupTableView()
    }
    
    func setupTableView() {
        let cellNib = UINib(nibName: "HomeTableViewCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: "HomeTableViewCell")
    }
    
    func setupAppearance() {
        setupNavigation()
    }
    
    func setupNavigation() {
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationItem.setHidesBackButton(true, animated: true)
        
        let logoutBarButtonItem = UIBarButtonItem(
            image: .init(systemName: "plus.app.fill"),
            style: .plain,
            target: self,
            action: #selector(addTapped)
        )
        navigationItem.rightBarButtonItem  = logoutBarButtonItem
    }
    
    @objc func addTapped() {
        showAddActionSheet()
    }
    
    func showAddActionSheet() {
        let alertController = UIAlertController(
            title: "Add content",
            message: "What type of content do you want to add?",
            preferredStyle: .actionSheet
        )
        
        let addTextAction = UIAlertAction(
            title: "Longread",
            style: .default
        ) { [weak self] _ in
            self?.addContent(with: .longread(UUID().uuidString))
        }
        
        let addColorAction = UIAlertAction(
            title: "Color",
            style: .default
        ) { [weak self] _ in
            self?.addContent(with: .color(UIColor.random))
        }
        
        let addImageAction = UIAlertAction(
            title: "Image",
            style: .default
        ) { [weak self] _ in
            let imageName = "cellInnerBGImage" + String(Int.random(in: 1...4))
            self?.addContent(with: .image(.init(named: imageName)))
        }
        
        let cancelAction = UIAlertAction(
            title: "Cancel",
            style: .cancel
        )
        
        alertController.addAction(addTextAction)
        alertController.addAction(addColorAction)
        alertController.addAction(addImageAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    func addContent(with type: HomeInnerVCType) {
        switch type {
        case .longread(_):
            tableViewDataArray.append(LongreadData(type: type, title: "Longread"))
        case .color(_):
            tableViewDataArray.append(ColorData(type: type, title: "Color"))
        case .image(_):
            tableViewDataArray.append(ImageData(type: type, title: "Image"))
        }
        
        DispatchQueue.main.async {
            self.tableView.performBatchUpdates(
                {
                    self.tableView.insertRows(
                        at: [IndexPath(
                            row: self.tableViewDataArray.count - 1,
                            section: 0)],
                        with: .automatic
                    )
                },
                completion: nil
            )
        }
    }
}

// MARK: - UITableViewDelegate & UITableViewDataSource
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableViewDataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath) as? HomeTableViewCell {
            let item = tableViewDataArray[indexPath.row]
            cell.setup(with: item.title)
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "CellInnerViewController", bundle: nil)
        guard let innerVC = storyboard.instantiateViewController(withIdentifier: "CellInnerViewController") as? CellInnerViewController else { return }
        
        innerVC.setup(
            itemData: tableViewDataArray[indexPath.row],
            redButtonTapped: { [weak self] title in
                UserDefaults.standard.set(title, forKey: "LastTappedCellTitle")
                self?.lastTappedCellLabel.text = title
            }
        )
                
        navigationController?.show(innerVC, sender: nil)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableViewDataArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .left)
        }
    }    
}

// MARK: - CellInnerViewControllerDelegate
extension HomeViewController: CellInnerViewControllerDelegate {
    func buttonTapped(title: String) {
        lastTappedCellLabel.text = title
    }
}
