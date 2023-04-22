pragma solidity ^0.8.17;
contract Phlebotomist
 {
   
    address phlebotomist;
    constructor(){
        phlebotomist= msg.sender ; 
    }
    modifier isPhlebotomist (){
        require(msg.sender == phlebotomist,"Not phlebotomist");
        _;

    }
    function getAdress() external view returns (address){
        return(phlebotomist);
    }
    
   
    
}
