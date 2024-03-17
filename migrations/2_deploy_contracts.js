const FileAccessControl = artifacts.require("FileAccessControl");

module.exports = function (deployer) {
  deployer.deploy(FileAccessControl);
};
