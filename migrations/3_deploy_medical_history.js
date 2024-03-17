const MedicalHistory = artifacts.require("MedicalHistory");

module.exports = function (deployer) {
  deployer.deploy(MedicalHistory);
};
