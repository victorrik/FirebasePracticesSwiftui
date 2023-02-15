//
//  VButton.swift
//  FirebasePractice
//
//  Created by Victor Andres Marcial on 11/02/23.
//

import SwiftUI

enum ButtonType {
	case primary, secondary, tertiary
}
final class VButtonRef: ObservableObject {
	@Published var isLoading: Bool = false
	
	func handleLoading(_ bool:Bool) {
		self.isLoading = bool
	}
}
struct VButton: View {
	let type: ButtonType
	var title: String
	let action: (()-> Void)?
	var icon: String?
	var slim: Bool = false
	var disabled: Bool = false
	var iconLeft: Bool = false
	var highlight: Color = .white
	var bgButton: Color = .black
	@ObservedObject var butonRef: VButtonRef = VButtonRef()
	
	init(_ title: String ,
			 type: ButtonType = .primary,
			 action:(() -> Void)? = {},
			 icon: String? = nil,
			 slim: Bool = false,
			 disabled: Bool = false,
			 iconLeft: Bool = false,
			 ref:VButtonRef = VButtonRef()
	) {
		self.type = type
		self.title = title
		self.action = action
		self.icon = icon
		self.slim = slim
		self.disabled = disabled
		self.iconLeft = iconLeft
		self.highlight = type == .primary ? .white : .black
		self.bgButton = type == .primary ? .black : type == .secondary ? .blue : .white
		self.butonRef = ref
	}
	
	var body: some View {
		ZStack{
			 Button(action: action!, label: {
				 Text(title)
					 .font(.system(size: 14,weight: .semibold))
					 .foregroundColor(highlight)
					 .frame(height: 48)
					 .frame(maxWidth: .infinity)
					 .background(bgButton)
					 .cornerRadius(4)
			 })
			 .buttonStyle(PlainButtonStyle())
		 
			if butonRef.isLoading {
				
				HStack{
					ProgressView()
						.progressViewStyle(CircularProgressViewStyle(tint: highlight))
				}
				.frame(height: 48)
				.frame(maxWidth: .infinity)
				.background(bgButton)
				
			}
			
		 }
	}
}

struct VButton_Previews: PreviewProvider {
    static var previews: some View {
        VButton("meow")
    }
}
