//
//  AutoManufacturerViewController.swift
//  AutoCatalog
//
//  Created by Jagtap, Amol on 1/8/17.
//  Copyright © 2017 Amol Jagtap. All rights reserved.
//

import UIKit

class AutoManufacturerViewController: UIViewController, AutoManufacturerViewProtocol{

    //prsenter to handle view actions and display data in view
    var presenter:AutoManufacturerPresenterProtocol?
    
    @IBOutlet weak var tableView: UITableView!
    
    var manufacturers:[AutoManufacturerItem] = [AutoManufacturerItem](){
        didSet{
            
            UIView.performWithoutAnimation {
                tableView.reloadData()
                tableView.beginUpdates()
                tableView.endUpdates()
            }
            
        }
    }
    
    private lazy var activityIndicator:UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
        activity.center = self.view.center
        activity.hidesWhenStopped = true
        return activity
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "Manufacturers"
        
        tableView.register(UINib(nibName: "AutoManufacturerTableViewCell", bundle: nil), forCellReuseIdentifier: AutoManufacturerTableViewCell.reusableIdentifier)
        tableView.estimatedRowHeight = 50
        view.addSubview(activityIndicator)
        
        loadManufacturer()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Request manufacturers
    func loadManufacturer(){
        presenter?.fetchManufacturers()
    }
    
    //Display manufaturers
    func displayManufactures(manufacturer: [AutoManufacturerItem]?) {
        if let list = manufacturer {
            self.manufacturers += list
        }
    }
    
    func noContentMessage(message: String) {
        print(message)
    }
    
    func showLoadinView(show: Bool) {
        if show {
            activityIndicator.startAnimating()
        }else{
            activityIndicator.stopAnimating()
        }
    }

}

extension AutoManufacturerViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return manufacturers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AutoManufacturerTableViewCell.reusableIdentifier, for: indexPath) as! AutoManufacturerTableViewCell
        cell.title = manufacturers[indexPath.row].name
        if indexPath.row % 2 == 0 {
            cell.backgroundColor = UIColor.white
        }else{
            cell.backgroundColor = UIColor.lightGray
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let manufacturer = manufacturers[indexPath.row]
        presenter?.navigateToNextScreen(manufacturer: manufacturer)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == tableView.dataSource!.tableView(tableView, numberOfRowsInSection: indexPath.section) - 1 {
            presenter?.fetchManufacturers()
        }
    }
    
}
