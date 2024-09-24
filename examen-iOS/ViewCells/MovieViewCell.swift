//
//  MovieViewCell.swift
//  examen-iOS
//
//  Created by Mañanas on 24/9/24.
//

import UIKit

class MovieViewCell: UITableViewCell {
    
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    
    func render (_ movie: Movie) {
        movieImageView.loadFrom(url: movie.poster)
        movieTitleLabel.text = movie.title
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
     

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
     

}
