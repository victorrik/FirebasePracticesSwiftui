//
//  VFunctions.swift
//  FirebasePractice
//
//  Created by Victor Andres Marcial on 11/02/23.
//

import Foundation
import FirebaseFunctions

struct FunctionsError {
	var message:String
	var details:String
	var code:String
}

struct FunctionsResult{
	var succes: Bool
	var info: Any?
	var failure:FunctionsError
	
	init(succes: Bool = false,info: Any? = nil, failure: FunctionsError = FunctionsError(message: "", details: "", code: "")) {
		self.succes = succes
		self.info = info
		self.failure = failure
	}
}

enum FunctionsLocations: String {
	case handleAuths = "handleAuths"
}

struct VFunctions {
	private static let functions = Functions.functions()
	@MainActor
	static func callFunction(location:FunctionsLocations, operation:String, dataObject: Any) async -> FunctionsResult {
		var resultFunction = FunctionsResult()
		do{
			print("location.rawValue\(location.rawValue)")
			print("location.rawValue\(operation)")
			let rtFunction = try await functions.httpsCallable(location.rawValue).call(["operacion":operation,"dataObject":dataObject])
			resultFunction.info = rtFunction.data
			return resultFunction
			
		}catch{
			print("Error en la function -> \(error.localizedDescription)")
			if let error = error as NSError? {
				if error.domain == FunctionsErrorDomain {
					var code = ""
					switch FunctionsErrorCode(rawValue: error.code){
					case .unknown:
						code = "Error desconocido chico"
					case .unauthenticated:
						code = "No eres apto para esto chico"
					default:
						code = "Sos pelotudo"
					}
					resultFunction.failure.code = code
					resultFunction.failure.message = error.localizedDescription
					resultFunction.failure.details = error.userInfo[FunctionsErrorDetailsKey] as! String
				}
				
				return resultFunction
				// [END_EXCLUDE]
			}
		}
		
	}
	
}
