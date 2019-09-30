//
//  ListActorsAdaptor.swift
//  TMDB
//
//  Created by sara.galal on 9/29/19.
//  Copyright © 2019 Ibtikar Technologies, Co. Ltd. All rights reserved.
//

import Foundation
import UIKit
class ListActorsAdaptor: NSObject, BaseListAdapterProtocal {
    typealias DataType = Person
    var list: [Person]? = [Person]()
    var reloadData: (() -> Void)?
    var showEmptyState: ((Bool) -> Void)?
    var didSelectCell: ((Int) -> Void)?
    var showLoadingMore: (() -> Void)?
    var loadMoreActores: (() -> Void)?
    var tableView: UITableView!
    func setAdaptor(tableView: UITableView!, reloadData: (() -> Void)?, didSelectCell: ((Int) -> Void)?, showLoadingMore: (() -> Void)?, loadMoreActores: (() -> Void)?){
        self.tableView = tableView
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.reloadData = reloadData
        self.didSelectCell = didSelectCell
        self.showLoadingMore = showLoadingMore
        self.loadMoreActores = loadMoreActores
    }
    
    func add(item: Person) {
        
    }
    
    func add(items: [Person]?) {
        if let itemList = items{
        list?.append(contentsOf: itemList)
            reloadData?()
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
        reloadData?()
        }
    }
    func getActor(at cellNumber: Int) -> Person {
        if let item = list?[cellNumber] {
            return item
        }
        return Person()
    }
}
extension ListActorsAdaptor: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.count()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ListActorsTableViewCell", for: indexPath) as? ListActorsTableViewCell {
            let actor = self.getActor(at: indexPath.row)
                cell.configureCell(person: actor)
                return cell
        }
        fatalError()
    }
}
extension ListActorsAdaptor: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelectCell?(indexPath.row)
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let height = scrollView.frame.size.height
        let contentYoffset = scrollView.contentOffset.y
        let distanceFromBottom = scrollView.contentSize.height - contentYoffset
        if distanceFromBottom == height - 2 {
            showLoadingMore?()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                print(" you reached end of the table")
              self.loadMoreActores?()
            }
        }
    }
}
