const TreeSpotNFT = artifacts.require("TreeSpotNFT");

contract("TreeSpotNFT", accounts => {
    it("should mint definite number of 15 NFTs in the first account", () => {
        TreeSpotNFT.deployed()
        .then(instance => instance.totalSupply().call())
        .then(totalSupply => {
            assert.equal(
                totalSupply.valueOf(),
                15,
                "There wasn't 15 minted NFTs"
            );
        });
    })
});
    it("should able to change tokenName of the tokenId", () => {
        let nftInstance;
        return TreeSpotNFT.deployed()
        .then(inst => { 
            nftInstance = inst; 
            return nftInstance.setTokenName(1, "Pavel");
        })
        .then(() => nftInstance.tokenName(1))
        .then(name => {
            assert.equal(
                name,
                "Pavel",
                "Set Token Name Function Failed."
            )
        })
    });

    it("should able to change tokenURI of the tokenId", () => {
        let nftInstance;
        return TreeSpotNFT.deployed()
        .then(inst => { 
            nftInstance = inst; 
            return nftInstance.setTokenURI(1, "https://ipfs.io/TreeSpotNFT/1.json");
        })
        .then(() => nftInstance.tokenURI(1))
        .then(name => {
            assert.equal(
                name,
                "https://ipfs.io/TreeSpotNFT/1.json",
                "Set Token URI Function Failed."
            )
        })
    });

