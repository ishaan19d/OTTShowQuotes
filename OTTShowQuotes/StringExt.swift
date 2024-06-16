//
//  StringExt.swift
//  OTTShowQuotes
//
//  Created by Ishaan Das on 16/06/24.
//

import Foundation

extension String{
    func removeSpaces() -> String{
        return self.replacingOccurrences(of: " ", with: "")
    }
    
    func removeSpaceAndLowecase() -> String {
        return self.removeSpaces().lowercased()
    }
}
