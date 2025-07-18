## WETH Unwrapper

> These contracts are not audited. Use at own risk.

**Public utility contract to help unwrap WETH for Smart Accounts that are incompatible with [WETH9](https://basescan.org/token/0x4200000000000000000000000000000000000006) withdraw**

WETH9's `withdraw` function sends unwrapped ETH back to the caller using the deprecated `transfer` function which comes with a `2300` gas limit. Smart contract accounts may have logic on `receive` that exceeds this gas limit, causing a revert that prevents them from unwraping their WETH directly. For example, a smart account that uses an ERC-1967 proxy will require `SLOAD` and `DELEGATECALL` opcodes which exceed this limit.

To circumvent this, a public `WETHUnwrapper` contract can facilitate the unwrapping for smart accounts.

As a wallet, simply submit a batch of calls to:
1. `WETH.approve(Unwrapper, amount)`
2. `WETHUnwrapper.unwrap(amount)`

The [unwrap](https://github.com/ilikesymmetry/weth-unwrapper/blob/main/src/WETHUnwrapper.sol#L18-L28) function on the Unwrapper will:
1. pull WETH into the Unwrapper via transferFrom (requires account first approving contract with WETH)
2. unwrap via calling withdraw on WETH
3. send unwrapped ETH back to sender

A sample contract is deployed to Base Sepolia at [0xf58200cA78aE59C0A123aa6dA45883c7436E1064](https://sepolia.basescan.org/address/0xf58200ca78ae59c0a123aa6da45883c7436e1064#code)
