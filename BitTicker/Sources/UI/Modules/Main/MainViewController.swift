//
//  MainViewController.swift
//  BitTicker
//
//  Created by Ahmad Ansari on 07/03/2019.
//  Copyright © 2019 Ahmad Ansari. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

class MainViewController: BaseViewController {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var defaultViewController: DefaultViewController!
    var customViewController: CustomViewController!
    
    // MARK: Publish Events
    let startSearch = PublishSubject<Void>()
    let filterContents = PublishSubject<String>()
    var cancelSearch = PublishSubject<Void>()
    
    static func instance() -> MainViewController {
        return Storyboard.main.viewController(withIdentifier: "MainViewController") as! MainViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupUI()
    }
    
    func setupUI() {
        title = "Trading Tickers"
        
        //Initiating Objects
        defaultViewController = DefaultViewController.instance()
        customViewController = CustomViewController.instance()
        
        //Assigning Weak Reference
        defaultViewController.mainController = self
        customViewController.mainController = self
        
        //Adding Subviews to Containers
        containerView.addSubview(customViewController.view, addConstraints: true)
        containerView.addSubview(defaultViewController.view, addConstraints: true)
        
        //Selecting Default View
        segmentedControl.selectedSegmentIndex = 0
    }
    
    @IBAction func onValueChanged(_ sender: UISegmentedControl) {
        if segmentedControl.selectedSegmentIndex == 0 {
            customViewController.view.isHidden = true
            defaultViewController.view.isHidden = false
        } else {
            customViewController.view.isHidden = false
            defaultViewController.view.isHidden = true
        }
    }
}

extension MainViewController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        startSearch.onNext(())
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterContents.onNext(searchText)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil
        searchBar.endEditing(true)
        cancelSearch.onNext(())
    }
}

extension MainViewController {
    class func show() {
        let mainViewController = MainViewController.instance()
        let navigationController = UINavigationController(rootViewController: mainViewController)
        if let window = UIApplication.shared.delegate?.window {
            UIView.animate(withDuration: 0.5, animations: {
                window?.rootViewController = navigationController
                window?.becomeKey()
            })
        }
    }
}
