// SPDX-License-Identifier: MIT
pragma solidity >=0.8.22;

import "@openzeppelin/contracts/interfaces/IERC20.sol";

contract Bank{
    address public token;

    constructor(address _token){
        token=_token;
    }

    mapping(address=>uint) public balance;

    function deposit(uint _amt) public{
        IERC20(token).transferFrom(msg.sender, address(this),_amt);
        balance[msg.sender]+=_amt;
    } 

    function withdraw(uint _amt) public{
        require(_amt<balance[msg.sender],"Insufficient Balace");
        IERC20(token).transfer(msg.sender,_amt);
        balance[msg.sender]-=_amt;
    }
}
