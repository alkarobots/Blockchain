// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./3_CoinFlip.sol";

contract CoinFlipAttack {
  // Create state variable to represent CoinFlip contract + FACTOR
  CoinFlip public victimContract;
  uint256 FACTOR = 57896044618658097711785492504343953926634992332820282019728792003956564819968;


}