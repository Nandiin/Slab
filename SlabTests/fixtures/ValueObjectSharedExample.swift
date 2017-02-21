import Nimble
import Quick

class ValueObjectSharedExampleConfiguration: QuickConfiguration {
	override class func configure(_ configuration: Configuration) {
		sharedExamples("Value Object") {
			(sharedExampleContext: @escaping SharedExampleContext) in
			var isEqual: ((Any, Any) -> Bool)!
			var baseObject: Any!
			var sameObjects: [Any]!
            var differentObjects: [Any]!
			beforeEach {
				let _context = sharedExampleContext()
				isEqual = _context["isequal"] as! (Any, Any) -> Bool
                baseObject = _context["base"]
                sameObjects = _context["same"] as! [Any]!
                differentObjects = _context["different"] as! [Any]!
			}
			context("when two objects are same") {
				it("should be equal") {
                    for (i, same) in sameObjects.enumerated() {
                        expect(isEqual(baseObject, same))
                            .to(beTrue(), description: "\n" +
                                "same[\(i)] should equal to base.\n" +
                                "base: \n" +
                                "\(stringify(baseObject))\n" +
                                "same[\(i)]: \n" +
                                "\(stringify(same))\n"
                                
                        )
                    }
				}
			}
            context("when two objects are different") {
                it("should not be equal") {
                    for (i, different) in differentObjects.enumerated() {
                        expect(isEqual(baseObject, different))
                            .to(beFalse(), description: "\n" +
                                "different[\(i)] should not equal to base.\n" +
                                "base: \n" +
                                "\(stringify(baseObject))\n" +
                                "different[\(i)]: \n" +
                                "\(stringify(different))\n"
                                
                        )
                    }
                }
            }
		}
	}
}

fileprivate func equalFunction<T: Equatable>(type: T.Type) -> (Any, Any) -> Bool {
	return {
		(lhs: Any, rhs: Any) -> Bool in
		guard let lhs = lhs as? T, let rhs = rhs as? T else { return false }
		return lhs == rhs
	}
}

func itIsValueObject<T: Equatable>(context: @escaping () -> [String:[T]]) {
	itBehavesLike("Value Object") {
		var _context = context()
        return [
            "base": _context["base"]![0],
            "same": _context["same"] as Any,
            "different": _context["different"] as Any,
            "isequal": equalFunction(type: T.self)
        ]
	}
}
