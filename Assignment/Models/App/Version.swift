//
//  Version.swift
//  Assignment
//
//  Created by Lukas Kubaliak on 05/11/2025.
//

struct Version {
        
    let number: Double
    
}

extension Version {
    
    init?(response: VersionResponse) {
        if let number = Double(response.ios) {
            self.number = number
            return
        }
        return nil
    }
    
}
