//
//  ListActorsViewController.swift
//  Sample MVP
//
//  Created by Bassem Abbas on 9/18/19.
//  Copyright © 2019 Ibtikar Technologies, Co. Ltd. All rights reserved.
//

import UIKit

class ListActorsViewController: BaseViewController<ListActorsPresenter> {
     @IBOutlet weak var tableView: UITableView!
    var listActorsPresenter: ListActorsPresenterProtocal?
    var listActorsAdaptor: ListActorsAdaptor?
    let searchBar = UISearchBar()
    var searchPerson: String? = ""
     override func viewDidLoad() {
        tableView.dataSource = self
        tableView.delegate = self
        self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.register(UINib(nibName: "ListActorsTableViewCell", bundle: nil), forCellReuseIdentifier: "ListActorsTableViewCell")
        listActorsAdaptor = ListActorsAdaptor()
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.accessibilityIdentifier = "refresh_control_label"
        tableView.refreshControl?.attributedTitle = NSAttributedString(string: "Refresh")
        tableView.refreshControl?.addTarget(self, action: #selector(refresh(sender:)), for: UIControl.Event.valueChanged)
        self.tableView.addSubview(self.tableView.refreshControl!)
        searchBar.delegate = self
        searchBar.showsCancelButton = true
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem(rawValue: 12)! , target: self, action: #selector(searchFunc))
        navigationItem.title = "Home"
        listActorsPresenter?.viewDidLoad?()
    }
    @objc func refresh(sender:AnyObject) {
        URLCache.shared.removeAllCachedResponses()
        searchBar.resignFirstResponder()
        searchBar.endEditing(true)
        searchBar.text = ""
       listActorsPresenter?.refreshActores()
    }
   
    @IBAction func searchFunc (sender:AnyObject) {
       // searchIsPressed = true
        listActorsPresenter?.activateSearch()
        self.searchBar.text = ""
        self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        self.navigationItem.rightBarButtonItem = nil
        createSearchBar()
        setGestures()
    }
    func setGestures(){
        
        let keyboardTap = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        keyboardTap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(keyboardTap)
        
    }
    @objc func hideKeyboard(){
        print("hideKeyboard")
        searchBar.resignFirstResponder()
        self.view.endEditing(true)
        if let cancelButton = self.searchBar.value(forKey: "cancelButton") as? UIButton {
            cancelButton.isEnabled = true
        }
    }
    
    func createSearchBar(){
        self.searchBar.showsCancelButton = true
        searchBar.placeholder = "Search Person"
        self.searchBar.becomeFirstResponder()
        self.searchBar.tintColor = UIColor.lightGray
        self.navigationItem.titleView = searchBar
        self.view.endEditing(false)
    }
}

extension ListActorsViewController: ListActorsViewProtocal {
    func getSearchText() -> String? {
        return searchPerson
    }
    
    func clearData() {
        listActorsAdaptor?.clear(reload: true)
    }
    
    func add(actors: [Person]?) {
       listActorsAdaptor?.add(items: actors)
    }
    
    func updateTableView() {
        self.tableView.reloadData()
        if self.tableView.refreshControl?.isRefreshing ?? false
            {
                self.tableView.refreshControl?.endRefreshing()
            }
      }
}
extension ListActorsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listActorsAdaptor?.count() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ListActorsTableViewCell", for: indexPath) as? ListActorsTableViewCell {
            if let actor = listActorsAdaptor?.getActor(at: indexPath.row){
          cell.configureCell(person: actor)
        return cell
            }
        }
        fatalError()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let height = scrollView.frame.size.height
        let contentYoffset = scrollView.contentOffset.y
        let distanceFromBottom = scrollView.contentSize.height - contentYoffset
        if distanceFromBottom == height - 5 {
            print(" you reached end of the table")
           listActorsPresenter?.loadMoreActores()
        }
    }
}
extension ListActorsViewController: UISearchBarDelegate {
   
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("textDidChange")
        listActorsAdaptor?.clear(reload: true)
        tableView.reloadData()
        searchPerson = searchText
        
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("searchBarSearchButtonClicked")
        searchBar.resignFirstResponder()
        if let cancelButton = self.searchBar.value(forKey: "cancelButton") as? UIButton {
            cancelButton.isEnabled = true
        }
        if let searchText = searchPerson{
            listActorsPresenter?.loadActors()
        }
        
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        print("searchBarTextDidBeginEditing")
        listActorsAdaptor?.clear(reload: true)
        tableView.reloadData()
     }
    
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        listActorsPresenter?.cancelSearch()
        searchBar.resignFirstResponder()
        if let cancelButton = self.searchBar.value(forKey: "cancelButton") as? UIButton {
            cancelButton.isEnabled = true
        }
        searchBar.text = ""
        searchBar.showsCancelButton = false
        hideSearchBar()
    }
    
    
    func hideSearchBar() {
        navigationItem.titleView = nil
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem(rawValue: 12)! , target: self, action: #selector(searchFunc))
        listActorsAdaptor?.clear(reload: true)
        tableView.reloadData()
    }
}
