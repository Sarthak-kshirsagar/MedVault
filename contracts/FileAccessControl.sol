// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract FileAccessControl {
    mapping(address => bool) public authorizedUsers;

    constructor() {
        authorizedUsers[msg.sender] = true; // Assign deployer as authorized user during deployment
    }

    function grantAccess(address user) external {
        authorizedUsers[user] = true;
    }

    function revokeAccess(address user) external {
        authorizedUsers[user] = false;
    }
}
