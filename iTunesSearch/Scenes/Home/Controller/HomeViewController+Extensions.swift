//
//  HomeViewController+Extensions.swift
//  iTunesSearch
//
//  Created by Emrullah Hancer on 24.08.2021.
//

import UIKit

extension HomeViewController: ViewModelDelegate {
    func success() {
        DispatchQueue.main.async {
            self.collectionView.performBatchUpdates({
                let indexSet = IndexSet(integersIn: 0...0)
                self.collectionView.reloadSections(indexSet)
                self.showIndicator = false
            }, completion: { _ in
                
            })
        }
    }
    
    func fail() {
        print("fail")
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.results?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeListCell.CellID, for: indexPath) as? HomeListCell else {
            return UICollectionViewCell()
        }
        if viewModel.results?.indices.contains(indexPath.row) ?? false {
            cell.result = viewModel.results?[indexPath.row]
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row + 1 == (viewModel.results?.count ?? 0) && viewModel.hasNext && !showIndicator {
            showIndicator = true
            let indexSet = IndexSet(integersIn: 0...0)
            self.collectionView.reloadSections(indexSet)
            viewModel.getData(term: self.terms, wrapperType: self.wrapperType)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionFooter && showIndicator {
            let view = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "footerView", for: indexPath)
            let indicatorView = UIActivityIndicatorView(frame: CGRect(x: (view.frame.width / 2) - 25, y: (view.frame.height / 2) - 25, width: 50, height: 50))
            indicatorView.color = .black
            indicatorView.style = .whiteLarge
            indicatorView.startAnimating()
            view.addSubview(indicatorView)
            return view
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: showIndicator ? 60 : 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if !(viewModel.results?.indices.contains(indexPath.row) ?? false) {
            return
        }
        guard let vc = UIStoryboard(name: "Detail", bundle: nil).instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController, let detail = viewModel.results?[indexPath.row] else {
            return
        }
        vc.detail = detail
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension HomeViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        if text.count >= 2 {
            terms = text
        } else {
            terms = "all"
        }
        DispatchQueue.global().async {
            self.operationsQueue.sync {
                self.fetchData(refresh: true)
            }
        }
    }
}
