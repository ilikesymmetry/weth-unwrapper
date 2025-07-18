// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";

import {WETHUnwrapper} from "../src/WETHUnwrapper.sol";
import {IWETH} from "../src/IWETH.sol";

contract WETHUnwrapperTest is Test {
    WETHUnwrapper public unwrapper;
    IWETH public weth;

    address constant WETH_ADDRESS = 0x4200000000000000000000000000000000000006;
    address user = 0x515B4Ff55078066BA8B025a1e974215084FE86d5;

    function setUp() public {
        // Fork Base mainnet
        vm.createSelectFork("base");

        weth = IWETH(WETH_ADDRESS);
        unwrapper = new WETHUnwrapper(WETH_ADDRESS);
    }

    function test_unwrap_happy_path(uint256 amount) public {
        vm.assume(amount < 0.0005 ether);

        // Record initial balances
        uint256 initialUserETH = user.balance;
        uint256 initialUserWETH = weth.balanceOf(user);

        // Approve and unwrap
        vm.startPrank(user);
        weth.approve(address(unwrapper), amount);
        unwrapper.unwrap(amount);
        vm.stopPrank();

        // Verify balances after unwrapping
        assertEq(user.balance, initialUserETH + amount, "User should receive ETH");
        assertEq(weth.balanceOf(user), initialUserWETH - amount, "User WETH should decrease");
        assertEq(address(unwrapper).balance, 0, "Unwrapper should have no ETH remaining");
    }
}
