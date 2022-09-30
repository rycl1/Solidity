// incorporating oracles, contract inheritance
// Maybe some kind of auto payout contract scheme, like inheritance or something that pulls from an oracle?
// Maybe a contract that uses price datafeed to trigger some kind of action? Like a distribution of funds if some asset reaches a certain price?


// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

contract PriceConsumerV3 {

    struct user {
        address user_address;
        uint amount;
        uint connect_val;
        // If we use this connect_val to connect, we have to make sure there's no latency between two
        // initializers, so that nobody jumps in between. Just have it initialize at the same time if possible?
      }

    AggregatorV3Interface internal priceFeed;

    /**
     * Network: Goerli
     * Aggregator: ETH/USD
     * Address: 0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e
     */
    constructor() {
        priceFeed = AggregatorV3Interface(0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e);
    }

    /**
     * Returns the latest price
     */
    function getLatestPrice() public view returns (int) {
        (
            /*uint80 roundID*/,
            int price,
            /*uint startedAt*/,
            /*uint timeStamp*/,
            /*uint80 answeredInRound*/
        ) = priceFeed.latestRoundData();
        return price;
    }

    function test() public view returns (string memory) {
        string memory p1 = "P1";
        string memory p2 = "P2";

        (
            /*uint80 roundID*/,
            int price,
            /*uint startedAt*/,
            /*uint timeStamp*/,
            /*uint80 answeredInRound*/
        ) = priceFeed.latestRoundData();

        if (price > 133466002243) {
            return p1;
        } else {
            return p2;
        }



    }
}
