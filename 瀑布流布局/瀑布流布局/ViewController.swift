//
//  ViewController.swift
//  瀑布流布局
//
//  Created by mkxy on 17/7/7.
//  Copyright © 2017年 阿蛋. All rights reserved.
//

import UIKit
private let cellID : String = "cellId"
class ViewController: UIViewController {

    fileprivate lazy var collectionView : UICollectionView = {
        let layout = ADFlowLayout()
        let margin : CGFloat = 10
        layout.minimumLineSpacing = margin
        layout.minimumInteritemSpacing = margin
        layout.sectionInset = UIEdgeInsetsMake(margin, margin, margin, margin)
        layout.datasource = self
        
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellID)
        return collectionView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
    }
}

extension ViewController{
    func setupUI() {
        view.addSubview(collectionView)
    }
}
extension ViewController : UICollectionViewDataSource{

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath)
        cell.backgroundColor = UIColor.ramdomColor()
        
        return cell
    }
}
//瀑布流数据源方法
extension ViewController : ADFlowLayoutDataSource{
    func numberofCols(_ waterFlowLayout: ADFlowLayout) -> Int {
        return 3
    }
    func waterflow(_ waterFlowLayout: ADFlowLayout, item: Int) -> CGFloat {
        return CGFloat(arc4random_uniform(150) + 100)
    }
}




