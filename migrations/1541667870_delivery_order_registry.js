const DeliveryOrderRegistry = artifacts.require("DeliveryOrderRegistry.sol");
const DeliveryOrderBidder = artifacts.require("DeliveryOrderBidder.sol");
module.exports = function(deployer) {
  deployer
    .then(() => {
      return deployer.deploy(DeliveryOrderRegistry);
    })
    .then(() => {
      return deployer.deploy(DeliveryOrderBidder, DeliveryOrderRegistry.address);
    });
};
