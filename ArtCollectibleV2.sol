// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import '@openzeppelin/contracts/token/ERC1155/ERC1155.sol';
import '@openzeppelin/contracts/access/Ownable.sol';
import '@openzeppelin/contracts/utils/Strings.sol';

contract ArtCollectibleV2 is Ownable, ERC1155 {
    // Base URI
    string private baseURI;
    string public name;

/*
       //from https://coinsbench.com/fully-decentralized-erc-721-and-erc-1155-nfts-6c229adf9c9b
    mapping (uint256 => string) private _tokenURIs;
    using Counters for Counters.Counter; 
    Counters.Counter private _tokenIds;     
    //end of from https://coinsbench.com/.....
*/
    constructor()
        ERC1155(
            'ipfs://QmTBaZBTCcbVz6fy9KJvbtt7dixHW9aWJUe89g834eQxzp/{id}.json'
        )
    {
        setName('The notes Collection Mumbai Omega');
        
    }

    function setURI(string memory _newuri) public onlyOwner {
        _setURI(_newuri);
    }

    function setName(string memory _name) public onlyOwner {
        name = _name;
    }

    function mintBatch(uint256[] memory ids, uint256[] memory amounts)
        public
        onlyOwner
    {
        _mintBatch(msg.sender, ids, amounts, '');
    }

    function mint(uint256 id, uint256 amount) public onlyOwner {
        _mint(msg.sender, id, amount, '');
    }




 /*
//from https://coinsbench.com/fully-decentralized-erc-721-and-erc-1155-nfts-6c229adf9c9b

    
    function mintToken(string memory tokenURI, uint256 amount)
    public returns(uint256) { 
        uint256 newItemId = _tokenIds.current(); 
        _mint(msg.sender, newItemId, amount, "");
        _setTokenUri(newItemId, tokenURI); 
        _tokenIds.increment(); 
        return newItemId; 
    }    



     function uri(uint256 tokenId) override public view 
    returns (string memory) { 
        return(_tokenURIs[tokenId]); 
    }     
    
    
    function _setTokenUri(uint256 tokenId, string memory tokenURI)
    private {
         _tokenURIs[tokenId] = tokenURI; 
    } 
//end from https://coinsbench.com/...
*/


// From https://gist.github.com/soenkeba/5df8ee90d600e8e3c9ceee0a6a3a23a0

       function uint2hexstr(uint256 i) public pure returns (string memory) {
        
        if (i == 0) return "0";
        
        uint j = i;
        uint length;
        while (j != 0) {
            length++;
            j = j >> 4;
        }
        uint mask = 15;
        bytes memory bstr = new bytes(length);
        uint k = length;
        while (i != 0) {
            uint curr = (i & mask);
           
            bstr[--k] = curr > 9 ?
                bytes1(uint8(55 + curr)) :
                bytes1(uint8(48 + curr)); // 55 = 65 - 10
            i = i >> 4;
        }
     
        return string(bstr);
        
       
    }

    function uint2A(uint256 i) public pure returns (uint256 val) {
        
        if (i == 0) return 0;
        
        return i;
    }
 /*   
function TrimZeros(str) {
    string memory str;
    str = str.trim(); 
    if (!str) {
        return false;
    }

    str = str.replace(/^0+/, "") || "0";
    var n = Math.floor(Number(str));
    
    return n;
     //hexstringtokenID = TrimZeros(String(_tokenID));
}
   */ 

        
       
    
    function uri(uint256 _tokenID) override public view returns (string memory) {
    
       string memory hexstringtokenID;
        // hexstringtokenID = uint2hexstr(_tokenID); //in use
        //hexstringtokenID = Strings.toString(uint2A(_tokenID));

         hexstringtokenID = Strings.toString(_tokenID);
    
    return string(
        abi.encodePacked(
        "ipfs://QmTBaZBTCcbVz6fy9KJvbtt7dixHW9aWJUe89g834eQxzp/",
        hexstringtokenID,".json")
        );
    }
    


}
