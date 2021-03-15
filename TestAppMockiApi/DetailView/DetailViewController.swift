//
//  DetailViewController.swift
//  TestAppMockiApi
//
//  Created by shizo663 on 15.03.2021.
//

import UIKit
import Kingfisher
class DetailViewController: UIViewController  {
    
    //MARK: - Properties -
    var someText: String?
    var imageUrl: String?
    
    //MARK: - IBOutlets -
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var textsLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var containerView: UIView!
    
    //MARK: - LifeCycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        setUpView()
    }
    
    //MARK: - Func -
    private func setUpView() {
        if someText == nil  {
            guard let imageUrl = imageUrl else { return }
            if let url = URL(string: imageUrl) {
                mainImageView.kf.indicatorType = .activity
                mainImageView.kf.setImage(with: url)
                view.backgroundColor = .black
                containerView.backgroundColor = .black
            }
        } else {
            containerView.isHidden = true
            scrollView.isHidden = true
            textsLabel.text = someText
        }
    }
}

//MARK: - ScrollView extension -
extension DetailViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return mainImageView
    }
}
