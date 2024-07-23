// SPDX-License-Identifier: MIT
pragma solidity >=0.8.21;

interface interCombined {
    function storeAddressToTicket(uint _ticket) external;
    function storeTicketToAddress(uint _ticket) external;

}

contract addressToTicket {
    
    address public owner;
    mapping(address => uint) public addtoTicket;

    modifier onlyOwner{
        require(msg.sender==owner, "Only Owner can call this function");
        _;
    }

    constructor(address _owner) {
        owner = _owner;
    }
    
    function storeAddressToTicket(uint _ticket) public onlyOwner{
        addtoTicket[msg.sender] = _ticket;
    }
    
}

contract ticketToAddress {
    mapping(uint => address) public ticketToAdd;

    function storeTicketToAddress(uint _ticket) public {
        ticketToAdd[_ticket] = msg.sender;
    }

    function exterCall(address _address, uint _ticket) public {    
        // interCombined(_address).storeTicketToAddress(_ticket);
        interCombined(_address).storeAddressToTicket(_ticket);
    }
}

// contract CombinedStorage is addressToTicket, ticketToAddress {
//     function storeData(uint _ticket) public {
//         storeAddressToTicket(_ticket);
//         storeTicketToAddress(_ticket);
//     }
// }
