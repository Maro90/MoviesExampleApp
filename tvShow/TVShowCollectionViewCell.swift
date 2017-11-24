//
//  TVShowCollectionViewCell.swift
//  tvShow
//
//  Created by Mauro Gonzalez on 21/11/2017.
//  Copyright © 2017 Mauro Gonzalez. All rights reserved.
//

import UIKit

class TVShowCollectionViewCell: UICollectionViewCell {
	@IBOutlet weak var tvShowImage: UIImageView!
	
	
	func loadProgram(program : TVShow) {
		if let imageURL = program.posterPath{
			tvShowImage.imageURL(MoviesService().imageURL(path: imageURL), placeholder: #imageLiteral(resourceName: "moviePlaceholder"))
		}else{
			tvShowImage.image = #imageLiteral(resourceName: "moviePlaceholder")
		}
	}

	
	func clearCell() {
		self.tvShowImage?.image = nil
	}

}
