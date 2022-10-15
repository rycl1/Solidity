// incorporating oracles, contract inheritance
// Maybe some kind of auto payout contract scheme, like inheritance or something that pulls from an oracle?
// Maybe a contract that uses price datafeed to trigger some kind of action? Like a distribution of funds if some asset reaches a certain price?


// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

contract Distribute {

    /*struct user {
        address user_address1;
        address user_address2;
        uint amount;
        // If we use this connect_val to connect, we have to make sure there's no latency between two
        // initializers, so that nobody jumps in between. Just have it initialize at the same time if possible?
        // Going to need a mapping to look ppl up by their struct (maybe)
      } */

    AggregatorV3Interface internal priceFeed;
    address public user_deployer;
    address public user_secondary;
    uint public full_val;
    uint public tok_val;
    uint public datetime;

    /**
     * Network: Goerli
     * Aggregator: ETH/USD
     * Address: 0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e
     */
     
     function getBalance () external view returns(uint) {
        return address(this).balance;
    }

    
    constructor(address user2, uint full_value, uint token_value, uint datetime_input) {
        priceFeed = AggregatorV3Interface(0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e);
        user_deployer = msg.sender;
        user_secondary = user2;
        full_val = full_value;
        tok_val = token_value;
        datetime = datetime_input;
    }

    function user_secondary_pay () public payable {
        require(msg.value = 2 ether); // Shouldn't need to be hardcoded
    }
    
    //upkeep function is triggered by Chainlink timekeeper on designated datetime
    function upkeep() public returns (address) {
        uint current_contract_val = getBalance();
        require(current_contract_val == 4 ether);
        //maybe require upkeep to check that the contract value is the full value, or 
        //test for it later and revert after 24 hours or something if second user hasn't put the money
        //in. Have one check 24 hours after deployment for second user funds, if user didn't put them
        //in the value reverts back to deployer because second user is awol. Second check comes on datetime_input.
        (
            /*uint80 roundID*/,
            int price,
            /*uint startedAt*/,
            /*uint timeStamp*/,
            /*uint80 answeredInRound*/
        ) = priceFeed.latestRoundData();

        //133466002243


        if (price > int(tok_val)) {
            return user_deployer;
        } else {
            return user_secondary;
        }

    }  

}
