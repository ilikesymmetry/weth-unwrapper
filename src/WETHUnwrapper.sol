// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {IWETH} from "./IWETH.sol";

contract WETHUnwrapper {
    IWETH public immutable weth;

    error WETHTransferFromFailed();
    error ETHTransferFailed();

    constructor(address _weth) {
        weth = IWETH(_weth);
    }

    receive() external payable {}

    function unwrap(uint256 amount) external {
        // Transfer WETH from caller to this contract
        if (!weth.transferFrom(msg.sender, address(this), amount)) revert WETHTransferFromFailed();

        // Unwrap WETH to ETH
        weth.withdraw(amount);

        // Transfer ETH back to caller
        (bool success,) = msg.sender.call{value: amount}("");
        if (!success) revert ETHTransferFailed();
    }
}
