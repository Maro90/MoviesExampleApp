//
//  SearchResponse.swift
//  MoviesApp
//
//  Created by Matias Gualino on 7/19/17.
//  Copyright © 2017 Matias Gualino. All rights reserved.
//

import Foundation

class SearchResponse {
	var results: [TVShow]
	var total: Int
	var page: Int
	var totalPages: Int
	
	init(total: Int, page: Int, totalPages: Int, results: [TVShow]) {
		self.total = total
		self.page = page
		self.totalPages = totalPages
		self.results = results
	}
	
	static func fromJSON(json: [String: Any]) -> SearchResponse? {
		guard let total = json["total_results"] as? Int,
			let page = json["page"] as? Int,
			let totalPages = json["total_pages"] as? Int,
			let results = json["results"] as? [[String: Any]]
			else { return nil }
		
		var tvshows: [TVShow] = []
		results.forEach { json in
			guard let show = TVShow.fromJSON(json: json) else { return }
			tvshows.append(show)
		}
		
		return SearchResponse(total: total, page: page, totalPages: totalPages, results: tvshows)
	}
}

