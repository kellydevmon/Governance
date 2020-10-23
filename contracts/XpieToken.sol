pragma solidity ^0.6.2;

import "@openzeppelin/contracts/token/ERC20/ERC20Pausable.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20Burnable.sol";
import "@openzeppelin/contracts/math/SafeMath.sol";
import "@openzeppelin/contracts/GSN/Context.sol";

contract XpieToken is Context, ERC20Pausable, ERC20Burnable {

    using SafeMath for uint256;

    string _tokenName = "LibertyPie";
    string _tokenSymbol = "XPIE";
    uint8 _tokenDecimal = 8;
    uint256 _tokenInitialSupply = uint256(10000000000); //10b
    address PERMISSION_MANAGER_DOMAIN;

    constructor(
        address _permissionManagerDomain
    ) public ERC20(_tokenName,_tokenSymbol) {

        PERMISSION_MANAGER_DOMAIN = _permissionManagerDomain;

        _setupDecimals(_tokenDecimal);
        uint _tokenTotalSupply = _tokenInitialSupply.mul(10 ** uint256(_tokenDecimal));
        _mint(_owner, _tokenTotalSupply);
    }

    /**
     * onlyAdmin
     */
     modifier onlyAdmin() {
         
     }

    function _beforeTokenTransfer(address from, address to, uint256 amount) internal virtual override(ERC20, ERC20Pausable) {
        super._beforeTokenTransfer(from, to, amount);
    }
    
}