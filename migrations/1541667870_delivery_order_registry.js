module.exports = function(deployer) {
  const DeliveryOrderRegistry = artifacts.require("DeliveryOrderRegistry.sol")  ;
  deployer.deploy(DeliveryOrderRegistry);
};
