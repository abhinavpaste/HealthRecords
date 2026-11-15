// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";

contract PatientHealthRecordsNFT is ERC721, AccessControl {
    bytes32 public constant VERIFIED_USER_ROLE = keccak256("VERIFIED_USER_ROLE");
    uint256 public nextTokenIdToMint;

    // tokenId => IPFS URI
    mapping(uint256 => string) private _tokenIPFSHashes;

    // tokenId => (userAddress => isGranted)
    mapping(uint256 => mapping(address => bool)) private _accessPermissions;

    constructor() ERC721("Patient Health Records", "PHR") {
        _grantRole(DEFAULT_ADMIN_ROLE, msg.sender);
    }

    function mintNFT(address to, string memory ipfsHash) external returns (uint256) {
        uint256 tokenId = nextTokenIdToMint;
        nextTokenIdToMint++;
        _safeMint(to, tokenId);
        _tokenIPFSHashes[tokenId] = ipfsHash;
        return tokenId;
    }

    function grantAccess(uint256 tokenId, address user) external {
        require(ownerOf(tokenId) == msg.sender, "Caller is not the token owner");
        _accessPermissions[tokenId][user] = true;
    }

    function revokeAccess(uint256 tokenId, address user) external {
        require(ownerOf(tokenId) == msg.sender, "Caller is not the token owner");
        _accessPermissions[tokenId][user] = false;
    }

    function checkAccessPermission(uint256 tokenId, address user) external view returns (bool) {
        if (ownerOf(tokenId) == user) return true;
        return _accessPermissions[tokenId][user];
    }

    function getIPFSHash(uint256 tokenId) external view returns (string memory) {
        require(
            ownerOf(tokenId) == msg.sender || _accessPermissions[tokenId][msg.sender],
            "No access permission"
        );
        return _tokenIPFSHashes[tokenId];
    }

    function getIPFSHashNoAccessControl(uint256 tokenId) external view returns (string memory) {
        return _tokenIPFSHashes[tokenId];
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721, AccessControl)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }
}
