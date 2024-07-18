// SPDX-License-Identifier: MIT
pragma solidity >=0.8.21;

contract Lottery {
    struct Ticket {
        string name;
        uint ticketNumber;
    }

    mapping(uint => Ticket) public tickets;

    function buyTicket(string memory name, uint ticketNumber) public returns (bool) {
        if (tickets[ticketNumber].ticketNumber != 0) {
            return false;
        }

        tickets[ticketNumber] = Ticket(name, ticketNumber);
        return true;
    }
}
