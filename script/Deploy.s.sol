// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {WETHUnwrapper} from "../src/WETHUnwrapper.sol";

contract Deploy is Script {
    address wethAddress = 0x4200000000000000000000000000000000000006;

    bytes32 salt = keccak256("WETHUnwrapper");

    function setUp() public {}

    function run() public {
        vm.startBroadcast();

        new WETHUnwrapper{salt: salt}(wethAddress);

        vm.stopBroadcast();
    }
}
