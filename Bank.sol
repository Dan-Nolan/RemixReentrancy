//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.4;

// TODO: exploit to take someone else's balance
contract Bank {
    mapping (address => uint) private userBalances;

    function deposit() external payable {
        userBalances[msg.sender] += msg.value;
    }

    function withdraw() external {
        uint userBalance = userBalances[msg.sender];

        require(userBalance > 0, "User balance insufficient for withdrawal");

        (bool success, bytes memory payload) = msg.sender.call{value: userBalance}("");
        require(success, string(payload));
        
        userBalances[msg.sender] = 0;
    }
}