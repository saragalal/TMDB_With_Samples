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
    var searchActivated = false
    init(view: ListActorsViewProtocal, model: ListActorsModelProtocal) {
        self.view = view
        self.model = model
        self.currentPage = 0
    }
    func viewDidLoad() {
        currentPage = 1
        getList()
    }
    func activateSearch() {
        searchActivated = true
    }
    
    func cancelSearch() {
        currentPage = 1
        searchActivated = false
        getList()
    }
    
    func loadActors() {
        getSearchedList()
    }
    
    func refreshActores() {
        removeDataFromTableView()
        currentPage = 1
        getList()
    }
    
    func loadMoreActores() {
        currentPage += 1
        if searchActivated{
           getSearchedList()
        }else {
        getList()
       }
    }
    func getList() {
        model?.getActors(forPage: currentPage, compelation: {result in
            switch result {
            case .success(let arrayOfPersons):
                print("\(arrayOfPersons)")
                let listActors = arrayOfPersons as? [Person]
                self.view?.add(actors: listActors)
                self.view?.updateTableView()
            case .failure(let error):
                print("\(error)")
               // self.view?.showErrorMessage?(title: "error", message: error.localizedDescription)
            }
        })
    }
    func getSearchedList() {
        if let searchText = view?.getSearchText() {
        model?.getSearchedActors(forPage: currentPage,text: searchText ,compelation: {result in
            switch result {
            case .success(let arrayOfPersons):
                print("\(arrayOfPersons)")
                let listActors = arrayOfPersons as? [Person]
                self.view?.add(actors: listActors)
                self.view?.updateTableView()
            case .failure(let error):
                print("\(error)")
                // self.view?.showErrorMessage?(title: "error", message: error.localizedDescription)
            }
        })
    }
}
    
    func removeDataFromTableView() {
        view?.clearData()
        view?.updateTableView()
    }
}
