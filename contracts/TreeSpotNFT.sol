// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./ERC721Enumerable.sol";
import "./utils/Ownable.sol";

contract TreeSpotNFT is ERC721Enumerable, Ownable {
    //MAX TreeSpotNFT Supply
    uint256 public MAX_SUPPLY = 15;

    //Names of TreeSpotNFT token
    mapping(uint256 => string) private _tokenNames;

    event NewTreeSpotNFTMinted(address user, uint256 tokenId); // Emits when new token minted.

    /**
     * @dev Initializes the contract by setting a `name` and a `symbol` to the token collection.
     */
    constructor() ERC721("TreeSpotNFT", "TSN") {
    }

    /**
     * @dev Set Max Nft Supply of the token collection.
     * @param maxNftSupply MAX TreeSpotNFT Supply
     * Can only be called by the owner of contract.
     */
    function setMaxSupply(uint256 maxNftSupply) public onlyOwner {
        MAX_SUPPLY = maxNftSupply;
    }

    /**
     * @dev Set Base URI of the token collection.
     * @param baseURI base URI of the token collection
     * Can only be called by the owner of contract.
     */
    function setBaseURI(string memory baseURI) public onlyOwner {
        _setBaseURI(baseURI);
    }

    /**
     * @dev Set Token URI of the specific tokenId.
     * @param tokenId Specific tokenId.
     * @param tokenURI new TokenURI of the tokenId.
     * Can only be called by the owner of the tokenId.
     */
    function setTokenURI(uint256 tokenId, string memory tokenURI) public {
        require(_isApprovedOrOwner(_msgSender(), tokenId), "ERC721: transfer caller is not owner nor approved");

        _setTokenURI(tokenId, tokenURI);
    }

    /**
     * @dev Get Name of TreeSpotNFT token.
     * @param tokenId Specific tokenId
     * @return Name of TreeSpotNFT token.
     */
    function tokenName(uint256 tokenId) public view returns(string memory) {
        require(_exists(tokenId), "ERC721Metadata: URI query for nonexistent token");

        return _tokenNames[tokenId];
    }

    /**
     * @dev Set Name of the specific tokenId.
     * @param tokenId Specific tokenId.
     * @param _tokenName new Name of the tokenId.
     * Can only be called by the owner of the tokenId.
     */
    function setTokenName(uint256 tokenId, string memory _tokenName) public {
        require(_isApprovedOrOwner(_msgSender(), tokenId), "ERC721: transfer caller is not owner nor approved");
        require(_exists(tokenId), "ERC721Metadata: URI set of nonexistent token");
        
        _tokenNames[tokenId] = _tokenName;
    }

    /**
     * @dev Mint new NFT.
     * @param _tokenName Name of the new NFT
     * Requirements
     * - totalSupply <= MAX_SUPPLY
     * - Can only be called by the owner of contract.
     */
    function mintNFT(string memory _tokenName) public onlyOwner {
        require(totalSupply() < MAX_SUPPLY, "Cannot mint more than MAX_SUPPLY");

        uint tokenId = totalSupply() + 1;
        _safeMint(_msgSender(), tokenId);
        setTokenName(tokenId, _tokenName);
        emit NewTreeSpotNFTMinted(_msgSender(), tokenId);
    }
}
