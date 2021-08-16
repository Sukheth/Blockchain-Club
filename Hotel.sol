pragma solidity >=0.5.0 <0.6.0;

import "./owner.sol";

contract Hotel is Ownable{
    
    event newBooking(uint bookingId, address guest, uint roomNo);
    event cancellation(uint bookingId, address guest, uint roomNo);
    
    mapping (uint => address) roomToGuest;
    mapping (uint => bool) avail;
    
    uint fee=2;
    uint canc1=0;
    uint canc2=50;
    uint canc3=100;
    
    struct booking{
        uint roomNo;
        address guest;
        uint time;
        uint duration;
    }
    
    booking[] Bookings;

    
    function values(uint _fee, uint _canc1, uint _canc2, uint _canc3) public onlyOwner{
        fee=_fee;
        canc1=_canc1;
        canc2=_canc2;
        canc3=_canc3;
    }
    
    
    
    function bookRoom(uint _roomNo, uint _time, uint _duration) public payable {
        require(msg.value == fee);
        require(avail[_roomNo] == true);
        roomToGuest[_roomNo] = msg.sender;
        avail[_roomNo] = false;
        uint id = Bookings.push(booking(_roomNo, msg.sender, _time, _duration));
        emit newBooking(id, msg.sender, _roomNo);
    }
    
    function cancel (uint _id) public {
        require(Bookings[_id].guest == msg.sender);
        if (now-Bookings[_id].time > 1 weeks){
            avail[Bookings[_id].roomNo] = true;
            msg.sender.transfer((1-canc1)*fee);
        }
        else if (now-Bookings[_id].time > 2 days){
            avail[Bookings[_id].roomNo] = true;
            msg.sender.transfer((1-canc2)*fee);
        }
        else{
            avail[Bookings[_id].roomNo] = true;
            msg.sender.transfer((100-canc3)*fee/100);
        }
        emit cancellation(_id, msg.sender, Bookings[_id].roomNo);
    }
}