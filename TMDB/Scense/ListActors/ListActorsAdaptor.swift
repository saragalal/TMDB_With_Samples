//
//  ListActorsAdaptor.swift
//  TMDB
//
//  Created by sara.galal on 9/29/19.
//  Copyright © 2019 Ibtikar Technologies, Co. Ltd. All rights reserved.
//

import Foundation
class ListActorsAdaptor: BaseListAdapterProtocal {
    typealias DataType = Person
    var list: [Person]? = [Person]()
    var reloadData: (() -> Void)?
    var showEmptyState: ((Bool) -> Void)?
    
    func add(item: Person) {
        
    }
    
    func add(items: [Person]?) {
        if let itemList = items{
        list?.append(contentsOf: itemList)
        }
    }
    
    func update(item: Person) {
        
    }
    
    func count() -> Int {
        return list?.count ?? 0
    }
    
    func isLastIndex(index: IndexPath) -> Bool {
        return false
    }
    
    func clear(reload: Bool) {
        if reload {
        list = []
        }
    }
    func getActor(at cellNumber: Int) -> Person {
        if let item = list?[cellNumber] {
            return item
        }
        return Person()
    }
}
