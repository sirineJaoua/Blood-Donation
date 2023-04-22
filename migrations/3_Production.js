const Production = artifacts.require ("Production");
const Contract1 = artifacts.require("Phlebotomist");
module.exports = async function (deployer){
    const contract1Instance = await Contract1.deployed();
    await deployer.deploy(Production,contract1Instance.address);
} ;