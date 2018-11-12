/*
 * NB: since truffle-hdwallet-provider 0.0.5 you must wrap HDWallet providers in a
 * function when declaring them. Failure to do so will cause commands to hang. ex:
 * ```
 * mainnet: {
 *     provider: function() {
 *       return new HDWalletProvider(mnemonic, 'https://mainnet.infura.io/<infura-key>')
 *     },
 *     network_id: '1',
 *     gas: 4500000,
 *     gasPrice: 10000000000,
 *   },
 */

module.exports = {
  // See <http://truffleframework.com/docs/advanced/configuration>
  // to customize your Truffle configuration!
  networks: {
    development: {
      host: "localhost",
      port: 8545,
      network_id: "*", // Match any network id
      from: "0x17484326Fc7b21c7cB23F471e87e031052eF3530",
      gas: 1000000
    },
    rinkeby: {
      host: "52.77.225.127",
      port: 8593,
      network_id: "4",
      from: "0x476af74013e526879d421d3dc8b4efd1571036ff",
      gas: 4700036,
      gasPrice: 10000000000
    }
  }
};
