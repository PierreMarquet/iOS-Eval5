//
//  MovieCollectionViewCell.swift
//  iOS-Eval5
//
//  Created by Student05 on 10/11/2021.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var movieImage: UIImageView!
    @IBOutlet var movieNameLabel: UILabel!
    @IBOutlet var movieDateLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    func setupCell(tab: Results){
        //movieImage.backgroundColor = .gray
        //movieNameLabel.text = "Test 1"
        //movieDateLabel.text = "Test 2"
        
        
        movieNameLabel.text = tab.original_title
        movieDateLabel.text = tab.release_date
        
    }

}
