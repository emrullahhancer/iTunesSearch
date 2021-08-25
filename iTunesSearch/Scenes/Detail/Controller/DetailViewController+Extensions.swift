//
//  DetailViewController+Extensions.swift
//  iTunesSearch
//
//  Created by Emrullah Hancer on 25.08.2021.
//

import UIKit

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailCell.CellID, for: indexPath) as? DetailCell else {
            return UITableViewCell()
        }
        cell.detail = detail
        return cell
        
    }
    
    
}
