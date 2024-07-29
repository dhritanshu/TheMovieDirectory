//
//  MovieCollectionViewCell.swift
//  MovieDirectory
//
//  Created by Dhritanshu Aggarwal on 27/07/24.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var posterImg: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var releaseLbl: UILabel!
    
    var viewModel: Movie? {
        didSet {
            updateView()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        posterImg.image = UIImage(systemName: "popcorn")
    }

    func updateView() {
        titleLbl.text = viewModel?.title
        releaseLbl.text = viewModel?.year
        setImage()
    }
    
    private func setImage() {
        guard let posterString = viewModel?.poster else { return }
        posterImg.downloadImage(posterString) { [weak self] image in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                if let posterImage = image {
                    self?.posterImg.image = posterImage
                } else {
                    // set placeholder img
                    self?.posterImg.image = UIImage(systemName: "popcorn")
                }
            }
        }
    }
    
}
