//
//  XYShareViewController.swift
//  XYCardbag
//
//  Created by 渠晓友 on 2022/1/25.
//  Copyright © 2022 xiaoyou. All rights reserved.
//

import UIKit
import Social

@objc
open
class XYShareViewController: UIViewController {
    
    init() {
        super.init(nibName: nil, bundle: nil)
//        SLComposeViewController.isAvailable(forServiceType: SLServiceTypeSinaWeibo)
        
//        SLComposeViewController.
        
        
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
//        let detail = SLComposeServiceViewController()
//
//
//        let item = SLComposeSheetConfigurationItem()
//        item?.title = "Haha"
//
//        present(detail, animated: true) {
//
//        }
        
//        let item = UIActivityItemProvider
        
        let act = UIActivityViewController(activityItems: ["我是要分享的内容"], applicationActivities: nil)
        present(act, animated: true) {
            print("presented")
        }
        
    }
}


