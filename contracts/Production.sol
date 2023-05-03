pragma solidity ^0.8.17;
import './Technician.sol';
import './Phlebotomist.sol';
import './Transporter.sol';
import './Doctor.sol';
import './Donor.sol';




contract Production is   Phlebotomist, Transporter,Technician,Doctor{
    enum BloodStatus { ReadyForDelivery,  OnTrack, EndDelivery, Received,ReadyToBeDonated,ApprovedToBeDonated,OnTrackToTheHospital,ArrivedToTheHospital,Donated}
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
    
    
     function CollectBloodUnit (uint donner )public isPhlebotomist returns (BloodUnit memory) {
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
     function getCount() public view returns(uint){return(bloodCount);}
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
         bool test=false;
        for (uint j=0;j<=bloodCount;j++){
            if(units[j]._status==BloodStatus.ReadyForDelivery)  {  
                for(uint i=0;i<transporters.length;i++){
                    if(msg.sender==transporters[i]){
                        test=true;
               
                    
                        units[j]._status=BloodStatus.OnTrack;
                        //delete units[j];
                        OnDelievery[OnDelieverycount]=units[j];
                        //delete units[j];
                        
                        OnDelieverycount++;
                         emit OnTrack("On Track");
                     } }    }
                       else {
            revert('the Blood is not ready for Delievery');                  
                }     }
                if (test){

        
        bloodCount=0;}
        else {revert('not the right transporter');}}

    function End_Delivery() public {
        bool test=false;
        for (uint j=0; j<OnDelieverycount;j++){
        if(OnDelievery[j]._status==BloodStatus.OnTrack)  {  
            for(uint i=0;i<transporters.length;i++){
                    if(msg.sender==transporters[i]){
                        test=true;
         
                OnDelievery[j]._status=BloodStatus.EndDelivery;
                

                emit EndDelivery("EndDelivery");
            }}}
            
         
          else {
            revert('the Blood delivery is already done');
        }
        }
        if(test==false){revert('Not the right Transporter');}
        }
        

    function BloodReceived() public {
        for(uint j=0; j<OnDelieverycount;j++){
         if (OnDelievery[j]._status==BloodStatus.EndDelivery) {
             OnDelievery[j]._status=BloodStatus.Received; 
             delete OnDelievery[j];

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
    event order( string ty);
    function StateInUnits(uint _Id) public view returns (uint){
        bool test= false;
        uint i=0;
        while(i<bloodCount && !test ){
            if(_Id==units[i].DonnerId){
                test=true;
            } else{
                i++;
            }
        }
        if(test){
       return((i));}
       else {return(9999);}

    }
    function StateInOnDeliver(uint _Id) public view  returns(uint){
        bool test= false;
        uint i=0;
        while(i<OnDelieverycount && !test ){
            if(_Id==OnDelievery[i].DonnerId){
                test=true;
            } else{
                i++;
            }
        }
       if(test){
       return(i);}
       else {return(9999);}

    }
    function StateInAnalyzed(uint _Id) public view  returns(uint){
        bool test= false;
        uint i=0;
        while(i<analyzedCount && !test ){
            if(_Id==Analyzed[i].DonnerId){
                test=true;
            } else{
                i++;
            }
        }
        if(test){
       return(i);}
       else {return(9999);}

    }
      function StateToHospital(uint _Id) public view  returns(uint){
        bool test= false;
        uint i=0;
        while(i<ToHospitalCount && !test ){
            if(_Id==ToHospital[i].DonnerId){
                test=true;
            } else{
                i++;
            }
        }
        if(test){
       return(i);}
       else {return(9999);}

    }
      function StateDonated(uint _Id) public view returns(uint){
        bool test= false;
        uint i=0;
        while(i<DonatedCount && !test ){
            if(_Id==Donated[i].DonnerId){
                test=true;
            } else{
                i++;
            }
        }
        if(test){
       return(i);}
       else {return(9999);}

    }
    event dd(string d);
    event pos(string p);
     event Done(string p);
      event None(string p);
    function States( uint  _Id) public returns ( string memory){
        uint UnitsTest= StateInUnits(_Id);
        uint AnalyzedTest= StateInAnalyzed(_Id);
        uint OnDeliverTest= StateInOnDeliver(_Id);
        uint DonatedTest=StateDonated(_Id);
        uint HospitalTest= StateToHospital(_Id);
         if(DonatedTest != 9999){emit Done("Done");
            return("Your Blood is Donated and saved a life. Please make sure that you will donate once again");}
         else if(HospitalTest !=9999){
            if(ToHospital[HospitalTest]._status==BloodStatus.OnTrackToTheHospital){return("Your Blood is on track to the Hospital");}
            else{emit order("AH");
                return("Your Blood has arrived to the Hospital");}
        }
        else if(AnalyzedTest != 9999 ){
            if(Analyzed[AnalyzedTest]._status==BloodStatus.ApprovedToBeDonated){emit dd("doctor");
                return ("A doctor has ordered your Blood");}
            else{emit pos("Positive");
                return("Your Blood is Tested Positive To be Donated");}
        }
        
        
         else if(OnDeliverTest != 9999) {
            if(OnDelievery[OnDelieverycount]._status==BloodStatus.OnTrack){emit OnTrack("TrackB");
                return("Your Blood is on track to the Blood Bank");
            }
            else if(OnDelievery[OnDelieverycount]._status==BloodStatus.EndDelivery){
                emit EndDelivery("AB"); 
                return("Your Blood has arrived to the Blood Bank");}
            else{emit Received("Technician");
                return("Your Blood is Received by the Technician and needs to be tested first");}
        }
        else if(UnitsTest != 9999) {emit ready("ready");
        return("Ready For Delivery");
        }
        else{
        emit None("None");
        return("Your Blood is under tests. If this state doesn't change within atleast 5 days, you better check a doctor.");
        }

        
    }

     


event compare(bytes32 h1, bytes32 h2 , uint ii);
uint Approved=0;
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
        Approved++;      
        
        return(i);}
        else{
            revert("blood not found");
        }   
    
 }
 function getApproved() public view returns(uint) { return(Approved);}

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
    bool test=false;
        for (uint j=0;j<analyzedCount;j++){
            if( Analyzed[j]._status==BloodStatus.ApprovedToBeDonated)  {  
                 for(uint i=0;i<transporters.length;i++){
                    if(msg.sender==transporters[i]){
                        test=true;
              
                        Analyzed[j]._status=BloodStatus.OnTrackToTheHospital;
                        ToHospital[ToHospitalCount]=Analyzed[j];
                        DeleteFromAnalyzed(j);
                        emit OnTrack("ToTheHospital");
                        ToHospitalCount++;}
                                           
                } 
                             
         }       }
         if(test==false){revert('Not the right Transporter');}}
        
         
        
        

    function ArrivedToTheHospital() public {
        bool test=false;
        for (uint j=0; j<ToHospitalCount;j++){
        if(ToHospital[j]._status==BloodStatus.OnTrackToTheHospital)  {  
             for(uint i=0;i<transporters.length;i++){
                    if(msg.sender==transporters[i]){
                        test=true;
         
                ToHospital[j]._status=BloodStatus.ArrivedToTheHospital;
                

                emit EndDelivery("EndDelivery");
            }
            /* else {
            revert('the Blood delivery is already done');
        }*/
           
         }}}
         if(test==false){revert('Not the right transporter');}}
        
        //ToHospitalCount=0;
        

        mapping (uint=>BloodUnit) Donated;
        uint DonatedCount=0;
        
        

    function Donation (uint _id) public {
        BloodUnit memory B0= BloodUnit({
            DonnerId: _id,
            Typee: "__" ,
            Amount : 0,
            ExpiryDate :"__",
            _status : BloodStatus.Donated});
        Donated[DonatedCount]=B0;
        DonatedCount++;
 }
}


