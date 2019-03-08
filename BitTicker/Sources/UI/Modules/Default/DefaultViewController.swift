//
//  DefaultViewController.swift
//  BitTicker
//
//  Created by Ahmad Ansari on 07/03/2019.
//  Copyright © 2019 Ahmad Ansari. All rights reserved.
//

import UIKit
import RxSwift

class DefaultViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!    
    fileprivate var viewModel = DefaultViewModel()
    fileprivate let disposeBag = DisposeBag()

    weak var mainController: MainViewController?    
    
    static func instance() -> DefaultViewController {
        return Storyboard.main.viewController(withIdentifier: "DefaultViewController") as! DefaultViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        //Register Custom Cell
        TickerCell.register(forTableView: tableView)
        
        //Configure
        viewModel.configure()
        
        //Bind
        viewModel.fetchedResultsController.subscribe(forTableView: tableView)
        viewModel.fetchedResultsController.performFetch()
        subscribeToSearchEvents()
        
        viewModel.loadTickers { [weak self] in
            self?.viewModel.fetchedResultsController.performFetch()
            self?.reloadData()
        }
    }
    
    func subscribeToSearchEvents() {
        
        guard mainController != nil else {
            return
        }
        
        mainController?.startSearch.subscribe(onNext: { [weak self] in
            print("RX: Search Start")
            self?.reloadData()
        }).disposed(by: disposeBag)
        
        mainController?.filterContents.subscribe(onNext: { [weak self] searchText in
            print("RX: Search For: \(searchText)")
            if searchText.count > 0 {
                self?.searchText = searchText
            } else {
                self?.searchText = nil
            }
            self?.reloadData()
        }).disposed(by: disposeBag)
        
        mainController?.cancelSearch.subscribe(onNext: { [weak self] in
            print("RX: Search Cancel")
            self?.searchText = nil
            self?.reloadData()
        }).disposed(by: disposeBag)
    }
    
    func reloadData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

// MARK: - Table View Methods
extension DefaultViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension DefaultViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.fetchedResultsController.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.fetchedResultsController.numberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tickerCell: TickerCell = self.tableView.dequeueReusableCell(withIdentifier: TickerCell.cellIdentifier)! as! TickerCell
        
        if let tickerDTO = viewModel.fetchedResultsController.object(at: indexPath) as? TickerDTO {
            tickerCell.configure(tickerDTO: tickerDTO, searchText: searchText)
        }
        return tickerCell
    }
}
