//
//  SearchCell.swift
//  tvShow
//
//  Created by Mauro Gonzalez on 23/11/2017.
//  Copyright © 2017 Mauro Gonzalez. All rights reserved.
//

import UIKit

class SearchCell: UITableViewCell {

	@IBOutlet weak var title: UILabel!
	@IBOutlet weak var gender: UILabel!
	@IBOutlet weak var resultImage: UIImageView!

	
	func loadProgram(program : TVShow) {
		self.title.text = program.name
		if let imageURL = program.posterPath{
			resultImage.imageURL(MoviesService().imageURL(path: imageURL), placeholder: #imageLiteral(resourceName: "moviePlaceholder"))
		}else{
			resultImage.image = #imageLiteral(resourceName: "moviePlaceholder")
		}
	}
	
	func clearCell() {
		self.title.text = ""
		self.gender.text = ""
		self.imageView?.image = nil
	}
	
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
