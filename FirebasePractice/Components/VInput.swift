//
//  VInput.swift
//  FirebasePractice
//
//  Created by Victor Andres Marcial on 11/02/23.
//

import SwiftUI

enum InputType {
	case text
	case password
}

final class VInputRef: ObservableObject {
	
	@Published var error:Bool = false
	@Published var caption:String = ""
	
	func showCaption(_ caption:String,_ error:Bool = true) {
		self.caption = caption
		self.error = error
	}
	func resetCaption() {
		self.caption = ""
		self.error = false
	}
}

struct VInput: View {
	@Binding var value:String
	@FocusState private var isFocused: Bool
	@State private var isTapped:Bool = false
	@ObservedObject var inputRef:VInputRef
	let labelPlaceholder:String
	var caption:String = ""
	var autocapitalization: TextInputAutocapitalization? = nil
	var keyboardType: UIKeyboardType = .default
	var type: InputType = .text
	let iconPrefix: IconsAvailable?
	var iconPrefixAction: ()-> Void = {}
	let iconSuffix: IconsAvailable?
	var iconSuffixAction: ()-> Void = {}
	
	init(value: Binding<String>,
			 labelPlaceholder: String,
			 caption:String = "",
			 autocapitalization: TextInputAutocapitalization? = nil,
			 keyboardType: UIKeyboardType = .default,
			 type:InputType = .text,
			 iconPrefix: IconsAvailable? = nil,
			 iconPrefixAction: @escaping () -> Void = {},
			 iconSuffix: IconsAvailable? = nil,
			 iconSuffixAction: @escaping () -> Void = {},
			 ref:VInputRef = VInputRef()
	) {
		self._value = value
		self.labelPlaceholder = labelPlaceholder
		self.caption = caption
		self.type = type
		self.autocapitalization = autocapitalization
		self.keyboardType = keyboardType
		self.iconPrefix = iconPrefix
		self.iconPrefixAction = iconPrefixAction
		self.iconSuffix = iconSuffix
		self.iconSuffixAction = iconSuffixAction
		self.inputRef = ref
	}
	
	func validatingState() -> Bool {
		isFocused || !value.isEmpty
	}
	
	func colorValidation()-> Color {
		inputRef.error ? .red : isFocused ? Color.orange : Color.black
	}
	
	var body: some View {
		VStack(alignment: .leading,
					 spacing: 6,
					 content: {
			HStack(spacing:8){
				if (iconPrefix != nil){
					Button(action: iconPrefixAction , label: {
						VIcons(name:iconPrefix!,color: .gray, size:24)
					})
				}
				switch type {
				case .text:
					textInput
				case .password:
					passwordInput
				}
				if (iconSuffix != nil){
					Button(action: iconSuffixAction, label: {
						VIcons(name:iconSuffix!,color: .gray,size:24)
					})
				}
			}
			.padding(.vertical,12)
			.padding(.horizontal,16)
			.background(content: {
				ZStack(alignment: .leading){
					RoundedRectangle(cornerRadius: 4.0)
						.strokeBorder(colorValidation(),style: StrokeStyle(lineWidth: 1.0))
						.animation(.linear(duration: 0.2),value: validatingState())
					VFont(labelPlaceholder,type: validatingState() ? .b1 : .b1)
						.background(content:{
							Rectangle()
								.foregroundColor(.white)
								.padding(0)
						})
						.offset(x:validatingState() ? 0: iconPrefix != nil ? 32 : 0,y: validatingState() ? -24 : 0)
						.foregroundColor(colorValidation())
						.padding(.leading,16)
						.animation(.linear(duration: 0.2),value: validatingState())
				}
			})
			if !inputRef.caption.isEmpty || !caption.isEmpty {
				VFont(!inputRef.caption.isEmpty ? inputRef.caption : caption ,type: .b1)
					.padding(.horizontal, 16)
					.foregroundColor(inputRef.error ? .red : .gray)
				
			}
		})
	}
	
	var textInput: some View {
		TextField("",text: $value)
			.focused($isFocused)
			.textInputAutocapitalization(autocapitalization)
			.keyboardType(keyboardType)
			.onSubmit {
				isTapped = false
			}
			.frame(height: 24)
			.font(.system(size: 14,weight: .regular))
			.foregroundColor(.gray)
	}
	var passwordInput: some View {
		SecureField("", text: $value)
			.focused($isFocused)
			.textInputAutocapitalization(autocapitalization)
			.keyboardType(keyboardType)
			.onSubmit {
				isTapped = false
			}
			.frame(height: 24)
			.font(.system(size: 14,weight: .regular))
			.foregroundColor(.gray)
	}
}

struct VInput_Previews: PreviewProvider {
    static var previews: some View {
			VStack{
				VInput(value: .constant("asd"),labelPlaceholder: "meow",caption: "caption"  )
				VInput(value: .constant(""), labelPlaceholder: "Correo"  )
				VInput(value: .constant("sd"), labelPlaceholder: "Contrasela", iconPrefix: .lock, iconSuffix: .eye  )
				VInput(value: .constant("sd"), labelPlaceholder: "Contrasela", type: .password, iconPrefix: .lock, iconSuffix: .eye  )
				VInput(value: .constant(""), labelPlaceholder: "Correo electronico"  )
			}
    }
}
