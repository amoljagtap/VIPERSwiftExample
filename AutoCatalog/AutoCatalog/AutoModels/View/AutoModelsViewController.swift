//
//  AutoModelsViewController.swift
//  AutoCatalog
//
//  Created by Jagtap, Amol on 1/8/17.
//  Copyright © 2017 Amol Jagtap. All rights reserved.
//

import UIKit


class AutoModelsViewController: UIViewController, AutoModelsViewProtocol {
    
    var presenter:AutoModelsPresenterProtocol?
    
    internal var models: [AutoModelsItem] = [AutoModelsItem]()
    
    var manufacturer:String?
    
    @IBOutlet weak var tableView: UITableView!
    
    private lazy var activityIndicator:UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
        activity.center = self.view.center
        activity.hidesWhenStopped = true
        return activity
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.register(UINib(nibName: "AutoManufacturerTableViewCell", bundle: nil), forCellReuseIdentifier: AutoManufacturerTableViewCell.reusableIdentifier)
        view.addSubview(activityIndicator)
        loadAutoModels()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
    func loadAutoModels(){
       presenter?.getAutoModels()
    }
    
    func setTitle(title:String){
        self.title = title
    }
    
    func displayAutoModels(models: [AutoModelsItem]?) {
        if let list = models {
            self.models += list
            tableView.reloadData()
        }
    }
    
    func showLoadinView(show: Bool) {
        if show {
            activityIndicator.startAnimating()
        }else{
            activityIndicator.stopAnimating()
        }
    }

    func noContentMessage(message: String) {
        print(message)
    }
}

extension AutoModelsViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AutoManufacturerTableViewCell.reusableIdentifier, for: indexPath) as! AutoManufacturerTableViewCell
        cell.title = models[indexPath.row].name
        if indexPath.row % 2 == 0 {
            cell.backgroundColor = UIColor.white
        }else{
            cell.backgroundColor = UIColor.lightGray
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter?.model = models[indexPath.row]
        presenter?.presentModelInfo()
    }
    
}



