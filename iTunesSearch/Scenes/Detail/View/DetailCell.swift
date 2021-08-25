//
//  DetailCell.swift
//  iTunesSearch
//
//  Created by Emrullah Hancer on 25.08.2021.
//

import UIKit

final class DetailCell: UITableViewCell {

    @IBOutlet weak var detailImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    static let CellID = "DetailCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    var detail: Results? {
        didSet {
            let imageURL = detail?.artworkUrl100?.replace(target: "100x100", withString: "900x900") ?? ""
            detailImage.sd_setImage(with: URL(string: imageURL))
            titleLabel.text = detail?.collectionName
            descriptionLabel.text = detail?.longDescription
        }
    }
}
