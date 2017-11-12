//
//  Phenotypes.swift
//  Herediscope
//
//  Created by Jonathan yue on 10/27/17.
//  Copyright © 2017 Genesis. All rights reserved.
//

import Foundation

class Phenotype {
    var name: String
    var description: String
    var questions: [Question]
    var answered: Bool
    var type: traitType
    
    init () {
        name = ""
        description = ""
        questions = []
        answered = false
        type = traitType.AutosomalDominant
    }
    
    init (n: String, d: String, q: [Question], a: Bool, t: traitType) {
        name = n
        description = d
        questions = q
        answered = a
        type = t
    }
}
