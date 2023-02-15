//
//  FirebasePracticeApp.swift
//  FirebasePractice
//
//  Created by Victor Andres Marcial on 11/02/23.
//

import SwiftUI
import Firebase
import FirebaseCore
import FirebaseAuth
import FirebaseFirestore
import FirebaseFunctions

enum Configuration {
	enum Error: Swift.Error{
		case missingKey , invalidValue
	}
	enum CustomValues: String {
		case IP = "CT_IP_HOST"
	}
	static func value<T>(for key: CustomValues) throws -> T where T: LosslessStringConvertible{
		guard let objet = Bundle.main.object(forInfoDictionaryKey: key.rawValue) else {
			throw Error.missingKey
		}
		switch objet {
		case let value as T:
			return value
		case let string as String:
			guard let value = T(string) else { fallthrough }
			return value
		default:
			throw Error.invalidValue
		}
	}
}

@main
struct FirebasePracticeApp: App {
	
	let ipHosting:String = try! Configuration.value(for: .IP)
	init(){
		
		FirebaseApp.configure()
		#if DEVELOPMENT
			print(
			"""
			*********
			DEVELOPMENT MODE IS ON
			*********
			"""
			)
			Auth.auth().useEmulator(withHost:"192.168.100.37", port:5009)
			Functions.functions().useEmulator(withHost:"192.168.100.37", port:5008)
			let settings = Firestore.firestore().settings
			settings.host = "192.168.100.37:5007"
			settings.isPersistenceEnabled = false
			settings.isSSLEnabled = false
			Firestore.firestore().settings = settings
		#elseif DEBUG
			print(
			"""
			*********
			DEBUGGIN MODE IS ON
			*********
			"""
			)
			#else
			print(
			 """
			 *********
			 RELEASE THE KRAKEN
			 *********
			 """
			 )
		#endif
	}
	
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
