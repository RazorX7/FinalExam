//
//  TableViewCell.swift
//  NJU
//
//  Created by naive on 2019/12/23.
//  Copyright © 2019 linnaXie. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    
    
    
    @IBOutlet weak var imagePic: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var date: UILabel!
    var url:String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func getInfo(_ sender: Any) {
        
    }
}
