pragma solidity ^0.4.23;

contract DeliveryOrder {
  /*
   * Data persistence
   */
  bytes private _destination;
  address private _owner;
  address private _courier;
  mapping (uint => bytes) public statuses;
  uint public statusCount;

  /**
   * @dev Throws if called by any account other than the owner.
   */
  modifier onlyOwner() {
    require(isOwner());
    _;
  }

  /**
   * @dev Throws if called by any account other than the owner.
   */
  modifier onlyCourier() {
    require(isCourier());
    _;
  }

  /**
   * @return true if `msg.sender` is the owner of the contract.
   */
  function isOwner() public view returns(bool) {
    return msg.sender == _owner;
  }

  /**
   * @return true if `msg.sender` is the owner of the contract.
   */
  function isCourier() public view returns(bool) {
    return msg.sender == _courier;
  }

  constructor(bytes destination, address courier)
    public
  {
    _destination = destination;
    _courier = courier;
    _owner = msg.sender;
  }


  function addStatus(bytes status)
    public
    onlyCourier
    returns (uint statusId)
  {
    statusId = statusCount;
    statuses[statusId] = status;
    statusCount += 1;
  }

  function complete()
    public
    onlyOwner
  {
    _courier.transfer(address(this).balance);
  }

}
