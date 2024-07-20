// SPDX-License-Identifier: MIT
pragma solidity >=0.8.21;

contract Lottery {
    struct Ticket {
        string name;
        uint ticketNumber;
    }
    
    Ticket[] public dataArray;

    uint winningNumber;

    address user = msg.sender;    

    mapping(uint => string) public tickets;
    mapping(uint=>Ticket) public numToData;

    event DataStored(string name, uint Amount);
    
    function buyTicket(string memory name, uint ticketNumber) public returns (bool) {
        if (keccak256(abi.encodePacked(tickets[ticketNumber])) ==  keccak256(abi.encodePacked(""))) {
            tickets[ticketNumber]=name;
            emit DataStored(name,ticketNumber);
        }
        return false;
    }

    function buyTicket1( string memory name, uint ticketNumber) public {
        require((keccak256(abi.encodePacked(tickets[ticketNumber])) ==  keccak256(abi.encodePacked(""))), "Ticket Already Exists");
        numToData[ticketNumber] = Ticket(name,ticketNumber);
        emit DataStored(name,ticketNumber);
    }

    function setWinningNumber(string memory name, uint ticketNumber) public returns (bool){
        if(keccak256(abi.encodePacked(name)) != keccak256(abi.encodePacked("admin"))){
            return false;
        }

        winningNumber=ticketNumber;
        return true;
    }

    function returnWinningNumber()public view returns(uint){
        return winningNumber;
    }
}
