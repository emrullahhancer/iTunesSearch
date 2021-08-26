//
//  HomeListCell.swift
//  iTunesSearch
//
//  Created by Emrullah Hancer on 24.08.2021.
//

import UIKit
import SDWebImage

final class HomeListCell: UICollectionViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    static let CellID = "HomeListCell"
    
    let df = DateFormatter()
    let dfDate = DateFormatter()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        df.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dfDate.setLocalizedDateFormatFromTemplate("dd.MM.yyyy")
    }

    var result: Results? {
        didSet {
            imageView.sd_setImage(with: URL(string: result?.artworkUrl100 ?? ""))
            titleLabel.text = result?.collectionName ?? ""
            priceLabel.text = "\(result?.collectionPrice ?? 0)\(result?.currency ?? "")"
            
            var releaseDate: String?
            if let date = df.date(from: result?.releaseDate ?? "") {
                releaseDate = dfDate.string(from: date)
            }
            dateLabel.text = releaseDate
        }
    }
}
