//
//  MovieDetailTableCell.swift
//  MovieDirectory
//
//  Created by Dhritanshu Aggarwal on 28/07/24.
//

import UIKit

class MovieDetailTableCell: UITableViewCell {
    
    @IBOutlet weak var headlingLbl: UILabel!
    @IBOutlet weak var detailLbl: UILabel!
    
    var model: DetailItem? {
        didSet {
            updateView()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    private func updateView() {
        headlingLbl.text = model?.heading
        detailLbl.text = model?.detail
    }
}
