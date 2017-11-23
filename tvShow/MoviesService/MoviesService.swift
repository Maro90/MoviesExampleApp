//
//  MoviesService.swift
//  tvShow
//
//  Created by Mauro Gonzalez on 21/11/2017.
//  Copyright © 2017 Mauro Gonzalez. All rights reserved.
//

import Foundation
import Alamofire

class MoviesService :NSObject {
	
	var headers = [String : String]()
	
	static let BASE_URL : String = "https://api.themoviedb.org/"
	static let API_KEY : String = "208ca80d1e219453796a7f9792d16776"
	
	static let BASE_IMAGE_URL : String = "https://image.tmdb.org/t/p/w138_and_h175_bestv2"
	
	static let SEARCH_URI : String = "3/search/tv"
	
	func manager() -> SessionManager {
		if let HTTPAdditionalHeaders = Alamofire.SessionManager.default.session.configuration.httpAdditionalHeaders {
			for header in HTTPAdditionalHeaders {
				if
					let key = header.0 as? String,
					let value = header.1 as? String
				{
					self.headers[key] = value
				}
			}
		}
		
		return Alamofire.SessionManager.default
	}

	
	func search(query: String, success: @escaping ((SearchResponse) -> Void), failure: @escaping ((NSError) -> Void)) {
		
		guard let url = MoviesService.url(for: MoviesService.SEARCH_URI, key: MoviesService.API_KEY, items: ["query": query])
			else { return failure(NSError(domain: "Movies", code: -1, userInfo: ["message":"cannot read url"])) }

		print("\(url)")
		manager().request(url, headers: self.headers ).responseJSON { response in
			guard let json = response.result.value as? [String : Any] else{
				failure(NSError(domain: "Movies", code: -2, userInfo: ["message":"cannot decode response"]))
				return
			}
			
			if let searchResponse = SearchResponse.fromJSON(json: json) {
				success(searchResponse)
			} else {
				failure(NSError(domain: "Movies", code: -2, userInfo: ["message":"cannot decode response"]))
			}
		}
	}

	
	
	
//	static func search(query: String, success: @escaping ((SearchResponse) -> Void), failure: @escaping ((NSError) -> Void)) {
//		guard let url = url(for: SEARCH_URI, key: API_KEY, items: ["query": query])
//			else { return failure(NSError(domain: "Movies", code: -1, userInfo: ["message":"cannot read url"])) }
//		self.request(url: url, success: { json in
//			if let searchResponse = SearchResponse.fromJSON(json: json) {
//				success(searchResponse)
//			} else {
//				failure(NSError(domain: "Movies", code: -2, userInfo: ["message":"cannot decode response"]))
//			}
//		}, failure: { error in
//			failure(error)
//		})
//	}
//
//	// TODO: GET Genre for TVShow
//
//	private static func request(url: URL, success: @escaping (_ jsonResult: [String:Any]) -> Void, failure: ((_ error: NSError) -> Void)?) {
//
//		UIApplication.shared.isNetworkActivityIndicatorVisible = true
//
//		let session = URLSession(configuration: URLSessionConfiguration.default)
//		let request: NSMutableURLRequest = NSMutableURLRequest(url: url)
//		request.httpMethod = "GET"
//
//		let task = session.dataTask(with: request as URLRequest) { (data, response, error) in
//			UIApplication.shared.isNetworkActivityIndicatorVisible = false
//			if let error = error {
//				failure?(error as NSError)
//			} else {
//				if let data = data {
//					if let json = try? JSONSerialization.jsonObject(with: data, options: []) {
//						if let jsonDic = json as? [String: Any] {
//							success(jsonDic)
//						} else {
//							self.failureDecodeResponse(failure: failure)
//						}
//					} else {
//						self.failureDecodeResponse(failure: failure)
//					}
//				} else {
//					self.failureDecodeResponse(failure: failure)
//				}
//			}
//		}
//		task.resume()
//	}
//
//	static func failureDecodeResponse(failure: ((_ error: NSError) -> Void)?) {
//		let e: NSError = NSError(domain: "Movies", code: NSURLErrorCannotDecodeContentData, userInfo: nil)
//		failure?(e)
//	}
//
	
	
	func imageURL(path:String) -> String {
		return "\(MoviesService.BASE_IMAGE_URL)\(path)"
	}
	
	
	
	private static func url(for path: String, key: String, items: [String: String] = [:]) -> URL? {
		
		var query = "?api_key=" + key
		items.forEach { query = query + "&" + $0 + "=" + $1 }
		let url = BASE_URL + path + query
		return URL(string: url)
	}
	
}
