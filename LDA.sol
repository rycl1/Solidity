
pragma solidity ^0.8.0; 

contract LDA { 

  function getBalance () external view returns(uint) {
        return address(this).balance;

      }

  function transferbal() public payable {
    //payable(address).transfer(value);
    }

}
