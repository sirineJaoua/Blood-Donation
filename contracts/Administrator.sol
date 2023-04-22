pragma solidity ^0.8.17;
contract Administrator{
    address administrator ;

    constructor(){
        administrator= msg.sender ; 
    }
    modifier isAdministrator (){
        require(msg.sender == administrator,"Not administrator");
        _;

    }
    function getAdress() public view returns (address){
        return(administrator);
    }
    
   
    
}