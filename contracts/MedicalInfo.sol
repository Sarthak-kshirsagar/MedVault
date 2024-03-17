// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MedicalHistory {
    struct MedicalRecord {
        string ongoingMedicalConditions;
        string currentMedications;
        string previousSurgeries;
        string implantedMedicalDevices;
        string familyMedicalHistory;
        string healthcareProviders;
        string insuranceInformation;
        string advanceDirectives;
        address patient;
        address doctor;
        uint256 timestamp;
    }

    mapping(uint256 => MedicalRecord) public medicalRecords;
    uint256 public recordCount;

    event MedicalRecordUpdated(uint256 indexed recordId, string ongoingMedicalConditions, string currentMedications, string previousSurgeries, string implantedMedicalDevices, string familyMedicalHistory, string healthcareProviders, string insuranceInformation, string advanceDirectives, address patient, address doctor, uint256 timestamp);

    function updateMedicalRecord(
        string memory _ongoingMedicalConditions,
        string memory _currentMedications,
        string memory _previousSurgeries,
        string memory _implantedMedicalDevices,
        string memory _familyMedicalHistory,
        string memory _healthcareProviders,
        string memory _insuranceInformation,
        string memory _advanceDirectives,
        address _doctor
    ) public {
        recordCount++;
        medicalRecords[recordCount] = MedicalRecord(
            _ongoingMedicalConditions,
            _currentMedications,
            _previousSurgeries,
            _implantedMedicalDevices,
            _familyMedicalHistory,
            _healthcareProviders,
            _insuranceInformation,
            _advanceDirectives,
            msg.sender,
            _doctor,
            block.timestamp
        );

        emit MedicalRecordUpdated(
            recordCount,
            _ongoingMedicalConditions,
            _currentMedications,
            _previousSurgeries,
            _implantedMedicalDevices,
            _familyMedicalHistory,
            _healthcareProviders,
            _insuranceInformation,
            _advanceDirectives,
            msg.sender,
            _doctor,
            block.timestamp
        );
    }

    function getMedicalRecord(uint256 recordId) public view returns (string memory, string memory, string memory, string memory, string memory, string memory, string memory, string memory, address, address, uint256) {
        MedicalRecord memory record = medicalRecords[recordId];
        return (
        record.ongoingMedicalConditions,
        record.currentMedications,
        record.previousSurgeries,
        record.implantedMedicalDevices,
        record.familyMedicalHistory,
        record.healthcareProviders,
        record.insuranceInformation,
        record.advanceDirectives,
        record.patient,
        record.doctor,
        record.timestamp
        );
    }
}
