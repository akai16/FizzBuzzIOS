import Foundation

enum FizzBuzzEnum {
    case normal
    case fizz
    case buzz
    case fizzbuzz
}

func fizzBuzz(number: Int) -> FizzBuzzEnum {
    var result: FizzBuzzEnum = .normal
    if (number % 15 == 0) { result = .fizzbuzz }
    else if (number % 3 == 0) { result = .fizz }
    else if (number % 5 == 0) { result = .buzz }
    
    return result
}

func checkFizzBuzz(givenAnswer: FizzBuzzEnum, number: Int) -> Bool {
    return givenAnswer == fizzBuzz(number: number)
}


