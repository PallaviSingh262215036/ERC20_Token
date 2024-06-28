// SPDX-License-Identifier: MIT
// SPDX: Software Data Exchange MIT: Open Sourse
pragma solidity >=0.6.12 <0.9.0;
// version of compiler

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/IERC20.sol";
contract ERC20 is IERC20{
    string public Name;
    string public Abbrv;
    uint256 internal TotalSupply;
    address public Owner;
    mapping (address=>uint256) private BalanceOf;
    mapping (address=> mapping(address=>uint256)) private Allowance;

  constructor(string memory _name, string memory _abbrv)
  {
   Name=_name;
   Abbrv=_abbrv;

   Owner=msg.sender;


  }
 

  function totalSupply() external view override returns (uint256){
         return(TotalSupply);

    }

  function balanceOf(address account) external view override returns (uint256){
      return(BalanceOf[account]);
    }
  
  function transfer(address to, uint256 value) external override returns (bool){
      _transfer(msg.sender,to,value);
      return true;
    }

  function allowance(address owner, address spender) external view override returns (uint256){
   return (Allowance[owner][spender]);
    }
  
  function approve(address spender, uint256 value) external override returns(bool){
   _approve(msg.sender,spender,value);
   return true;
  }

  function transferFrom(address from, address to, uint256 value) external override returns (bool){
    _transfer(from,to,value);
     Allowance[from][to]-=value;
     return true;
      }
  


  

  
  function _transfer( address from, address to, uint256 amount) internal {
  require(from!=address(0),"You are sending from Invalid address");
  require(to!=address(0),"You are sending to Invalid address");
  require(BalanceOf[from]>=amount,"Insufficient balance to send");
  
  BalanceOf[from]=BalanceOf[from]-amount;
  BalanceOf[to]=BalanceOf[to]+amount;
   emit Transfer(from, to, amount);
    
    }  

  function _approve(address owner,address spender,uint256 value) internal{
     require(spender!=address(0),"You are giving approve to zero address");  
     require(owner!=address(0),"owner has zero address");
     BalanceOf[owner]>=value;
     Allowance[owner][spender]=value;
     emit Approval(owner, spender, value);
  
  }  
  
  function _mint(address to, uint256 amount) external{
    require(msg.sender==Owner,"Only Owner");
    require(to!=address(0),"you are minting to Zero address bro!");
    BalanceOf[to]+=amount;
    TotalSupply+=amount;
  }

  function _burn(address to, uint256 amount) external{
    require(to!=address(0),"you are burning to Zero address bro!");
    BalanceOf[to]-=amount;
    TotalSupply-=amount;
  }
  
    
}
