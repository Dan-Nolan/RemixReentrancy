//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.4;

// TODO: exploit to take someone else's balance
contract EOABank {
    modifier isNotContract(address account) {
        uint size;
        assembly {
            size := extcodesize(account)
        }
        require(size == 0);
        _;
    }

    mapping(address => uint) public balances;

    // this bank only accepts deposits from EOAs!
    receive() external payable isNotContract(msg.sender) {
        balances[msg.sender] += msg.value;
    }

    function withdraw() external {
        (bool success, ) = msg.sender.call{ value: balances[msg.sender] }("");
        require(success);
        balances[msg.sender] = 0;
    }
}