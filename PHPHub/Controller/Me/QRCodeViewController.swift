//
//  QRCodeViewController.swift
//  PHPHub
//
//  Created by 2014-104 on 15/12/24.
//  Copyright © 2015年 ninerec. All rights reserved.
//

import UIKit
import SwiftQRCode

class QRCodeViewController: UIViewController {
    lazy var scanner = QRCode()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        scanner.prepareScan(view) { stringValue in
            print(stringValue)
        }
        scanner.scanFrame = view.bounds
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        scanner.startScan()
    }
}
