
//
//  SecondViewController.swift
//  GoogleSearchAPIDemo
//
//  Created by wfh on 07/03/20.
//  Copyright © 2020 Harsha. All rights reserved.
//

import Foundation
import UIKit

class SecondViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var searchResult: GoogleResponse?
    let imageLoader = ImageCacheLoader()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    deinit {
        print("Deinit: SecondViewController")
    }
}

//MARK: UITableViewDelegate & UITableViewDataSource
extension SecondViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResult?.items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SearchResultTableViewCell") as? SearchResultTableViewCell else { return UITableViewCell.init() }
        cell.metaDataDetasilsText.text = searchResult?.items?[indexPath.row].title
        if let imagePath = searchResult?.items?[indexPath.row].pagemap?.cseThumbnail?.first?.src
        {
            imageLoader.obtainImageWithPath(imagePath: imagePath, completionHandler: { (image) in
                if let updateCell = tableView.cellForRow(at: indexPath) as? SearchResultTableViewCell {
                    updateCell.searchImageView.image = image
                }
            })
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "ThirdViewController") as? ThirdViewController {
            vc.urlSTR = searchResult?.items?[indexPath.row].link ?? "https://www.google.com"
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}
