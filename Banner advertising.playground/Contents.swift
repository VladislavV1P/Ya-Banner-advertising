import Foundation

struct Pixel {
    var blueLamp: String = "0" {
        didSet { color = colorGeneration() }
    }
    var redLamp: String = "0" {
        didSet { color = colorGeneration() }
    }
    var yellowLamp: String = "0" {
        didSet { color = colorGeneration() }
    }
    private func colorGeneration() -> Set<String> {
        var color: Set<String> = []
        let pixelColor = (blue: self.blueLamp, red: self.redLamp, yellow: self.yellowLamp)
        switch pixelColor {
        case ("1", "1", "1"):
            color = ["G", "P", "D", "Y", "B", "V", "O", "R"]
        case ("1", "0", "0"):
            color = ["D", "B"]
        case ("0", "1", "0"):
            color = ["D", "R"]
        case ("0", "0", "1"):
            color = ["D", "Y"]
        case ("1", "1", "0"):
            color = ["P", "D", "B", "R"]
        case ("1", "0", "1"):
            color = ["G", "D", "B", "Y"]
        case ("0", "1", "1"):
            color = ["D", "Y", "O", "R"]
        default:
            color = ["D"]
        }
        return color
    }
    var color: Set<String> = ["D"]
}

//test data
let size1 = "2 2"
var inputTest = [Array<Int>: String]()
inputTest[[0, 0]] = "1 1"
inputTest[[0, 1]] = "1 0"

inputTest[[1, 0]] = "0 1"
inputTest[[1, 1]] = "0 0"

inputTest[[2, 0]] = "1 1"
inputTest[[2, 1]] = "0 1"

inputTest[[3, 0]] = "B O"
inputTest[[3, 1]] = "D P"
//test

var answer = "YES"
var sizeBillboard = Array<Int>()
var billboard = [Array<Int>: Pixel]()

func writeData(iteration: Int, n: Int, m: Int, input: String) {
    switch iteration {
    case 0:
        billboard[[n,m]] = Pixel()
        billboard[[n,m]]?.blueLamp = input
    case 1:
        billboard[[n,m]]?.redLamp = input
    case 2:
        billboard[[n,m]]?.yellowLamp = input
    default:
        if let color = billboard[[n,m]]?.color {
            if !color.contains(input) {
                answer = "NO"
            }
        }
    }
}

if let inputSize = readLine() {
    sizeBillboard = inputSize.split(separator: " ").compactMap {Int(String($0))}
} else {
    sizeBillboard = size1.split(separator: " ").compactMap {Int(String($0))}
}

var iteration = 0

func loadData(row: Int, col: Int) {
    var inputData = [String]()
    for n in 0..<row {
        if let input = readLine()?
            .split(separator: " ")
            .compactMap({ String($0) }) {
            inputData = input
        } else if let input = inputTest[[iteration, n]]?
            .split(separator: " ")
            .compactMap({ String($0) }) {
                inputData = input
            }
        for m in 0..<col {
            writeData(iteration: iteration, n: n, m: m, input: inputData[m])
        }
    }
}

func solution() {
    for i in 0..<4 {
        iteration = i
        loadData(row: sizeBillboard[0], col: sizeBillboard[1])
    }
}

solution()
print(answer)
