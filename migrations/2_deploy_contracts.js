const Investment = artifacts.require("SeedfundInvestment");

module.exports = function (deployer) {
    deployer.deploy(Investment);
};