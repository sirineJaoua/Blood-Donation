const Transporter = artifacts.require ("Transporter");
module.exports = function (deployer, network , accounts){
    deployer.deploy(Transporter, { from: accounts[1] });
    
} ;