// SPDX-License-Identifier: MIT
pragma solidity >=0.8.21;

contract Lottery{
    struct Ticket {
        address owner;
        uint ticketNumber;
    }
    uint randNum;
    uint constant ticketPrice = 100000000 gwei;
    
    Ticket[] public dataArray;

    uint winningNumber;

    mapping(uint => bool) public ticketsExist;
    mapping(address => uint) public addressToTicketNumber;

    event TicketBought(address indexed owner, uint ticketNumber);
    event WinningNumberSet(uint winningNumber);
    address owner = msg.sender;

    modifier onlyOwner(){
        require(owner==msg.sender,"You are not the Owner");
        _;
    }

    constructor() {
        ticketsExist[0] = true;
    }

    function buyTicket(uint ticketNumber) public payable returns (bool) {
        require(!ticketsExist[ticketNumber], "Ticket already bought.");
        require(addressToTicketNumber[msg.sender] == 0, "You have already bought a ticket.");
        require(msg.value == ticketPrice, "Incorrect ticket price. Please send 100000000 gwei");

        Ticket memory newTicket = Ticket({
            owner: msg.sender,
            ticketNumber: ticketNumber
        });

        dataArray.push(newTicket);
        addressToTicketNumber[msg.sender] = ticketNumber;
        ticketsExist[ticketNumber] = true;

        emit TicketBought(msg.sender, ticketNumber);

        return true;
    }

    function setWinningNumber(string memory _anystring) public onlyOwner{
        winningNumber = uint(keccak256(abi.encodePacked(_anystring)));
        winningNumber = winningNumber%100;
    }

    function getWinningNumber() public onlyOwner view returns(uint){
        return winningNumber;
    }

    function distributePrize() public onlyOwner{
        require(winningNumber != 0, "Winning number has not been set yet.");

        address winner = address(0);
        for (uint i = 0; i < dataArray.length; i++) {
            if (dataArray[i].ticketNumber == winningNumber) {
                winner = dataArray[i].owner;
                break;
            }
        }

        require(winner != address(0), "No winner found for the winning number.");

        uint prizeAmount = address(this).balance;
        payable(winner).transfer(prizeAmount);

    }
    
} 
