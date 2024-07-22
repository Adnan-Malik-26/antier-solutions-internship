// SPDX-License-Identifier: MIT
pragma solidity >=0.8.21;

contract Lottery {
    struct Ticket {
        address owner;
        uint ticketNumber;
    }
    
    Ticket[] public dataArray;

    uint winningNumber;

    mapping(uint => bool) public ticketsExist;
    mapping(address => uint) public addressToTicketNumber;

    event TicketBought(address indexed owner, uint ticketNumber);
    event WinningNumberSet(uint winningNumber);

    constructor() {
        ticketsExist[0] = true;
    }

    function buyTicket(uint ticketNumber) public returns (bool) {
        require(!ticketsExist[ticketNumber], "Ticket already bought.");
        require(addressToTicketNumber[msg.sender] == 0, "You have already bought a ticket.");

        address owner = msg.sender;
        Ticket memory newTicket = Ticket({
            owner: owner,
            ticketNumber: ticketNumber
        });

        dataArray.push(newTicket);
        addressToTicketNumber[owner] = ticketNumber;
        ticketsExist[ticketNumber] = true;

        emit TicketBought(owner, ticketNumber);

        return true;
    }

    function setWinningNumber(uint _winningNumber) public {
        require(msg.sender == 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4, "Only admin can set winning number.");

        winningNumber = _winningNumber;

        emit WinningNumberSet(winningNumber);
    }

    function getWinningNumber() public view returns (uint) {
        return winningNumber;
    }
}
