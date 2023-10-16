//
//  ViewController.swift
//  DilemmaDelish
//
//  Created by TORI on 2023/09/20.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
     
        let gpt = ChatCompletionsAPI()
        let request = gpt.createChatRequest(with: "김치찌개 레시피 알려줘")!
        gpt.createChatCompletion(with: request) { results in
            switch results {
            case .success(let data):
                print(data)
            case .failure(let error):
                print(error)
            }
        }
    }


}

