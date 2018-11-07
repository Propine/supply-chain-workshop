pragma solidity ^0.4.23;

contract DeliveryOrder {
  /*
   * Data persistence
   */
  bytes private _destination;
  address private _owner;
  address private _courier;

  constructor(bytes destination, address courier)
    public
  {
    _destination = destination;
    _courier = courier;
    _owner = msg.sender;
  }
}
