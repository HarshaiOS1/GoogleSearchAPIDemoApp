//
//  ViewController.swift
//  GoogleSearchAPIDemo
//
//  Created by wfh on 07/03/20.
//  Copyright © 2020 Harsha. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    let searchViewModel = SearchViewModel()
    let loader = UIActivityIndicatorView.init()
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        loader.frame = CGRect(origin: self.view.center, size: CGSize(width: 150.0, height: 150.0))
        self.view.addSubview(loader)
    }
    
    deinit {
        print("Deinit: ViewController")
    }
}

//MARK: UISearchBarDelegate
extension ViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        loader.startAnimating()
//        searchViewModel.searchForText(searchText: searchBar.text ?? "") {[weak self] (didReceiveSearch, message) in
        searchViewModel.getGoogleResult(searchString: searchBar.text ?? "") {[weak self] (didReceiveSearch, message) in
            if let weakSelf = self {
                DispatchQueue.main.async {
                    weakSelf.loader.stopAnimating()
                }
                if didReceiveSearch {
                    if (weakSelf.searchViewModel.searchResult?.items.count ?? 0) > 0 {
                        //Navigate to next screen
                        DispatchQueue.main.async {
                            let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
                            if let vc = storyboard.instantiateViewController(withIdentifier: "SecondViewController") as? SecondViewController {
                                vc.searchResult = weakSelf.searchViewModel.searchResult
                                self?.navigationController?.pushViewController(vc, animated: true)
                            }
                        }
                    } else {
                        weakSelf.showAlert()
                    }
                } else {
                    weakSelf.showAlert()
                }
            } else {
                self?.showAlert()
            }
        }
    }
    
    func showAlert() {
        DispatchQueue.main.async {
            let alert = UIAlertController.init(title: "Error", message: "No Search Result Found", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
}

