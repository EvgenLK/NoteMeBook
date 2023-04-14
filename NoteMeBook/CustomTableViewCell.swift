//
//  CustomTableViewCell.swift
//  NoteMeBook
//
//  Created by Evgenii Kutasov on 14.04.2023.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    let mylabelDate = UILabel()
    let mylabelText = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(mylabelDate)
        addSubview(mylabelText)
        
        mylabelDate.frame = CGRect(x: 10, y: 10, width: 100, height: 20)
        mylabelText.frame = CGRect(x: 100, y: 10, width: self.bounds.width - 10 , height: 20)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
