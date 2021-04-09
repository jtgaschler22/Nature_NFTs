## Nature NFTs (Heavily based on opensea-creatures https://github.com/ProjectOpenSea/opensea-creatures)
- Coded by Connor Crawford, John Gaschler, Francois-M Brych, Henna Singh, Meagan Rathjen, and Oguzhan Acil

### Disclaimer:
**As mentioned above, this project is based heavily on the opensea-creatures repository. Most of the code found within this project is either a direct copy, or a copy which we then edited in order to have it to serve our purposes. This readme file is also copied, and then edited in order to have it specifically apply to the code found within this repository.**

### About this Project

We set out to follow the Opensea erc 721 tutorial (https://docs.opensea.io/docs/getting-started) in order to mint and list several NFT's on the Opensea marketplace. In the end, we ended up using the pre-made contracts that the Opensea tutorial provided by editing them to mint tokens with the off-chain metadata that can be found in the Nature Metadata folder within this repository.

The resulting marketplace can be found at the following link. At the time of writing, we minted 15 photos all taken by members of our group, and listed them for sale on the Rinkeby testnet. If we so-desired, we could easily migrate these NFTs to the Ethereum main-net, however, as this project is proof of concept, we decided not to do that.

https://testnets.opensea.io/accounts/0x26a9d5bc3f91502957201015ace9db7c13b4cffd/fintech-nature-photos-uj6bxg1rkj

What's included:

### Sample ERC721/ERC1155 Contracts

This includes a very simple sample ERC721 / ERC1155 for the purposes of demonstrating integration with the [OpenSea](https://opensea.io) marketplace. We include a script for minting the items.

Additionally, this contract whitelists the proxy accounts of OpenSea users so that they are automatically able to trade the ERC721 item on OpenSea (without having to pay gas for an additional approval). On OpenSea, each user has a "proxy" account that they control, and is ultimately called by the exchange contracts to trade their items. (Note that this addition does not mean that OpenSea itself has access to the items, simply that the users can list them more easily if they wish to do so)

### Factory Contracts

In addition to these template 721/1155 contracts, we provide sample factory contracts for running gas-free presales of items that haven't been minted yet. See https://docs.opensea.io/docs/opensea-initial-item-sale-tutorial for more info.

## Requirements

### Node version

Either make sure you're running a version of node compliant with the `engines` requirement in `package.json`, or install Node Version Manager (https://github.com/creationix/nvm) (Mac/Linux), (https://github.com/coreybutler/nvm-windows) (Windows), and run `nvm use` to use the correct version of node. 

In this case, after installing Node Version Manager, the command will be:

```bash
nvm install 12.18.0
nvm use 12.18.0
```

## Installation

Run

```bash
npm install -g yarn
yarn set version 1.22.4
yarn
```

If you run into an error while building the dependencies and you're on a Mac, run the code below, remove your `node_modules` folder, and do a fresh `yarn install`:
***Disclaimer: This instruction is provided by opensea, we did not test to determine its efficacy***

```bash
xcode-select --install # Install Command Line Tools if you haven't already.
sudo xcode-select --switch /Library/Developer/CommandLineTools # Enable command line tools
sudo npm explore npm -g -- npm install node-gyp@latest # Update node-gyp
```

## Deploying

### (Optional) Creating a .env file
1. Within the main folder of this repository, you should create a .env file with the following fields to be filled out later (***Do not copy the portions in parenthesis***):

export INFURA_KEY="" (can also be an Alchemy key, if you want to change it, change INFURA_KEY to be ALCHEMY_KEY)
export MNEMONIC="" (the mnemonic of the wallet you would like to charge the deployment's gas fees to)
export OWNER_ADDRESS="" (the person you would like to have own the NFT's you will be minting later)
export NFT_CONTRACT_ADDRESS="" (addressed in the Deploying to the Rinkeby network step)
export FACTORY_CONTRACT_ADDRESS="" (addressed in the Deploying to the Rinkeby network step)
export NETWORK="rinkeby" (pre-filled for deploying to rinkeby testnet)

2. As you follow the remainder of this tutorial, rather than running the export commands, you can fill out the relevant env fields, and once you have the .env completed, rather than re-typing out each export, instead you can run:

```
. .env
```
This will make re-deployments and resuming work much simpler.

### Deploying to the Rinkeby network.

1. To access a Rinkeby testnet node, you'll need to sign up for [Alchemy](https://dashboard.alchemyapi.io/signup?referral=affiliate:e535c3c3-9bc4-428f-8e27-4b70aa2e8ca5) and get a free API key. Click "View Key" and then copy the part of the URL after `v2/`.
   a. You can use [Infura](https://infura.io) if you want as well. Just change `ALCHEMY_KEY` below to `INFURA_KEY`.
2. Using your API key and the mnemonic for your Metamask wallet (make sure you're using a Metamask seed phrase that you're comfortable using for testing purposes), run:

```
export ALCHEMY_KEY="<your_alchemy_project_id>"
export MNEMONIC="<metmask_mnemonic>"
DEPLOY_CREATURES_SALE=1 yarn truffle deploy --network rinkeby
```

3. At this point, your terminal will provide you information about your deployed contracts. I recommend saving this information in a text file for reference later. Additionally, if you are creating a .env file, make sure to copy your NFT_CONTRACT_ADDRESS (in our case called Nature) and your FACTORY_CONTRACT_ADDRESS (in our case Nature_Factory) into your .env file. At this point your .env file should be complete, so make sure to run the . .env command.

### Minting tokens.

After deploying to the Rinkeby network, there will be a contract on Rinkeby that will be viewable on [Rinkeby Etherscan](https://rinkeby.etherscan.io). For example, here is a [recently deployed contract](https://rinkeby.etherscan.io/address/0xeba05c5521a3b81e23d15ae9b2d07524bc453561). You should set this contract address and the address of your Metamask account as environment variables when running the minting script. If a [CreatureFactory was deployed](https://github.com/ProjectOpenSea/opensea-creatures/blob/master/migrations/2_deploy_contracts.js#L38), which the sample deploy steps above do, you'll need to specify its address below as it will be the owner on the NFT contract, and only it will have mint permissions. In that case, you won't need NFT_CONTRACT_ADDRESS, as all we need is the contract with mint permissions here.

```
export OWNER_ADDRESS="<my_address>"
export NFT_CONTRACT_ADDRESS="<deployed_contract_address>"
export FACTORY_CONTRACT_ADDRESS="<deployed_factory_contract_address>"
export NETWORK="rinkeby"
node scripts/mint.js
```

***By default, the mint script will mint 15 tokens, as we have 15 photos worth of metadata in our Nature Metadata folder. If you wish to change how many tokens you are minting, you will need to edit the variable 'NUM_CREATURES' in scripts/mint.js to be the number of tokens you desire to mint.***



### Diagnosing Common Issues ***Disclaimer: These are provided by Opensea, we ended up using some of them, but have not verified all fixes listed below.***

If you're running a modified version of `sell.js` and not getting expected behavior, check the following:

- Is the `expirationTime` in future? If no, change it to a time in the future.

- Is the `expirationTime` a fractional second? If yes, round the listing time to the nearest second.

- Are the input addresses all strings? If no, convert them to strings.

- Are the input addresses checksummed? You might need to use the checksummed version of the address.

- Is your computer's internal clock accurate? If no, try enabling automatic clock adjustment locally or following [this tutorial](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/set-time.html) to update an Amazon EC2 instance.

- Do you have any conflicts that result from globally installed node packages? If yes, try `yarn remove -g truffle; yarn`

- Are you running a version of node compliant with the `engines` requirement in `package.json`? If no, try `nvm use; rm -rf node_modules; yarn`

# About OpenSea Creature Accessories

This is a sample ERC-1155 contract for the purposes of demonstrating integration with the [OpenSea](https://opensea.io) marketplace for crypto collectibles. We also include:

- A factory contract for making sell orders for unminted items (allowing for **gas-free and mint-free presales**).
- A configurable lootbox contract for selling randomized collections of ERC-1155 items.

On top of the features from the OpenSea ERC721 sample contracts above, ERC1155

- supports multiple creators per contract, where only the creator is able to mint more copies
- supports pre-minted items for the lootbox to choose from

## Configuring the Lootbox

Open CreatureAccessoryLootbox.sol

1. Change `Class` to reflect your rarity levels.
2. Change `NUM_CLASSES` to reflect how many classes you have (this gets used for sizing fixed-length arrays in Solidity)
3. In `constructor`, set the `OptionSettings` for each of your classes. To do this, as in the example, call `setOptionSettings` with
   1. Your option id,
   2. The number of items to issue when the box is opened,
   3. An array of probabilities (basis points, so integers out of 10,000) of receiving each class. Should add up to 10k and be descending in value.
4. Then follow the instructions below to deploy it! Purchases will auto-open the box. If you'd like to make lootboxes tradable by users (without a purchase auto-opening it), contact us at contact@opensea.io (or better yet, in [Discord](https://discord.gg/ga8EJbv)).

## Why are some standard methods overridden?

This contract overrides the `isApprovedForAll` method in order to whitelist the proxy accounts of OpenSea users. This means that they are automatically able to trade your ERC-1155 items on OpenSea (without having to pay gas for an additional approval). On OpenSea, each user has a "proxy" account that they control, and is ultimately called by the exchange contracts to trade their items.

Note that this addition does not mean that OpenSea itself has access to the items, simply that the users can list them more easily if they wish to do so!

# Requirements

### Node version

Either make sure you're running a version of node compliant with the `engines` requirement in `package.json`, or install Node Version Manager [`nvm`](https://github.com/creationix/nvm) and run `nvm use` to use the correct version of node.

## Installation

Run

```bash
yarn
```

## Deploying

### Deploying to the Rinkeby network.

1. Follow the steps above to get a Rinkeby node API key
2. Using your API key and the mnemonic for your MetaMask wallet (make sure you're using a MetaMask seed phrase that you're comfortable using for testing purposes), run:

```
export ALCHEMY_KEY="<alchemy_project_id>" # or you can use INFURA_KEY
export MNEMONIC="<metmask_mnemonic>"
DEPLOY_ACCESSORIES_SALE=1 yarn truffle migrate --network rinkeby
```

### Deploying to the mainnet Ethereum network.

Make sure your wallet has at least a few dollars worth of ETH in it. Then run:

```
yarn truffle migrate --network live
```

Look for your newly deployed contract address in the logs! 🥳

### Viewing your items on OpenSea

OpenSea will automatically pick up transfers on your contract. You can visit an asset by going to `https://opensea.io/assets/CONTRACT_ADDRESS/TOKEN_ID`.

To load all your metadata on your items at once, visit [https://opensea.io/get-listed](https://opensea.io/get-listed) and enter your address to load the metadata into OpenSea! You can even do this for the Rinkeby test network if you deployed there, by going to [https://rinkeby.opensea.io/get-listed](https://rinkeby.opensea.io/get-listed).

### Troubleshooting

#### It doesn't compile!

Install truffle locally: `yarn add truffle`. Then run `yarn truffle migrate ...`.

You can also debug just the compile step by running `yarn truffle compile`.

#### It doesn't deploy anything!

This is often due to the truffle-hdwallet provider not being able to connect. Go to your [Alchemy Dashboard](https://dashboard.alchemyapi.io/signup?referral=affiliate:e535c3c3-9bc4-428f-8e27-4b70aa2e8ca5) (or infura.io) and create a new project. Use your "project ID" as your new `ALCHEMY_KEY` and make sure you export that command-line variable above.

### ERC1155 Implementation

To implement the ERC1155 standard, these contracts use the Multi Token Standard by [Horizon Games](https://horizongames.net/), available on [npm](https://www.npmjs.com/package/multi-token-standard) and [github](https://github.com/arcadeum/multi-token-standard) and also under the MIT License.

# Running Local Tests

In one terminal window, run:

    yarn run ganache-cli

Once Ganache has started, run the following in another terminal window:

    yarn run test
