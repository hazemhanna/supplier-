//
//  String.swift
//
//  Created by Ahmed Madeh.
//

import Foundation
import UIKit

extension String {

    subscript (i: Int) -> Character {
        return self[index(startIndex, offsetBy: i)]
    }
    subscript (i: Int) -> String {
        return String(self[i] as Character)
    }
    subscript (r: Range<Int>) -> String {
        let start = index(startIndex, offsetBy: r.lowerBound)
        let end = index(startIndex, offsetBy: r.upperBound)
        let range = start..<end
        return String(self[range])
    }
}
extension String {
    
    var isValidEmail: Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    
    var isValidId: Bool {
        return count == 14
    }
    
    var isPhoneNumber: Bool {
        if count != 11 { return false }
        if String(self.prefix(2)) != "01" { return false }
        return true

//        let regex = NSPredicate(format: "SELF MATCHES %@", "^(009665|\\+9665)(5|0|3|6|4|9|1|8|7)([0-9]{7})")
//       return regex.evaluate(with: self) 
    }
    
    var isValidPassword: Bool {
        if count < 6 { return false }
//        let array = map({ Int(String($0)) ?? -1})
        return true//array.contains(-1) && array.contains(where: {$0 != -1})
//        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
//        return passwordTest.evaluate(with: self)
    }
    var isValidIpAddress: Bool {
        let items = components(separatedBy: ".")
        if items.count != 4   { return false }
        for item in items {
            if UInt8(item) == nil { return false }
        }
        return true
    }
    var isValidHostname: Bool {
        let validHostnameRegex = "^(([a-zA-Z0-9]|[a-zA-Z0-9][a-zA-Z0-9\\-]*[a-zA-Z0-9])\\.)*([A-Za-z0-9]|[A-Za-z0-9][A-Za-z0-9\\-]*[A-Za-z0-9])$"
        return (self.range(of: validHostnameRegex, options: .regularExpression, range: nil, locale: nil) != nil)

    }

    public var initials: String {
        var finalString = String()
        var words = components(separatedBy: .whitespacesAndNewlines)
        
        if let firstCharacter = words.first?.first {
            finalString.append(String(firstCharacter))
            words.removeFirst()
        }
        return finalString.uppercased()
    }

    var intValue : Int {
        
        let arr = ["٠","١","٢","٣","٤","٥","٦","٧","٨","٩"]
        var result = self
        for int in 0...9 {
            result = result.replacingOccurrences(of: arr[int], with:String(int) )
        }
        result = result.replacingOccurrences(of: " \("SAR".localized)", with:"" )
        
        return Int(result) ?? 0
    }
  
    var englishPhoneNumber : String {
        
        let arr = ["٠","١","٢","٣","٤","٥","٦","٧","٨","٩"]
        var result = self
        for int in 0...9 {
            result = result.replacingOccurrences(of: arr[int], with:String(int) )
        }
        return result
    }
    
    var doubleValue: Double {
        return Double(self) ?? 0.0
    }
    
    var floatValue: Float {
        return Float(self) ?? 0.0
    }
    var htmlToAttributedString: NSAttributedString? {
          guard let data = data(using: .utf8) else { return NSAttributedString() }
          do {
              return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
          } catch {
              return NSAttributedString()
          }
      }
      var htmlToString: String {
          return htmlToAttributedString?.string ?? ""
      }

}

extension String {

    func size(usingFont font: UIFont) -> CGSize {
        let label = UILabel.init()
        label.text = self
        label.font = font
        return label.bounds.size
    }
    
    func widthOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.width
    }
    func heightOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.height
    }
    func sizeOfString(usingFont font: UIFont) -> CGSize {
        let fontAttributes = [NSAttributedString.Key.font: font]
        return self.size(withAttributes: fontAttributes)
    }
}

extension String {
    
    func charAt(at: Int) -> Character {
        let charIndex = self.index(self.startIndex, offsetBy: at)
        return self[charIndex]
    }
}
extension String {
    
    func fromBase64() -> String? {
        guard let data = Data(base64Encoded: self) else {
            return nil
        }
        return String(data: data, encoding: .utf8)
    }
    
    func toBase64() -> String {
        return Data(self.utf8).base64EncodedString()
    }
    func absoluteBase64() -> String {
        if let string = components(separatedBy: "base64,").last, components(separatedBy: "base64,").count == 2 {
            return string
        }
        return self
    }
}
extension String {
    func getDateAndAge() -> (birthdate: String, age: String, gender: String) {
        if self.count < 14 { return ("", "", "") }
        let year = self.starts(with: "2") ? ("19" + self[1..<3]) : ("20" + self[1..<3])
        let month = self[3..<5]
        let day = self[5..<7]
        
        let age = Date().string(format: "yyyy").intValue - year.intValue
        let genderInt = self[12..<13]
        let gender = genderInt.intValue % 2 == 0 ? "Female".localized : "Male".localized
        
        return (month + "/" + day + "/" + year, age.string(), gender)
    }
}
