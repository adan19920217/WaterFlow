//
//  UIColor+Extension.swift
//  ListView
//
//  Created by mkxy on 17/7/5.
//  Copyright © 2017年 阿蛋. All rights reserved.
//

import UIKit
//扩充类方法
extension UIColor{
    //1.扩充便利构造函数必须以convenience开头
    convenience init(r : CGFloat,g : CGFloat,b : CGFloat,alpha : CGFloat = 1) {
        //2.必须调用self.init方法
        self.init(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: alpha)
    }
    //快速设置随机色
    class func ramdomColor() ->UIColor{
        return UIColor(r: CGFloat(arc4random_uniform(256)), g: CGFloat(arc4random_uniform(256)), b: CGFloat(arc4random_uniform(256)))
    }
}
extension UIColor{
    //计算两个颜色之间R,G,B之间的差值
    class func getRGBdifference(firstColor : UIColor,secondColor : UIColor) -> (CGFloat,CGFloat,CGFloat) {
        let firstRGB = firstColor.getRGB()
        let secondRGB = secondColor.getRGB()
        //计算差值(两者之间的颜色改变差值)
        return (firstRGB.0 - secondRGB.0,firstRGB.1 - secondRGB.1,firstRGB.2 - secondRGB.2)
    }
    //传入一个RGB颜色,获取它的R值G值B值
    func getRGB() -> (CGFloat,CGFloat,CGFloat) {
        guard let Com = cgColor.components else {
            fatalError("确保颜色是以RGB方式传入")
        }
        return (Com[0]*255,Com[1]*255,Com[2]*255)
    }
}



