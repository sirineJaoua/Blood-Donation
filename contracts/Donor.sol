pragma solidity ^0.8.17;
contract Donor{
    address donor ;

    constructor(){
        donor= msg.sender ; 
    }
    modifier isAdministrator (){
        require(msg.sender == donor,"Not donor");
        _;

    }
    function getAdress() public view returns (address){
        return(donor);
    }
    
   
    
}