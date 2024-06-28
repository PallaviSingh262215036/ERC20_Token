# ERC-20 Token Contract

This is a simple implementation of an ERC-20 token contract written in Solidity. The contract adheres to the ERC-20 standard and includes functionalities for minting, burning, transferring tokens, and approving allowances for delegated spending.

## Prerequisites

- Solidity compiler version >=0.6.12 <0.9.0
- An Ethereum wallet (e.g., MetaMask) for deploying and interacting with the contract
- Basic understanding of Solidity and smart contract development

## Getting Started

### Installing

1. Open the [Remix IDE](https://remix.ethereum.org/).
2. Create a new file and paste the contents of `ERC20.sol` from this repository.

### Deployment

1. **Compile the Contract:**
   - Select the appropriate Solidity compiler version (>=0.6.12 <0.9.0).
   - Click on the "Compile" button to compile the contract.

2. **Deploy the Contract:**
   - Go to the "Deploy & Run Transactions" tab.
   - Select the environment (e.g., JavaScript VM, Injected Web3).
   - Click on the "Deploy" button.

## Contract Details

### State Variables

- `string public Name`: The name of the token.
- `string public Abbrv`: The abbreviation (symbol) of the token.
- `uint256 internal TotalSupply`: The total supply of the token.
- `address public Owner`: The address of the contract owner.
- `mapping(address => uint256) private BalanceOf`: Mapping to keep track of token balances for each address.
- `mapping(address => mapping(address => uint256)) private Allowance`: Mapping to keep track of allowances for delegated spending.

### Constructor

The constructor is called when the contract is deployed. It initializes the token's name, abbreviation, and sets the contract owner.

```solidity
constructor(string memory _name, string memory _abbrv) {
    Name = _name;
    Abbrv = _abbrv;
    Owner = msg.sender;
}
```

### Deployment

Deploy the contract by providing the token name, token abbreviation, and initial supply.

 ### ERC-20 Standard Function

`totalSupply`
Returns the total supply of tokens.

```solidity
function totalSupply() external view override returns (uint256) {
    return TotalSupply;
}
```

`balanceOf`
Returns the token balance of a given address.
```slodity
function balanceOf(address account) external view override returns (uint256) {
    return BalanceOf[account];
}
```

`transfer`
Transfers tokens from the caller's address to another address
```soldity
function transfer(address to, uint256 value) external override returns (bool) {
    _transfer(msg.sender, to, value);
    return true;
}
```

`allowance`
Returns the remaining number of tokens that a spender is allowed to spend on behalf of the owner.
```soldity
function allowance(address owner, address spender) external view override returns (uint256) {
    return Allowance[owner][spender];
}
```

`approve`
Allows a spender to spend a certain number of tokens on behalf of the caller.
```soldity
function approve(address spender, uint256 value) external override returns (bool) {
    _approve(msg.sender, spender, value);
    return true;
}
```

`transferFrom`
Transfers tokens from one address to another using an allowance.
```soldity
function transferFrom(address from, address to, uint256 value) external override returns (bool) {
    _transfer(from, to, value);
    Allowance[from][to] -= value;
    return true;
}
```

Internal Functions
`_transfer`
Handles the actual transfer of tokens between addresses.
```soldity
function _transfer(address from, address to, uint256 amount) internal {
    require(from != address(0), "You are sending from Invalid address");
    require(to != address(0), "You are sending to Invalid address");
    require(BalanceOf[from] >= amount, "Insufficient balance to send");

    BalanceOf[from] -= amount;
    BalanceOf[to] += amount;
    emit Transfer(from, to, amount);
}
```

`_approve`
Handles the approval of allowances for spenders.
```solidity
function _approve(address owner, address spender, uint256 value) internal {
    require(spender != address(0), "You are giving approve to zero address");
    require(owner != address(0), "owner has zero address");
    BalanceOf[owner] >= value;
    Allowance[owner][spender] = value;
    emit Approval(owner, spender, value);
}
```

Minting and Burning Tokens
`_mint`
Allows the owner to mint new tokens.
```solidity
function _mint(address to, uint256 amount) external {
    require(msg.sender == Owner, "Only Owner");
    require(to != address(0), "you are minting to Zero address bro!");
    BalanceOf[to] += amount;
    TotalSupply += amount;
}
```

`_burn`
Allows the owner to burn tokens.
```solidity
function _burn(address to, uint256 amount) external {
    require(to != address(0), "you are burning to Zero address bro!");
    BalanceOf[to] -= amount;
    TotalSupply -= amount;
}
```

### License
This project is licensed under the MIT License.



