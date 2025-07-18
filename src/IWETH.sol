// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

interface IWETH {
    function withdraw(uint256 amount) external;
    function transferFrom(address from, address to, uint256 amount) external returns (bool);
    function balanceOf(address) external view returns (uint256);
    function approve(address spender, uint256 amount) external returns (bool);
    function deposit() external payable;
}
