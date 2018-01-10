//
//  ColorUtils.swift
//  Pods
//
//  Created by 陆伟 on 2018/1/10.
//

import Foundation

/**
 一个便利的创建UIColor对象方法
 
 - parameter red:   红色值（0~255）
 - parameter green: 绿色值（0~255）
 - parameter blue:  蓝色值（0~255）
 - parameter alpha: 透明度（0~255）
 
 - returns: 返回一个UIColor对象
 */
public func color(red: UInt8, green: UInt8, blue: UInt8, alpha: UInt8) -> UIColor {
    return UIColor(red: CGFloat(red)/255.0, green: CGFloat(green)/255.0, blue: CGFloat(blue)/255.0, alpha: CGFloat(alpha)/255.0)
}

public func color(red: UInt8, green: UInt8, blue:UInt8) -> UIColor {
    return color(red: red, green: green, blue: blue, alpha: 255)
}

extension UInt32 {
    public var colorRGB: UIColor {
        let trim: UInt32 = 0xFF000000
        let num = self | trim
        
        return num.colorARGB
    }
    
    public var colorRGBA: UIColor {
        let trim: UInt32 = 0x000000FF
        var num = self
        let alpha = num & trim
        num >>= 8
        num |= (alpha << 24)
        
        return num.colorARGB
    }
    
    public var colorARGB: UIColor {
        let trim: UInt32 = 0x000000FF
        var num = self
        
        let blue    = UInt8(num & trim); num >>= 8
        let green   = UInt8(num & trim); num >>= 8
        let red     = UInt8(num & trim); num >>= 8
        let alpha   = UInt8(num & trim); num >>= 8
        
        return color(red: red, green: green, blue: blue, alpha: alpha)
    }
}

extension Int {
    public var colorRGB: UIColor {
        return UInt32(self).colorRGB
    }
    
    public var colorRGBA: UIColor {
        return UInt32(self).colorRGBA
    }
    
    public var colorARGB: UIColor {
        return UInt32(self).colorARGB
    }
}
