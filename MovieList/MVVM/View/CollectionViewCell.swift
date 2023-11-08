//
//  CollectionViewCell.swift
//  MovieList
//
//  Created by Masud Onikeku on 07/11/2023.
//

import UIKit
import SwiftyJSON

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var tagStack: UIStackView!
    @IBOutlet weak var durationText: UILabel!
    
    var id : [Int] = []
    var genre : [String] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.constraint(equalToTop: topAnchor, equalToBottom: bottomAnchor, equalToLeft: leadingAnchor, equalToRight: trailingAnchor)
    }
    
    func configure() {
        
        for view in tagStack.subviews {
            
            view.removeFromSuperview()
        }
        genre.removeAll()
        
        if let gen = genres {
            
            if !id.isEmpty && !gen.isEmpty {
                
                for n in id {
                    
                    for g in gen {
                        
                        for (_,value) in g {
                            
                            if let v = value as? JSON {
                                
                                if n == v.intValue {
                                    
                                    genre.append((g["name"] as! JSON).stringValue)
                                }
                            }
                            
                            
                        }
                    }
                }
            }
        }
        
        print(genres)
        populateGenres()
    }
    
    func populateGenres() {
        
        if !genre.isEmpty {
            
            for gen in 0...genre.count - 1 {
                
                if gen < 3 {
                    let view = UIView()
                    view.backgroundColor = Constants.tmBlue
                    view.cornerRadius = 4
                    
                    let label = UILabel()
                    label.text = genre[gen].capitalized
                    label.textColor = Constants.blu
                    label.font = Constants.regularFont(size: 8)
                    view.addSubview(label)
                    label.constraint(equalToTop: view.topAnchor,equalToBottom: view.bottomAnchor, equalToLeft: view.leadingAnchor, equalToRight: view.trailingAnchor, paddingTop: 4, paddingBottom: 4, paddingLeft: 4, paddingRight: 4)
                    
                    
                    tagStack.addArrangedSubview(view)
                }
            }
        }
    }
}
