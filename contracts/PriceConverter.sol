// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

//contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol"; // Importing this interface directly from the github or npm.

library PriceConverter{             // all the functions in the library to export should be internal not public.

    function getPrice() internal view returns(uint256){
        // Address 0x694AA1769357215DE4FAC081bf1f309aDC325306
        //ABI done.
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        (,int256 price,,,) = priceFeed.latestRoundData();   // Destructuring the functions reults into different variables or only select a perticular variable.
        // price of eth in usd dollars
        // 2000_00000000
        return uint256(price*1e10);
    }

    function getConversionRate(uint256 ethAmount) internal  view returns (uint256) {
        uint256 ethPrice = getPrice();
        uint256 ethAmountInUsd = (ethPrice * ethAmount) / 1e18; // (1000000000000000000 * 1000000000000000000) / 1000000000000000000
        return ethAmountInUsd;
    }

    function getVersion() internal view returns (uint256) {
        return AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306).version();
    }

}