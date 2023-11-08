//
//  DetailsViewController.swift
//  MovieList
//
//  Created by Masud Onikeku on 07/11/2023.
//

import UIKit
import SwiftyJSON

class DetailsViewController: UIViewController {
    
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var backImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var tagStack: UIStackView!
    @IBOutlet weak var length: UILabel!
    @IBOutlet weak var language: UILabel!
    @IBOutlet weak var pgRating: UILabel!
    @IBOutlet weak var descText: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var movie : Movie? = nil
    var genre : [String] = []
    
    var viewModel = ViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setup()
        setupUI()
    }
    
    func setupUI() {
        backImage.isUserInteractionEnabled = true
        backImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(goBack)))
        
        image.contentMode = .scaleToFill
    }
    
    @objc func goBack() {
        
        self.dismiss(animated: true)
    }
    
    func setup() {
        
        if let mov = movie {
            
            configure(mov: mov)
            image.setImageSd(url: APIList.imageUrl + (mov.backdrop_path ?? ""))
            titleLabel.text = mov.title
            rating.text = String(mov.vote_average ?? 0.0) + "/10"
            length.text = "1h 47m"
            descText.text = mov.overview
            language.text = mov.original_language == "en" ? "English" : "Ukraine"
            
            pgRating.text = mov.adult! ? "PG-18":"PG-13"
            
        }
    }
    
    func configure(mov: Movie) {
        
        if let gen = genres {
            
            if !mov.genre_ids!.isEmpty && !gen.isEmpty {
                
                for n in mov.genre_ids! {
                    
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
                    label.text = genre[gen]
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
    

