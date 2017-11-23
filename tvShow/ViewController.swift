//
//  ViewController.swift
//  tvShow
//
//  Created by Mauro Gonzalez on 21/11/2017.
//  Copyright © 2017 Mauro Gonzalez. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
	@IBOutlet weak var tvShowCollectionView: UICollectionView!
	
	var list = [TVShow]()
	var programSelected : TVShow!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		
		MoviesService().search(query: "Breaking", success: { (response) in
			self.list = response.results
			self.tvShowCollectionView.reloadData()
		}) { (error) in
			
		}
		
		
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	
	
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return self.list.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "tvShowCell", for: indexPath) as! TVShowCollectionViewCell
		
		// Configure the cell
		let program = self.list[indexPath.row]
		
		if let imageURL = program.posterPath{
			cell.tvShowImage.imageURL(MoviesService().imageURL(path: imageURL))
		}
		
		return cell
	}

	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		
		self.programSelected = self.list[indexPath.row]
		
		let viewController = self.storyboard!.instantiateViewController(withIdentifier: "ProgramDetail") as! ProgramDetailViewController
		viewController.program = programSelected

		self.navigationController?.pushViewController(viewController, animated: true)
		
	}
}

