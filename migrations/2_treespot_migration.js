const TreeSpotNFTContract = artifacts.require("TreeSpotNFT");
const baseURI = "https://ipfs.io/ipfs/QmaPDfB5o3CcJSkWaeeWNFj72N4VoYzwQYvJuiUaiycYXD/";

module.exports = async function(deployer) {
    console.log("Migrating TreeSpotNFT");
    await deployer.deploy(TreeSpotNFTContract);
    const contractInstance = await TreeSpotNFTContract.deployed();
    const Names = ['Rebecca', 'Jane', 'Maksym', 'Pavel', 'John', 'Angela', 'Benjamin', 'Tim', 'Noam', 'Susan', 'Jack', 'Pavel', 'Monte',
                    'Alexandra', 'Vlady']
    await contractInstance.setBaseURI(baseURI);
    for (let i = 0; i < 15; i ++) {
        await contractInstance.mintNFT(Names[i]);
        console.log(await contractInstance.tokenName(i + 1));
        console.log(await contractInstance.tokenURI(i + 1));
    }
    console.log(await contractInstance.totalSupply());
    console.log("Successfully minted 15 NFTs");
}