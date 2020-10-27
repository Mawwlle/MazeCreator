import SwiftUI
import PlaygroundSupport

/* This program generate maze in matrix
0 - is wall
1 - passage */

struct MatrixCreate {
    let rows: Int, columns: Int
    var grid: [String]
    init(rows: Int, columns: Int) {
        self.rows = rows
        self.columns = columns
        grid = Array(repeating: "0", count: rows * columns)
    }
    func indexIsValid(row: Int, column: Int) -> Bool {
        return row >= 0 && row < rows && column >= 0 && column < columns
    }
    subscript(row: Int, column: Int) -> String {
        get {
            assert(indexIsValid(row: row, column: column), "Index out of range")
            return grid[(row * columns) + column]
        }
        set {
            assert(indexIsValid(row: row, column: column), "Index out of range")
            grid[(row * columns) + column] = newValue
        }
    }
}




let i = 2
let j = 1
let arraySize = [10,10]
var validation = MatrixCreate(rows: arraySize[0], columns: arraySize[1]).indexIsValid(row: i, column: j)
var matrix = MatrixCreate(rows: arraySize[0], columns: arraySize[1])


func output(matrix:MatrixCreate){
    for countI in 0...arraySize[0]-1 {
        for countJ in 0...arraySize[1]-1 {
            print("\(matrix[countI,countJ]) ",terminator: " ")
        }
        print(separator: " ")
    }
}

func transform() {
    for count in 0...arraySize[1]-1{
        matrix[0,count]="1"
    }
    for count in 0...arraySize[0]-1{
        matrix[count,arraySize[0]-1]="1"
    }
    for count in 0...arraySize[1]-1{
        matrix[arraySize[0]-1,count]="1"
    }
    for count in 0...arraySize[0]-1{
        matrix[count,0]="1"
    }
}


func randDigger()->(i: Int,j: Int){
    
    let randi = Double(arraySize[0]-1)
    let randj = Double(arraySize[1]-1)
    let icount = Int(round(Double.random(in: 1...randi)/2)*2)
    let jcount = Int(round(Double.random(in: 1...randj)/2)*2)
    matrix[icount,jcount]="1"
    return (icount,jcount)
    
}

var mainCount = 0

while mainCount < (arraySize[0]*arraySize[1])/2{
    var line = randDigger().i
    var col = randDigger().j
    var count = 0
    
    while count < 2{
        
        var randDirChoise = UInt8.random(in: 0...3)
        
        switch randDirChoise {
        
        case 0:
            if MatrixCreate.init(rows: arraySize[0], columns: arraySize[1]).indexIsValid(row: line, column: col+2){
                
                matrix[line,col+2] = "1"
                matrix[line,col+1] = "1"
                col += 2
            
            }else{
                
                randDirChoise = UInt8.random(in: 1...3)
            
            }
        
        case 1:
            if MatrixCreate.init(rows: arraySize[0], columns: arraySize[1]).indexIsValid(row: line, column: col-2) == true {
                
                matrix[line,col-2] = "1"
                matrix[line,col-1] = "1"
                col -= 2
            
            }else{
                
                randDirChoise = UInt8.random(in: 0...3)
            
            }
        case 2:
            if   MatrixCreate.init(rows: arraySize[0], columns: arraySize[1]).indexIsValid(row: line+2, column: col) == true {
                
                matrix[line+2,col] = "1"
                matrix[line+1,col] = "1"
                line += 2
                
            }else{
                
                randDirChoise = UInt8.random(in: 0...3)
            
            }
        case 3:
            if MatrixCreate.init(rows: arraySize[0], columns: arraySize[1]).indexIsValid(row: line-2, column: col) == true {
                
                matrix[line-2,col] = "1"
                matrix[line-1,col] = "1"
                line -= 2
                
            }else{
                
                randDirChoise = UInt8.random(in: 0...2)
                
            }
        default:
            
            break;
            
        }
        
        count += 1
    
    }
    
    mainCount += 1

}

output(matrix: matrix)
