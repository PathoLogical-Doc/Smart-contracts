// SPDX-License-Identifier: MIT

// Amended by Patho-Logical
/**
  _____   ____   _____ _______ ____  _____  
 |  __ \ / __ \ / ____|__   __/ __ \|  __ \ 
 | |  | | |  | | |       | | | |  | | |__) |
 | |  | | |  | | |       | | | |  | |  _  / 
 | |__| | |__| | |____   | | | |__| | | \ \ 
 |_____/ \____/ \_____|  |_|  \____/|_|  \_\

    !Disclaimer!
    
    These contracts have been used to create tutorials,
    and was created for the purpose to teach people
    how to create smart contracts on the blockchain.
    please review this code on your own before using any of
    the following code for production.
    The developer will not be responsible or liable for all loss or 
    damage whatsoever caused by you participating in any way in the 
    experimental code, whether putting money into the contract or 
    using the code for your own project.
*/

pragma solidity ^0.8.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC1155/ERC1155.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";

// change NFT1155 to the name you want to give your for your smartcontract below

contract NFT1155 is ERC1155, Ownable {
    
  string public name;
  string public symbol;

  mapping(uint => string) public tokenURI;

  constructor() ERC1155("") {
    name = "Pathological";  // Change the name to name of your collection
    symbol = "PTH";         // Change symbol to what you want it to look like on the etherscan/polygonscan
  }

  function mint(address _to, uint _id, uint _amount) external onlyOwner {
    _mint(_to, _id, _amount, "");
  }

  function mintBatch(address _to, uint[] memory _ids, uint[] memory _amounts) external onlyOwner {
    _mintBatch(_to, _ids, _amounts, "");
  }

  function burn(uint _id, uint _amount) external {
    _burn(msg.sender, _id, _amount);
  }

  function burnBatch(uint[] memory _ids, uint[] memory _amounts) external {
    _burnBatch(msg.sender, _ids, _amounts);
  }

  function burnForMint(address _from, uint[] memory _burnIds, uint[] memory _burnAmounts, uint[] memory _mintIds, uint[] memory _mintAmounts) external onlyOwner {
    _burnBatch(_from, _burnIds, _burnAmounts);
    _mintBatch(_from, _mintIds, _mintAmounts, "");
  }

  function setURI(uint _id, string memory _uri) external onlyOwner {
    tokenURI[_id] = _uri;
    emit URI(_uri, _id);
  }

  function uri(uint _id) public override view returns (string memory) {
    return tokenURI[_id];
  }

}
    // Thanks to HashLips