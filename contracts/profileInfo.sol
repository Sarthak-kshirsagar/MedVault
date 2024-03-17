// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract PatientProfile {
    struct Patient {
        string fullName;
        string dateOfBirth;
        string gender;
        string bloodType;
        string allergies;
        string chronicMedicalConditions;
        string emergencyContacts;
        string aadharNumber;
        address uploader;
        uint256 timestamp;
    }

    mapping(address => Patient) public patients;
    uint256 public patientCount;

    event ProfileUpdated(address indexed patientAddress, string fullName, string dateOfBirth, string gender, string bloodType, string allergies, string chronicMedicalConditions, string emergencyContacts, string aadharNumber, uint256 timestamp);

    function updateProfile(string memory _fullName, string memory _dateOfBirth, string memory _gender, string memory _bloodType, string memory _allergies, string memory _chronicMedicalConditions, string memory _emergencyContacts, string memory _aadharNumber) public {
        require(bytes(_fullName).length > 0, "Full name must not be empty");

        patientCount++;
        patients[msg.sender] = Patient(_fullName, _dateOfBirth, _gender, _bloodType, _allergies, _chronicMedicalConditions, _emergencyContacts, _aadharNumber, msg.sender, block.timestamp);

        emit ProfileUpdated(msg.sender, _fullName, _dateOfBirth, _gender, _bloodType, _allergies, _chronicMedicalConditions, _emergencyContacts, _aadharNumber, block.timestamp);
    }

    function getProfile(address patientAddress) public view returns (string memory, string memory, string memory, string memory, string memory, string memory, string memory, string memory, uint256) {
        Patient memory patient = patients[patientAddress];
        return (patient.fullName, patient.dateOfBirth, patient.gender, patient.bloodType, patient.allergies, patient.chronicMedicalConditions, patient.emergencyContacts, patient.aadharNumber, patient.timestamp);
    }
}
