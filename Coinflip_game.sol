pragma solidity ^0.5.0; 
   

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

      function initialize(uint wager) public {
        players.push(Player("no", msg.sender, wager));  
      } 
   
      function loop() public returns(uint[] memory, string memory){
    
      uint len = players.length;

      for(uint i=0; i<len-1; i++){
          Player storage myplayer = players[i];
          Player storage newestplayer = players[len-1];
          if (myplayer.wager == newestplayer.wager) {
              flip(myplayer.wager, myplayer.my_address, newestplayer.wager, newestplayer.my_address);
          } else {
              return (data, "Sorry, no other players with that wager. Wait until another player triggers your wager with an equal wager");
              // I believe this is outputting too many times (as many times as above statement isn't true, but doesn't activate flip() wich is good, as I didn't get another random number)
          }
          
          data.push(myplayer.wager);
      }
        //return data;
      }



      function flip(uint wager1, address address1, uint wager2, address address2) public {
          randNonce++;
          // Use better (oracle) random number generation scheme here
          uint rand = uint(keccak256(abi.encodePacked(now, msg.sender, randNonce))) % 100;
          if (rand >= 50) {

            // first player wins, transfer ETH to him. Original initialize function should be payable, and the ETH sits in the contract wallet

          } else {

            // second player wins, transfer ETH to him. Original initialize function should be payable, and the ETH sits in the contract wallet 

          }
          randcar.push(rand);
      }
}

