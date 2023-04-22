
const Phlebotomist = artifacts.require ("Phlebotomist");

module.exports = function (deployer, network , accounts){
    
    deployer.deploy(Phlebotomist, { from: accounts[3] });
} ;