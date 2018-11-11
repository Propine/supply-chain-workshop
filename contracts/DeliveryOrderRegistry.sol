pragma solidity ^0.4.23;

import './DeliveryOrderBidder.sol';

contract DeliveryOrderRegistry {

  /*
   * Data persistence
   */
  struct Order {
    uint price;
    bytes destination;
  }
  struct OrderBidder {
    uint price;
    uint orderId;
    address bidder;
  }

  address private _owner;
  mapping (uint => Order) public orders;
  uint public orderCount;
  mapping (uint => OrderBidder) public orderBidders;
  uint public orderBidderCount;

  /*
   * Modifiers
   */

  /**
   * @dev Throws if called by any account other than the owner.
   */
  modifier onlyOwner() {
    require(isOwner());
    _;
  }

  /**
   * @return true if `msg.sender` is the owner of the contract.
   */
  function isOwner() public view returns(bool) {
    return msg.sender == _owner;
  }

   /*
    * Public functions
    */
  constructor()
    public
  {
    _owner = msg.sender;
  }

  function addOrder(bytes destination, uint price)
    public
    onlyOwner
    returns (uint orderId)
  {
    orderId = orderCount;
    orders[orderId] = Order({
      destination: destination,
      price: price
    });
    orderCount += 1;
  }

  function bidForOrder(uint orderId, uint price)
    public
    returns (bool)
  {
    uint orderBidderId = orderBidderCount;
    orderBidders[orderBidderId] = OrderBidder({
      price: price,
      orderId: orderId,
      bidder: DeliveryOrderBidder(msg.sender)
    });
    orderBidderCount += 1;
    return true;
  }

  function awardOrder(uint orderBidderId)
    public
    onlyOwner
    returns (bool)
  {
    OrderBidder storage orderBidder = orderBidders[orderBidderId];
    orderBidder.bidder.transfer(orderBidder.price);
    return true;
  }

  function completeOrder(uint orderBidderId)
    public
    onlyOwner
    returns (bool)
  {
    OrderBidder storage orderBidder = orderBidders[orderBidderId];
    return DeliveryOrderBidder(orderBidder.bidder).complete();
  }
}
