pragma solidity ^0.6.2;

import "@openzeppelin/contracts/presets/ERC20PresetMinterPauser.sol";
import "@openzeppelin/contracts/math/SafeMath.sol";
import "@openzeppelin/contracts/GSN/Context.sol";

contract XpieToken is Context, ERC20PresetMinterPauser {

    using SafeMath for uint256;

    string constant  _name = "LibertyPie";
    string  constant _symbol = "XPIE";
    uint256 constant _initialSupply = uint256(990000000); //990m
    
    string _version = "1";

    bytes32 public DOMAIN_SEPARATOR;
    // keccak256("Permit(address owner,address spender,uint256 value,uint256 nonce,uint256 deadline)");
    bytes32 public constant PERMIT_TYPEHASH = 0x6e71edae12b1b97f4d1f60370fef10105fa2faae0126114a169c64845d6126c9;
    mapping(address => uint) public nonces;

    constructor() public ERC20PresetMinterPauser(_name,_symbol) {
        
        uint _newSupply = _initialSupply.mul(uint256(10) ** uint256(decimals()));
        
        mint(_msgSender(), _newSupply);

        uint chainId; 

        assembly {
            chainId := chainid()
        }
        
        DOMAIN_SEPARATOR = keccak256(
            abi.encode(
                keccak256('EIP712Domain(string name,string version,uint256 chainId,address verifyingContract)'),
                keccak256(bytes(_name)),
                keccak256(bytes(_version)),
                chainId,
                address(this)
            )
        );
    }


    function permit(address owner, address spender, uint value, uint deadline, uint8 v, bytes32 r, bytes32 s) external {
        
        require(deadline >= block.timestamp, 'EXPIRED');

        bytes32 digest = keccak256(
            abi.encodePacked(
                '\x19\x01',
                DOMAIN_SEPARATOR,
                keccak256(abi.encode(PERMIT_TYPEHASH, owner, spender, value, nonces[owner]++, deadline))
            )
        );
        address recoveredAddress = ecrecover(digest, v, r, s);
        require(recoveredAddress != address(0) && recoveredAddress == owner, 'INVALID_SIGNATURE');
        _approve(owner, spender, value);
    }
    
}