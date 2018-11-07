pragma solidity ^0.4.23;
import "./DeliveryOrder.sol";

contract DeliveryOrderRegistry {

  /*
   * Data persistence
   */
  struct Order {
    uint price;
    bytes destination;
    bool taken;
  }

  address private _owner;
  mapping (uint => Order) public orders;
  uint public orderCount;

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
      price: price,
      taken: false
    });
    orderCount += 1;
  }

  function takeOrder(uint orderId)
    public
    returns (address deliveryOrder)
  {
    deliveryOrder = new DeliveryOrder(orders[orderId].destination, msg.sender);
  }

  /*
   * Internal functions
   */
}
