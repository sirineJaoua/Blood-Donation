pragma solidity ^0.8.17;
contract Technician{
    address technician ;

    constructor(){
        technician= msg.sender ; 
    }
    modifier isTechnician (){
        require(msg.sender == technician,"Not technician");
        _;

    }
    
   
    
}