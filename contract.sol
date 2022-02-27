// SPDX-License-Identifier: NONE

pragma solidity >=0.8.10 <=0.8.10;

import "./OpenzeppelinERC721.sol";

contract SushiTopFriendsNft is  ERC721URIStorage  , ERC721Enumerable{

    address public owner;
    uint nftid = 1;
    
    string currentURI = "http://arweave.net/fLk2kQ8xbYjHapkkNxHT9a66rUmrHHNnSyQuUXWTMTY";
    //address  stmsenderaddress= 0x5da89c55fdEd626B5F1e8446F00d52679Aa32cbA;
    mapping (address => bool) public stmsenderaddress;
    
    event Mint();
    event SetTokenURI( uint256 , string );

    function setTokenURI( uint targetnftid ,string memory _uri ) public {
        require( _msgSender() == owner );
        //ipfs://Qm....... or https://arweave.net/......  etc.
        _setTokenURI( targetnftid , _uri );
        emit SetTokenURI( targetnftid , _uri );
    }

    function setCurrentURI( string memory _uri ) public {
        require( _msgSender() == owner );
        currentURI = _uri;
    }

    function addstmsenderaddress(address _sender) public {
        require( _msgSender() == owner );
        stmsenderaddress[_sender] = true;
    }

    function _beforeTokenTransfer(address from, address to, uint256 tokenId)
        internal
        override(ERC721 , ERC721Enumerable)
    {
        super._beforeTokenTransfer(from, to, tokenId);
    }

    // function setStmSender(address _newSTMsender) public {
    //     require(_msgSender() == owner);
    //     stmsenderaddress = _newSTMsender;
    // }

    function _burn(uint256 tokenId) internal override(ERC721, ERC721URIStorage) {
        super._burn(tokenId);
    }

    function burn(uint256 _id) public {
        require( _msgSender() == ownerOf(_id));
        _burn(_id);
    }

    function tokenURI(uint256 tokenId)
        public
        view
        override(ERC721URIStorage , ERC721)
        returns (string memory)
    {
        
        if ( keccak256(abi.encodePacked(super.tokenURI(tokenId))) != keccak256(abi.encodePacked(""))){
        return super.tokenURI(tokenId);
        } else {
        return currentURI;
        }
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721 , ERC721Enumerable)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }

    function friendsNftPresent(address _userAddress) public {
        require( stmsenderaddress[_msgSender()] == true );
        //require(balanceOf(_userAddress)==0);
        _safeMint( _userAddress , nftid);
        emit Mint();
        nftid++;
    }

    // function isApprovedForAll(
    //     address _owner,
    //     address _operator
    // ) public override view returns (bool isOperator) {
    //     if (_operator == owner) {
    //         return true;
    //     }
        
    //     // otherwise, use the default ERC721.isApprovedForAll()
    //     return ERC721.isApprovedForAll(_owner, _operator);
    // }

    constructor() ERC721("SushiTopFriendsNft", "STN") {
        owner = _msgSender();
        stmsenderaddress[_msgSender()] = true;
        stmsenderaddress[0x5da89c55fdEd626B5F1e8446F00d52679Aa32cbA] = true;
    } 
    
} 
