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

    @IBOutlet weak var testInputField: UITextField!
    @IBOutlet weak var testResultLabel: UILabel!
    @IBOutlet weak var testActionButton: UIButton!
    
    let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
   

        let inputText = testInputField.rx.controlEvent(.editingDidEndOnExit).asObservable()
            .map { self.testInputField.text }
            .filter { ($0 ?? "").count > 0 }
            .asDriver(onErrorJustReturn: "error")
        

        inputText
            .drive(testResultLabel.rx.text)
            .disposed(by: bag)

        let hasText = testInputField.rx.text
            .map { ($0 ?? "").count > 0 }
            .asDriver(onErrorJustReturn: false)

        hasText
            .drive(testActionButton.rx.isEnabled)
            .disposed(by: bag)

        testActionButton.rx.tap.subscribe { observer in
            print(observer)
            print("button tapped")
        }
        .disposed(by: bag)
        
    }
    
    private func error() throws {
       throw Errors.errorTest
    }
}

enum Errors: Error {
    case errorTest
}

