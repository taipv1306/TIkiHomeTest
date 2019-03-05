//
//  String+Utility.swift
//  HomeTestTiki
//
//  Created by ZickOne on 3/5/19.
//  Copyright © 2019 TaiPham. All rights reserved.
//

import UIKit

extension String {
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return ceil(boundingBox.height)
    }
    
    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return ceil(boundingBox.width)
    }
    
    func caculatorMinWidth(withConstrainedHeight height: CGFloat, font: UIFont) -> (CGFloat,String)? {
        let allRangeSpace = self.ranges(of: " ")
        let minWidth : CGFloat = 112
        let maxWidth : CGFloat = 99999
        var currentMinWidth : CGFloat = maxWidth
        let padding : CGFloat = 30
        var newStr = self

        for e in allRangeSpace {
            let stringWithBreakLine : String = self.replacingCharacters(in: e, with: "\n")
            let minSpace = stringWithBreakLine.width(withConstrainedHeight: height, font: font) + padding
            if minSpace < currentMinWidth {
                currentMinWidth = max(min(minSpace, currentMinWidth),minWidth)
                newStr = stringWithBreakLine
                if minSpace <= minWidth {break}
            }

        }
        return (((currentMinWidth == maxWidth ) ? minWidth : currentMinWidth)  ,newStr)
    }

}


extension StringProtocol where Index == String.Index {
    func index(of string: Self, options: String.CompareOptions = []) -> Index? {
        return range(of: string, options: options)?.lowerBound
    }
    func endIndex(of string: Self, options: String.CompareOptions = []) -> Index? {
        return range(of: string, options: options)?.upperBound
    }
    func indexes(of string: Self, options: String.CompareOptions = []) -> [Index] {
        var result: [Index] = []
        var start = startIndex
        while start < endIndex,
            let range = self[start..<endIndex].range(of: string, options: options) {
                result.append(range.lowerBound)
                start = range.lowerBound < range.upperBound ? range.upperBound :
                    index(range.lowerBound, offsetBy: 1, limitedBy: endIndex) ?? endIndex
        }
        return result
    }
    func ranges(of string: Self, options: String.CompareOptions = []) -> [Range<Index>] {
        var result: [Range<Index>] = []
        var start = startIndex
        while start < endIndex,
            let range = self[start..<endIndex].range(of: string, options: options) {
                result.append(range)
                start = range.lowerBound < range.upperBound ? range.upperBound :
                    index(range.lowerBound, offsetBy: 1, limitedBy: endIndex) ?? endIndex
        }
        return result
    }
}
