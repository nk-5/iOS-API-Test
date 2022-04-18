//
//  ViewController.swift
//  DynamicTypeUIKitApp
//
//  Created by Keigo Nakagawa on 2022/04/18.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel! {
        didSet {
//            label.font = .preferredFont(forTextStyle: .title1)
//            label.adjustsFontForContentSizeCategory = true
//            label.maximumContentSizeCategory = .extraExtraExtraLarge
//            label.minimumContentSizeCategory = .medium
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
