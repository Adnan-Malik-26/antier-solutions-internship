
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract addressToTicket {
    mapping(address => uint) public addtoTicket;

    function storeAddressToTicket(uint _ticket) public {
        addtoTicket[msg.sender] = _ticket;
    }


}

contract ticketToAddress {
    mapping(uint => address) public ticketToAdd;

    function storeTicketToAddress(uint _ticket) public {
        ticketToAdd[_ticket] = msg.sender;
    }

}

contract CombinedStorage is addressToTicket, ticketToAddress {
    function storeData(uint _ticket) public {
        storeAddressToTicket(_ticket);
        storeTicketToAddress(_ticket);
    }

}
