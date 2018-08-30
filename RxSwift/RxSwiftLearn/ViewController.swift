//
//  ViewController.swift
//  RxSwift
//
//  Created by 中川 慶悟 on 2017/09/16.
//  Copyright © 2017年 nk5. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    @IBOutlet weak var text: UITextField!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var button: UIButton!
    
    let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
//        text.rx.controlEvent()
        button.rx.tap.subscribe { observer in
            print(observer)
            print("button tapped")
        }
        .disposed(by: bag)
    }

}

