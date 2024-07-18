// SPDX-License-Identifier: MIT
pragma solidity >=0.8.21;

contract Lottery {
    struct Ticket {
        string name;
        uint ticketNumber;
    }
    uint winningNumber;

    mapping(uint => string) public tickets;
    
    
    function buyTicket(string memory name, uint ticketNumber) public returns (bool) {
        if (keccak256(abi.encodePacked(tickets[ticketNumber])) ==  keccak256(abi.encodePacked(""))) {
            tickets[ticketNumber]=name;
            return true;
        }

        return false;
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
