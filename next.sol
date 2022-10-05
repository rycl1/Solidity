// incorporating oracles, contract inheritance
// Maybe some kind of auto payout contract scheme, like inheritance or something that pulls from an oracle?
// Maybe a contract that uses price datafeed to trigger some kind of action? Like a distribution of funds if some asset reaches a certain price?


// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

contract PriceConsumerV3 {

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
    address public user2;
    uint public full_val;
    uint public tok_val;
    uint public datetime;

    /**
     * Network: Goerli
     * Aggregator: ETH/USD
     * Address: 0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e
     */

    
    constructor(address user2, uint full_val, uint tok_val, uint datetime) {
        priceFeed = AggregatorV3Interface(0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e);
        user_deployer = msg.sender;
        user2 = user2;
        full_val = full_val;
        tok_val = tok_val;
        datetime = datetime;
    }
    
    //upkeep function is triggered by Chainlink timekeeper on designated datetime
    function upkeep() public returns (address) {
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
            return user2;
        }

    }  

}
