/**
 * Use this file to configure your truffle project. It's seeded with some
 * common settings for different networks and features like migrations,
 * compilation and testing. Uncomment the ones you need or modify
 * them to suit your project as necessary.
 *
 * More information about configuration can be found at:
 *
 * truffleframework.com/docs/advanced/configuration
 *
 * To deploy via Infura you'll need a wallet provider (like truffle-hdwallet-provider)
 * to sign your transactions before they're sent to a remote public node. Infura accounts
 * are available for free at: infura.io/register.
 *
 * You'll also need a mnemonic - the twelve word phrase the wallet uses to generate
 * public/private key pairs. If you're publishing your code to GitHub make sure you load this
 * phrase from a file you've .gitignored so it doesn't accidentally become public.
 *
 */
 const HDWalletProvider = require('@truffle/hdwallet-provider');
 
 const fs = require('fs');
 const mnemonic = fs.readFileSync(".secret").toString().trim(); //contains mnemonic
 const infuraKey = fs.readFileSync(".infura").toString().trim(); // infura key

 const adr=new HDWalletProvider(mnemonic,"https://localhost:8545")
 console.log(`Deployment account: ${adr.getAddress()}`); 

module.exports = {

  plugins: [
    'truffle-plugin-verify'
  ]

  /*api_keys: {
    'MY_API_KEY'
  }*/

  networks: {
      development: {
      host: "127.0.0.1",     // Localhost (default: none)
      port: 8545,            // Standard Ethereum port (default: none)
      network_id: "*",       // Any network (default: none)
     },
     ropsten: {
            provider: () => new HDWalletProvider(mnemonic, `https://ropsten.infura.io/v3/${infuraKey}`),
            network_id: 3,       // Ropsten's id
            gas: 5500000,        // Ropsten has a lower block limit than mainnet. Default is 6721975.
            skipDryRun: true
        },
        rinkeby: {
            provider: () => new HDWalletProvider(mnemonic, `https://rinkeby.infura.io/v3/${infuraKey}`),
            network_id: 4,       // rinkeby id
            skipDryRun: true
        },
        goerli: {
            provider: () => new HDWalletProvider(mnemonic, `https://goerli.infura.io/v3/${infuraKey}`),  
            network_id: 5,       // goerli's id
            gas: 4465030,        // default: 6721975,
            skipDryRun: true       
        },
        athereum: {
            provider: () => new HDWalletProvider(mnemonic, `https://ava.network:21015/ext/evm/rpc`),
            network_id: 1,       // athereum id
            gasPrice: 1,
            skipDryRun: true
        },
     // default gasPrice: 20000000000, // 20 gwei

    // Another network with more advanced options...
    // advanced: {
      // port: 8777,             // Custom port
      // network_id: 1342,       // Custom network
      // gas: 8500000,           // Gas sent with each transaction (default: ~6700000)
      // gasPrice: 20000000000,  // 20 gwei (in wei) (default: 100 gwei)
      // from: <address>,        // Account to send txs from (default: accounts[0])
      // websockets: true        // Enable EventEmitter interface for web3 (default: false)
    // },

    // Useful for private networks
    // private: {
      // provider: () => new HDWalletProvider(mnemonic, `https://network.io`),
      // network_id: 2111,   // This network is yours, in the cloud.
      // production: true    // Treats this network as if it was a public net. (default: false)
    // }
  },

  // Set default mocha options here, use special reporters etc.
  mocha: {
    // timeout: 100000
  },

  // Configure your compilers
  compilers: {
    solc: {
      // version: "0.5.1",    // Fetch exact version from solc-bin (default: truffle's version)
      // docker: true,        // Use "0.5.1" you've installed locally with docker (default: false)
      // settings: {          // See the solidity docs for advice about optimization and evmVersion
      //  optimizer: {
      //    enabled: false,
      //    runs: 200
      //  },
      //  evmVersion: "byzantium"
      // }
    }
  }
}
