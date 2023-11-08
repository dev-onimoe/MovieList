//
//  HeaderViewCell.swift
//  MovieList
//
//  Created by Masud Onikeku on 07/11/2023.
//

import UIKit

class HeaderViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var rating: UILabel!
    
    var id : [Int] = []
    var genre : [String] = []
    
    
    func configure() {
        
        if let gen = genres {
            
            if !id.isEmpty && !gen.isEmpty {
                
                for n in id {
                    
                    for g in gen {
                        
                        for (_,value) in g {
                            
                            if let v = value as? Int {
                                
                                if n == v {
                                    
                                    genre.append(value as! String)
                                }
                            }
                            
                            
                        }
                    }
                }
            }
        }
    }
    
    
    
}
