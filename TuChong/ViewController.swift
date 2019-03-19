//
//  ViewController.swift
//  TuChong
//
//  Created by SummerHF on 2019/3/19.
//  Copyright © 2019 Summer. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        Network.request(target: .homepage_recommend(page: 1, type: .refresh), success: { (data) in
            
        }, error: { (code) in
            print(code)
        }) { (error) in
            print(error)
        }
    }
}
