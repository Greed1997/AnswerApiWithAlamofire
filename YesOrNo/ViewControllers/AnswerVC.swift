//
//  AnswerVC.swift
//  YesOrNo
//
//  Created by Александр on 28.09.2022.
//

import UIKit
import WebKit

class AnswerVC: UIViewController {

    @IBOutlet var gifWK: WKWebView!
    @IBOutlet var answerLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpAnswer()
    }
    private func setUpAnswer() {
        NetworkManager.shared.fetchData(linkAPI) { result in
            switch result {
            case .success(let success):
                self.answerLabel.text = success.answer
                
                guard let image = success.image else { return }
                guard let imageURL = URL(string: image) else { return }
                guard let htmlString = try? String(contentsOf: imageURL) else { return }
                
                self.gifWK.loadHTMLString(htmlString, baseURL: imageURL)
                
            case .failure(_):
                print(1)
            }
        }
    }

}
