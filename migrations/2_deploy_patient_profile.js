const PatientProfile = artifacts.require("PatientProfile");

module.exports = function (deployer) {
  deployer.deploy(PatientProfile);
};
