//
//  BaseViewController.swift
//  TMDB
//
//  Created Bassem Abbas on 9/24/19.
//  Copyright © 2019 Ibtikar Technologies, Co. Ltd. All rights reserved.
//

import UIKit
import Foundation

class BaseViewController<Presenter:BasePresenterProtocol>: UIViewController, BaseViewProtocal {
    
    // MARK: - Public Variables
    
    // MARK: - Private Variables
    
    var presenter:BasePresenterProtocol!
    
    // MARK: - Computed Variables
    
    // MARK: - IBOutlets
    
    
    public func setPresenter (presenter: Presenter) {
        self.presenter = presenter
    }
    func showLoading(allowNavigation: Bool) {
        print("showLoading")
    }
    func hideLoading() {
        print("hideLoading")
    }
    func loadDataSuccess() {
        print("loadDataSuccess")
    }
    func loadDataFailed(with error: Error?) {
        print("loadDataFailed")
    }
    func showSuccessMessage() {
        print("showSuccessMessage")
    }
    func showErrorMessage() {
        print("showErrorMessage")
    }
}
