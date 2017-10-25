//
//  ADFlowLayout.swift
//  瀑布流布局
//
//  Created by mkxy on 17/7/11.
//  Copyright © 2017年 阿蛋. All rights reserved.
//

import UIKit
protocol ADFlowLayoutDataSource : class{
    func numberofCols(_ waterFlowLayout : ADFlowLayout) -> Int
    func waterflow(_ waterFlowLayout : ADFlowLayout,item : Int) -> CGFloat
}
class ADFlowLayout: UICollectionViewFlowLayout {
    //数据源
    weak var datasource : ADFlowLayoutDataSource?
    //每一行多少列
    fileprivate lazy var cols : Int = {
        return self.datasource?.numberofCols(self) ?? 2
    }()
    fileprivate lazy var attrsArr : [UICollectionViewLayoutAttributes] = [UICollectionViewLayoutAttributes]()

    //定义高度数组
    fileprivate lazy var heightArr : [CGFloat] = Array(repeating: self.sectionInset.top, count: self.cols)
}
//1.准备布局
extension ADFlowLayout{
    override func prepare() {
        super.prepare()
        //1.获取item个数
        let itemCount = collectionView!.numberOfItems(inSection: 0)
        let cellW : CGFloat = (collectionView!.bounds.width - sectionInset.left - sectionInset.right - CGFloat(cols - 1) * minimumInteritemSpacing)/CGFloat(cols)
        for i in 0..<itemCount {
            //2.获取每个item的indexpath
            let indexpath = IndexPath(item: i, section: 0)
            //3.根据indexpath创建对应的attr并根据高度设置frame
            let attr = UICollectionViewLayoutAttributes(forCellWith: indexpath)
            //4.高度
            guard let cellH : CGFloat = datasource?.waterflow(self, item: i)else{
                fatalError("请实现对应的数据源方法")
            }
            //5.取出最小高度
            let minH = heightArr.min()!
            //6.取出最小高度对应的index
            let minIndex = heightArr.index(of: minH)!
            
            let cellX : CGFloat = sectionInset.left + CGFloat(minIndex) * (minimumInteritemSpacing + cellW)
            let cellY : CGFloat = minH + minimumLineSpacing
            attr.frame = CGRect(x: cellX, y: cellY, width: cellW, height: cellH)
            //7.保存
            attrsArr.append(attr)
            //8.赋值
            heightArr[minIndex] = minH + cellH + minimumLineSpacing
        }
    }
}
//2.返回布局
extension ADFlowLayout{
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return attrsArr
    }
}
//3.设置滚动区域
extension ADFlowLayout{
    override var collectionViewContentSize: CGSize{
        return CGSize(width: 0, height: heightArr.max()! + minimumLineSpacing)
    }
}
