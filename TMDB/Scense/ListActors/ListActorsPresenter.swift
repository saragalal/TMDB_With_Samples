//
//  ListActorsPresenter.swift
//  TMDB
//
//  Created by sara.galal on 9/26/19.
//  Copyright © 2019 Ibtikar Technologies, Co. Ltd. All rights reserved.
//

import Foundation

class ListActorsPresenter: BasePresenter, ListActorsPresenterProtocal{
    var currentPage: Int
    var view: ListActorsViewProtocal?
    var model: ListActorsModelProtocal?
    required init(view: BaseViewProtocal, model: BaseModelProtocal) {
        self.view = view
        self.model = model
    }
    func activateSearch() {
        <#code#>
    }
    
    func cancelSearch() {
        <#code#>
    }
    
    func loadActors() {
        <#code#>
    }
    
    func refreshActores() {
        <#code#>
    }
    
    func loadMoreActores() {
        <#code#>
    }
}
