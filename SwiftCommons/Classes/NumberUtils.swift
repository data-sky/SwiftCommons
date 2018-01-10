//
//  NumberUtils.swift
//  Pods
//
//  Created by 陆伟 on 2018/1/10.
//

import Foundation

/**
 *  对浮点数进行四舍五入操作
 */
public protocol FixedNumber: CVarArg {
    /**
     对数字进行四舍五入。
     
     - parameter num: 规定小数的位数，是 0 ~ 6 之间的值，包括 0 和 6，有些实现可以支持更大的数值范围。如果省略了该参数，将用 0 代替。
     
     - returns: 四舍五入后的值
     */
    func toFixed(digits: Int) -> Self
    
    var value: NSNumber { get }
}

extension FixedNumber {
    
    /// 货币格式。小数位固定保留两位有效数字
    public var currency: String {
        let fmt = NumberFormatter()
        fmt.numberStyle = .currency
        fmt.currencySymbol = "¥"
        
        guard let str = fmt.string(from: self.value) else {
            return "[None]"
        }
        
        return str
    }
    
    /**
     对数字进行四舍五入，然后转换成字符串形式。并对整数部分进行分组，每组3位数字。
     
     - parameter digits:    小数部分保留位数。多余部分进行四舍五入，不足部分补零。
     - parameter separator: 整数部分的分隔符，默认为：","
     
     - returns: 数字的字符串格式
     */
    public func toString(fractionDigits digits: Int, separator: String = ",") -> String {
        checkArg(digits: digits)
        
        let fmt = NumberFormatter()
        fmt.numberStyle = .decimal
        fmt.positivePrefix = ""
        fmt.groupingSeparator = separator
        fmt.maximumFractionDigits = digits
        fmt.minimumFractionDigits = digits
        
        guard let str = fmt.string(from: self.value) else {
            return ""
        }
        
        return str
    }
    
    /**
     百分号格式。注意：这里不会进行四舍五入操作
     
     - parameter digits: 小数部分保留位数。
     
     - returns: 百分号格式
     */
    public func toPercent(fractionDigits digits: Int? = nil) -> String {
        guard let digits = digits else {
            return NumberFormatter.localizedString(from: self.value, number: .percent)
        }
        
        checkArg(digits: digits)
        
        let fmt = NumberFormatter()
        fmt.numberStyle = .percent
        fmt.maximumFractionDigits = digits
        fmt.minimumFractionDigits = digits
        
        guard let str = fmt.string(from: self.value) else {
            return "[None]"
        }
        
        return str
    }
    
}

// MARK: - Double
extension Double: FixedNumber {
    
    /**
     对数字进行四舍五入
     
     - parameter digits: 规定小数的位数，是 0 ~ 6 之间的值，包括 0 和 6，有些实现可以支持更大的数值范围。如果省略了该参数，将用 0 代替。
     
     - returns: 四舍五入后的值
     */
    public func toFixed(digits: Int = 0) -> Double {
        checkArg(digits: digits)
        
        let keyNum = pow(10.0, Double(digits))
        let value = Darwin.round(self * keyNum)
        
        return value / keyNum
    }
    
    public var value: NSNumber {
        return NSNumber(value: self)
    }
}

// MARK: - Float
extension Float: FixedNumber {
    /**
     对数字进行四舍五入
     
     - parameter digits: 规定小数的位数，是 0 ~ 6 之间的值，包括 0 和 6，有些实现可以支持更大的数值范围。如果省略了该参数，将用 0 代替。
     
     - returns: 四舍五入后的值
     */
    public func toFixed(digits: Int = 0) -> Float {
        checkArg(digits: digits)
        
        let keyNum = pow(10.0, Float(digits))
        let value = Darwin.round(self * keyNum)
        
        return value / keyNum
    }
    
    public var value: NSNumber {
        return NSNumber(value: self)
    }
}

// MARK: - CGFloat
extension CGFloat: FixedNumber {
    /**
     对数字进行四舍五入
     
     - parameter digits: 规定小数的位数，是 0 ~ 6 之间的值，包括 0 和 6，有些实现可以支持更大的数值范围。如果省略了该参数，将用 0 代替。
     
     - returns: 四舍五入后的值
     */
    public func toFixed(digits: Int = 0) -> CGFloat {
        checkArg(digits: digits)
        
        let keyNum = pow(10.0, CGFloat(digits))
        let value = Darwin.round(self * keyNum)
        
        return value / keyNum
    }
    
    public var value: NSNumber {
        return NSNumber(value: Float(self))
    }
}

// MARK: - Int
extension Int: FixedNumber {
    /**
     对数字进行四舍五入
     
     - parameter digits: 规定小数的位数，是 0 ~ 6 之间的值，包括 0 和 6，有些实现可以支持更大的数值范围。如果省略了该参数，将用 0 代替。
     
     - returns: 四舍五入后的值
     */
    public func toFixed(digits: Int) -> Int {
        return self
    }
    
    public var value: NSNumber {
        return NSNumber(value: self)
    }
}

/**
 参数验证
 
 - parameter digits: 小数位位数，必须是0～6之间的数，包括0和6
 */
private func checkArg(digits: Int) {
    let limit: Int = 6
    assert(digits >= 0 && digits <= limit, "小数位位数\(digits)不在范围区间[\(0), \(limit)]内")
}
