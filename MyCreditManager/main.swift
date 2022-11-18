//
//  main.swift
//  MyCreditManager
//
//  Created by 문다 on 2022/11/16.
//

import Foundation

var records: [String: [Grade]] = [:] // 학생이름: 성적표

enum MenuType: String {
    case addStudent = "1"
    case deleteStudent = "2"
    case gradeScore = "3"
    case deleteScore = "4"
    case showGPA = "5"
    case exit = "X"
}

func addStudent() {
    
    // FIXME: var to let
    var newStudentName: String = ""
    print("추가할 학생의 이름을 입력해주세요.")
    newStudentName = readLine()!
    
    if let _ = records[newStudentName] {
        print("\(newStudentName) 학생은 이미 존재하는 학생입니다. 추가하지 않습니다.")
    } else {
        records[newStudentName] = []
        print("\(newStudentName) 학생을 추가했습니다.")
    }
}

func deleteStudent() {
    
    // FIXME: var to let
    var studentName: String = ""
    print("삭제할 학생의 이름을 입력해주세요.")
    studentName = readLine()!
    
    if let _ = records[studentName] {
        records[studentName] = nil
        print("\(studentName) 학생을 삭제하였습니다.")
    } else {
        print("\(studentName) 학생을 찾지 못했습니다.")
    }
}

func gradeScore() {
    print("성적을 추가할 학생의 이름, 과목 이름, 성적(A+, A, F 등)을 띄어쓰기로 구분하여 차례로 작성해주세요.")
    print("입력예) Mickey Swift A+")
    print("만약에 학생의 성적 중 해당 과목이 존재하면 기존 점수가 갱신됩니다.")
    
    // MARK: input[0] = 학생 이름, input[1] = 과목 이름, input[2] = 성적
    let input: [String] = readLine()!.split(separator: " ").map{String($0)}
    if input.count != 3 {
        print("입력이 잘못되었습니다. 다시 확인해주세요.")
        return
    }
    
    // MARK: 없는 학생인 경우 성적을 추가하지 않음
    if let _ = records[input[0]] {
        // TODO: 성적이 비정삭적으로 입력된 경우 처리
        if let grade = GradeType[input[2]] {
            records[input[0]]!.append(Grade(subject: input[1], grade: grade))
            print("\(input[0]) 학생의 \(input[1]) 과목이 \(input[2])로 추가(변경)되었습니다.")
        } else {
            print("성적 입력이 잘못되었습니다. A+, A, B+, B, C+, C, D+, D, F 중 하나를 입력해주세요.")
        }
    } else {
        print("존재하지 않은 학생입니다. 없는 학생의 성적은 추가하지 않습니다.")
    }
}

// 프로그램 동작 시작
var chosenMenu: String
while true {
    printMenu()
    chosenMenu = readLine()!
    if let menu = MenuType(rawValue: chosenMenu) {
    switch menu {
        case .addStudent:
            addStudent()
        
        case .deleteStudent:
            deleteStudent()

        case .gradeScore:
            gradeScore()
        
        case .deleteScore:
            break
        case .showGPA:
            break
        case .exit:
            exit(0)
    }
    } else {
        printErrorMsg()
    }
}
