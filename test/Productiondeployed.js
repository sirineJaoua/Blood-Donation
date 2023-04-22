const Production = artifacts.require ('Production');
const assert = require('assert');


contract ('Production', (accounts) => {
   
    const ID=124587;
    it('should allow a user to choose donner ID', async() => {
        const instance = await Production.deployed();
        await instance.CollectBloodUnit(ID,{ from: accounts[0] });
        const UpdatedBlood = await instance.ID;
        assert.equal(UpdatedBlood,ID,'the Donner was not restored');

    });
});