// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "./DiplomaToken.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";

contract Diploma {
    DiplomaToken public tokenContract;

    struct CreateStudentData {
        string lastName;
        string firstName;
        uint birthDate;
        string studentAddress;
        string email;
        string telephone;
        address company;
        string referentName;
        uint startDate;
        uint endDate;
    }

    struct Student {
        uint id;
        string lastName;
        string firstName;
        uint birthDate;
        string studentAddress;
        string email;
        string telephone;
        address company;
        string referentName;
        uint startDate;
        uint endDate;
        address university;
        int mark;
    }
    Student[] public students;

    struct Degree {
        uint studentId;
        string universityName;
        address university;
        string country;
        string degreeType;
        string speciality;
        string mention;
        uint256 obtainedDate;
    }
    mapping(uint => Degree) studentDegrees;

    uint public nextStudentId = 1;

    address public owner;
    uint public exchangeRate = 100; // 1 ether = 100 tokens
    uint public evaluationFee = 15;
    uint public verificationFee = 10;

    constructor(DiplomaToken _tokenContract) {
        tokenContract = _tokenContract;
        owner = msg.sender;
    }

    event StudentCreated(uint id, string lastName, string firstName, address university, address company);
    event GradeAssigned(uint id, uint grade);

    function createStudent(CreateStudentData memory studentData) public returns (uint) {
        students.push(Student({
            id: nextStudentId,
            lastName: studentData.lastName,
            firstName: studentData.firstName,
            birthDate: studentData.birthDate,
            studentAddress: studentData.studentAddress,
            email: studentData.email,
            telephone: studentData.telephone,
            company: studentData.company,
            referentName: studentData.referentName,
            startDate: studentData.startDate,
            endDate: studentData.endDate,
            university: msg.sender, // Utiliser l'adresse du contract comme l'université
            mark: -1 // Initialiser la note à 0
        }));
        emit StudentCreated(nextStudentId, studentData.lastName, studentData.firstName, msg.sender, studentData.company);
        return nextStudentId++;
    }

    function attribuateDegree(uint _studentId, string memory _universityName, string memory _country, string memory _degreeType, string memory _speciality, string memory _mention, uint256 _obtainedDate) public {
        require(_studentId > 0 && _studentId <= students.length, "The student must exist");
        require(students[_studentId - 1].university == msg.sender, "The university must be the student university");
        studentDegrees[_studentId - 1] = Degree(_studentId, _universityName, msg.sender, _country, _degreeType, _speciality, _mention, _obtainedDate);
    }

    function evaluateIntern(uint _id, uint _mark) public returns (bool) {
        uint256 balanceOwner = tokenContract.balanceOf(owner); // Solde de l'owner
        require(balanceOwner >= 15, "Balance insuffisante"); // Vérifie la balance de l'owner
        require(_id > 0 && _id <= students.length, "Invalid student id");
        require(students[_id - 1].company == msg.sender, "Only the assigned company can assign grades");
        require(_mark >= 0 && _mark <= 20, "The mark can only be between 0 and 20");
        students[_id - 1].mark = int(_mark);
        tokenContract.transfer(owner, msg.sender, 15); // Transfère les 15 tokens de l'owner à l'exécutant de la fonction
        emit GradeAssigned(_id, _mark);
        return true;
    }

    function verifyDegree(uint _studentId) public returns (Degree memory) {
        // le user a au moins 10 tokens
        require(tokenContract.balanceOf(msg.sender) >= 10, "Sender must have at least 10 tokens");
        require(tokenContract.allowance(msg.sender, address(this)) >= 10, "You must authorize the contract to use at least 10 of your tokens");
        // le student id exist
        require(_studentId > 0 && _studentId <= students.length, "Invalid student id");
        tokenContract.transferFrom(msg.sender, address(this), 10);
        return studentDegrees[_studentId - 1];
    }
}