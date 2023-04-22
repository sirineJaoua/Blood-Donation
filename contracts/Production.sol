pragma solidity ^0.8.17;
import './Technician.sol';
import './Phlebotomist.sol';
import './Transporter.sol';



contract Production is   Phlebotomist, Transporter {
    enum BloodStatus { ReadyForDelivery,  OnTrack, EndDelivery, Received,ReadyToBeDonated,ApprovedToBeDonated,OnTrackToTheHospital,ArrivedToTheHospital,ReceivedAtTheHospital,Donated}
    struct BloodUnit {
        uint DonnerId;
        string Typee;
        uint Amount;
        string ExpiryDate;
        Production.BloodStatus  _status; 
        
    }
   // address PhAdress;
   /* function SetPhlebotomist() public{
         PhAdress = Phlebotomist.getAdress();
    }*/
    /*function getPh()public view returns(address){
        return(PhAdress);

    }*/
    event ready(string _etat);
    event OnTrack(string _etat);
    event EndDelivery(string _etat);
    event Received(string _etat);
    mapping (uint => BloodUnit) public units;
    address [] public transporters;
     uint bloodCount=0;
    
    
     function CollectBloodUnit (uint donner )public isPhlebotomist  returns (BloodUnit memory) {
         //BloodUnit  B0=BloodUnit(0,0,0,0, BloodStatus.NotReady );
         //B0._status=BloodStatus.NotReady;
         
         BloodUnit memory B0= BloodUnit({
            DonnerId: donner,
            Typee: "Unknown" ,
            Amount : 0,
            ExpiryDate : "unknown" ,
            _status : BloodStatus.ReadyForDelivery


         });
            units[bloodCount]= B0;
            bloodCount++;
            
        return(B0);
            

                 
     }
     function getiD (uint _index) public view returns (uint){
        return units[_index].DonnerId;
     }
     function getState(uint _index) public view returns(BloodStatus){
        return units[_index]._status;
     }
      function getStateAnalyzed(uint _index) public view returns(BloodStatus){
        return Analyzed[_index]._status;
     }
     function getStateOnDeliever(uint _index) public view returns(BloodStatus){
        return OnDelievery[_index]._status;
     }
     function getStateHospital(uint _index) public view returns(BloodStatus){
        return ToHospital[_index]._status;
     }
     function getStateDonation(uint _index) public view returns(BloodStatus){
        return Donated[_index]._status;
     }
     

     function AssignTransporter(address _transporter) public isPhlebotomist{
         
         transporters.push(_transporter);
         emit ready("ready");
     }
     
     mapping (uint => BloodUnit) public OnDelievery;
     uint OnDelieverycount=0;
     function Start_Delivery() public {
        
        for (uint j=0;j<=bloodCount;j++){
            if(units[j]._status==BloodStatus.ReadyForDelivery)  {  
                for (uint i = 0; i < transporters.length; i++){
                     if (transporters[i] == msg.sender){
                        units[j]._status=BloodStatus.OnTrack;
                        OnDelievery[OnDelieverycount]=units[j];
                        
                        OnDelieverycount++;
                         
                     }     
                                         
                }
                
         }
         else {
            revert('the Blood is not ready for Delievery');
        }}
        emit OnTrack("On Track");
        bloodCount=0;}

    function End_Delivery() public {
        for (uint j=0; j<OnDelieverycount;j++){
        if(OnDelievery[j]._status==BloodStatus.OnTrack)  {  
         for (uint i = 0; i < transporters.length; i++){
            if (transporters[i] == msg.sender){
                OnDelievery[j]._status=BloodStatus.EndDelivery;
                

                emit EndDelivery("EndDelivery");
            }
            else {
                revert('Not the right Transporter');
            }
         }}
          else {
            revert('the Blood delivery is already done');
        }
        }}
        

    function BloodReceived() public {
        for(uint j=0; j<OnDelieverycount;j++){
         if (OnDelievery[j]._status==BloodStatus.EndDelivery) {
             OnDelievery[j]._status=BloodStatus.Received;                     
              }
        else {
            revert('the Blood is still On Track');
        }
        emit Received("Received"); 

    }
    OnDelieverycount=0;}
    mapping (uint => BloodUnit) public Analyzed;
    uint analyzedCount=0;
    
    function CreateBloodUnit(uint _donner,uint _amount, string memory _expiry ,string memory  _type) public{
         BloodUnit memory B0= BloodUnit({
            DonnerId: _donner,
            Typee: _type ,
            Amount : _amount,
            ExpiryDate : _expiry,
            _status : BloodStatus.ReadyToBeDonated});
        Analyzed[analyzedCount]=B0;
        analyzedCount++;
        
        
    }
    event order(uint am, string ty,string DoR);
    function OrderBlood(uint _amount,string memory _type, string memory  _DateofOrder) public{
        require(bytes(_type).length > 0, "Type must not be empty");
        emit order(_amount,_type,_DateofOrder);

    }

event compare(bytes32 h1, bytes32 h2 , uint ii);
  function Approve(uint _amount,string memory _date  ,string memory _type) public   returns(uint) {
    bool test = false;
    uint i = 0;
    
    
    while (i < analyzedCount && !test) {
       
        if (keccak256(abi.encodePacked(Analyzed[i].Typee)) ==keccak256(abi.encodePacked( _type)) && Analyzed[i].Amount >= _amount) {
            test = true;
            emit compare(keccak256(abi.encodePacked(Analyzed[i].Typee)),keccak256(abi.encodePacked( _type)), i);
        } else {
            
            i++;}       
    }
    if(test){
      
        emit Received("found");
        Analyzed[i]._status=BloodStatus.ApprovedToBeDonated;        
        
        return(i);}
        else{
            revert("blood not found");
        }   
    
 }

 function DeleteFromAnalyzed(uint i)private {    
    delete Analyzed[i];
    for (uint j =i; i < analyzedCount - 1; i++) {
        Analyzed[j] = Analyzed[j+1];
    }
   analyzedCount--;
 }

mapping(uint => BloodUnit) public  ToHospital;
uint ToHospitalCount=0;

 function DelieverToHospital() public {
        for (uint j=0;j<analyzedCount;j++){
            if( Analyzed[j]._status==BloodStatus.ApprovedToBeDonated)  {  
                for (uint i = 0; i < transporters.length; i++){
                     if (transporters[i] == msg.sender){
                        Analyzed[j]._status=BloodStatus.OnTrackToTheHospital;
                        ToHospital[ToHospitalCount]=Analyzed[j];
                        DeleteFromAnalyzed(j);
                        emit OnTrack("ToTheHospital");
                        ToHospitalCount++;}
                        //else{
                          //  revert('Not the right Transporter');
                       // }                                              
                } 
                             
         }       
        }
         
        
        }

    function ArrivedToTheHospital() public {
        for (uint j=0; j<ToHospitalCount;j++){
        if(ToHospital[j]._status==BloodStatus.OnTrackToTheHospital)  {  
         for (uint i = 0; i < transporters.length; i++){
            if (transporters[i] == msg.sender){
                ToHospital[j]._status=BloodStatus.ArrivedToTheHospital;

                emit EndDelivery("EndDelivery");
            }
             else {
            revert('the Blood delivery is already done');
        }
           
         }}
        }}

        mapping (uint=>BloodUnit) Donated;
        uint DonatedCount=0;
        
        function BloodReceivedInTheHospital() public {
        for(uint j=0; j<ToHospitalCount;j++){
         if (ToHospital[j]._status==BloodStatus.ArrivedToTheHospital) {
            ToHospital[j]._status=BloodStatus.ReceivedAtTheHospital;
            Donated[DonatedCount]=ToHospital[j];
            DonatedCount++;
            emit Received("Received");
          }
        else {
            revert('the Blood is still On Track');
        }
    }
    ToHospitalCount=0;}

    function Donation (uint _id) public {
       bool test=false;
       uint j=0;
       while ( j<=DonatedCount && test==false){
            if (Donated[j].DonnerId==_id){
                test=true;
            }
            else{
                j++;
            }
        }
        if(test){
            Donated[j]._status=BloodStatus.Donated;          
        }
        else{
            revert("ID not Found");
        }
    }
 }
 


