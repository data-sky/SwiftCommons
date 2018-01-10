//
//  StringUtils.swift
//  Pods
//
//  Created by 陆伟 on 2018/1/10.
//

import Foundation
import UIKit

// MARK: - 字符串尺寸计算
extension String {
    /**
     获取字符串的高度
     
     - parameter width: 最大宽度
     - parameter font:  字体
     
     - returns: 字符串高度
     */
    public func height(withMaxWidth width: CGFloat, font: UIFont) -> CGFloat {
        
        let attributes = [NSAttributedStringKey.font: font]
        let options = NSStringDrawingOptions(rawValue: NSStringDrawingOptions.usesLineFragmentOrigin.rawValue|NSStringDrawingOptions.usesFontLeading.rawValue)
        let maxSize = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        let size = (self as NSString).boundingRect(with: maxSize, options: options, attributes: attributes, context: nil)
        
        return ceil(size.height)
    }
}

// MARK: - 将String转换为NSAttributedString
public extension String {
    
    /**
     获得数字的NSAttributedString对象
     
     - parameter font:  字体，默认为系统字体，字体大小14
     - parameter color: 颜色
     - parameter zoom:  点号右边相对于点号左边的字体大小缩放值。默认为0，大于0放大，小于0缩小。
     
     - returns: 数字的NSAttributedString对象
     */
    public func toAttributedString(font: UIFont, color: UIColor, zoomDotRight zoom: CGFloat = 0) -> NSAttributedString {
        let dotRange = (self as NSString).range(of: ".")
        guard dotRange.location != NSNotFound else {
            return NSAttributedString(string: self, attributes: [NSAttributedStringKey.font: font, NSAttributedStringKey.foregroundColor: color])
        }
        
        let aString = NSMutableAttributedString(string: self, attributes: [NSAttributedStringKey.foregroundColor: color])
        
        let stringLength = self.count
        let leftLength = dotRange.location + dotRange.length
        
        // 点号左边部分（包括点号）设置
        let leftRange = NSRange(location: 0, length: leftLength)
        aString.addAttribute(NSAttributedStringKey.font, value: font, range: leftRange)
        
        // 点号右边部分设置
        let rightFont = font.withSize(font.pointSize + zoom)
        let rightRange = NSRange(location: leftLength, length: stringLength - leftLength)
        aString.addAttribute(NSAttributedStringKey.font, value: rightFont, range: rightRange)
        
        return aString
    }
    
    /**
     获得数字的NSAttributedString对象。颜色为’黑色‘
     
     - parameter font: 字体
     - parameter zoom: 点号右边相对于点号左边的字体大小缩放值。默认为0，大于0放大，小于0缩小。
     
     - returns: 数字的NSAttributedString对象
     */
    public func toAttributedString(font: UIFont, zoomDotRight zoom: CGFloat = 0) -> NSAttributedString {
        return toAttributedString(font: font, color: UIColor.black, zoomDotRight: zoom)
    }
    
    /**
     获得数字的NSAttributedString对象。
     
     - parameter fontSize: 字体大小。采用系统字体
     - parameter color:    颜色
     - parameter zoom:     点号右边相对于点号左边的字体大小缩放值。默认为0，大于0放大，小于0缩小。
     
     - returns: 数字的NSAttributedString对象
     */
    public func toAttributedString(fontSize: CGFloat, color: UIColor, zoomDotRight zoom: CGFloat = 0) -> NSAttributedString {
        return toAttributedString(font: UIFont.systemFont(ofSize: fontSize), color: color, zoomDotRight: zoom)
    }
    
    /**
     获得数字的NSAttributedString对象。颜色为’黑色‘
     
     - parameter fontSize: 字体大小。采用系统字体
     - parameter zoom:     点号右边相对于点号左边的字体大小缩放值。默认为0，大于0放大，小于0缩小。
     
     - returns: 数字的NSAttributedString对象
     */
    public func toAttributedString(fontSize: CGFloat, zoomDotRight zoom: CGFloat = 0) -> NSAttributedString {
        return toAttributedString(fontSize: fontSize, color: UIColor.black, zoomDotRight: zoom)
    }
    
    /**
     获得数字的NSAttributedString对象。采用系统字体，字号大小为14
     
     - parameter color: 颜色
     - parameter zoom:  点号右边相对于点号左边的字体大小缩放值。默认为0，大于0放大，小于0缩小。
     
     - returns: 数字的NSAttributedString对象
     */
    public func toAttributedString(color: UIColor, zoomDotRight zoom: CGFloat = 0) -> NSAttributedString {
        return toAttributedString(fontSize: 14, color: color, zoomDotRight: zoom)
    }
    
    /**
     获得数字的NSAttributedString对象。采用系统字体，字号大小为14，颜色为’黑色‘
     
     - parameter zoom: 点号右边相对于点号左边的字体大小缩放值。默认为0，大于0放大，小于0缩小。
     
     - returns: 数字的NSAttributedString对象
     */
    public func toAttributedString(zoomDotRight zoom: CGFloat) -> NSAttributedString {
        return toAttributedString(color: UIColor.black, zoomDotRight: zoom)
    }
    
    /**
     获得数字的NSAttributedString对象。采用系统字体，字号大小为14，颜色为’黑色‘，小数位和整数位一样大小。
     
     - returns: 数字的NSAttributedString对象
     */
    public func toAttributedString() -> NSAttributedString {
        return toAttributedString(color: UIColor.black)
    }
    
    /**
     获得数字的NSAttributedString对象。
     
     - parameter fontSize: 字体大小。采用系统字体
     - parameter rgb:      颜色RGB值
     - parameter zoom:     点号右边相对于点号左边的字体大小缩放值。默认为0，大于0放大，小于0缩小。
     
     - returns: 数字的NSAttributedString对象
     */
    public func toAttributedString(fontSize: CGFloat, colorRGB rgb: UInt32, zoomDotRight zoom: CGFloat = 0) -> NSAttributedString {
        return toAttributedString(font: UIFont.systemFont(ofSize: fontSize), color: rgb.colorRGB, zoomDotRight: zoom)
    }
    
    /**
     获得数字的NSAttributedString对象。采用系统字体，字号大小为14
     
     - parameter rgb:  颜色RGB值
     - parameter zoom: 点号右边相对于点号左边的字体大小缩放值。默认为0，大于0放大，小于0缩小。
     
     - returns: 数字的NSAttributedString对象
     */
    public func toAttributedString(colorRGB rgb: UInt32, zoomDotRight zoom: CGFloat = 0) -> NSAttributedString {
        return toAttributedString(color: rgb.colorRGB, zoomDotRight: zoom)
    }
}
