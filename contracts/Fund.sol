// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

//contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol"; // Importing this interface directly from the github or npm.

contract Fund{
    uint256 public myValue=1;

    function fund() public payable {    // payable allows function to make transaction
        
        myValue = myValue+2;    // If the below require doesn't satify this whole method will reverted and the value doesn't change.

        require( msg.value > 1e18,"didn't send enough ETH.");        // It sets the condition that if this contract doesn't have more than 1 ETH or 1*10^18 wei, then it will not execute.
    }

    function getPrice() public view returns(uint256){
        // Address 0x694AA1769357215DE4FAC081bf1f309aDC325306
        //ABI done.
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        (,int256 price,,,) = priceFeed.latestRoundData();
        return uint256(price*1e10);
    }

    function getVersion() public view returns (uint256) {
        return AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306).version();
    }

}