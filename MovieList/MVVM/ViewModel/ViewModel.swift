//
//  ViewModel.swift
//  MovieList
//
//  Created by Masud Onikeku on 07/11/2023.
//

import Foundation

class ViewModel {
    
    var nwModelResponse : Observable<Response?> = Observable(nil)
    var poModelResponse : Observable<Response?> = Observable(nil)
    var keyResponse : Observable<Response?> = Observable(nil)
    var genreResponse : Observable<Response?> = Observable(nil)
    
    var key = ""
    var keyPath = ""
    
    init() {
        if let apik = UserDefaults.standard.object(forKey: "apiKey") as? String {
            
            self.key = apik
            keyPath = "&api_key=\(apik)"
        }else {
            
            getKey()
        }
    }
    
    
    func getKey() {
        
        Service.sharedInstance().callApi(APIList.keyUrl, isLoader: false, param: nil, method: .get, header: nil, completionHandler: {[weak self] err,response  in
            
            if let error = err {
                Utility.showErrorMessage(msg: error.localizedDescription)
            }else {
                
                if let json = response{
                    print(json)
                    let key = json["key"]
                    self?.key = key.stringValue
                    self?.keyPath = "&api_key=\(self!.key)"
                    UserDefaults.standard.set(key.stringValue, forKey: "apiKey")
                    self?.keyResponse.value = Response(check: true, description: "", object: key.stringValue)
                    self?.getGenres()
                }
            }
            
        })
    }
    
    func getNowPlaying() {
        
        
        
        Service.sharedInstance().callApi(APIList.nowPlaying + "?api_key=\(key)", isLoader: false, param: nil, method: .get, header: nil, completionHandler: {[weak self] err,response  in
            
            if let error = err {
                Utility.showErrorMessage(msg: error.localizedDescription)
            }else {
                
                if let json = response{
                    //print(json)
                    let data = try?  json[RESULTS].rawData()
                    if let data = data {
                        let movies = try? JSONDecoder().decode([Movie].self, from: data)
                        if let movies = movies {
                            self?.nwModelResponse.value = Response(check: true, description: "", object: movies)
                        }else {
                            print("movies couldnt be parsed")
                        }
                    }else {
                        print("JSON couldnt be parsed")
                    }
                }
            }
            
        })
    }
    
    func getPopular() {
        
        Service.sharedInstance().callApi(APIList.popular + keyPath, isLoader: false, param: nil, method: .get, header: nil, completionHandler: {[weak self] err,response  in
            
            if let error = err {
                Utility.showErrorMessage(msg: error.localizedDescription)
            }else {
                
                if let json = response{
                    //print(json)
                    let data = try?  json[RESULTS].rawData()
                    if let data = data {
                        let movies = try? JSONDecoder().decode([Movie].self, from: data)
                        if let movies = movies {
                            self?.poModelResponse.value = Response(check: true, description: "", object: movies)
                        }else {
                            print("movies couldnt be parsed")
                        }
                    }else {
                        print("JSON couldnt be parsed")
                    }
                }
            }
            
        })
    }
    
    func getGenres() {
        
        Service.sharedInstance().callApi(APIList.genreUrl + "?api_key=\(key)", isLoader: false, param: nil, method: .get, header: nil, completionHandler: {[weak self] err,response  in
            
            if let error = err {
                Utility.showErrorMessage(msg: error.localizedDescription)
            }else {
                
                if let json = response{
                    //print(json)
                    let data = try?  json["genres"]
                    let genre = data?.arrayValue.map({d in
                        d.dictionaryValue
                    })
                    genres = genre
                    self?.genreResponse.value = Response(check: true, description: "", object: genre)
                }
            }
            
        })
    }
}
