pragma solidity ^0.8.17;
contract Transporter
 {
   
    address transporter;
    constructor(){
        transporter= msg.sender ; 
    }
    modifier isTransporter (){
        require(msg.sender == transporter,"Not transporter");
        _;

    }
    function getAdresss() public view returns (address){
        return(transporter);
    }
    
   
    
}