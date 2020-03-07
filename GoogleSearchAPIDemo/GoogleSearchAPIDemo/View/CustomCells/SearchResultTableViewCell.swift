//
//  SearchResultTableViewCell.swift
//  GoogleSearchAPIDemo
//
//  Created by wfh on 07/03/20.
//  Copyright © 2020 Harsha. All rights reserved.
//

import Foundation
import UIKit

class SearchResultTableViewCell: UITableViewCell {
    @IBOutlet weak var searchImageView: UIImageView!
    @IBOutlet weak var metaDataDetasilsText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}
