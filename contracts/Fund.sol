// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {PriceConverter} from "contracts/PriceConverter.sol";

// 772,317 gas - without constant and immutable keywords.
// 728,792 gas - with constant and immutable keywords.

error NotOwner();

contract Fund{

    using PriceConverter for uint256; // now PriceConverter can access all the uint256 of this contract.

    uint256 public constant MIN_USD= 3e18; // means $3 USD.

    address[] public funders;
    mapping (address funder => uint256 amountFunded) public addressToAmountFunded; // mapping is key value pair. (key = address, value = amount)
    address public immutable i_owner;

    constructor(){
        i_owner=msg.sender;
    }

    modifier onlyOwner(){   // same used as public, private, payable, etc.
        // _; if this is there then, the function will execute first and condition is checked after.
        // require(msg.sender==i_owner,"Sender is not owner!");  //condition: to verify that only owner can withdraw.
        if (msg.sender!=i_owner){revert NotOwner();} // does same as require.
        _; // this species function call
    }

    function fund() public payable {    // payable allows function to make transaction
        
        //myValue = myValue+2;    // If the below require doesn't satify this whole method will reverted and the value doesn't change.
        require( msg.value.getConversionRate() >= MIN_USD,"didn't send enough ETH.");        // It sets the condition that if this contract doesn't have more than 1 ETH or 1*10^18 wei, then it will not execute.
                // the 1st parameter of any imported library function should be provided like that.
                // all others in () sequentially.
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] += msg.value;  // for recording all transactions price.
    }

    function withdraw() public  onlyOwner{

        for (uint256 funderInd = 0; funderInd < funders.length; funderInd++) 
        {
            address funder = funders[funderInd];
            addressToAmountFunded[funder] = 0;   
        }

        funders = new address[](0);// resetting the array.

        (bool callSuccess,)= payable (msg.sender).call{value: address(this).balance}(""); // to send funds.
        require(callSuccess,"Send Not Successfull!");
    }

    receive() external payable {
        fund();
    }

    fallback() external payable {
        fund();
    }
}