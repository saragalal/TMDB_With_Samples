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
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var tableViewBottomConstraint: NSLayoutConstraint!
    override func viewDidLoad() {
        self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.register(UINib(nibName: "ListActorsTableViewCell", bundle: nil), forCellReuseIdentifier: "ListActorsTableViewCell")
        listActorsAdaptor = ListActorsAdaptor()
        listActorsAdaptor?.setAdaptor(tableView: tableView, reloadData: reloadTableView, didSelectCell: selectedCell(index:),showLoadingMore: showLoadingMore, loadMoreActores: loadMoreActores)
        searchBar.delegate = self
        searchBar.showsCancelButton = true
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem(rawValue: 12)! , target: self, action: #selector(searchFunc))
        navigationItem.title = "Home"
        setRefreshControl()
        listActorsPresenter?.viewDidLoad?()
    }
    func setRefreshControl(){
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.accessibilityIdentifier = "refresh_control_label"
        tableView.refreshControl?.attributedTitle = NSAttributedString(string: "Refresh")
        tableView.refreshControl?.addTarget(self, action: #selector(refresh(sender:)), for: UIControl.Event.valueChanged)
        self.tableView.addSubview(self.tableView.refreshControl!)
    }
    @objc func refresh(sender:AnyObject) {
        URLCache.shared.removeAllCachedResponses()
        searchBar.resignFirstResponder()
        searchBar.endEditing(true)
        searchBar.text = ""
       listActorsPresenter?.refreshActores()
    }
    
    override func setPresenter(presenter: ListActorsPresenter) {
        listActorsPresenter = presenter
    }
   
    func showLoadingMore(){
        UIView.animate(withDuration: 1, animations: {
            self.activityIndicator.isHidden = false
            self.activityIndicator.startAnimating()
            self.tableViewBottomConstraint.constant = -50
            self.view.setNeedsUpdateConstraints()
        })
    }
    func hideLoadingMore() {
        UIView.animate(withDuration: 1, animations: {
            self.activityIndicator.isHidden = true
            self.activityIndicator.stopAnimating()
            self.tableViewBottomConstraint.constant = 0
            self.view.setNeedsUpdateConstraints()
        })
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
    
    func reloadTableView() {
        if tableViewBottomConstraint.constant != 0 {
            hideLoadingMore()
         }
        self.tableView.reloadData()
        if self.tableView.refreshControl?.isRefreshing ?? false
            {
                self.tableView.refreshControl?.endRefreshing()
            }
      }
    func selectedCell(index: Int){
      listActorsPresenter?.didSelectCell(at: index)
    }
        func loadMoreActores(){
            self.listActorsPresenter?.loadMoreActores()
    }
}
extension ListActorsViewController: UISearchBarDelegate {
    @objc func searchFunc (sender:AnyObject) {
        listActorsPresenter?.activateSearch()
        self.searchBar.text = ""
        self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        self.navigationItem.rightBarButtonItem = nil
        createSearchBar()
        setGestures()
    }
    func createSearchBar(){
        self.searchBar.showsCancelButton = true
        searchBar.placeholder = "Search Person"
        self.searchBar.becomeFirstResponder()
        self.searchBar.tintColor = UIColor.lightGray
        self.navigationItem.titleView = searchBar
        self.view.endEditing(false)
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
        if searchPerson != nil{
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
