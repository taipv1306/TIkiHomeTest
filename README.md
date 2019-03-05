## TIkiHomeTest
###1.ScreenShot
![MacDown Screenshot](https://i.imgur.com/ED3c3uF.png)
###2.Code 
#### a) MinWidth:
    ```swift
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
    
        func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return ceil(boundingBox.width)
    }


```
