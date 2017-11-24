//
//  ProgramDetailViewController.swift
//  tvShow
//
//  Created by Mauro Gonzalez on 22/11/2017.
//  Copyright © 2017 Mauro Gonzalez. All rights reserved.
//

import UIKit

class ProgramDetailViewController: UIViewController {

	@IBOutlet weak var image: UIImageView!

	var program : TVShow!
	
    override func viewDidLoad() {
        super.viewDidLoad()

		self.title = program.name
		if let imageURL = program.posterPath{
			image.imageURL(MoviesService().imageURL(path: imageURL), placeholder: #imageLiteral(resourceName: "moviePlaceholder"))
		}else{
			image.image = #imageLiteral(resourceName: "moviePlaceholder")
		}
		
		
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
