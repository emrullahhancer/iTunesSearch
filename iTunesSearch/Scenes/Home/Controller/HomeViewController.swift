//
//  HomeViewController.swift
//  iTunesSearch
//
//  Created by Emrullah Hancer on 24.08.2021.
//

import UIKit

class HomeViewController: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK: - Variables
    var showIndicator = false
    var terms: String = "all"
    var wrapperType: String = "movie"
    let search = UISearchController()
    let operationsQueue = DispatchQueue.init(
        label: "search_operations_queue",
        qos: .default,
        attributes: .concurrent,
        autoreleaseFrequency: .inherit,
        target: nil
    )
    
    lazy var viewModel: HomeViewModel = {
        let viewModel = HomeViewModel()
        viewModel.delegate = self
        return viewModel
    }()
    
    //MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        drawViews()
        fetchData()
    }
    
    //MARK: - Functions
    func fetchData(refresh: Bool = false) {
        viewModel.getData(term: terms, wrapperType: wrapperType, refresh: refresh)
    }
    
    func drawViews() {
        initCollectionView()
        initSegments()
        initSearch()
    }
    
    func initCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.registerNib(HomeListCell.CellID)
        let layout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.size.width / 2
        layout.itemSize = CGSize(width: width - 5, height: width * 1.3)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 5
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.collectionViewLayout = layout
        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "footerView")
    }
    
    func initSegments() {
        segmentControl.addTarget(self, action: #selector(changeSegment), for: .valueChanged)
    }
    
    @objc func changeSegment(sender: UISegmentedControl) {
        guard let term = sender.titleForSegment(at: sender.selectedSegmentIndex) else {
            return
        }
        self.wrapperType = term.lowercased()
        fetchData(refresh: true)
        collectionView.setContentOffset(.zero, animated: true)
    }
    
    func initSearch() {
        search.searchResultsUpdater = self
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.placeholder = "Search"
        navigationItem.titleView = search.searchBar
        search.searchBar.searchBarStyle = .prominent
        definesPresentationContext = true
        search.hidesNavigationBarDuringPresentation = false
        search.searchBar.setValue("Cancel", forKey: "cancelButtonText")
    }
    
}
