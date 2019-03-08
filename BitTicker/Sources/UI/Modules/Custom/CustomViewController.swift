//
//  CustomViewController.swift
//  BitTicker
//
//  Created by Ahmad Ansari on 07/03/2019.
//  Copyright © 2019 Ahmad Ansari. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

class CustomViewController: BaseViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    fileprivate var viewModel = CustomViewModel()
    fileprivate let disposeBag = DisposeBag()
    
    weak var mainController: MainViewController?
    
    static func instance() -> CustomViewController {
        return Storyboard.main.viewController(withIdentifier: "CustomViewController") as! CustomViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //Register Custom Cell
        TickerCollectionCell.register(forCollectionView: collectionView)
        
        //Configure
        viewModel.configure()
        
        //Bind
        viewModel.fetchedResultsController.subscribe(forCollectionView: collectionView)
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
            self.collectionView.reloadData()
        }
    }
}

extension CustomViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.size.width - 16
        return CGSize(width: width,
                      height: 230)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.fetchedResultsController.numberOfRowsInSection(section: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let tickerCell: TickerCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: TickerCollectionCell.collectionCellIdentifier, for: indexPath) as! TickerCollectionCell
        
        if let tickerDTO = viewModel.fetchedResultsController.object(at: indexPath) as? TickerDTO {
            tickerCell.configure(tickerDTO: tickerDTO, searchText: searchText)
        }
        return tickerCell
    }
}
