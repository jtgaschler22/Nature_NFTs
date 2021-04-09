pragma solidity ^0.5.0;

import "./ERC721Tradable.sol";
import "openzeppelin-solidity/contracts/ownership/Ownable.sol";

/**
 * @title NatureNFT
 * Nature - a contract for my non-fungible nature photos.
 */
contract Nature is ERC721Tradable {
    constructor(address _proxyRegistryAddress)
        public
        ERC721Tradable("Nature", "NAT", _proxyRegistryAddress)
    {}

    function baseTokenURI() public pure returns (string memory) {
        return "https://raw.githubusercontent.com/jtgaschler22/Project_3_NFT/main/Nature%20Metadata/";
    }

    function contractURI() public pure returns (string memory) {
        return "https://raw.githubusercontent.com/jtgaschler22/Project_3_NFT/main/Nature%20Metadata/meta_data_project.txt";
    }
}
