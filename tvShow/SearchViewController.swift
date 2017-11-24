//
//  SearchViewController.swift
//  tvShow
//
//  Created by Mauro Gonzalez on 23/11/2017.
//  Copyright © 2017 Mauro Gonzalez. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
	

	var list = [TVShow]()
	@IBOutlet weak var tvShowTableView: UITableView!
	@IBOutlet weak var searchTextField: UITextField!

	
    override func viewDidLoad() {
        super.viewDidLoad()
		self.navigationItem.backBarButtonItem?.title = ""
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

	
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.list.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "resultCell", for: indexPath) as! SearchCell
		
		cell.clearCell()
		// Configure the cell
		let program = self.list[indexPath.row]

		cell.loadProgram(program: program)
		
		return cell
	}

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let programSelected = self.list[indexPath.row]
		
		let viewController = self.storyboard!.instantiateViewController(withIdentifier: "ProgramDetail") as! ProgramDetailViewController
		viewController.program = programSelected
		
		self.navigationController?.pushViewController(viewController, animated: true)

	}
	
	@IBAction func searchButtonTapped(_ sender: Any) {
		
		guard let title = self.searchTextField.text else {
			return
		}
		self.searchTitle(title: title)
		
	}
	
	
	func searchTitle(title : String) {
		MoviesService().search(query: title, success: { (response) in
			self.list = response.results
			self.tvShowTableView.reloadData()
		}) { (error) in
			
		}

	}
	
	
}
