pragma solidity ^0.4.23;

import './DeliveryOrderRegistry.sol';

contract DeliveryOrderBidder {

  event Deposit(address indexed sender, uint value);

  /*
   * Data persistence
   */
  bytes private _destination;
  address private _registry;
  address private _courier;
  mapping (uint => bytes) public statuses;
  uint public statusCount;

  /**
   * @dev Throws if called by any account other than the registry
   */
  modifier onlyRegistry() {
    require(isRegistry());
    _;
  }

  /**
   * @dev Throws if called by any account other than the courier
   */
  modifier onlyCourier() {
    require(isCourier());
    _;
  }

  function()
    public
    payable
      {
        if (msg.value > 0)
          emit Deposit(msg.sender, msg.value);
      }

  /**
   * @return true if `msg.sender` is the owner of the contract.
   */
  function isRegistry() public view returns (bool) {
    return msg.sender == _registry;
  }

  /**
   * @return true if `msg.sender` is the owner of the contract.
   */
  function isCourier() public view returns (bool) {
    return msg.sender == _courier;
  }

  constructor(address registry)
    public
  {
    _registry = registry;
    _courier = msg.sender;
  }

  function bid(uint orderId, uint price)
    public
    onlyCourier
    returns (bool)
  {
    return DeliveryOrderRegistry(_registry).bidForOrder(orderId, price);
  }

  function addStatus(bytes status)
    public
    onlyCourier
    returns (uint statusId)
  {
    statusId = statusCount;
    statuses[statusId] = status;
    statusCount += 1;
    return statusCount;
  }

  function complete()
    public
    onlyRegistry
    returns (bool)
  {
    _courier.transfer(address(this).balance);
    return true;
  }

}
