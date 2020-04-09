//
//  titleView.swift
//  zhihu
//
//  Created by 陈淑洋 on 2020/4/9.
//  Copyright © 2020 chensy. All rights reserved.
//

import UIKit

class titleView: BaseView {
    var titles = ["全部","全部","全部","全部","全部","全部"]
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        return scrollView
    }()
    override func configUI() {
        scrollView.frame = bounds
        addSubview(scrollView)
    }
}
