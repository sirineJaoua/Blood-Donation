pragma solidity ^0.8.17;
contract Doctor{
   
    address doctor ;

    constructor(){
        doctor= msg.sender ; 
    }
    modifier isDoctor (){
        require(msg.sender == doctor,"Not doctor");
        _;

    }
    
   
    
}