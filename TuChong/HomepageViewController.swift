//
//  ViewController.swift
//  TuChong
//
//  Created by SummerHF on 2019/3/19.
//  Copyright © 2019 Summer. All rights reserved.
//

import UIKit

class HomepageViewController: BaseViewControlle {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor.red
        
        print(self.node)
    }
    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        Network.request(target: .homepage_recommend(page: 1, type: .refresh), success: { (result) in
//            guard let model = HomePage_Recommend_Model.deserialize(from: result) else { return }
//            print(model.message)
//        }, error: { (code) in
//            print(code)
//        }) { (error) in
//            print(error)
//        }
//    }
}
