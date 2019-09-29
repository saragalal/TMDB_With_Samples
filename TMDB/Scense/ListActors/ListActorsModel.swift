//
//  ListActorsModel.swift
//  TMDB
//
//  Created by sara.galal on 9/26/19.
//  Copyright © 2019 Ibtikar Technologies, Co. Ltd. All rights reserved.
//

import Foundation

class ListActorsModel: BaseModel, ListActorsModelProtocal {
    func getActors(forPage page: Int, compelation: @escaping ((Result<Any, Error>) -> Void)) {
        NetworkManager.shared.getActors(pageNumber: page) { (response, statusCode) in
            if statusCode == 200{
                switch response {
                case .success(let result):
                    print("\(result)")
                    if let personsArray = result.results {
                    compelation(.success(personsArray))
                    }
                case .failure(let error):
                    print("\(error)")
                    compelation(.failure(error))
                }
            }
        }
    }
    func getSearchedActors(forPage page: Int,text: String ,compelation: @escaping ((Result<Any, Error>) -> Void)) {
        NetworkManager.shared.getSearchedActors(pageNumber: page,searchText: text) { (response, statusCode) in
            if statusCode == 200{
                switch response {
                case .success(let result):
                    print("\(result)")
                    if let personsArray = result.results {
                        compelation(.success(personsArray))
                    }
                case .failure(let error):
                    print("\(error)")
                    compelation(.failure(error))
                }
            }
        }
    }
    
}

