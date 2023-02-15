//
//  VFont.swift
//  FirebasePractice
//
//  Created by Victor Andres Marcial on 11/02/23.
//

import SwiftUI

enum FontType {
	case h1, h2, h3, h4, h5, h6, s1, s2, p1, p2, b1, b2, b3, l1, l2
}
struct VFont: View {
	let content:String
	let type: FontType
	var fontSize: CGFloat = 14
	var fontWeight: Font.Weight = .regular
	
	init(_ content: String, type: FontType = .p1, fontSize: CGFloat = 14, fontWeight: Font.Weight = .regular) {
		self.content = content
		self.type = type
		self.fontSize = getFontSize(type)
		self.fontWeight = getFontWeight(type)
	}
	func getFontSize(_ type:FontType) -> CGFloat {
		switch type {
		case .h1:
			return 93
		case .h2:
			return 58
		case .h3:
			return 46
		case .h4:
			return 33
		case .h5:
			return 23
		case .h6:
			return 19
		case .s1, .p1, .l1:
			return 15
		case .s2, .p2:
			return 13
		case .b1:
			return 16
		case .b2:
			return 14
		case .b3:
			return 12
		case .l2:
			return 10
			
		}
	}
	func getFontWeight(_ type:FontType) -> Font.Weight {
		switch type {
		case .h1, .h2:
			return .light
		case .b1:
			return .bold
		case .h6, .s2:
			return .medium
		case .b2, .b3, .l1, .l2:
			return .semibold
		default:
			return .regular
		}
		
	}
	
	
	var body: some View {
		Text(content)
			.font(.system(size: fontSize,weight: fontWeight))
	}
}

struct VFont_Previews: PreviewProvider {
    static var previews: some View {
			VStack{
				VFont("Texto clave")
				VFont("Texto clave")
			}
    }
}
