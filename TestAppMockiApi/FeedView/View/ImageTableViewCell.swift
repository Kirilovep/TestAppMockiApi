//
//  ImageTableViewCell.swift
//  TestAppMockiApi
//
//  Created by shizo663 on 15.03.2021.
//

import UIKit
import Kingfisher
class ImageTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var mainImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
    }
    
    func configure(_ imageUrl: String?) {
        
        guard let imageUrl = imageUrl else { return }
        
        if let url = URL(string: imageUrl) {
            mainImageView.kf.indicatorType = .activity
            mainImageView.kf.setImage(with: url) 
            
        }
        
    }
    
}
