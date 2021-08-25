//
//  DetailViewController.swift
//  iTunesSearch
//
//  Created by Emrullah Hancer on 25.08.2021.
//

import UIKit

class DetailViewController: UIViewController {
    //MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Variables
    var detail: Results?
    
    //MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        initTableView()
    }
    
    //MARK: - Functions
    func initTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.registerNib(DetailCell.CellID)
    }
}
