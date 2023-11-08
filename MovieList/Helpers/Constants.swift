//
//  Constants.swift
//  MovieList
//
//  Created by Masud Onikeku on 07/11/2023.
//

import Foundation
import UIKit
import SwiftyJSON

class Constants {
    
    
    
    static let tmBlue = UIColor(red: 219/255, green: 227/255, blue: 255/255, alpha: 1.0)
    static let blu = UIColor(red: 136/255, green: 164/255, blue: 232/255, alpha: 1.0)
    
    
    
    static func boldFont(size: Int) -> UIFont {
        
        return UIFont(name: "Merriweather-Bold", size: CGFloat(size))!
    }
    
    static func regularFont(size: Int) -> UIFont {
        
        return UIFont(name: "Merriweather-Regular", size: CGFloat(size))!
    }
    
    
    static func lightFont(size: Int) -> UIFont {
        
        return UIFont(name: "Merriweather-Light", size: CGFloat(size))!
    }
    
    static let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
}

var appdelegate = UIApplication.shared.delegate

//var window = appdelegate?.window

// MARK: - Utility

var genres : [[String:Any]]?
// MARK: - Response Parameter

let PAGE = "page"
let RESULTS = "results"
let TOTAL_PAGES = "total_pages"
let TOTAL_RESULTS = "total_results"

// MARK: - APIS

let baseUrl = "https://api.themoviedb.org/3"

struct APIList {
    
    static let nowPlaying = "\(baseUrl)/movie/now_playing"
    static let popular = "\(baseUrl)/discover/movie?sort_by=popularity.desc"
    static let keyUrl = "https://electronics-7ba0a-default-rtdb.firebaseio.com/MovieBDKey.json"
    static let imageUrl = "https://image.tmdb.org/t/p/w500"
    static let genreUrl = "https://api.themoviedb.org/3/genre/movie/list"
    
}

