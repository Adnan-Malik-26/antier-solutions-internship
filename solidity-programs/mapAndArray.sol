// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.18;

contract Solid{
    struct Account{
        string name;
        int amount;
    }
        
    mapping(string => int ) public map;    


    function store(string memory name, int amount) public  {
        map[name]=amount;
    }
    
    Account[] public AccountsArray;

    function storeInArray(string memory name, int amount) public {
        Account memory newAccount = Account(name, amount);
        AccountsArray.push(newAccount);
    }
}
