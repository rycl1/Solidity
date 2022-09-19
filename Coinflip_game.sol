pragma solidity ^0.8.0; 
   

contract Types { 

      struct Player {
        string hasplayed;
        address my_address;
        uint wager;
      }

      Player[] public players; 

      uint[] data;
      uint[] public randcar;
      string[] public emissions;

      uint randNonce = 0;

      function initialize() public payable {
        require(msg.value > 0);
        uint wager = msg.value;
        players.push(Player("no", msg.sender, wager));  
        // Wager value/payable value involves situation where Wei value is minute decimal of Ethereum etc... check code I did for Nodestack
      } 

      function getBalance () external view returns(uint) {
        return address(this).balance;

      }
   
      function loop() public returns(uint[] memory, string memory){
    
      uint len = players.length;

      uint vin = 0;
      uint vin2 = 0;

      for(uint i=0; i<len-1; i++){
          //need to input "has played" aspect as well
          Player storage myplayer = players[i];
          Player storage newestplayer = players[len-1];
          if (myplayer.wager == newestplayer.wager) {
              flip(myplayer.wager, myplayer.my_address, newestplayer.wager, newestplayer.my_address);
              vin2 = 1;
          } else {
              vin = 1;
          }
          
          data.push(myplayer.wager);
      }

      if (vin == 1 && vin2 == 0) {
          return (data, "Sorry, no other players with that wager. Wait until another player triggers your wager with an equal wager, and the flip will automatically commence. Check your wallet later to see if you've won or lost!");
              // I believe this is outputting too many times (as many times as above statement isn't true, but doesn't activate flip() wich is good, as I didn't get another random number
              // try triggering an integer here, which will then trigger a message when the function continues (that won't
              // then be triggered if flip() is triggered

        //return data;
      }
      }



      function flip(uint wager1, address address1, uint wager2, address address2) public {
          randNonce++;
          // Use better (oracle) random number generation scheme here
          uint rand = uint(keccak256(abi.encodePacked(block.timestamp, msg.sender, randNonce))) % 100;
          if (rand >= 50) {
            // figure out what value to multiply by to account for gas and money for company
            payable(address1).transfer(wager1 * 3 / 2);
          } else {
            payable(address2).transfer(wager2 * 3 / 2);
          }
          randcar.push(rand);
      }

      //fallback function needs to be placed
      //Other backup functions
}

// need to audit for security and gas efficiency
