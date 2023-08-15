// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Fallback {

  mapping(address => uint) public contributions; // Mapping a address to amount of contributions
  address public owner; 

    // Contructor = as soon as the contract initialized, this happen first. Just like initial state.
  constructor() {
    owner = msg.sender; 
    contributions[msg.sender] = 1000 * (1 ether);  // Sender that initialized this contract has amount of contributions set to 1000 * 1 ether
  }

    // Modifier = modify the behaviour of a function
    // in This onlyOwner modifier, it is like control acces. 
    // The only person that can interact with a specific function is only the 'owner'
    // modifier called on a function, ex here is on withdraw function below.  
    // When 
  modifier onlyOwner {
        require(
            msg.sender == owner,
            "caller is not the owner" // If the prerequisity is false, then it will return this.
        );
        _; // if true, it will continue to the function
    }

  function contribute() public payable {
    require(msg.value < 0.001 ether);
    contributions[msg.sender] += msg.value;
    if(contributions[msg.sender] > contributions[owner]) {
      owner = msg.sender;
    }
  }

  function getContribution() public view returns (uint) {
    return contributions[msg.sender];
  }

  function withdraw() public onlyOwner {
    payable(owner).transfer(address(this).balance);
  }

  receive() external payable {
    require(msg.value > 0 && contributions[msg.sender] > 0);
    owner = msg.sender;
  }
}
