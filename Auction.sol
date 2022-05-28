//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

// TODO: exploit so nobody else can bid above you
contract Auction {
    address highestBidder;
    uint highestBid;

    function bid() payable external {
        require(msg.value >= highestBid);

        if (highestBidder != address(0)) {
            (bool success, ) = highestBidder.call{value: highestBid}("");
            require(success);
        }

        highestBidder = msg.sender;
        highestBid = msg.value;
    }
}