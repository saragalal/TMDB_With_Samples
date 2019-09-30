//
//  ListActorsModule.swift
//  TMDB
//
//  Created by sara.galal on 9/26/19.
//  Copyright © 2019 Ibtikar Technologies, Co. Ltd. All rights reserved.
//

import Foundation

class ListActorsModule {
   class func createListActorsModule()  -> ListActorsViewController {
        let view = ListActorsViewController()
        let model = ListActorsModel()
        let presenter = ListActorsPresenter(view: view ,model: model)
        view.setPresenter(presenter: presenter) 
    return view
    }
  
}

